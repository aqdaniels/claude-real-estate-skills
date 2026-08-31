# claude-real-estate-skills

Source repo for agent skills that run on **claude.ai (web)**. Not an application: no build, no tests, no runtime. The deliverable is the Markdown in `skills/`, uploaded to claude.ai and consumed by Claude there at analysis time.

## The skills target web, not Claude Code

This is the single most important fact about this repo. Both skills call `web_fetch`, present output with `present_files`, write to `/mnt/user-data/outputs/`, and read `/mnt/skills/public/frontend-design/SKILL.md`. **These are correct and intentional. Do not "fix" them to `WebFetch`, the Artifact tool, or `artifact-design`.**

Consequences to respect when working here:

- Do not add `.claude/skills/`, a `.claude-plugin/` manifest, or anything else that would make these skills load in Claude Code. They would trigger and then fail mid-report on paths and tools that don't exist locally.
- Do not run or test a skill from Claude Code as a way of validating it. Validation is uploading to claude.ai and running it there against a real address.
- Editing these files with Claude Code is fine — the files are just Markdown. Only the execution environment is web-specific.

## Structure

`skills/<name>/SKILL.md` plus `references/`. `package-skills.sh` zips each skill into `dist/` for upload via Customize → Skills; the archive must keep the skill folder at its root, i.e. `SKILL.md` at `<skill-name>/SKILL.md`, not at the top level of the zip.

Note: Anthropic documents a 200-character limit on the frontmatter `description` (and 64 on `name`). Both skills currently exceed it — see "Editing skills" below before shortening anything.

## Scope

Dedicated to property evaluation. Two skills split by unit count: `property-analysis` (single-family) and `multifamily-analysis` (2+ units). New work should extend one of these or add a sibling under `skills/` with the same shape.

## Editing skills

- The `description` in a skill's frontmatter is its trigger. It's written as a long list of the phrasings a user would actually type ("run the numbers on", "would this cash flow"). Keep that density when editing — a terse description costs the skill its triggering.
- `SKILL.md` stays a workflow, not a manual. Formulas, source tables, and default assumptions belong in `references/`, which is read on demand mid-run.
- The **Honesty rules** section in each skill is load-bearing, not boilerplate. These reports are used to spend real money; the rules against inventing a comp, a rent, or a flood zone, and the requirement to label estimates and write "not found," take priority over producing a complete-looking report.
- The two skills deliberately mirror each other in section order, design intent, and tone. A change to one is usually a change to both.

## Regional focus

`references/data-sources.md` in both skills carries Louisiana and New Orleans specifics (Orleans Parish assessor, LSU AgCenter flood portal, city permit and blight portals, Restoration Tax Abatement) alongside national sources. When adding a region, follow that pattern: a national table first, then a state/city section naming the actual portals.
