# Review Report Format

Produce one block per slide. Use this structure:

```
## [filename] — Slide [N]: [slide title or first heading]

- ✅ [what is good about this slide]
- ⚠️  [issue] → [suggested fix]
- ❌ [critical issue] → [suggested fix]
```

**Icon guide**

| Icon | Meaning                                     |
| ---- | ------------------------------------------- |
| ✅   | Slide (or aspect) is fine — briefly say why |
| ⚠️   | Minor issue: can improve but not blocking   |
| ❌   | Critical issue: should be fixed before use  |

**Issue labels** — prefix each `⚠️` / `❌` line with one of:

- `[duplicate]` — content repeats another slide
- `[tone]` — phrasing is unprofessional, inconsistent, or unclear
- `[missing example]` — concept introduced without a concrete example
- `[weak example]` — example is trivial or disconnected
- `[empty]` — slide has no meaningful content
- `[overflow]` — content likely too long for one slide

## Example output

```
## slides/why.md — Slide 1: Why AI tools matter

- ✅ Clear rationale, good use of the `why` layout.
- ⚠️  [tone] "basically just speeds things up" — rephrase to "reduces repetitive overhead"
- ⚠️  [missing example] Claims productivity gains but gives no concrete figure or case

## slides/what.md — Slide 3: Context window

- ✅ Good code example showing token limits.
- ✅ Consistent terminology throughout.

## slides/how.md — Slide 2: Prompting patterns

- ❌ [duplicate] Bullet "zero-shot prompting" also appears in slides/why.md Slide 2 — remove one
- ⚠️  [overflow] Code block is 25 lines — consider splitting or using maxHeight
```

## Summary section

After all slide blocks, add a short summary:

```
## Summary

- X slides reviewed
- X critical issues (❌)
- X minor issues (⚠️)
- Top 3 recommended actions:
  1. …
  2. …
  3. …
```
