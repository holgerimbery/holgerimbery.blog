"""Verify that built HTML references complete, responsive image assets."""

import argparse
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import unquote, urlsplit


class ImageAudit(HTMLParser):
    def __init__(self, destination, baseurl):
        super().__init__()
        self.destination = destination
        self.baseurl = baseurl.rstrip("/")
        self.images = 0
        self.sources = 0

    def handle_starttag(self, tag, attributes):
        attributes = dict(attributes)
        if tag == "img":
            self.images += 1
            assert all(
                attributes.get(key, "").isdigit() and int(attributes[key]) > 0
                for key in ("width", "height")
            ), f"Missing image dimensions: {attributes}"
        if tag == "source" and attributes.get("type") == "image/webp":
            self.sources += 1
            assert attributes.get("sizes"), f"Missing responsive sizes: {attributes}"
            for candidate in attributes["srcset"].split(","):
                url, width = candidate.strip().rsplit(" ", 1)
                assert width.endswith("w") and int(width[:-1]) > 0, candidate
                path = unquote(urlsplit(url).path)
                if self.baseurl:
                    assert path.startswith(self.baseurl + "/"), url
                    path = path[len(self.baseurl):]
                assert (self.destination / path.lstrip("/")).is_file(), f"Missing variant: {url}"


def verify(destination, baseurl=""):
    audit = ImageAudit(destination, baseurl)
    pages = list(destination.rglob("*.html"))
    assert pages, f"No HTML pages in {destination}"
    for path in pages:
        audit.feed(path.read_text(encoding="utf-8-sig"))
    assert audit.sources > 0, "No responsive WebP sources in the built site"
    assert not list((destination / "images" / "generated").glob("*.json")), "Build cache metadata is public"
    assert not (destination / "images" / "generated" / ".metadata").exists(), "Build cache metadata is public"
    size = sum(path.stat().st_size for path in destination.rglob("*") if path.is_file())
    assert size <= 500_000_000, f"Built site exceeds Azure's 500 MB environment limit: {size:,} bytes"
    print(f"Verified {audit.images} images, {audit.sources} responsive sources, {len(pages)} HTML pages.")
    print(f"Deployment payload: {size / 1_000_000:.1f} MB / 500 MB.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--destination", type=Path, default=Path("holgerimbery") / "_site")
    parser.add_argument("--baseurl", default="")
    arguments = parser.parse_args()
    verify(arguments.destination, arguments.baseurl)
