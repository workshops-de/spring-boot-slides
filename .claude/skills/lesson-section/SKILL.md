---
name: lesson-section-interview
description: Conducts an interview with a trainer to define one section (topic) of a workshop lesson for Slidev slides. Use when the user wants to outline a new lesson section, define slide content, prepare a section outline for slide generation, or asks to interview them about a lesson topic.
---

# Lesson Section Interview

You are an **interviewer** helping a trainer define one **section** of a lesson. A section is a single building block; a lesson can contain multiple sections (e.g. lesson "Rules & Instructions" → sections: Vendor Rule files, Agents.md, Commands, Skills).

**Goal**: Ask focused questions so the trainer's answers become a detailed outline for another agent to build Slidev slides. Do not write slides — only collect answers and compile the outline.

## Required slide layouts

Every section outline must include content for:

| Layout          | Purpose                                                   |
| --------------- | --------------------------------------------------------- |
| **section**     | Section divider: "Section" badge, centred title           |
| **why**         | Rationale: why this topic matters, what problem it solves |
| **little-what** | One-sentence primer: what this topic _is_                 |

## Optional layouts

| Layout                             | Use for                       |
| ---------------------------------- | ----------------------------- |
| **cover**                          | Topic title slide             |
| **sub-section**                    | Nested divider for sub-topics |
| **task**                           | Exercises / "try this"        |
| **what-if**                        | Extensions or edge cases      |
| **ask-me-anything**                | Open Q&A                      |
| **default**                        | Normal content                |
| **two-cols** / **two-cols-header** | Text + list or text + code    |
| **image-left** / **image-right**   | Text + diagram/screenshot     |

## Interview flow

Ask in this order, one block at a time:

1. **Section title** — "What is the exact title of this section?"
2. **Why** — "Why does this topic matter? What concrete problem does it address?" + "What should learners feel or understand after the 'why' slide?"
3. **Little-what** — "In one or two sentences, what _is_ this topic?"
4. **Main content** — "What are 2–4 main points or steps?" + "Do you have a code/config example? Which layout fits best?" + "Any before/after comparison?"
5. **Visual** — "What one diagram or image would help? Describe it briefly."
6. **Task & wrap-up** _(optional)_ — task exercise, what-if extension, ask-me-anything prompt.

## Output

After the interview, compile the trainer's answers into a structured section outline. See [examples.md](examples.md) for the exact output template.
