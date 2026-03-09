---
name: lesson-migration
description: Migrates raw Slidev slides from raw-material/ to workshop lessons following the 4-MAT structure. Use when migrating AI topics for developers, converting sli.dev slides into lessons, or when the user asks to migrate lesson content.
---

# Lesson Migration

Migrates content from `raw-material/` into structured lessons. Follow these steps in order.

## Migration Flow

1. Preparation
2. Selection
3. Handle duplicated content
4. Research for correctness or missing content
5. Create lesson

---

## 1. Preparation

Before selecting content:

- Read `README.md` for project structure and conventions
- Analyse `lessons/01-example-lesson` (and optionally `lessons/02-rules-and-instructions`) for reference
- Understand lesson structure: `lesson.yml`, main `.md` entry, `slides/{topic}/`, `tasks/{task}/`
- Note supported layouts: `section`, `sub-section`, `why`, `cover`, `what-if`, `little-what`, `two-cols-header`, `default`
- Note components:
  - `<Callout type="info">[content]</Callout>` — types: `info` | `warning` | `important`
  - `<WindowMockup codeblock title="[filename]">` for code blocks

**Goal**: Know all capabilities before migrating the selected material.

---

## 2. Selection

- List folders in `raw-material/` and **ASK** which topic to migrate
- Topics are sli.dev slides; do **not** copy-paste slides verbatim
- Inspect each file in the selected folder: outline structure, slide count, and how it maps to 4-MAT
- Report findings before proceeding

---

## 3. Handle Duplicated Content

- Search for duplicated information across the selected material
- List duplicates and **ASK** which parts to remove or merge
- If no duplicates found, ask for support before proceeding

---

## 4. Research for correctness or missing content

- Be critical about the content
- Check its correctness
- Check if important information are missing

---

## 5. Create Lesson

Create the lesson in this order:

1. **section** — Section divider slide
2. **why** — Why this matters
3. **little-what** — Brief concept overview
4. **Content slides** — Mix of `default` and `two-cols-header` to explain the topic
5. **what-if** — Motivational question to expand thinking (max 2 slides)
6. **task** — Title of the upcoming task for the attendee

Use `sub-section` for nested content areas when needed.

For a full slide example, see [examples.md](examples.md).

---

## Additional Resources

- Lesson and task structure: `.cursor/rules/course-content-rules.mdc`
- Slide formatting and 4-MAT: `.cursor/rules/slidev-rules.mdc`
