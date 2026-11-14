# Branding

Header assets for the GitBook site. None of these are referenced by a page;
they exist to be uploaded through the GitBook UI, because Git Sync cannot
carry a logo or a favicon. The `gitbook-docs.yaml` schema only accepts
`site.title` and `site.structure`, so these files are not read by the sync.

## What goes where

| File | Size | GitBook field | Result |
| --- | --- | --- | --- |
| `logo-light.png` | 895 x 300 | Customization -> General -> Custom logo (light) | hooded figure plus `bpiecks` in the header |
| `logo-dark.png` | 895 x 300 | same, dark mode | same, white wordmark |
| `icon-132.png` | 132 x 132 | Customization -> General -> Icon | square favicon, replacing the generated letter avatar |
| `logo-light-regular.png`, `logo-dark-regular.png` | 874 x 300 | alternative | same layout, regular weight instead of bold |
| `logo-jpiecks-light.png`, `logo-jpiecks-dark.png` | 895 x 300 | alternative | the same layout with `Jpiecks` as the wordmark |
| `preview-light.png`, `preview-dark.png` | 720 x 140 | nothing | how the header looks at 90 px tall |
| `compare.png` | 900 x 420 | nothing | the reference geometry, our version, and the file at full size |

The custom logo replaces both the icon and the site title in the header. The
icon still controls the browser favicon.

## The font

**Iosevka Nerd Font** (family name `Iosevka NF`, OFL 1.1). Taken from the site
this layout is modelled on, which serves the same file as a GitBook custom font:

```
https://fonts.gitbook.com/font/custom/MAxoBoNe75Umz38IWLJC/2397319/iosevkanerdfont-regular.ttf
https://fonts.gitbook.com/font/custom/MAxoBoNe75Umz38IWLJC/9639324/iosevkanerdfont-bold.ttf
```

Local copies, used to render the wordmark: `%TEMP%\iosevka\`.

The reference header renders its title as Iosevka at 16 px, weight 600,
letter-spacing -0.4 px, next to a 32 px icon. That was read from the computed
style of the title element, not guessed from a screenshot.

## How the files were made

The figure is the original `1300 x 1304` upload, rounded and left-aligned on a
transparent 300 px canvas. The wordmark is Iosevka NF Bold, scaled so the cap
height is 190 px, in `#111111` for light and `#F5F5F5` for dark. Scripts used:
`%TEMP%\build_iosevka.ps1` and `%TEMP%\branding_sheet.ps1`.

Changing the wordmark means re-running the script with a different string, not
editing a PNG.
