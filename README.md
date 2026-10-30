for code [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)  | for anything else  [![License: CC BY-NC-ND 4.0](https://licensebuttons.net/l/by-nc-nd/4.0/80x15.png)](https://creativecommons.org/licenses/by-nc-nd/4.0/) | [![Azure Static Web Apps CI/CD](https://github.com/holgerimbery/holgerimbery.blog/actions/workflows/azure-static-web-apps-thankful-pebble-058e7d903.yml/badge.svg)](https://github.com/holgerimbery/holgerimbery.blog/actions/workflows/azure-static-web-apps-thankful-pebble-058e7d903.yml)
# source of https://holgerimbery.blog
a public repository of Blog: holgerimbery.blog

Please respect the author's copyrights and use citations when using articles or parts.
Copyright © 01.10.23-current date, holgerimbery.blog (Holger Imbery) – All the right reserved

License: 
MIT for the code and for the rest: [CC-BY-ND-NC](https://creativecommons.org/licenses/by-nc-nd/4.0/)   
SPDX-License-Identifier: MIT AND CC-BY-ND-NC

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
