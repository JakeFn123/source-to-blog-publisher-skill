# source-to-blog-publisher

A Codex skill that turns one or more source links into a cited blog post or GitHub Pages note, then helps publish it inside an existing repo.

This skill is designed for tasks like:

- turning a Douyin/X/WeChat/article link into a technical note
- extracting source images and text from a page
- expanding source content into an original post with attribution
- fitting the post into an existing `blogs/` or notes repo structure
- updating landing pages and publishing with git

## What the skill does

When triggered, the skill guides Codex to:

1. locate the correct publishing repo
2. inspect existing post conventions
3. extract source text, metadata, and images
4. expand the source into an original blog post
5. preserve attribution and source links
6. wire the post into the destination repo
7. verify git hygiene before commit/push

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

