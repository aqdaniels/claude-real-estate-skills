---
name: deal-memory
description: Shared persistence protocol for the real-estate skill set (market-scan, deal-finder, property-analysis, multifamily-analysis, rehab-estimator). Defines where deal records, market caches, county portal configs, the pipeline registry, and the estimated-vs-actual learnings log live, how every skill reads them before researching and writes to them after, and how to answer status questions from them. Use this skill ANY time a real-estate skill starts (read-before-research) or finishes (write-after-report), and directly whenever the user asks "where are we on", "what's in my pipeline", "show my deals", "update the deal", "I got a quote for", "we closed on", "mark it as passed", "what did we find last time", "which markets have we scanned", or wants to record an actual number (rent, insurance quote, contractor bid, appraisal) against an earlier estimate. Also trigger when a user mentions a property or market that may have been researched in a prior conversation — check the record before re-researching.
---

# Deal memory

The five research skills each produce a report and forget. This protocol makes them remember: one record per property, one cache per market, a pipeline view, and a running log of how estimates compared to reality. The goal is that the second conversation about a property starts where the first one ended, and that the tenth rehab estimate is better calibrated than the first.

## Where it lives

The store is a folder tree. Its root depends on where Claude is running:

| Environment | Root | How to access |
|---|---|---|
| claude.ai / Claude app with Google Drive connected | Drive folder `Real Estate Deals/` (create if missing) | `Google Drive:search_files` to find, `read_file_content` to read, `create_file` to write. Search by exact file name (e.g. `deal-1234-example-st.md`) — Drive search is name-based, so names must be deterministic. |
| claude.ai without Drive | None persistent — the container resets | Embed the deal record as a `<!-- deal-memory -->` block at the bottom of every HTML report and offer the `.md` sidecar for download; on the next run ask the user to upload the sidecar, or use `conversation_search` to find the prior report in past chats. |
| Claude Code / Cowork with a project folder | `./deals/` under the project | Plain filesystem reads and writes. |

Say which mode is active once per conversation, in one sentence, the first time a record is read or written. Never silently skip persistence: if nothing can be written, say so and attach the sidecar.

## Layout

```
Real Estate Deals/               (or ./deals/)
  pipeline.md                    one line per deal — slug, address, type, status, last skill, next action, date
  learnings.md                   estimated vs actual, appended by any skill when an actual arrives
  markets/
    <city-or-zip-slug>.md        market-scan output card; 90-day freshness
  counties/
    <state>-<county>.md          assessor / permit / tax portal URLs and quirks; no expiry
  deals/
    <slug>/
      deal.md                    the record (schema below)
      <skill>-<yyyymmdd>.html    each report as delivered
      <skill>-<yyyymmdd>.md      the sidecar card that skill produced
```

Slug = house number + street, lowercase, hyphens, no suffix: `1234-example-st`. Multi-unit and condos add the unit only if the record is for one unit. Markets: `metairie-la` or `70001`. Counties: `la-jefferson`, `fl-orange`.

## deal.md schema

```markdown
---
slug: 1234-example-st
address: 1234 Example St, Metairie, LA 70001
type: duplex            # sfr | duplex | triplex | fourplex | 5-plus | condo | land
units: 2
status: analyzing       # watching | screening | analyzing | offering | under-contract | owned | passed | sold
strategy: ltr           # ltr | house-hack | str | brrrr | flip | owner-occupant
list_price: 349000
year_built: 1962
sqft: 2100
source_listing: https://...
first_seen: 2026-08-30
last_updated: 2026-09-14
next_action: Get sewer scope quote before offer
---

## Key numbers (latest, with source skill and date)
| Metric | Value | Basis | Skill / date |
|---|---|---|---|
| Value estimate | $335k–$355k | comps ×5, moderate confidence | multifamily-analysis 2026-08-30 |
| Market rent | $1,450 + $1,350 | ZIP actives + Rentometer | multifamily-analysis 2026-08-30 |
| In-place rent | $1,200 + vacant | listing | deal-finder 2026-08-30 |
| Rehab (rent-ready) | $18k–$27k | photos ×22, mult 1.10 | rehab-estimator 2026-09-02 |
| Roof quote | $14,200 | contractor bid | user 2026-09-14  ← actual |
| Max offer | $318k | DSCR 1.25 floor | multifamily-analysis 2026-08-30 |

## Run log
- 2026-08-30 deal-finder — surfaced from Metairie duplex search, screen score 74, flagged pre-1970 + tenant-occupied
- 2026-08-30 multifamily-analysis — verdict Reasonable; roof age unknown; max offer $318k
- 2026-09-02 rehab-estimator — Moderate class; rent-ready $18–27k; sewer scope and roof age are the swing items
- 2026-09-14 user — roof quote $14,200 (est. range was $9–15k) → learnings.md

## Open items
- [ ] Sewer scope
- [x] Roof quote
- [ ] Insurance quote (Citizens vs private)

## Notes
Free text the user adds. Do not store seller or tenant names, phone numbers, or anything not in public record.
```

Rules for the record:

- **Actuals beat estimates.** When the user supplies a real number (bid, quote, appraisal, signed lease, closing statement), it replaces the estimate in Key numbers, is tagged `← actual`, and a line goes to `learnings.md`. Never overwrite an actual with a later estimate.
- **Keep history in the run log, current state in Key numbers.** The table is always the latest; the log is append-only.
- **Status moves forward on the user's word only.** A skill never marks a deal offered, under contract, or owned. It can suggest.
- **Don't store people.** Seller names, agent phone numbers, tenant details, owner mailing addresses stay out even if a listing or record shows them. Public parcel data (assessed value, tax, permits) is fine.

## What each skill does

**On start** (before any web research):

1. Locate the store (table above). If Drive: search for `pipeline.md`; if absent, this is a fresh store — say so and continue.
2. For an address: search for `deal-<slug>.md` / `deals/<slug>/deal.md`. If found, read it and reuse every Key number newer than the freshness limit below; tell the user in one line what was reused and from when. Research only what is missing or stale.
3. For a market or ZIP: search `markets/<slug>.md`. Fresh → reuse the card, skip the market research batch, cite it as "market card dated …". Stale → re-run and overwrite.
4. For any county touched: read `counties/<state>-<county>.md` and use its portal URLs and quirks instead of rediscovering them.
5. Also `conversation_search` the address or market name once — a prior conversation may hold a report that never got persisted.

Freshness limits: listing data 14 days · rent estimates 30 days · comps and value 60 days · market card 90 days · county config never expires · rehab estimate until new photos or inspection arrive.

**On finish** (after presenting the report):

1. Write or update `deals/<slug>/deal.md`: merge Key numbers (respecting actuals), append a run-log line, update `last_updated`, propose `next_action`.
2. Save the report HTML and the sidecar `.md` card into the deal folder.
3. Update the deal's line in `pipeline.md` (create the line if new).
4. `market-scan` additionally writes `markets/<slug>.md`; any skill that learned a portal URL or quirk writes `counties/<state>-<county>.md`.
5. If Drive isn't available: embed the sidecar card in the HTML and offer the `.md` for download in the same `present_files` call.

Do all of this without narrating each write. One closing line is enough: "Saved to the deal record; next action logged as …".

## Market card (`markets/<slug>.md`)

Frontmatter: slug, geography, as_of, strategy_assumed, verdict, scores (cash_flow, appreciation, risk). Body: the At-a-glance figures with sources, the sub-market tier table, the operating-climate summary, and the deal-finder criteria the scan recommended. This is what `deal-finder` and `property-analysis` read instead of re-scanning.

## County config (`counties/<state>-<county>.md`)

Assessor URL and search quirks, tax bill portal, permit/code-violation portal, flood lookup, STR ordinance link, reassessment rule (e.g., FL Save Our Homes reset, LA quadrennial), typical non-homestead effective tax rate, insurance notes. Append; never expire. This is the file that makes the fifth property in a parish faster than the first.

## learnings.md

One line per actual received:

```
| date | slug | metric | estimated | actual | error | skill | note |
| 2026-09-14 | 1234-example-st | roof replace | $9k–15k | $14,200 | within range, high end | rehab-estimator | New Orleans mult 1.10 → consider 1.15 for roofing |
```

Every skill reads the last ~20 lines on start and adjusts: if rehab estimates in a metro have run low three times, rehab-estimator says so and nudges its multiplier; if rent estimates ran high, property-analysis leans on the low end of the range. State any adjustment made and why in the report's Assumptions section.

## pipeline.md

```
| slug | address | type | status | strategy | last skill (date) | next action | headline |
```

Sorted by status (under-contract, offering, analyzing, screening, watching, then owned, passed, sold). This is the file to read when the user asks "where are we" or "what should I work on".

## Answering status questions

"Where are we on the Metairie duplex?" → read `pipeline.md` and the deal's `deal.md`; answer in 3–5 sentences from Key numbers, Open items, and next_action. Don't re-run any research unless asked or unless a number is stale and the user is about to act on it — then say which number and offer to refresh.

"What's in my pipeline?" → render `pipeline.md` as a short table in chat, grouped by status, with the next action per deal. Offer to open any one.

"Mark it passed / we closed / I offered $X" → update status and log the user's statement with date; for closings, ask for the numbers worth recording as actuals (price, rate, insurance, rents) and file them to `learnings.md`.

## Honesty rules

- A record is a snapshot; every reused number carries its date in the report. Never present a 60-day-old comp as current without saying so.
- If the store can't be read or written, say so in one sentence and fall back to the sidecar. Don't pretend persistence happened.
- The record contains estimates from prior runs, which may be wrong. A skill re-running on fresh data should note disagreements with the record, not silently overwrite.
- No personal data about sellers, tenants, agents, or owners beyond what a public parcel record shows.
