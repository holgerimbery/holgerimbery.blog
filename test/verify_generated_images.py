"""Verify built image dimensions and deployment size."""

import argparse
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import unquote, urlsplit


class ImageAudit(HTMLParser):
    def __init__(self, destination):
        super().__init__()
        self.destination = destination
        self.images = 0

    def handle_starttag(self, tag, attributes):
        attributes = dict(attributes)
        if tag == "img":
            self.images += 1
            assert all(
                attributes.get(key, "").isdigit() and int(attributes[key]) > 0
                for key in ("width", "height")
            ), f"Missing image dimensions: {attributes}"
            source = urlsplit(attributes.get("src", ""))
            if not source.netloc and source.path.startswith("/images/"):
                image_path = self.destination / unquote(source.path).lstrip("/")
                assert image_path.is_file(), f"Missing local image: {attributes['src']}"


def verify(destination):
    audit = ImageAudit(destination)
    pages = list(destination.rglob("*.html"))
    assert pages, f"No HTML pages in {destination}"
    for path in pages:
        audit.feed(path.read_text(encoding="utf-8-sig"))
    assert not list((destination / "images" / "generated").glob("*.json")), "Build cache metadata is public"
    assert not (destination / "images" / "generated" / ".metadata").exists(), "Build cache metadata is public"
    size = sum(path.stat().st_size for path in destination.rglob("*") if path.is_file())
    assert size <= 500_000_000, f"Built site exceeds Azure's 500 MB environment limit: {size:,} bytes"
    print(f"Verified dimensions for {audit.images} images across {len(pages)} HTML pages.")
    print(f"Deployment payload: {size / 1_000_000:.1f} MB / 500 MB.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--destination", type=Path, default=Path("holgerimbery") / "_site")
    arguments = parser.parse_args()
    verify(arguments.destination)
