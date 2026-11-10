for code [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)  | for anything else  [![License: CC BY-NC-ND 4.0](https://licensebuttons.net/l/by-nc-nd/4.0/80x15.png)](https://creativecommons.org/licenses/by-nc-nd/4.0/) | [![Azure Static Web Apps CI/CD](https://github.com/holgerimbery/holgerimbery.blog/actions/workflows/azure-static-web-apps-thankful-pebble-058e7d903.yml/badge.svg)](https://github.com/holgerimbery/holgerimbery.blog/actions/workflows/azure-static-web-apps-thankful-pebble-058e7d903.yml)
# source of https://holgerimbery.blog
a public repository of Blog: holgerimbery.blog

Please respect the author's copyrights and use citations when using articles or parts.
Copyright © 01.10.23-current date, holgerimbery.blog (Holger Imbery) – All the right reserved

License: 
MIT for the code and for the rest: [CC-BY-ND-NC](https://creativecommons.org/licenses/by-nc-nd/4.0/)   
SPDX-License-Identifier: MIT AND CC-BY-ND-NC

## Image dimensions and original assets

The Jekyll plugin in `holgerimbery/_plugins/image_dimensions.rb` adds missing
`width` and `height` attributes to rendered HTML images, including Markdown
article images. It reads the local image's intrinsic dimensions at build time
and caches them for that build. URLs on this site and raw GitHub URLs under
this repository's `main/holgerimbery/` path resolve to local files; the build
does not download remote images.

Image optimization is disabled. Builds use the original assets in
`holgerimbery/images/` without generating WebP variants. References to images
in the repository are served from `raw.githubusercontent.com`. Keep this
repository public so those image URLs remain accessible. The original images
are used for build-time dimensions but excluded from deployment artifacts,
reducing the Pages upload size. Existing explicit dimensions, loading
priorities, responsive `height: auto`, and CSS image crops are preserved. For
externally hosted images or missing assets, supply explicit dimensions; the
build logs a warning rather than guessing an aspect ratio.

Dynamically injected translation flags reserve their square aspect ratio in CSS.

For local builds, run these commands from the repository root:

```powershell
Set-Location holgerimbery
bundle install
bundle exec ruby ..\test\image_dimensions_test.rb
bundle exec jekyll build
```

The deployment workflows and container build use the existing image assets as
is, without installing image-processing dependencies or generating variants.
The post-build audit checks image dimensions, repository image references, and
deployment payload size. The
GitHub Pages artifact is retained for one day, the minimum supported retention.
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
