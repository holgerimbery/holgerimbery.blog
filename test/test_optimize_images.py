import hashlib
import importlib.util
import json
from pathlib import Path
import tempfile
import unittest

from PIL import Image


spec = importlib.util.spec_from_file_location(
    "optimize_images", Path(__file__).resolve().parents[1] / "scripts" / "optimize_images.py"
)
pipeline = importlib.util.module_from_spec(spec)
spec.loader.exec_module(pipeline)


class OptimizeImagesTest(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory()
        self.addCleanup(self.temporary.cleanup)
        self.source = Path(self.temporary.name)
        self.images = self.source / "images"
        self.images.mkdir()

    def test_variants_are_smaller_never_upscaled_and_keep_originals(self):
        photo = self.images / "photo.jpg"
        Image.effect_noise((1800, 1200), 30).convert("RGB").save(photo, quality=95)
        before = hashlib.sha256(photo.read_bytes()).digest()
        manifest = pipeline.build(self.source)
        entry = manifest["/images/photo.jpg"]
        self.assertEqual((1800, 1200), (entry["width"], entry["height"]))
        self.assertEqual(set(pipeline.WIDTHS), {variant["width"] for variant in entry["variants"]})
        for variant in entry["variants"]:
            destination = self.source / variant["path"].lstrip("/")
            self.assertLess(destination.stat().st_size, photo.stat().st_size)
            with Image.open(destination) as image:
                self.assertEqual("WEBP", image.format)
                self.assertEqual((variant["width"], variant["height"]), image.size)
        self.assertEqual(before, hashlib.sha256(photo.read_bytes()).digest())

    def test_small_transparent_png_is_lossless_and_not_upscaled(self):
        image = Image.new("RGBA", (90, 50), (100, 50, 20, 128))
        image.save(self.images / "screen.png")
        manifest = pipeline.build(self.source)
        variants = manifest["/images/screen.png"]["variants"]
        self.assertTrue(variants)
        self.assertLessEqual(max(variant["width"] for variant in variants), 90)
        full_size = next(variant for variant in variants if variant["width"] == 90)
        with Image.open(self.source / full_size["path"].lstrip("/")) as converted:
            self.assertEqual(image.tobytes(), converted.convert("RGBA").tobytes())

    def test_exif_orientation_is_applied(self):
        photo = Image.new("RGB", (200, 100), "blue")
        exif = Image.Exif()
        exif[274] = 6
        photo.save(self.images / "rotated.jpg", exif=exif)
        entry = pipeline.build(self.source)["/images/rotated.jpg"]
        self.assertEqual((100, 200), (entry["width"], entry["height"]))

    def test_cache_is_reused_and_missing_files_are_regenerated(self):
        Image.new("RGB", (600, 400), "blue").save(self.images / "photo.jpg")
        first = pipeline.build(self.source)
        variant = self.source / first["/images/photo.jpg"]["variants"][0]["path"].lstrip("/")
        original_time = variant.stat().st_mtime_ns
        self.assertEqual(first, pipeline.build(self.source))
        self.assertEqual(original_time, variant.stat().st_mtime_ns)
        variant.unlink()
        self.assertEqual(first, pipeline.build(self.source))
        self.assertTrue(variant.is_file())

    def test_source_change_invalidates_cache(self):
        photo = self.images / "photo.jpg"
        Image.new("RGB", (600, 400), "blue").save(photo)
        first = pipeline.build(self.source)
        obsolete = self.source / first["/images/photo.jpg"]["variants"][0]["path"].lstrip("/")
        Image.new("RGB", (600, 400), "red").save(photo)
        second = pipeline.build(self.source)
        self.assertNotEqual(first, second)
        self.assertFalse(obsolete.exists())
        persisted = json.loads((self.images / "generated" / ".metadata" / "manifest.json").read_text())
        self.assertEqual(second, persisted["images"])

    def test_animated_and_unsupported_images_remain_unchanged(self):
        frames = [Image.new("RGB", (50, 50), color) for color in ("red", "blue")]
        frames[0].save(self.images / "animated.webp", save_all=True, append_images=frames[1:], duration=100)
        (self.images / "icon.svg").write_text("<svg></svg>")
        manifest = pipeline.build(self.source)
        self.assertEqual({"variants": [], "skipped": "animated"}, manifest["/images/animated.webp"])
        self.assertNotIn("/images/icon.svg", manifest)

    def test_corrupt_image_fails_the_build(self):
        (self.images / "bad.png").write_bytes(b"not an image")
        with self.assertRaises(OSError):
            pipeline.build(self.source)

    def test_duplicate_images_can_be_generated_concurrently(self):
        image = Image.new("RGB", (600, 400), "blue")
        for name in ("first.jpg", "second.jpg"):
            image.save(self.images / name)
        manifest = pipeline.build(self.source, workers=2)
        self.assertEqual(manifest["/images/first.jpg"], manifest["/images/second.jpg"])


if __name__ == "__main__":
    unittest.main()
