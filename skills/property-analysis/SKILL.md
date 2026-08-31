---
name: property-analysis
description: Generate a complete, sourced property analysis report from a street address — valuation and comps, sale/tax history, flood and hazard risk, neighborhood/schools/crime, rental and investment math, and a bottom-line verdict — delivered as a polished HTML report artifact. Use this skill ANY time the user gives a street address (or a listing URL) and wants to know about the property, e.g. "analyze this property", "is this a good buy", "what's this house worth", "pull comps for", "run the numbers on", "property report", "due diligence on", "should I make an offer on", "what's the flood risk at", or simply pastes an address and asks a question about it. Also trigger for rental/investment screening ("would this cash flow", "cap rate on") and for comparing two or more addresses. Trigger even if the user only says "look into this address" — that is this skill's job.
---

# Property analysis

Turn an address into a decision-ready report: what the property is, what it's worth, what could go wrong, and whether it's worth pursuing. The reader is someone about to spend real money, so every number needs a source or an explicit "estimate" label, and the report must say plainly when data couldn't be found.

## Workflow

1. **Normalize the address.** Confirm street, city, state, ZIP. If a listing URL was given, `web_fetch` it first — listings contain price, beds/baths, sqft, lot, year built, HOA, days on market, and photos. If the address is ambiguous, ask once; otherwise proceed.

2. **Research in parallel.** Fire all of these searches in the same turn; don't serialize them. Query patterns and preferred sources are in `references/data-sources.md` — read it before searching, especially the state/parish-specific section (Louisiana/New Orleans has dedicated assessor, flood, and permit portals worth hitting directly).
   - Listing & value estimates (Zillow, Redfin, Realtor.com, Homes.com)
   - Assessor / parcel record (assessed value, tax bill, homestead exemption, lot dimensions)
   - Sale & transfer history
   - Comparable sales (same neighborhood, ±20% sqft, last 6–12 months, sold not listed)
   - Flood zone (FEMA NFHL; for Louisiana also cite the LSU AgCenter portal — see references) and other hazards (wind/hurricane, subsidence, wildfire, earthquake as relevant to region)
   - Insurance context (NFIP/Citizens/private market conditions for that ZIP)
   - Schools (GreatSchools / state report cards), crime (city open data / Crimegrade / NeighborhoodScout), walkability
   - Rent estimates (Zillow Rent Zestimate, Rentometer, active rentals nearby)
   - Permits, code violations, blight/liens where a city portal exists
   - Neighborhood trend: median price, DOM, price/sqft trajectory, new development
   - New-build alternative: local cost to build per sq ft, new-construction listings and their price/insurance premium, buildable lots

   `web_fetch` the two or three most useful pages to get complete numbers rather than snippets. Homes.com neighborhood "sold" pages fetch reliably and give a full comps table plus market stats in one call — start there. Zillow/Redfin/FEMA MSC often refuse fetches; don't burn more than one attempt each.

3. **Reconcile.** Different sources disagree. Report the range, not one number. When AVMs (Zestimate etc.) span more than ~15%, say so and lean on the comps. Flag anything that looks off: assessed value far below market, sale history showing a flip, sqft mismatch between listing and assessor.

4. **Run the math.** Include the concessions table from the reference — the user's standing ask is a seller-paid rate buydown, so always size one against the current rate and show its monthly value next to an equivalent price cut. Use `references/investment-math.md` for the formulas and default assumptions. Always show inputs; a cap rate without the assumptions behind it is useless. Compute for owner-occupant (monthly PITI + insurance + flood) and, when the user is investing or asked, for rental (gross yield, NOI, cap rate, cash-on-cash, DSCR).

5. **Trade-off analysis — always.** Using `references/tradeoff.md`: compare buying the subject against buying or building a comparable new home in the same area (all-in cost, insurance, maintenance, resale premium, equity created), then project 1-, 5- and 10-year equity and returns — cumulative cost of owning vs renting, principal paydown, appreciation, equity, and (for investors) cash-on-cash and equity multiple — for the subject and the new-build alternative. Add new-construction cost and new-build comps to the parallel research batch in step 2.

6. **Write the verdict.** One paragraph. Answer the question the user is actually asking (buy? offer price? rent it? walk away?). State the two or three factors that drive the answer and the one thing they must verify in person or with a professional before committing.

7. **Render.** Produce the HTML report artifact (see Output). Then a 3–5 sentence chat summary with the verdict and the biggest risk. Offer a .docx or .pdf version only if the user might need to share it.

## Report structure

Use this section order. Drop a section only if it's irrelevant (e.g., no rental section for a pure owner-occupant question), never because data was hard to find — an empty section with "No public record found; verify with [source]" is more useful than a missing one.

```
Header        Address, property type, beds/baths/sqft/lot/year, verdict badge (Strong / Reasonable / Caution / Pass)
At a glance   4–6 key figures: est. value range, list price (if listed), $/sqft vs area, tax bill, flood zone, rent est.
Valuation     AVM range, comps table (address, sold date, price, sqft, $/sqft, distance), reconciled estimate, offer guidance, concessions table (seller-paid rate buydown first)
History       Sale/transfer history, price changes, tax history, assessed vs market
Risk          Flood zone + BFE + elevation cert status, insurance outlook, other hazards, permits/violations, age-related items (roof, foundation, wiring, plumbing by era)
Location      Neighborhood profile, schools with ratings, crime relative to city, walk/transit, commute anchors, trend
Financials    Owner-occupant monthly cost table; investor table if applicable; sensitivity (what rate/price makes it work)
Trade-off     Subject vs new-build comparison; 1/5/10-year equity & returns table (owning vs renting for owner-occupants)
Verdict       Paragraph + "verify before closing" checklist
Sources       Numbered list, every figure in the report traceable to one
```

## Output

Default deliverable is a single self-contained HTML file in `/mnt/user-data/outputs/` named `property-report-<street-slug>.html`, presented with `present_files`. Read `/mnt/skills/public/frontend-design/SKILL.md` first for design quality.

Design intent: this is a due-diligence document, not a listing brochure. Quiet, dense, readable on a phone. Figures in tabular numerals; ranges shown as ranges. Verdict badge is the only strong color. Every section has a small source-reference number linking to the Sources list. No stock photos; the listing photo (if any) appears once, small. Print stylesheet so it survives Save-as-PDF.

If the user asks for a DXC-branded deliverable, use `dxc-docx` or `dxc-pptx` instead of HTML and keep the same structure.

## Honesty rules

These matter more than completeness:

- Never invent a comp, a tax figure, a school rating, or a flood zone. If it isn't in a fetched source, write "not found" and name where the user can check.
- Label every model-derived number as **estimate** and show the inputs.
- AVMs are not appraisals; say so once, in the Valuation section, not in every sentence.
- Flood and insurance figures change fast and are policy-specific; give the zone and the direction of risk, not a premium quote, unless a source states one.
- Don't editorialize about the neighborhood's residents. Crime and school data are reported as numbers relative to the city, with the source.
- Not a licensed appraiser, inspector, or advisor — say it once, in the Verdict section.

## Comparing multiple addresses

Run the full workflow per address, then add a comparison table at the top (same "At a glance" figures side by side) and a verdict that ranks them with reasons. One HTML file, tabs or stacked sections.
