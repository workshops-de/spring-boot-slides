---
background: https://cover.sli.dev
title: Example Lesson
info: |
  ## Example Lesson
  This is an example lesson to demonstrate the slide structure.
class: text-center
drawings:
  persist: false
transition: slide-left
mdc: true
seoMeta:
  ogImage: auto
# Build configuration
base: /01-example-lesson/
out: ../../dist/01-example-lesson
theme: '@workshops.de/slidev-theme'
addons:
  - window-mockup
  - slidev-addon-tldraw
---

# Example Lesson

Welcome to this example lesson

<div class="pt-12">
  <span @click="$slidev.nav.next" class="px-2 py-1 rounded cursor-pointer" hover="bg-white bg-opacity-10">
    Press Space for next page <carbon:arrow-right class="inline"/>
  </span>
</div>

---

# Table of Contents

<Toc maxDepth="1"></Toc>

---
src: ./slides/example-topic/0-index.md
---

---
layout: end
---

# Thank You!

Questions?

<div class="abs-br m-6 text-xl">
  <a href="https://github.com/workshops-de" target="_blank" class="slidev-icon-btn">
    <carbon:logo-github />
  </a>
</div>
