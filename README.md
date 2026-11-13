# About Me

Most of what's on this site is malware analysis. Loaders, droppers, RATs, whatever ended up in my samples folder that week. I also spend time on Windows internals, some CTFs, and the occasional web app.

Everything here comes from a file I opened myself. If a post says a string decodes to a URL, I ran the decoder and printed the URL. If I couldn't confirm something, the post says so in a limitations section, because a writeup that hides its gaps is worse than no writeup.

I publish as `bpiecks`.

{% hint style="info" %}
**Contact:** [bpieckrafale@hotmail.com](mailto:bpieckrafale@hotmail.com) · GitHub [`bawciarati`](https://github.com/bawciarati)
{% endhint %}

## Posts

### [DBDJpx: Unsigned Updater, Zero Integrity Checks](malware-analysis/2026-11-13-dbdaxera-updater.md)

A game-cheat loader that pulls its payload from a Railway host, compares version strings with `std::string::find`, and runs the download as Administrator. No hash check anywhere in the chain.

### [WandEnhancer: Patching Another App's Fuses](malware-analysis/2026-11-13-wandenhancer.md)

A WeMod patcher that rewrites `app.asar`, side-loads a `version.dll` proxy to flip an Electron fuse in memory, and can open an unauthenticated panel on `0.0.0.0:3223`.

### [AppDomain Hijacking: Analyzing a LNK malware](malware-analysis/2026-11-13-lnk-appdomain-hijack.md)

A shortcut that carries its own base64 payload, a Microsoft-signed ClickOnce host copied into the Startup folder, and four lines of `.exe.config` that make the CLR load a stranger's assembly before `Main` runs.

### [UAC Bypass through CMSTPLUA: What the Two DLLs Actually Do](windows/2026-11-13-uac-bypass-cmstplua.md)

Where the auto-approved CLSID is registered, why `cmstplua.dll` forwards to `cmlua.dll`, and which vtable slot `ShellExec` really occupies.

### YARA rules

Rules are written from the sample's bytes rather than from recovered plaintext, because the plaintext isn't in the file. Each post links to its own rule in `detections/`.

## Sections

| Section | What goes there |
| --- | --- |
| Malware Analysis | Loaders, stealers, RATs, string obfuscation, C2, persistence, detection rules |
| Windows | Internals, privilege escalation, COM, UAC, LOLBins |
| CTF Writeups | How I got there, including the dead ends |
| Blogs | Everything that doesn't fit above |

## How I work

- Static analysis first, always. If a sample has to run, it runs in a VM with no route to a real network.
- Hashes, addresses and offsets in these posts were read off the file, not remembered.
- No samples in this repo. Hashes and rules only.

Nothing here is a tutorial for running anything on your own machine. The files are hostile.
