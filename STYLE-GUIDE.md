# Style Guide

Writing rules for this site — so post 20 reads like post 1, and so I never publish something that sounds confident but cannot be checked.

## 1. Core principles

1. **Write from the artefact.** If I haven't taken it apart, I don't write the post yet. If I'm relying on someone else's work, say so — it's a secondary source.
2. **Separate "observed" from "inferred".** Use different wording:
   - Observed: *"confirmed from…"*, *"the xref at `0x…` points to…"*
   - Inferred: *"probably"*, *"inferred from…"*, *"could not confirm because…"*
3. **Never invent a hash, an address, or an IOC.** If it isn't there, say it isn't there.
4. **Every post has a Limitations section.** It's the shortest section and usually the most valuable.

## 2. Language

- **Everything published is English.** No mixed-language posts.
- **British spelling**, consistently: *analyse, analysed, behaviour, defence, organisation* (but keep API names and product names exactly as shipped, e.g. `InitializeSecurityContext`).
- Technical terms stay as they are — don't translate `import table`, `persistence`, `shellcode`, `unpacking`.
- Write like one engineer explaining a finding to another, not like a report: short sentences, new paragraph when the idea changes.
- Cut filler: "it is worth noting that", "as we all know", "very interesting".

## 3. Post structure

Use this order (skip a section only if there is genuinely no data; **never reorder**):

| # | Section | Required |
| --- | --- | --- |
| 1 | Front matter + H1 | ✅ |
| 2 | Metadata table (hash, size, format, signed, analysis method) | ✅ |
| 3 | TL;DR (single paragraph, inside a `hint`) | ✅ |
| 4 | Why this one is interesting | ✅ |
| 5 | Static triage / structure | ✅ |
| 6 | Main content (obfuscation, C2, flow, …) | ✅ |
| 7 | IOC | ✅ |
| 8 | Detection (YARA + hunting) | if there's a rule |
| 9 | ATT&CK mapping | ✅ |
| 10 | Limitations | ✅ |
| 11 | Closing | ✅ |
| 12 | Appendix (address map, raw bytes, scripts) | if relevant |

## 4. Metadata table

Every post needs one, and it must answer: *if I have this file, can I tell whether it's the same one?*

```markdown
|  |  |
| --- | --- |
| **SHA-256** | `…` |
| **Size** | … |
| **Format** | … |
| **Compiled** | … UTC |
| **Signed** | ✅ / ❌ |
| **Analysis** | static only / sandbox / dynamic |
```

## 5. Specific conventions

### Addresses and offsets

- x64 virtual addresses: full width, in backticks — `` `0x140002fdd` ``
- File offsets: hex, and always label which one it is (`file offset 0x92A8`, not `VA 0x92A8`)
- Unrenamed functions keep the decompiler's name: `FUN_140004fb0`. Don't invent prettier names.

### Bytes and patterns

- Hex in two-digit groups separated by spaces, wrapped at ~20 bytes per line
- A YARA pattern must be bytes that **actually exist in the file**, and should include the trailing NUL / terminator where one exists, to reduce false positives

### IOC

- Defang domains and IPs: `hxxps://host[.]tld/path`
- Keep IOCs in code blocks so they copy cleanly, not in tables
- Group them: Network / Host / File

### Links and images

- Relative paths inside the site: `[YARA rule](../detections/x.yar)`
- Images live in `assets/` and are linked relatively (`../assets/…`) so they also render on GitHub
- GitBook builds heading anchors from English headings — only link anchors that exist

### Callout blocks

```
{% hint style="info" %} … {% endhint %}
{% hint style="warning" %} … {% endhint %}
{% hint style="danger" %} … {% endhint %}
{% hint style="success" %} … {% endhint %}
```

Use `info` for TL;DR / notes, `warning` for security caveats and inference warnings, `danger` for "do not run this".

**Why `{% hint %}` and not a blockquote `>`** — decided Nov 2026: GitBook is the surface readers actually use, so use the block GitBook renders best. Accept the side effect that the same file on GitHub shows the `{% hint %}` tags as raw text. **Do not convert them to blockquotes to make GitHub look nicer** — that costs the site its coloured callouts.

## 6. File and folder naming

```
malware-analysis/YYYY-MM-DD-slug.md
windows/YYYY-MM-DD-slug.md
ctf/YYYY-MM-DD-event-challenge.md
blogs/YYYY-MM-DD-slug.md
detections/<family>_<what>.yar
assets/<family>-<what>.png
```

- Slugs are lowercase English, hyphen-separated
- The date in the filename is the publish date (not the date the sample was collected) and must match the post body
- After adding a file, **update `SUMMARY.md`** or it will not appear in the sidebar

## 7. Voice

Read it back in your head. If a sentence sounds like a conference bio or a product page, rewrite it.

Things that make text read as machine-written, and what to do instead:

| Don't | Do |
| --- | --- |
| "It's not just X, it's Y." | Say what it is. Once per post, at most, if it's genuinely surprising. |
| Three-item lists in every paragraph | Use two items, or four, or a plain sentence |
| A bold label opening every paragraph | Plain prose. Bold is for the metadata table and warnings. |
| Em dashes everywhere | Commas, parentheses, or a full stop |
| "This raises the question…", "Here's the thing" | Just ask the question, or state the thing |
| "Robust", "leverage", "seamless", "landscape", "critical" | The actual number, tool, or behaviour |
| A rhetorical one-liner to close each section | Stop when the information stops |
| Clever headings ("The Sound of Silence") | "The update check", "What it doesn't do" |
| Symmetrical sentences ("Not X. Not Y. Just Z.") | Uneven sentences, because that's how people write |

Other habits that help:

- One concrete detail beats three adjectives. "1,740,800 bytes, 97% of it one PNG" is worth more than "bloated".
- Admit dead ends. Writing about what didn't work is worth more than only showing what did.
- Vary paragraph length. A one-line paragraph is fine.
- Never name or shame victims, and don't publish anything that lets a reader reproduce an attack in one step (a working C2 client, for example).
- Client or work samples: strip hashes and domains, and say they were anonymised.

## 7b. Headings and post openings

- The first paragraph after H1 should tell the reader what the file is and why it exists. No scene setting.
- Skip "In this post we will…" and any table of contents in prose. The sidebar already does that job.
- A section that only repeats the TL;DR should not exist.

## 8. Pre-publish checklist

- [ ] Hash recomputed against the actual file
- [ ] Every address/offset traceable to a tool or an xref
- [ ] Every YARA pattern verified to exist in the sample (`yara` run locally)
- [ ] Limitations written, and the post doesn't read as safer than reality
- [ ] IOCs defanged
- [ ] All relative links resolve
- [ ] `SUMMARY.md` updated
- [ ] No placeholder text (`YOURNAME`, `0xYOURHANDLE`, `TODO`) left in a post
