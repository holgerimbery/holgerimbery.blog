for code [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)  | for anything else  [![License: CC BY-NC-ND 4.0](https://licensebuttons.net/l/by-nc-nd/4.0/80x15.png)](https://creativecommons.org/licenses/by-nc-nd/4.0/) | [![Azure Static Web Apps CI/CD](https://github.com/holgerimbery/holgerimbery.blog/actions/workflows/azure-static-web-apps-thankful-pebble-058e7d903.yml/badge.svg)](https://github.com/holgerimbery/holgerimbery.blog/actions/workflows/azure-static-web-apps-thankful-pebble-058e7d903.yml)
# source of https://holgerimbery.blog
a public repository of Blog: holgerimbery.blog

Please respect the author's copyrights and use citations when using articles or parts.
Copyright © 01.10.23-current date, holgerimbery.blog (Holger Imbery) – All the right reserved

License: 
MIT for the code and for the rest: [CC-BY-ND-NC](https://creativecommons.org/licenses/by-nc-nd/4.0/)   
SPDX-License-Identifier: MIT AND CC-BY-ND-NC

## Responsive images and dimensions

The Jekyll plugin in `holgerimbery/_plugins/image_dimensions.rb` adds missing
`width` and `height` attributes to rendered HTML images, including Markdown
article images. It reads the local image's intrinsic dimensions at build time
and caches them for that build. URLs on this site and raw GitHub URLs under
this repository's `main/holgerimbery/` path resolve to local files; the build
does not download remote images.

`scripts/optimize_images.py` generates content-hashed WebP variants at widths
80, 160, 400, 800, 1,200 and 1,600 pixels without upscaling or modifying originals.
JPEG photos use quality 80; PNG screenshots and existing WebP images use
lossless encoding to avoid additional compression artifacts. A variant is
published only when smaller than its original. Animated images are preserved.

The initial rollout wraps photos, article cards, and avatars in `<picture>`
with WebP `srcset` sources and `sizes`. PNG/WebP screenshots in article/page
content and galleries retain their original files and receive dimensions only.
This keeps screenshot quality unchanged and the deployment within Azure Static
Web Apps' 500 MB per-environment limit. The original JPEG/PNG remains the
fallback, served from the blog rather than raw GitHub. Image zoom loads the
original on demand. Existing hand-authored `<picture>` and `srcset` are not
replaced. Generated files and their manifest live in the ignored
`holgerimbery/images/generated/` directory; unchanged inputs reuse cached
variants. Old content-hashed variants are removed on the next generation run.
Only variants actually referenced by rendered HTML are copied into `_site`;
unused variants and private build metadata are not deployed. Azure gives
generated images a one-year immutable cache policy. The post-build audit checks
the image references, dimensions, metadata exclusion, and deployment size.

Existing explicit dimensions, loading priorities, responsive `height: auto`,
and CSS image crops are preserved. Dynamically injected translation flags
reserve their square aspect ratio in CSS. For externally hosted images or missing
assets, supply explicit dimensions; the build logs a warning rather than
guessing an aspect ratio.

For local builds, install Python 3.10+ and the pinned image dependency, then run
these commands from the repository root (activate a Python virtual environment
first if needed):

```powershell
python -m pip install -r requirements-images.txt
python -m unittest discover -s test -p test_optimize_images.py
python scripts\optimize_images.py
Set-Location holgerimbery
bundle install
bundle exec ruby ..\test\image_dimensions_test.rb
bundle exec jekyll build
python ..\test\verify_generated_images.py --destination _site
```

Run the image generator again after adding or replacing images, before running
Jekyll. A missing manifest fails the build with an actionable error. All three
deployment workflows use the shared `.github/actions/optimize-images` action
to generate and cache variants before building Jekyll, including scheduled
publication and future/draft previews. The container build command also
generates variants before serving.
Build that container from the repository root with
`docker build -f holgerimbery/containerfile -t holgerimbery-blog .`.

## Shared profile and legal pages

holgerimbery.blog remains a separate publishing platform. Articles and their URLs
stay here, and `/about/` explains the blog's editorial purpose, content date
caveat, and use of AI.

The canonical professional profile and talks are maintained at
https://instruo365.de/about/. The German legal notice at
https://instruo365.de/impressum/ covers only instruo365.de and holgerimbery.blog.
The shared privacy page at https://instruo365.de/privacy/ documents both sites'
currently configured integrations. Maintain these shared pages in the
instruo365 repository rather than duplicating their content here. Cookie
preferences remain available in the blog footer.

**Deployment order:** Publish and verify the instruo365 profile, Impressum, and
privacy subpages before merging or deploying these blog changes, so links never
point to missing pages. The shared privacy page is currently a visible draft
requiring operator/legal review; its availability is not compliance approval.

**Separate consent review:** The existing blog loads Google Analytics and Umami
independently of its consent banner. Review reject, accept, and withdrawal gating
for all relevant scripts before relying on a final privacy notice. This migration
only changes the privacy link, not tracking or consent semantics.

Azure Static Web Apps permanently redirects both `/impressum` and `/impressum/`
using `holgerimbery/staticwebapp.config.json`. For GitHub Pages,
`holgerimbery/impressum/index.html` is a static Jekyll asset with a visible link,
canonical URL, and meta refresh; GitHub Pages resolves `/impressum` to
`/impressum/`. Do not reintroduce a collection page with the same permalink or
redirect `/about/`.

Before shipping, run `bundle exec jekyll build` from `holgerimbery` and inspect
`_site/impressum/index.html` for the shared legal link and meta refresh. Check
`_site/staticwebapp.config.json` for both 301 routes and the existing 404 override,
and `_site/about/index.html` for the blog-specific page and its canonical URL.
Verify rendered navigation, the homepage profile link, cookie preferences,
contact form, and unchanged article URLs.
