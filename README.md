# Real estate skills

Agent skills for evaluating properties, written for **Claude on the web (claude.ai)**. Give an address, a listing URL, or a rent roll and get back a sourced, decision-ready report — valuation, risk, financing math, and a verdict — rendered as a self-contained HTML document.

Two skills, split by unit count:

| Skill | Use it for | Answers |
|---|---|---|
| [property-analysis](skills/property-analysis/SKILL.md) | Single-family homes, condos, one address or several compared | What is it worth, what could go wrong, is it worth pursuing |
| [multifamily-analysis](skills/multifamily-analysis/SKILL.md) | Duplex, triplex, fourplex, New Orleans double, 5–20 unit buildings, house hacks | What does it earn, what should it earn, what is it worth on that income, what's the max offer |

One unit routes to `property-analysis`; two or more routes to `multifamily-analysis`.

## What they produce

Both skills follow the same discipline:

- **Parallel research** against a documented source list — assessor records, comps, FEMA flood, schools, crime, permits, rent comps — rather than model recall.
- **Every figure sourced or labeled.** Numbers are tagged as sourced, estimated, or "not found," with a pointer to where the user can check. Nothing is invented.
- **A trade-off section, always** — the subject property against building new in the same submarket, plus 1/5/10-year equity and return projections.
- **A verdict** that answers the question actually asked (buy, offer at $X, walk away), plus the one thing to verify before committing.

Region-specific sources are documented for Louisiana and New Orleans (assessor, flood, permit, and abatement portals) alongside the national ones.

## Install on claude.ai

```
./package-skills.sh
```

This writes `dist/property-analysis.zip` and `dist/multifamily-analysis.zip`. Upload each in **Settings → Capabilities → Skills**. Re-run the script and re-upload after editing a skill.

## Layout

```
skills/
├── property-analysis/
│   ├── SKILL.md                      workflow, report structure, honesty rules
│   └── references/
│       ├── data-sources.md           query patterns and preferred sources
│       ├── investment-math.md        formulas and default assumptions
│       └── tradeoff.md               subject vs new build, 1/5/10-year returns
└── multifamily-analysis/
    ├── SKILL.md
    └── references/
        ├── data-sources.md
        ├── underwriting.md           NOI, cap rate, DSCR, max offer, expense defaults
        └── tradeoff.md
```

`SKILL.md` carries the workflow and the rules. The `references/` files are loaded as needed during a run, so detail lives there rather than in the skill body.

## These are web skills, not Claude Code skills

They depend on the claude.ai environment and will not run correctly in Claude Code:

| Used | Why it's web-only |
|---|---|
| `web_fetch` | Claude Code's equivalent is `WebFetch` |
| `present_files` | No equivalent; Claude Code publishes via the Artifact tool |
| `/mnt/user-data/outputs/` | Web sandbox output path; no such path locally |
| `/mnt/skills/public/frontend-design/SKILL.md` | Bundled web skill; Claude Code's equivalent is `artifact-design` |

This repo deliberately contains no `.claude/skills/` or plugin manifest, so the skills don't auto-load in Claude Code and fail halfway through a report. Porting them would mean retargeting all four rows above.

## Scope

These reports are research and math, not professional advice — not an appraisal, inspection, or legal opinion. Each skill states this in its verdict section.
