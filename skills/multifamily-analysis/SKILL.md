---
name: multifamily-analysis
description: Underwrite a small multifamily property (duplex, triplex, fourplex, New Orleans double, or 5–20 unit building) from an address, listing URL, rent roll, or T12 — unit mix and rent roll, market rents per unit, income-based valuation, actual vs pro forma expenses, house-hack/FHA and investor financing, cap rate/DSCR/cash-on-cash, value-add upside, tenant and legal risk, and a max offer price — as a polished HTML report. Use ANY time the user mentions a duplex, triplex, fourplex, quad, double, shotgun double, multi-unit, multifamily, apartment building, rental with more than one unit, or "house hack", or gives an address and asks whether it would "cash flow", "pencil", "what's the cap rate", "what should I offer", "underwrite this", or "run the numbers". Also for evaluating a pasted rent roll or pro forma, and for comparing income properties. Single-family homes go to property-analysis; two or more units means this skill.
---

# Multifamily analysis

An income property is bought on its numbers. The report answers four questions in order: what does it earn today, what should it earn, what is it worth on that income, and what's the most you can pay and still hit your return. Everything else — condition, location, tenants, law — feeds those four.

## Workflow

1. **Establish the facts.** Fetch the listing URL if given. Capture: unit count and mix (beds/baths/sqft per unit), current rents per unit, occupancy, lease terms, who pays which utilities, metering (separate vs master), year built, lot, parking, laundry, roof/HVAC/water-heater ages, and anything the listing says about "pro forma" or "potential" rent — that word means the seller is quoting what they wish it earned. If the user pasted a rent roll or T12, treat that as ground truth over the listing.

2. **Ask only what changes the answer.** Before research, confirm at most two things if not stated: (a) house-hack (owner occupies one unit) or pure investment, and (b) any target — cash-on-cash, cap rate, or "just needs to cover itself." Default: pure investment, 20–25% down, target ≥ 1.25 DSCR and positive cash flow after reserves.

3. **Research in parallel.** Read `references/data-sources.md` first — it carries the sources and the Louisiana/New Orleans specifics. Fire these in one turn:
   - Listing / AVM and sale history
   - Assessor record (assessed value, tax bill, homestead status — matters for house-hack)
   - **Rent comps per unit type** (2–3 active rentals of similar beds/sqft within ~1 mile, plus Zillow/Rentometer estimates) — this is the most important research; get real listings, not just an index
   - Sold comps for similar unit-count properties in the last 12 months (price, $/unit, $/sqft, GRM if rents are disclosed)
   - Market cap rates for the submarket and asset class (search `<city> duplex cap rate <year>`, brokerage reports)
   - Flood zone, insurance context (multi-unit and non-owner-occupied policies price differently)
   - Neighborhood trend, crime, schools, walkability, employment anchors
   - Local landlord-tenant rules, STR rules, rental registration/inspection programs, rent control if any
   - Permits, violations, blight, and whether the unit count is legal (zoning/certificate of occupancy)
   - New-build alternative: local construction cost per unit/sq ft, multifamily-zoned land prices, new-build rent premium, and incentives (Opportunity Zone, Restoration Tax Abatement, PILOT)

4. **Build the rent roll two ways.** *In-place*: what it earns today. *Market*: what each unit should earn at current comps. The gap is the value-add and the risk — a building 30% under market is either an opportunity or a sign of tenants who can't pay more. Show both columns.

5. **Classify the deal first.** Stabilized (occupied, in-place NOI) → cap-rate/DSCR underwriting. Heavy value-add or distressed (vacant, foreclosure, rehab > ~$15k/unit) → developer-margin underwriting with bridge-then-refi financing; the max offer is a function of verified rehab cost, and the seller's equity claim must be recomputed. The reference covers both.

6. **Underwrite.** Use `references/underwriting.md` for the formulas and default assumptions. Produce: NOI (in-place and stabilized), cap rate at list, income-based value, DSCR, cash flow, cash-on-cash, and the **max offer price** that hits the user's target. Include payroll for 21+ units. Run a house-hack version too whenever the property is 2–4 units and the user hasn't ruled it out — FHA 3.5% down with rental income counted changes the picture completely.

7. **Trade-off analysis — always.** Using `references/tradeoff.md`: (a) compare the subject against building the equivalent property new in the same submarket (all-in cost, time to stabilization, stabilized NOI, value, equity created, risk); (b) project 1-, 5- and 10-year cash flow, equity, cash-on-cash, total return and equity multiple for the subject and the new-build alternative. Add the new-construction cost, land and new-build rent searches to the parallel research batch in step 3.

8. **Sensitivity and downside.** One unit vacant for 3 months; rents 10% below assumption; insurance +30%; rate +1%. State the scenario in which the deal breaks.

9. **Verdict.** One paragraph: does it pencil, at what price, under which financing, and what single fact — usually verified rents, an insurance quote, or legal unit count — must be confirmed before the offer goes in. Then the concessions table (seller-paid rate buydown first, per the underwriting reference).

10. **Render.** HTML artifact (see Output), then a 4–6 sentence chat summary leading with the verdict and max offer.

## Report structure

```
Header        Address, unit count/mix, sqft, year built, list price, $/unit, verdict badge (Pencils / Pencils at $X / Value-add only / Pass)
At a glance   List price, $/unit, in-place gross rent, market gross rent, cap rate at list (in-place), stabilized cap, DSCR, max offer
Rent roll     Table per unit: beds/baths/sqft, current rent, lease end, market rent, gap, utilities paid by, notes
Income        In-place vs stabilized: GPR, vacancy, other income, EGI; rent comps table with sources
Expenses      Line items actual vs underwritten (taxes reset at sale, insurance, utilities owner pays, maintenance, CapEx, mgmt, admin/legal), expense ratio; call out anything the seller's pro forma omits
Valuation     Income approach (NOI / market cap), sales comps ($/unit, $/sqft, GRM), reconciled range, offer guidance, concessions table
Financing     Investor 20–25% down and, for 2–4 units, house-hack FHA/5% conventional: monthly debt service, cash to close, DSCR, cash flow, cash-on-cash for each
Trade-off     Subject vs new build comparison table; 1/5/10-year returns & equity table for both; crossover year
Sensitivity   Downside table + break-even rent and break-even price
Risk          Flood/insurance, legal unit count & zoning, tenant/lease risk, deferred maintenance by era (lead paint pre-1978, knob-and-tube, cast iron), local landlord law, STR rules
Location      Neighborhood, renter demand signals, crime (with Community Crime Map link where available), schools, transit, trend
Verdict       Paragraph + max offer + verify-before-offer checklist
Sources       Numbered; every figure traceable
```

## Output

Single self-contained HTML file in `/mnt/user-data/outputs/` named `multifamily-report-<street-slug>.html`, presented with `present_files`. Read `/mnt/skills/public/frontend-design/SKILL.md` first. Same design intent as property-analysis: a due-diligence document, quiet and dense, tabular numerals, one strong color for the verdict, every figure tagged `src` / `est` / `not found`, print stylesheet. The rent roll and the income/expense tables are the center of the document; give them room.

If the user asks for a DXC-branded deliverable, use `dxc-docx` or `dxc-pptx` with the same structure.

## Honesty rules

- Never invent a rent, a comp, an expense, or a cap rate. "Not found — request the seller's T12 and leases" is the correct line.
- Pro forma is the seller's claim; label it as such and underwrite to market comps, not to it.
- Seller-reported expenses are almost always low. When the expense ratio comes in under 35% for an older building, say so and underwrite to the reference defaults.
- Taxes reset at sale — never use the seller's tax bill in the buyer's underwriting.
- AVMs are nearly useless for 2–4 units; say it once and lean on income and $/unit comps.
- Report crime and school figures as numbers relative to the city, with sources.
- Not a licensed appraiser, broker, lender, or attorney — state once in the Verdict.

## Multiple properties

Run the full workflow per property, then lead with a comparison table (price, $/unit, in-place cap, stabilized cap, DSCR, cash-on-cash, max offer) and a ranked verdict. One HTML file.
