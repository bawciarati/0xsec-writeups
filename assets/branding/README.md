# Branding

Header assets for the GitBook site. None of these are referenced by a page;
they exist to be uploaded through the GitBook UI, because Git Sync cannot
carry a logo or a favicon. The `gitbook-docs.yaml` schema only accepts
`site.title` and `site.structure`, so these files are not read by the sync.

## What goes where

| File | Size | GitBook field | Result |
| --- | --- | --- | --- |
| `logo-light.png` | 1007 x 300 | Customization -> General -> Custom logo (light) | hooded figure plus `bpiecks` in the header |
| `logo-dark.png` | 1007 x 300 | same, dark mode | same, white wordmark |
| `icon-132.png` | 132 x 132 | Customization -> General -> Icon | square favicon, replacing the generated letter avatar |
| `logo-jpiecks-light.png`, `logo-jpiecks-dark.png` | 1007 x 300 | alternative | the same layout with `Jpiecks` as the wordmark |
| `preview-light.png`, `preview-dark.png` | 760 x 140 | nothing | how the header looks at 90 px tall |

The custom logo replaces both the icon and the site title in the header. The
icon still controls the browser favicon. If the two disagree, the header shows
the logo and the tab shows the icon.

## How the files were made

The figure is the original `1300 x 1304` upload, rounded and left-aligned on a
transparent 300 px canvas. The wordmark is Cascadia Mono SemiBold, scaled so the
cap height is 190 px, in `#111111` for light and `#F5F5F5` for dark. Script used:
`%TEMP%\build_branding.ps1` on the machine that produced them.

Changing the wordmark means re-running that script with a different string, not
editing a PNG.
