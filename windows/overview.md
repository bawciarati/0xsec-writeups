# Windows & AD

Windows internals and Active Directory. The parts you never need until you're staring at a process that shouldn't be running as SYSTEM.

## Posts

- [UAC Bypass through CMSTPLUA: What the Two DLLs Actually Do](2026-11-13-uac-bypass-cmstplua.md) — an auto-approved COM class, two Microsoft DLLs, and the vtable slot that runs your command as administrator.

## What I'm planning to write

- Tokens, integrity levels, and which privileges malware asks for first
- LOLBins that still work in 2026
- AD: Kerberos, delegation, certificate abuse

## Ground rule

Every post says what build it was tested on. Windows behaviour moves between builds, and a post without a build number is a post someone will waste an afternoon on. If I only tested one VM, that's what the post will say.
