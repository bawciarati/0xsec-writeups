# SETUP — getting this repo onto GitBook

This file is for the owner, not for readers: it lives in the repo but is not listed in `SUMMARY.md`, so it never appears in the site navigation.

Current state: repo is live at `github.com/bawciarati/0xsec-writeups`, sync config is committed, and the site still needs to be published.

---

## 0. Prerequisites

- A GitHub account
- A GitBook account
- `git` locally (`C:\Program Files\Git\cmd\git.exe`)

---

## 1. Repository

The repo already exists and is pushed. If you ever need to rebuild it:

1. GitHub → **New repository**, name `0xsec-writeups`
2. Leave **Add README**, **Add .gitignore** and **Add license** switched **off** — this repo already has all three, and initialising them on GitHub creates a commit that makes your first push fail
3. Visibility: public (the repo contains no live samples, only `.md`, `.yar` and one PNG)

```powershell
cd "C:\Users\bpiec\OneDrive\Documents\Default Project\sec-writeups"
git remote add origin https://github.com/bawciarati/0xsec-writeups.git
git push -u origin main
```

`.gitbook.yaml`, `gitbook-docs.yaml`, `SUMMARY.md` and `README.md` must sit at the **repository root**.

---

## 2. Connect GitBook to the repo (Git Sync)

GitBook configures Git Sync at the **site** level now: one connection, one repo, one branch. Which space reads which directory is defined in `gitbook-docs.yaml` at the repo root (already in this repo).

1. gitbook.com → create an **organisation** (name it `bpiecks` to get the `bpiecks.gitbook.io` subdomain)
2. Create a **site** named `bpiecks`
3. In the site → **Git Sync** → **Connect GitHub**
4. Install the **GitBook GitHub App** with **Only select repositories** → `bawciarati/0xsec-writeups`
5. **Source repository**: `0xsec-writeups`, branch `main`
6. **Initial sync direction**: **GitHub → GitBook** (the repo is the source of truth; the space was empty, so nothing is lost)
7. **Project directory**: leave empty (repo root — where `gitbook-docs.yaml` lives)
8. **Content mapping**: confirm the row `bpiecks` → `./` (GitBook reads it from `gitbook-docs.yaml`)
9. Click **Sync**

### Errors seen during setup, and their causes

| Error | Cause | Fix |
| --- | --- | --- |
| `gitbook-docs.yaml does not exist on this branch` | Site-level sync needs that file at the project directory | `gitbook-docs.yaml` added at repo root — make sure it's pushed, then Sync again |
| `Failed to parse YAML configuration file ".gitbook.yaml" … redirects: Invalid input: expected record, received null` | A `redirects:` key with only comments under it parses as `null` | Keep the `redirects` key commented out until there are real redirects |

### Files GitBook reads after the first sync

| File | Purpose |
| --- | --- |
| `gitbook-docs.yaml` | Which spaces the site has, and which directory each reads |
| `README.md` | Space homepage (About Me) |
| `SUMMARY.md` | The entire left-hand navigation |
| `.gitbook.yaml` | Content root, first page, navigation file, redirects |

Anything **not** in `SUMMARY.md` (`SETUP.md`, `STYLE-GUIDE.md`, `templates/`, `detections/`) stays out of the navigation. `detections/*.yar` is still reachable by direct URL, so post links keep working.

{% hint style="danger" %}
**Never change `key:` in `gitbook-docs.yaml` after the first sync.** GitBook treats a new key as a brand-new space with a new space ID, and every existing link to the old one breaks. To rename, change `title:` only.
{% endhint %}

---

## 3. Publish the site

Syncing only fills the editor. Nothing is on the public web until you publish:

1. Open the site → **Publish** (or **Settings → Publishing / Domain**)
2. Visibility: **Public**
3. Subdomain: `bpiecks` → `https://bpiecks.gitbook.io/bpiecks/`
4. Optional: custom domain

Before publishing, check the preview:

- [ ] Homepage shows About Me (not an empty page)
- [ ] Sidebar lists: About Me, Malware Analysis, Windows & AD, CTF Writeups, Blogs
- [ ] The DBDAxera post renders its logo image
- [ ] The TL;DR renders as a coloured callout, not raw `{% hint %}` text
- [ ] The mermaid diagram renders as a diagram

---

## 4. Look and feel (GitBook UI, not git)

These settings live in GitBook's platform, not in the repo:

- **Settings → Branding**: logo, favicon, colours
- **Settings → Themes**: light/dark
- **Settings → Domain**: `bpiecks.gitbook.io` or a custom domain
- **Settings → Social preview**: the card shown when the link is shared
- Turn off **suggest edits / comments** if you don't want public edits

> Editing the navigation in the GitBook UI commits `SUMMARY.md` back to the repo. Don't edit both sides at once — treat **git as the source of truth**.

---

## 5. Writing a new post

```powershell
cd "C:\Users\bpiec\OneDrive\Documents\Default Project\sec-writeups"

# 1. Draft from the template
Copy-Item templates\writeup-template.md malware-analysis\2026-12-01-my-sample.md

# 2. Write it, then add the new page to SUMMARY.md

# 3. Commit and push
git add -A
git commit -m "post: my-sample static analysis"
git push
```

GitBook picks the commit up within seconds.

**Three rules**

1. Edit in your editor and push. Don't edit the same page in the GitBook UI at the same time.
2. Never create or edit `README.md` through the GitBook UI — it duplicates the file and causes conflicts.
3. A new file does not appear until it is listed in `SUMMARY.md`.

---

## 6. Identity used across the site

| Value | Where it appears |
| --- | --- |
| `bpiecks` | Author name (`meta.author` in YARA rules) |
| [`bawciarati`](https://github.com/bawciarati) | GitHub (Contact in `README.md`, repo remote) |
| `bpieckrafale@hotmail.com` | `README.md` (Contact) |
| `https://bpiecks.gitbook.io/bpiecks/…` | `meta.reference` in YARA rules |

If you change the GitBook subdomain or space path, update `meta.reference` in `detections/dbdaxera_updater.yar` — it is the only place the published URL is hardcoded.

Check that no placeholder text survived:

```powershell
Get-ChildItem -Recurse -Include *.md,*.yar |
  Where-Object { $_.Name -notin 'SETUP.md', 'STYLE-GUIDE.md', 'writeup-template.md' } |
  Select-String -Pattern "YOURNAME|0xYOURHANDLE|YOUR_EMAIL"
```

No output means you're clean.

---

## 7. Decisions only you can make

- **Name and handle**: `bpiecks` is currently the writing name; the GitHub account is `bawciarati`. Using one handle everywhere builds recognition faster than splitting them.
- **Public or private**: a portfolio should be public — but anonymise anything that describes a client's or employer's systems first.
- **Samples in the repo**: don't. Hashes and YARA rules only, which is what this repo does.
- **Language**: English only. To add Thai later, GitBook supports per-section translations rather than a second directory tree.
