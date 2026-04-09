---
name: source-to-blog-publisher
description: Use this skill when the user wants to turn one or more source links into a cited blog post, technical note, or GitHub Pages article, especially when the job includes extracting source text or images, expanding the content into an original post, fitting an existing site structure, updating index pages, and publishing via git/GitHub.
---

# Source To Blog Publisher

## Overview

This skill handles the end-to-end job of taking a source link and turning it into a publishable blog post with attribution. Use it when the work includes source extraction, rewriting and expansion, repo-aware publishing, and optional git push.

## When To Use

Trigger this skill when the user asks for things like:

- "Turn this link into a blog post"
- "Write a note based on this article/video/post and publish it"
- "Extract the images/text from this page and expand it into a technical note"
- "Post this as a GitHub note / GitHub Pages blog"
- "整理成博客并发布"

Use it for source types such as:

- Public webpages and articles
- Social posts and image notes
- Video or note pages where text must be extracted from page content or images
- Threads where the user wants a cited secondary write-up rather than a verbatim copy

Do not use this skill for:

- Pure summarization of text already pasted by the user
- General copyediting with no publishing step
- Cases where the user only wants raw scraping output and no post

## Workflow

### 1. Resolve the target publishing repo first

Before writing, locate the repo and publishing pattern:

- Find the likely site repo
- Identify where notes or blogs live
- Inspect one or two existing posts
- Match existing frontmatter, permalink style, asset folder naming, and index-page update pattern
- Look for site-level design guidance such as `DESIGN.md`, style tokens, layout docs, or strongly repeated visual patterns

If the target repo already has multiple published notes or blogs, treat those pages as the primary style reference. Use `DESIGN.md` or other design docs as supporting constraints, not as permission to make a single article visually inconsistent with the rest of the blog.

If multiple plausible repos exist and the right one is not obvious, pause and ask a short clarifying question.

### 2. Extract the source content

Choose the least fragile extraction method that still gets the needed fidelity:

- For normal pages: read page text and metadata
- For dynamic or login-gated pages: use a real browser flow and prefer an already authenticated local browser session when available
- For image-based notes: extract the original images first, then inspect the image text

For platforms that often gate content behind login or anti-bot layers:

- First try the share URL and follow redirects to the canonical page
- Then inspect the already-rendered DOM via a real browser instead of relying on static HTML
- Reuse the local browser profile or existing signed-in session when the environment already has access
- Extract loaded `document.images`, visible text, and metadata from the live page after hydration
- If the page is still partially gated, capture only what is visible and be explicit about the limit
- Treat prior successful extraction via authenticated browser automation as the preferred path, not a hack

Capture:

- Original title
- Author or account name if visible
- Source URL
- Publish time if visible
- Key text from the source
- Source images if they are part of the argument

Do not treat platform UI chrome as source content.

### 2.5. Build a source packet before drafting

Before writing the article, assemble a minimal source packet:

- source title
- author/account
- canonical URL and share URL when both exist
- publish time if visible
- extracted body text or a clean excerpt
- local copies of the key source images
- a short note about what was inferred vs. directly visible

This packet should be enough for another person to understand where the post came from without reopening the original link.

### 3. Decide the writing mode

Pick one of these modes before drafting:

- `technical-note`: explanatory, structured, practical
- `founder-note`: direct, opinionated, operator-focused
- `research-note`: source-grounded, careful, more analytical

Default to the style implied by the target repo and the user request. If the user asks for "去AI味", write with shorter claims, fewer canned transitions, and more concrete judgment.

### 3.5. Choose the presentation mode

After deciding the writing mode, choose the presentation mode:

- `native-minimal`: plain Markdown with light formatting when the site already uses understated note pages
- `design-system-article`: a styled article shell that explicitly uses repo colors, spacing, and card patterns
- `source-appendix`: when the source images matter, show a few key images inline and collapse the rest into an appendix rather than dumping a long unstructured gallery

Prefer `design-system-article` only when it still matches the site's existing note pages. If the rest of the blog is lighter, quieter, or more editorial, stay within that mode.

### 4. Expand without copying

The post should be an original write-up built from the source, not a rewrite that hugs the original wording.

Safe structure:

1. State the source claim or framing
2. Extract the core mechanism or example
3. Extend it with domain reasoning, tradeoffs, and practical interpretation
4. Add actionable templates, checklists, or examples if useful
5. End with a concise source note and scope disclaimer

Prefer:

- Interpretation
- Reframing
- Practical expansion
- Comparisons and edge cases

Avoid:

- Long verbatim source copying
- Claiming facts not supported by the source unless clearly marked as your extension
- Passing off the source author's wording as original prose

## Attribution Rules

Always include:

- Source author/account when available
- Source title when available
- Direct source URL

When source images are used:

- Store them under the post asset folder
- Mention that the article is based on or cites the original image note

If some interpretation goes beyond the source, make that visible with phrasing like:

- "Based on that example, a more complete startup version is..."
- "The original image stops at X; below is the practical extension..."

## Repo-Aware Publishing Rules

When editing the destination repo:

- Preserve the site's visual and structural conventions
- Reuse the existing article format instead of inventing a new one
- If `DESIGN.md` or equivalent exists, actively map article surfaces, colors, headings, and cards to that system
- Add the post asset folder only if needed
- Update the notes/blog landing page if the site clearly surfaces latest posts there
- Stage and commit only the files related to this article unless the user asks otherwise

When source images are numerous:

- Avoid full-length uncollapsed image dumps if they hurt readability
- Prefer a small highlighted source section plus a collapsible appendix or gallery
- Keep the article scannable before the reader reaches raw source material

Before pushing:

- Verify links and asset paths
- Verify the title, frontmatter, and permalink pattern
- Verify the visual hierarchy is intentional on both desktop and mobile
- Check `git status` carefully so unrelated files are not included

## Quality Bar

The finished post should satisfy all of these:

- A reader can tell what the original source was
- A reader can tell what is extension vs. what came from the source
- The article reads like a deliberate blog post, not a transcript cleanup
- The tone matches the target audience and site
- The post is publish-ready inside the repo with assets and index updates wired correctly
- The page looks intentionally designed inside the destination site's visual system
- Login-gated extraction steps are documented well enough that future runs can repeat them

## Escalation Points

Pause and confirm with the user if:

- The correct publishing repo is ambiguous
- The source is inaccessible or too incomplete to support a credible post
- The user wants strong factual claims that cannot be verified from the source
- The user wants a full legal, medical, or financial advisory article based on a weak source

## References

- For final pre-publish checks and frontmatter consistency, read [references/publishing-checklist.md](references/publishing-checklist.md).
