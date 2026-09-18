---
name: rehab-estimator
description: Produce a line-item renovation budget for a property from photos, a listing URL, an inspection report, or a written walkthrough — grading six building zones (envelope, mechanical, plumbing, interior surfaces, kitchen/baths, structure/site), pricing every item as a range from regional cost tables, flagging hidden-cost risks by build era, and delivering three scenarios (rent-ready, mid-grade, full worst-case) plus deal impact (BRRRR/flip max offer, buy-and-hold capex) as a polished HTML report. Use this skill ANY time the user wants to know what fixing a property will cost, e.g. "estimate the rehab", "what will it cost to fix up", "investor special — what am I looking at", "read this inspection report and price the repairs", "is this a $20k or $60k rehab", "BRRRR numbers on", or uploads property photos or an inspection PDF and asks about condition or cost. Also trigger when a property surfaces as as-is, needs TLC, estate sale, or dated. Pair with property-analysis or multifamily-analysis for the full deal.
---

# Rehab estimator

Turn what can be seen about a property into a defensible repair budget: what needs doing, roughly what it costs here, what the photos can't tell you, and what that does to the deal. The reader is deciding whether to offer, what to offer, and how much cash to hold back, so every line is a range with a stated basis, and the report is loud about uncertainty rather than falsely precise.

This skill feeds `property-analysis` (SFR) and `multifamily-analysis` (2+ units), which use its totals in their financials, and is usually triggered by a candidate that `deal-finder` flagged as as-is or dated.

## Inputs, in order of usefulness

1. **Photos in the conversation** — uploaded walkthrough or inspection photos. Best input. Look at every one; note what each shows and which zone it covers.
2. **Inspection report (PDF)** — read it fully (see `/mnt/skills/public/pdf-reading/SKILL.md`). Inspector findings outrank photo inference. Extract every deficiency with its location and the inspector's severity language.
3. **Listing URL** — `web_fetch` for description, year built, sqft, beds/baths, foundation, roof, HVAC, and photo captions. Listing photos usually can't be viewed by fetch; say so, and lean on the description language ("as-is", "needs TLC", "original", "updated 2019", "new roof 2022"). Ask the user to upload the photos if they want the zone grades to be evidence-based.
4. **Written description or address only** — grade from year built, listing language, and regional norms; label the whole estimate **assumption-based** and widen ranges 25%.

Whatever the input, confirm the basics before pricing: sqft, beds/baths, stories, year built, foundation type, roof type, HVAC type, region. Pull missing ones from the listing or assessor (`<address> zillow`, `<address> assessor`) in one parallel search batch. If `property-analysis` already ran in this conversation, take them from there.

## Workflow

1. **Establish the target spec.** Ask once if not stated: is this for a rental (rent-ready), a retail sale or owner-occupant (mid-grade), or unknown? If unknown, produce all three scenarios and lead with rent-ready for an investor, mid-grade for an owner-occupant.

2. **Grade the six zones.** Use `references/zones.md`. For each zone assign a grade (A sound / B serviceable / C needs work / D replace or unknown-assume-worst), cite the evidence (photo number, inspection page, listing phrase), and list what the evidence cannot confirm. Unknown mechanicals in a pre-1980 house are graded D for the worst-case scenario and C for the others — say that explicitly.

3. **Build the line items.** Per zone, list each repair with quantity basis (sqft, linear ft, count, each) and unit cost from `references/cost-tables.md`, adjusted by the regional multiplier. Search once for local calibration — `<metro> cost to replace roof <year>`, `<metro> HVAC replacement cost` — and note where local quotes differ from the table. Every line is low–high. Include soft costs: permits, dumpster/haul-off, contingency (10% rent-ready, 15% mid-grade, 20% full), and holding costs if the user is flipping or BRRRR-ing (months × PITI + utilities).

4. **Flag hidden-cost risks.** From `references/zones.md` era table: items photos never show (wiring type, sewer line, subfloor, asbestos, lead, polybutylene, foundation movement, termite damage, permits closed). Each with the trigger (year built, region, symptom seen), a cost range if it materializes, and how to verify (sewer scope, panel inspection, termite letter, permit search). These go into the worst-case scenario at their cost and into the verify checklist for the others.

5. **Assemble three scenarios.**
   - **Rent-ready**: safe, functional, durable, clean. Repair over replace where serviceable. Rental-grade finishes.
   - **Mid-grade**: what a retail buyer expects in this ZIP — check what renovated sold comps show (`<zip> renovated sold`), don't over- or under-improve.
   - **Full / worst case**: mid-grade plus every hidden risk materializing plus D-grade replacements.
   Show each as a zone-by-zone table with subtotal, soft costs, contingency, total range, and $/sqft.

6. **Run the deal impact.** Use the section in `references/cost-tables.md`:
   - BRRRR: max purchase = 0.75 × ARV − rehab (mid-grade or rent-ready per strategy). ARV from renovated sold comps or from `property-analysis` if run.
   - Flip: max purchase = 0.70 × ARV − rehab − holding − selling costs; show margin.
   - Buy-and-hold: rehab as added basis → effect on all-in $/sqft, cash-on-cash, and first-year reserve; plus the capex items the rent-ready scenario defers and when they'll come due.
   - Owner-occupant: budget + contingency and the items worth negotiating as seller credits.
   Show the offer implication at low, mid, and high rehab.

7. **Write the verdict.** One paragraph: which scenario is realistic, the three biggest cost drivers, the two verifications that would most change the number (usually sewer scope and roof/HVAC age), and whether the property is a cosmetic, moderate, or heavy rehab in plain terms.

8. **Render.** HTML report (see Output), then a 3–5 sentence chat summary with the mid-point total, the biggest driver, and the offer implication. Offer to run or update `property-analysis` / `multifamily-analysis` with these numbers.

## Report structure

```
Header          Address, sqft/beds/baths/year/foundation, input basis (photos N / inspection / listing / assumption), overall rehab class badge (Cosmetic / Moderate / Heavy / Gut)
At a glance     Three scenario totals (low–high), $/sqft each, contingency %, top 3 cost drivers
Zone grades     Six-zone table: grade, evidence, what's unconfirmed
Line items      Per zone: item, qty basis, unit cost range, line total range, scenario(s) it applies to
Hidden risks    Era/region table: risk, trigger, cost if real, how to verify
Scenarios       Three side-by-side columns with subtotals, soft costs, contingency, total, $/sqft
Deal impact     Strategy-specific max offer / basis effect at low-mid-high rehab; deferred capex schedule
Verdict         Paragraph + verify-before-offer checklist (ordered by how much each could move the number)
Assumptions     Regional multiplier and source, finish level definitions, labor assumptions, what wasn't visible
Sources         Photos/pages referenced, cost calibration searches, comps used for ARV
```

## Output

Default deliverable is one self-contained HTML file in `/mnt/user-data/outputs/` named `rehab-estimate-<street-slug>.html`, presented with `present_files`. Read `/mnt/skills/public/frontend-design/SKILL.md` first for design quality.

Design intent: a contractor's scope sheet crossed with an analyst brief. Dense line-item tables, ranges rendered as ranges, zone grades as small badges, scenario columns side by side on desktop and stacked on a phone. Rehab class badge is the only strong color. Referenced photos appear as small numbered thumbnails only if the user uploaded them; never pull listing photos into the report. Print stylesheet.

If the user asks for a DXC-branded deliverable, use `dxc-docx` or `dxc-pptx` and keep the same structure.

## Honesty rules

- A photo shows a surface, not a system. Never state that wiring, plumbing, sewer, roof decking, or foundation are fine because they weren't visibly bad; grade them "unconfirmed" and price the risk.
- Cost tables are regional baselines, not quotes. Say once that the reader needs two or three contractor bids before relying on any number, and show the multiplier used.
- Don't invent a year built, sqft, or renovation date; if the listing and assessor disagree, show both.
- Inspection report findings are quoted by location and severity; don't soften an inspector's "safety hazard" into "minor".
- Not a licensed inspector, contractor, or engineer — say it once, in the Verdict.
