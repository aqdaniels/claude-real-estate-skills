# Real estate skills

Agent skills for real estate research and deal evaluation, written for **Claude on the web (claude.ai)**. Give a market, a buy box, an address, a listing URL, or a rent roll and get back a sourced, decision-ready report — rendered as a self-contained HTML document.

## The skills

They form a pipeline: pick a market, find listings in it, underwrite one address, price the rehab. `deal-memory` isn't triggered directly — it's the shared persistence layer the other seven read from and write to.

| Stage | Skill | Use it for | Answers |
|---|---|---|---|
| 1. Market | [market-scan](skills/market-scan/SKILL.md) | A metro, city, county, ZIP, or neighborhood | Is this market worth hunting in, for which strategy, in which sub-markets |
| 2. Sourcing | [deal-finder](skills/deal-finder/SKILL.md) | Residential buy box — SFR, small multifamily, STR, land | Which currently listed properties fit, roughly screened |
| 2. Sourcing | [commercial-space-finder](skills/commercial-space-finder/SKILL.md) | Commercial lease/buy box — retail, restaurant, office/medical, industrial | Which currently listed spaces or buildings fit |
| 3. Underwrite | [property-analysis](skills/property-analysis/SKILL.md) | Single-family homes, condos, one address or several compared | What is it worth, what could go wrong, is it worth pursuing |
| 3. Underwrite | [multifamily-analysis](skills/multifamily-analysis/SKILL.md) | Duplex, triplex, fourplex, New Orleans double, 5–20 unit buildings, house hacks | What does it earn, what should it earn, what is it worth, max offer |
| 3. Underwrite | [commercial-property-analysis](skills/commercial-property-analysis/SKILL.md) | Retail, office/medical office, industrial/flex/warehouse under ~$5M | Lease-by-lease NOI, valuation, financing, max offer |
| 4. Condition | [rehab-estimator](skills/rehab-estimator/SKILL.md) | Photos, a listing, an inspection report, or a walkthrough of any property | What fixing it up will cost, in three scenarios |
| — | [deal-memory](skills/deal-memory/SKILL.md) | Shared persistence read/written by all the above | Where we left off on a property, market, or pipeline |

Routing between the three underwriting skills is by unit count and use: 1 residential unit → `property-analysis`, 2–20 residential units → `multifamily-analysis`, any commercial space → `commercial-property-analysis`.

## What they produce

The five research-and-report skills follow the same discipline:

- **Parallel research** against a documented source list — assessor records, comps, FEMA flood, schools, crime, permits, rent/lease comps — rather than model recall.
- **Every figure sourced or labeled.** Numbers are tagged as sourced, estimated, or "not found," with a pointer to where the user can check. Nothing is invented.
- **A trade-off section** in the underwriting skills — the subject property against building new in the same submarket, plus 1/5/10-year equity and return projections.
- **A verdict** that answers the question actually asked (buy, offer at $X, walk away, hunt this market or skip it), plus the one thing to verify before committing.
- **Deal memory** — each reads prior records for the same address/market before researching, and writes back what it found, so a second conversation about the same deal doesn't start from zero.

Region-specific sources are documented for Louisiana and New Orleans (assessor, flood, permit, and abatement portals) alongside the national ones, in each skill's `references/data-sources.md`.

## Install on claude.ai

### 1. Turn on code execution

Skills don't appear until this is enabled — it's the sandbox they run in.

- **Free, Pro, Max:** Settings → Capabilities → enable **Code execution and file creation**.
- **Team, Enterprise:** an organization Owner enables both **Code execution and file creation** and **Skills** under Organization settings → Skills.

Uploading your own skills requires a Pro, Max, Team, or Enterprise plan.

### 2. Build the zips

```bash
git clone https://github.com/aqdaniels/claude-real-estate-skills.git
cd claude-real-estate-skills
./package-skills.sh
```

This writes one zip per skill to `dist/` — currently `market-scan.zip`, `deal-finder.zip`, `commercial-space-finder.zip`, `property-analysis.zip`, `multifamily-analysis.zip`, `commercial-property-analysis.zip`, `rehab-estimator.zip`, and `deal-memory.zip`.

Each archive holds the skill *folder* at its root, which is the structure the uploader requires:

```
property-analysis.zip
└── property-analysis/
    ├── SKILL.md
    └── references/
```

If you zip by hand, don't zip the loose files — `SKILL.md` at the top level of the archive is rejected. On macOS, right-clicking the skill folder → **Compress** produces the correct layout.

### 3. Upload

In claude.ai, open **Customize → Skills**, click **+**, choose to create/upload a skill, and select a zip. Repeat for each skill you want. Upload `deal-memory` too — the other skills expect it to be present, even though you never invoke it by name. All are private to your account.

### 4. Use them

You don't invoke skills by name — Claude reads the descriptions and triggers the right one from what you ask. Start a new conversation and say what you're looking for:

> Is Cleveland a good rental market right now?

> Find me duplexes under $250k in New Orleans that would cash flow.

> 1234 Magazine St, New Orleans, LA 70130 — is this a good buy?

> Run the numbers on this duplex: <listing URL>

> What will it cost to fix up this place? <photos or inspection PDF>

Each produces a self-contained HTML report you can download and save as PDF. You can toggle any skill off in **Customize → Skills**.

### Updating

Skills don't auto-update from this repo. After `git pull` or editing a skill, re-run `./package-skills.sh` and re-upload the changed zip(s), replacing the existing skill.

## Layout

```
skills/
├── market-scan/
│   ├── SKILL.md
│   └── references/
│       ├── data-sources.md
│       └── scoring.md
├── deal-finder/
│   ├── SKILL.md
│   └── references/
│       ├── buy-box.md
│       ├── data-sources.md
│       └── screening-math.md
├── commercial-space-finder/
│   ├── SKILL.md
│   └── references/
│       ├── box.md
│       ├── data-sources.md
│       └── screening-math.md
├── property-analysis/
│   ├── SKILL.md
│   └── references/
│       ├── data-sources.md
│       ├── investment-math.md
│       └── tradeoff.md
├── multifamily-analysis/
│   ├── SKILL.md
│   └── references/
│       ├── data-sources.md
│       ├── underwriting.md
│       └── tradeoff.md
├── commercial-property-analysis/
│   ├── SKILL.md
│   └── references/
│       ├── data-sources.md
│       ├── leases.md
│       ├── tradeoff.md
│       └── underwriting.md
├── rehab-estimator/
│   ├── SKILL.md
│   └── references/
│       ├── cost-tables.md
│       └── zones.md
└── deal-memory/
    ├── SKILL.md
    └── references/
        └── templates.md
```

`SKILL.md` carries the workflow and the rules for each skill. The `references/` files are loaded as needed during a run, so detail lives there rather than in the skill body.

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
