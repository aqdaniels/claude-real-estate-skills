# Templates

Copy these when creating a fresh store or a new record. Keep the frontmatter keys exactly as shown so every skill can parse them.

## pipeline.md (new store)

```markdown
# Pipeline
Updated: <date>

| slug | address | type | status | strategy | last skill (date) | next action | headline |
|---|---|---|---|---|---|---|---|
```

## learnings.md (new store)

```markdown
# Learnings — estimated vs actual
One line per actual. Skills read the last ~20 on start.

| date | slug | metric | estimated | actual | error | skill | note |
|---|---|---|---|---|---|---|---|
```

## markets/<slug>.md

```markdown
---
slug: metairie-la
geography: Metairie, Jefferson Parish, LA (ZIPs 70001, 70002, 70003, 70005, 70006)
as_of: 2026-08
strategy_assumed: ltr
verdict: Selective
cash_flow: 3
appreciation: 3
risk: 2
---

## At a glance
| Metric | Value | As of | Source |
|---|---|---|---|

## Sub-market tiers
| ZIP / area | Tier | Median price | Median rent | Yield | Rationale |
|---|---|---|---|---|---|

## Operating climate
Tax · Insurance · Landlord-tenant · STR — one line each with source.

## Recommended deal-finder criteria
Geography, price cap, type, floors — as the scan recommended.
```

## counties/<state>-<county>.md

```markdown
---
county: Jefferson Parish
state: LA
---

| Need | URL / how | Quirk |
|---|---|---|
| Assessor | | |
| Tax bill | | |
| Permits / code enforcement | | |
| Flood lookup | | |
| STR ordinance | | |
| Reassessment rule | | |
| Non-homestead effective tax rate | | |
| Insurance notes | | |
```

## deals/<slug>/deal.md

See the schema in SKILL.md. Minimum viable record on first creation: frontmatter, one Key numbers row, one run-log line, `next_action`.

## Sidecar card (`<skill>-<yyyymmdd>.md` and the `<!-- deal-memory -->` HTML block)

The card is the skill's contribution to the record in a form another skill can merge without reading the whole report:

```markdown
---
skill: rehab-estimator
slug: 1234-example-st
date: 2026-09-02
---
| Metric | Value | Basis |
|---|---|---|
| Rehab rent-ready | $18k–$27k | photos ×22, mult 1.10 |
| Rehab mid-grade | $41k–$58k | comps show mid spec |
| Rehab class | Moderate | $31/sqft mid |
| Swing items | sewer scope, roof age | |
next_action: Sewer scope before offer
```

Embed the same text inside the HTML report as the last element:

```html
<!-- deal-memory
... card text ...
-->
```

## Integration paragraph for each research skill

Add this section, verbatim, to the SKILL.md of market-scan, deal-finder, property-analysis, multifamily-analysis, and rehab-estimator, just before "Honesty rules":

```markdown
## Deal memory

Follow the `deal-memory` skill. Before researching, locate the store and read the deal record (`deals/<slug>/deal.md`), the market card (`markets/<slug>.md`), the county config, and the last ~20 lines of `learnings.md`; reuse anything within its freshness limit and say in one line what was reused. After presenting the report, write the sidecar card, update `deal.md` and `pipeline.md`, save the report into the deal folder, and log a `next_action`. If no store is writable, embed the card in the HTML and offer the `.md` sidecar for download. Never store seller, tenant, agent, or owner personal details.
```
