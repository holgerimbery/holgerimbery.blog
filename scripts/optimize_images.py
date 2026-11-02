"""Generate cached, responsive WebP assets without changing the source images."""

import argparse
from concurrent.futures import ThreadPoolExecutor
import hashlib
import io
import json
from pathlib import Path
import re
import tempfile

from PIL import Image, ImageOps, __version__ as pillow_version


WIDTHS = (80, 160, 400, 800, 1200, 1600)
RECIPE = f"webp-v1-{pillow_version}-{WIDTHS}-photo80-lossless-png-method4"
EXTENSIONS = {".jpg", ".jpeg", ".png", ".webp"}


def atomic_write(path, data):
    with tempfile.NamedTemporaryFile(dir=path.parent, delete=False) as temporary:
        temporary.write(data)
        name = Path(temporary.name)
    try:
        name.replace(path)
    finally:
        name.unlink(missing_ok=True)


def optimize_image(path, source, output):
    original = path.read_bytes()
    digest = hashlib.sha256(RECIPE.encode() + original).hexdigest()[:24]
    cache_path = output / ".metadata" / f"{digest}.json"
    if cache_path.exists():
        cached = json.loads(cache_path.read_text(encoding="utf-8"))
        if all(
            (source / variant["path"].lstrip("/")).is_file()
            and (source / variant["path"].lstrip("/")).stat().st_size == variant["bytes"]
            for variant in cached["variants"]
        ):
            return path, cached, True

    with Image.open(io.BytesIO(original)) as opened:
        if getattr(opened, "is_animated", False):
            return path, {"variants": [], "skipped": "animated"}, False
        image = ImageOps.exif_transpose(opened)
        lossless = opened.format in {"PNG", "WEBP"}
        image = image.convert("RGBA" if "A" in image.getbands() or "transparency" in image.info else "RGB")
        entry = {"width": image.width, "height": image.height, "variants": []}
        for width in sorted({min(width, image.width) for width in WIDTHS}):
            height = max(1, round(image.height * width / image.width))
            resized = image.resize((width, height), Image.Resampling.LANCZOS)
            encoded = io.BytesIO()
            resized.save(
                encoded,
                format="WEBP",
                quality=80,
                lossless=lossless,
                method=4,
                icc_profile=opened.info.get("icc_profile", b""),
            )
            data = encoded.getvalue()
            if len(data) >= len(original):
                continue
            destination = output / f"{digest}-{width}.webp"
            atomic_write(destination, data)
            entry["variants"].append(
                {
                    "path": "/" + destination.relative_to(source).as_posix(),
                    "width": width,
                    "height": height,
                    "bytes": len(data),
                }
            )
    atomic_write(cache_path, json.dumps(entry, sort_keys=True).encode())
    return path, entry, False


def build(source, workers=2):
    source = source.resolve()
    images = source / "images"
    if not images.is_dir():
        raise ValueError(f"Image directory does not exist: {images}")
    output = images / "generated"
    output.mkdir(exist_ok=True)
    (output / ".metadata").mkdir(exist_ok=True)
    paths = sorted(
        path for path in images.rglob("*")
        if path.is_file() and output not in path.parents and path.suffix.lower() in EXTENSIONS
    )
    manifest = {}
    cached = 0
    with ThreadPoolExecutor(max_workers=workers) as executor:
        for index, (path, entry, hit) in enumerate(
            executor.map(lambda path: optimize_image(path, source, output), paths), start=1
        ):
            manifest["/" + path.relative_to(source).as_posix()] = entry
            cached += hit
            if entry.get("skipped"):
                print(f"Preserving {entry['skipped']} image: {path.name}", flush=True)
            if index % 100 == 0:
                print(f"Processed {index}/{len(paths)} images", flush=True)
    content = json.dumps({"recipe": RECIPE, "images": manifest}, sort_keys=True, indent=2) + "\n"
    manifest_path = output / ".metadata" / "manifest.json"
    if not manifest_path.exists() or manifest_path.read_text(encoding="utf-8") != content:
        atomic_write(manifest_path, content.encode())
    referenced = {
        Path(variant["path"]).name for entry in manifest.values() for variant in entry["variants"]
    }
    for path in output.glob("*.webp"):
        if re.fullmatch(r"[a-f0-9]{24}-\d+\.webp", path.name) and path.name not in referenced:
            path.unlink()
    print(f"Image variants ready: {len(manifest)} originals, {cached} cache hits.", flush=True)
    return manifest


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source", type=Path, default=Path(__file__).resolve().parents[1] / "holgerimbery")
    parser.add_argument("--workers", type=int, choices=range(1, 5), default=2)
    arguments = parser.parse_args()
    build(arguments.source, arguments.workers)
