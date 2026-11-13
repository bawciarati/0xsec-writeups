# About Me

I'm a cybersec person who likes taking things apart — especially things with no source code. Code, protocols, binaries, weird files: I'd rather explain what they actually do than what the README says they do.

Most of my time goes into **malware analysis**, **reverse engineering** and **Windows internals**. Sometimes CTFs, sometimes bug hunting in web apps.
If it's made of code, I want to know how it breaks.

This site is my notebook. Every post comes from analysis I actually ran on my own machine, not from summarising someone else's article. If I don't know something, I say so.

{% hint style="info" %}
**Contact:** [bpieckrafale@hotmail.com](mailto:bpieckrafale@hotmail.com) · GitHub [`bawciarati`](https://github.com/bawciarati)
{% endhint %}

## Projects

### DBDAxera — loader teardown

A static teardown of a loader that updates itself over HTTPS without validating a single hash or signature, then runs the result as Administrator — [read the full post](malware-analysis/2026-11-13-dbdaxera-updater.md)

### YARA rules

Detection rules written from the sample's actual bytes, not from guessed plaintext — see the Detection section of each post

## What you'll find here

| Section | Contents |
| --- | --- |
| Malware Analysis | Loader / stealer / RAT structure, string obfuscation, C2, persistence, and the rules that catch them |
| Windows & AD | Internals, privilege escalation, COM, UAC, LOLBins |
| CTF Writeups | How I thought about it, not just the flag |
| Blogs | Notes that don't fit anywhere else |

## Ground rules

- Every sample is analysed **statically** first. If it has to run, it runs in a VM isolated from any real network.
- Hashes, addresses and offsets in these posts were verified, not recalled from a training cutoff.
- No post tells you to run anything on a real machine. The samples are hostile.

{% hint style="warning" %}
This is a young site: the piece count is small and growing. Everything here was written by me, published as soon as it was verified.
{% endhint %}
