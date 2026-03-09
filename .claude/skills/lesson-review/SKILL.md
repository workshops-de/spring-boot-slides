---
name: lesson-review
description: Reviews a workshop lesson directory for quality issues. Use when the user wants to review, audit, or check a lesson for duplicates, tone, examples, or slide quality.
---

# Lesson Review

Analyses all slides in a lesson directory and produces a per-slide quality report.

## How to run

1. Ask the user for the lesson directory if not provided.
2. Read every `.md` file in the lesson's `slides/` subdirectory.
3. For each slide, evaluate the criteria below.
4. Output a structured report (see [report-format.md](report-format.md)).

## Review criteria

### Duplicates

- Flag any heading, bullet, sentence, or code block that appears verbatim (or near-verbatim) in another slide within the same lesson.
- Note both slides by file + slide number.

### Tone

- Slides should use a **clear, professional, and concise** tone — no filler phrases ("basically", "simply", "just"), no colloquialisms.
- Technical terms must be used consistently (same name throughout the lesson).
- Sentences should be direct: active voice preferred, no unnecessary hedging.

### Examples

- Every conceptual slide should have at least one concrete example (code snippet, diagram, real-world analogy, or use-case).
- Flag slides that introduce a concept without backing it up with an example.
- Flag slides where an example exists but is overly trivial or disconnected from the topic.

### Slide completeness

- Slides must not be empty or near-empty (title only).
- Required layouts (`section`, `why`, `little-what`) must be present and fully filled.
- Text must not overflow the slide (watch long code blocks and long bullet lists).

## Scope

Focus on lesson-level slides (`slides/**/*.md`). Ignore task files unless the user asks to include them.
