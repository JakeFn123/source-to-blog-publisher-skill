# source-to-blog-publisher

A Codex skill that turns one or more source links into a cited blog post or GitHub Pages note, then helps publish it inside an existing repo.

This skill is designed for tasks like:

- turning a Douyin/X/WeChat/article link into a technical note
- extracting source images and text from a page
- expanding source content into an original post with attribution
- fitting the post into an existing `blogs/` or notes repo structure
- updating landing pages and publishing with git
- matching the destination repo's design system instead of shipping generic article pages
- handling dynamic or partially login-gated source pages through browser-based extraction

## What the skill does

When triggered, the skill guides Codex to:

1. locate the correct publishing repo
2. inspect existing post conventions
3. inspect repo design guidance such as `DESIGN.md` or repeated layout patterns
4. extract source text, metadata, and images
5. expand the source into an original blog post
6. preserve attribution and source links
7. wire the post into the destination repo
8. verify git hygiene before commit/push

## What changed in the updated workflow

This version is opinionated about two things that matter in real use:

- Design-aware publishing:
  If the destination repo has `DESIGN.md`, layout tokens, or a clear visual system, the skill should use that system rather than producing a generic Markdown page.

- Login-aware extraction:
  For Douyin and similar platforms, the skill should prefer a real browser flow, reuse the existing signed-in session when available, inspect the hydrated DOM, and extract loaded images and visible text from the rendered page.

## Install

### One-command install

```bash
curl -fsSL https://raw.githubusercontent.com/JakeFn123/source-to-blog-publisher-skill/main/install.sh | bash
```

### Install into a custom Codex home

```bash
curl -fsSL https://raw.githubusercontent.com/JakeFn123/source-to-blog-publisher-skill/main/install.sh | CODEX_HOME=/path/to/codex bash
```

### Local install from a clone

```bash
bash install.sh
```

## Uninstall

```bash
bash uninstall.sh
```

## Usage

Once installed, Codex can trigger it automatically from the task description, or you can invoke it explicitly.

Example prompts:

```text
Use $source-to-blog-publisher to turn this source link into a cited blog post and publish it.
```

```text
用 $source-to-blog-publisher 把这个链接整理成博客并发布。
```

```text
Use $source-to-blog-publisher to extract the source images and write a founder-style note for my GitHub Pages repo.
```

## Best-fit tasks

This skill works best when the task is:

- source-driven
- citation-sensitive
- repo-aware
- publish-oriented

It is not meant for:

- plain summarization of user-pasted text
- generic blog ideation with no source material
- bulk web scraping with no writing or publishing step

## Extraction guidance for gated platforms

When a source page is dynamic, partially login-gated, or anti-bot protected, the intended flow is:

1. open the share link in a real browser
2. follow redirects to the canonical page
3. inspect rendered text and `document.images` after hydration
4. reuse the local browser's authenticated state when available
5. save the key source images locally before drafting

The goal is not to bypass access controls in a shady way. The goal is to use the same already-available viewing context a human would use, then turn that visible material into a cited post.

## Repo layout

```text
source-to-blog-publisher-skill/
├── install.sh
├── uninstall.sh
├── README.md
└── source-to-blog-publisher/
    ├── SKILL.md
    ├── agents/
    │   └── openai.yaml
    └── references/
        └── publishing-checklist.md
```

## How installation works

The installer copies the `source-to-blog-publisher/` folder into:

```text
${CODEX_HOME:-$HOME/.codex}/skills/source-to-blog-publisher
```

If the skill already exists, the installer replaces it.

## Notes

- The skill itself contains the workflow and publishing rules.
- The checklist file is intentionally short and practical.
- This repo packages the skill for reuse and simple distribution.
