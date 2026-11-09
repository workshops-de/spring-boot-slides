# Workshop Slides Template

A template repository for creating workshop slides using [Slidev](https://sli.dev/) with integrated task management for the workshops.de platform.

## 🚀 Quick Start

### 1. Use This Template

Click "Use this template" on GitHub to create a new repository.

### 2. Clone and Setup

```bash
git clone https://github.com/your-org/your-workshop-slides.git
cd your-workshop-slides
npm install
```

### 3. Start Development

```bash
npm run dev
```

Open http://localhost:3030 to see your slides.

## 📁 Project Structure

```
/
├── 00-index.md                      # Main index with links to all lessons
├── sources.md                       # Sources and references
├── package.json                     # Dependencies and scripts (build tooling: @workshops.de/slidev-toolkit)
├── lessons/
│   └── 01-example-lesson/           # Lesson folder
│       ├── lesson.yml               # Lesson metadata (synced to platform)
│       ├── 01-example-lesson.md     # Main slide deck entry point
│       ├── slides/                  # Slide content organized by topic
│       │   └── example-topic/
│       │       ├── why.md           # 4-MAT: Why this matters
│       │       ├── what.md          # 4-MAT: Core concepts
│       │       ├── how.md           # 4-MAT: Practical steps
│       │       ├── what-if.md       # 4-MAT: Edge cases & alternatives
│       │       └── task.md          # Exercise slide
│       └── tasks/                   # Task definitions (synced to platform)
│           ├── 01-first-task/
│           │   ├── task.yml         # Task metadata
│           │   ├── body.md          # Main description
│           │   ├── hint.md          # Hints (optional)
│           │   └── trainer_hint.md  # Trainer notes (optional)
│           └── 02-second-task/
│               ├── task.yml
│               ├── body.md
│               ├── hint.md
│               ├── bonus.md         # Bonus challenges (optional)
│               └── assets/          # Task-specific images
└── .cursor/
    └── rules/
        └── slidev-rules.mdc         # AI rules for slide creation
```

## 📝 Creating a New Lesson

### 1. Create Lesson Folder

```bash
mkdir -p lessons/02-new-lesson/slides/topic-name
mkdir -p lessons/02-new-lesson/tasks/01-first-task
```

### 2. Create lesson.yml

```yaml
name: New Lesson Title
position: 2
trainer: trainer@workshops.de
github_code_url: https://github.com/org/code-repo
git_tag_starting: main
slides_type: slidev
pdf_generation_enabled: true
stackblitz_enabled: true
codesandbox_enabled: false
deprecated: false
```

### 3. Create Main Slide File

Create `lessons/02-new-lesson/02-new-lesson.md` with the Slidev frontmatter.

### 4. Add Topic Slides

Create the 4-MAT structure:

- `slides/topic-name/why.md`
- `slides/topic-name/what.md`
- `slides/topic-name/how.md`
- `slides/topic-name/what-if.md`
- `slides/topic-name/task.md`

### 5. Add Tasks

Create a task folder with `task.yml` for metadata and separate `.md` files for content:

```
tasks/01-task-name/
├── task.yml           # Metadata (title, position, category, etc.)
├── body.md            # Main task description
├── hint.md            # Hints for participants (optional)
├── bonus.md           # Bonus challenges (optional)
├── trainer_hint.md    # Notes for trainers (optional)
└── assets/            # Task-specific images (optional)
```

**task.yml** - Only metadata:

```yaml
title: 'Task Title'
position: 1
category: 'Basics'
preparation: false
estimated_time_in_minutes: 15
always_unlocked: false
git_tag_completed: solution-01-task-name
```

**body.md** - Main task description with full Markdown support.

**hint.md** - Collapsible hints using `<details>` tags.

**bonus.md** - Additional challenges for fast learners.

**trainer_hint.md** - Notes visible only to trainers (common issues, time estimates, discussion points).

> **Note**: You can also include markdown content directly in `task.yml` using `body_markdown`, `hint_markdown`, etc., but separate files are recommended for better readability and editor support.

### 6. Build

Nothing to register: `npm run build` (the `workshop-slides` CLI from
[`@workshops.de/slidev-toolkit`](https://github.com/workshops-de/slidev-toolkit)) picks up every
`lessons/*/*.md` with `base:` and `out:` in its headmatter, builds it into `dist/<lesson>/` and exports
a PDF. `npm run dev` lists all lessons in an interactive menu (`npm run dev -- 02` starts lesson 02).

## 🎓 4-MAT Teaching Structure

Each topic follows the 4-MAT learning cycle:

| Phase       | Purpose    | Content                               |
| ----------- | ---------- | ------------------------------------- |
| **WHY**     | Connection | Why this matters, real-world problems |
| **WHAT**    | Conceptual | Core concepts, theory, definitions    |
| **HOW**     | Practice   | Step-by-step implementation           |
| **WHAT IF** | Creative   | Edge cases, alternatives, extensions  |

## 📦 Available Scripts

| Script                | Description                                    |
| --------------------- | ---------------------------------------------- |
| `npm run dev`         | Start development server (lesson menu)         |
| `npm run dev -- 01`   | Start dev server for lesson 01                 |
| `npm run build`       | Build all lessons and export PDFs into `dist/` |
| `npm run export`      | Export slides to PDF                           |
| `npm run preview`     | Preview built slides                           |

Build tooling, core dependencies (Slidev, Playwright, TypeScript, Vue) and the deploy workflow come from
[`@workshops.de/slidev-toolkit`](https://github.com/workshops-de/slidev-toolkit). To update them, bump
that one package.

## 🔗 Platform Integration

This template is designed to work with the workshops.de platform:

- **lesson.yml**: Defines lesson metadata synced to the platform
- **task.yml**: Defines task content synced to the platform
- **GitHub Sync**: The platform can automatically sync content from this repository

### Enabling GitHub Sync

1. Set the `github_course_url` in your course settings on the platform
2. Enable sync for the course
3. The platform will automatically import lessons and tasks

## 🎨 Customization

### Theme

Change the theme in your slide frontmatter:

```yaml
---
theme: seriph # or: default, apple-basic, etc.
---
```

### Styling

Use [UnoCSS](https://unocss.dev/) classes directly in your slides.

## 📚 Resources

- [Slidev Documentation](https://sli.dev/)
- [UnoCSS](https://unocss.dev/)
- [Mermaid Diagrams](https://mermaid.js.org/)
- [Shiki Syntax Highlighting](https://shiki.matsu.io/)

## 📄 License

MIT
