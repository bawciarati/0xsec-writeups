# Windows & AD

Windows internals and Active Directory. The parts you never need until you're staring at a process that shouldn't be running as SYSTEM.

## What I'm planning to write

- COM objects you can activate without elevation, and why that matters
- UAC: what actually auto-elevates versus what only looks like it does
- Tokens, integrity levels, and which privileges malware asks for first
- LOLBins that still work in 2026
- AD: Kerberos, delegation, certificate abuse

## Ground rule

Every post says what build it was tested on. Windows behaviour moves between builds, and a post without a build number is a post someone will waste an afternoon on. If I only tested one VM, that's what the post will say.
