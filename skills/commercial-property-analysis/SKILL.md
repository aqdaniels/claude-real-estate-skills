---
name: commercial-property-analysis
description: Underwrite a commercial property under ~$5M — retail (strip, single-tenant NNN, pad), office/medical office, or industrial/flex/warehouse — from an address, LoopNet/Crexi URL, offering memorandum, rent roll, or T12. Abstracts every lease (term, escalations, options, recoveries), builds in-place vs market NOI, values on cap rate and $/sqft comps, sizes conventional, SBA 504/7(a) owner-user, and bridge debt, computes DSCR/cash-on-cash/IRR, stress-tests rollover, and delivers a max offer as a polished HTML report. Use ANY time the user mentions a commercial building, strip center, NNN or net lease, office building, medical office, industrial, warehouse, flex, pad site, an OM, a LoopNet/Crexi link, a commercial cap rate, or buying a building for their own business (owner-user, SBA loan). Also for "underwrite this", "does this pencil", "what should I offer", "WALT", "tenant credit". 1–20 residential units go to property-analysis / multifamily-analysis; any commercial space means this skill.
---

# Commercial property analysis

A commercial building is a bundle of leases with a roof on it. Its value is the income those leases produce, discounted for how likely they are to keep producing it. So the report answers five questions in order: what do the leases say, what does the property earn today, what should it earn, what is it worth on that income, and what's the most you can pay and still hit your return — then the risk that the leases don't perform.

Everything below $5M is the "private capital" tier: local banks and credit unions, SBA for owner-users, and a buyer pool of individuals and small LLCs. Underwrite to how those lenders and buyers actually behave, not to institutional conventions.

## Workflow

1. **Read deal memory first.** Follow the `deal-memory` skill: look for an existing record for this address or market before researching. Say which persistence mode is active.

2. **Establish the facts.** Fetch the listing/OM if given. Capture: property type and subtype, building sqft (GLA/RSF vs gross), land acres, year built and renovations, zoning, parking count and ratio, clear height and dock/grade doors (industrial), frontage and traffic count (retail), occupancy, number of tenants, and everything the OM says about rents — then treat the OM as the seller's argument, not the truth. If the user pasted a rent roll, T12, or leases, those override the OM.

3. **Ask only what changes the answer.** Confirm at most two things if not stated: (a) **strategy** — passive/stabilized hold, value-add/reposition, or owner-user (their business occupies ≥51%); and (b) any **return floor** — cash-on-cash, cap rate, or DSCR. Defaults: passive hold, 25% down conventional, target DSCR ≥ 1.25 and cash-on-cash ≥ 8%. For owner-user, the question becomes rent-vs-own, and the floor is "occupancy cost ≤ what we'd pay a landlord."

4. **Abstract the leases.** Read `references/leases.md`. For every tenant (or the top tenants by rent if there are more than ~8): name, use, sqft, base rent and $/sqft/yr, commencement, expiration, remaining term, escalations, renewal options and whether they're at fixed or market rent, expense structure (NNN / modified gross / full-service), what the tenant reimburses and any caps, co-tenancy or exclusive-use clauses, personal or corporate guaranty, and tenant credit tier. Compute **WALT** and the **rollover schedule** (% of rent expiring each year for 5 years). A building with 60% of rent expiring in 24 months is a different deal from one with a 12-year Walgreens lease, at the same cap rate.

5. **Research in parallel.** Read `references/data-sources.md` first — it carries the sources, the property-type specifics, and the Louisiana/Gulf Coast rows. Fire these in one turn:
   - Listing / OM, sale and transfer history, assessor record (assessed value, tax bill, whether taxes will reassess at sale)
   - **Market rent comps for the property type** (3–5 active lease listings within the submarket, same use and size class, quoted as $/sqft/yr with expense structure) — the most important research; a real listing beats a survey number
   - Sold comps: 3–6 same-type sales ≤ 24 months, $/sqft, cap rate if disclosed, occupancy at sale
   - Submarket cap rates, vacancy and asking rent trend (brokerage reports: CBRE, Colliers, Marcus & Millichap, Cushman, local firms)
   - Tenant credit: public filings, news, store-closure lists, franchisee vs corporate, Google reviews trend for local tenants
   - Zoning and permitted uses, parking requirements, any overlay or redevelopment plans; traffic counts (retail); truck access and power (industrial)
   - Flood zone, wind/hail exposure, insurance climate; environmental red flags (prior gas station, dry cleaner, auto repair, industrial history — a Phase I is non-negotiable if any appear)
   - Roof, HVAC, parking-lot age; ADA status; fire/life safety
   - Local commercial rules: sales/occupational tax, business license, signage, STR/short-term commercial use, any commercial rent regulation
   - Lender terms: search current commercial real estate loan rates, SBA 504 debenture rate, and local bank owner-occupied commercial rates — never assume
   - New-build alternative for the trade-off: local construction cost per sqft for the type, commercial land $/sqft or $/acre, and incentives (Opportunity Zone, Restoration Tax Abatement, ITEP, PILOT, Enterprise Zone)

6. **Build NOI two ways.** *In-place*: current rent roll, actual recoveries, actual expenses (adjusted for taxes at the buyer's basis and a real management fee). *Market/stabilized*: every space at market rent, market vacancy, structural vacancy for rollover, and a leasing-cost reserve (TI + commissions + downtime) — read `references/underwriting.md`. The gap between them is either the upside or the reason the seller is selling.

7. **Classify the deal first.** Stabilized (≥ 85% occupied, WALT ≥ 3 years, credit tenants) → cap-rate/DSCR underwriting. Value-add (vacancy, below-market rents, near-term rollover, deferred maintenance) → stabilization pro forma with lease-up costs and bridge-then-refi financing; max offer is a function of verified lease-up cost and time. Owner-user → rent-vs-own with SBA 504/7(a) financing; the property's "income" is the rent the business no longer pays. The reference covers all three.

8. **Underwrite.** Use `references/underwriting.md`. Produce: NOI (in-place and stabilized), cap rate at list on both, income value at the market cap, sales-comp value, DSCR, cash flow, cash-on-cash, 5- and 10-year unlevered and levered IRR with an exit at a cap rate 25–50 bps above entry, equity multiple, and the **max offer price** that hits the user's floor. For owner-user, add the occupancy-cost comparison and the SBA structure.

9. **Trade-off analysis — always.** Using `references/tradeoff.md`: compare the subject against building the equivalent property new in the same submarket (all-in cost, time to stabilization, stabilized NOI, value at completion, equity created, risk), and against the "do nothing / keep leasing" case for owner-users. Project 1/5/10-year cash flow, equity and returns for each.

10. **Sensitivity and downside.** Largest tenant leaves at expiration and the space takes 12 months to re-lease at market; rents 10% below assumption; exit cap +100 bps; rate +1%; insurance +30%; one capital item (roof, HVAC, parking) lands in year 1. State the scenario in which the deal breaks and the scenario in which it becomes excellent.

11. **Verdict.** One paragraph: does it pencil, at what price, under which financing and strategy, and what single fact — usually the actual leases, a tenant estoppel, an environmental history, or an insurance quote — must be confirmed before the offer goes in. Then the verify-before-offer checklist and the concessions/structure table (seller financing, master lease on vacant space, rent guaranty, credit for deferred maintenance).

12. **Render and persist.** HTML artifact (see Output), then the deal-memory write (deal record, run log, sidecar), then a 4–6 sentence chat summary leading with the verdict and max offer.

## Report structure

```
Header        Address, type/subtype, sqft & acres, year built, occupancy, list price, $/sqft, cap at list, verdict badge (Pencils / Pencils at $X / Value-add only / Owner-user only / Pass)
At a glance   List price, $/sqft, in-place NOI, stabilized NOI, in-place cap, stabilized cap, WALT, DSCR, cash-on-cash, 10-yr levered IRR, max offer
Lease abstract Table per tenant: use, sqft, base rent & $/sf/yr, term start/end, remaining, escalations, options, structure (NNN/MG/FS), recoveries, guaranty, credit tier, market rent, gap, notes
Rollover      Bar/table: % of rent expiring by year (5 yrs) + WALT; commentary on the concentration risk
Income        In-place vs stabilized: base rent, recoveries, other income, vacancy & credit loss, EGI; market lease comps table with sources and expense structure
Expenses      Line items actual vs underwritten (taxes reassessed, insurance, CAM/utilities, R&M, mgmt, admin, reserves, leasing-cost reserve), recoverable vs non-recoverable split, expense ratio; call out what the OM omits
Valuation     Income approach (in-place and stabilized NOI / market cap), sales comps ($/sqft, cap), replacement cost check, reconciled range, offer guidance, structure/concessions table
Financing     Conventional 25–30% down; SBA 504 / 7(a) when owner-user; bridge → perm when value-add: debt service, cash to close, DSCR, cash flow, cash-on-cash for each
Owner-user    (when applicable) Rent-vs-own: current occupancy cost vs all-in ownership cost, tax effects (depreciation, interest), equity build, breakeven year
Trade-off     Subject vs new build (vs keep-leasing for owner-user) comparison table; 1/5/10-year returns & equity for each; crossover year
Sensitivity   Downside table + break-even rent, break-even occupancy, break-even price
Risk          Tenant/credit & rollover, lease structure gaps (uncapped CAM, no escalations, below-market options), environmental, flood/wind/insurance, deferred capital by era (roof, HVAC, parking, ADA, sprinklers), zoning/parking conformity, submarket supply
Location      Submarket, traffic/visibility or truck access, daytime population/anchors, competing supply, trend, crime (with Community Crime Map link where available)
Verdict       Paragraph + max offer + verify-before-offer checklist (leases, estoppels, Phase I, survey, roof/HVAC inspection, insurance quote, zoning letter)
Sources       Numbered; every figure traceable
```

## Output

Single self-contained HTML file in `/mnt/user-data/outputs/` named `commercial-report-<street-slug>.html`, presented with `present_files`. Read `/mnt/skills/public/frontend-design/SKILL.md` first. Same design intent as property-analysis and multifamily-analysis: a due-diligence document, quiet and dense, tabular numerals, one strong color for the verdict, every figure tagged `src` / `est` / `not found`, print stylesheet. The lease abstract and the income/expense tables are the center of the document; give them room. Append the `<!-- deal-memory -->` block per the deal-memory skill.

If the user asks for a DXC-branded deliverable, use `dxc-docx` or `dxc-pptx` with the same structure.

## Honesty rules

- Never invent a rent, a lease term, a comp, an expense, or a cap rate. "Not found — request the leases, rent roll, and T12" is the correct line, and the report is still useful without them: it says what the leases must show for the deal to work.
- The OM is the seller's argument. Its "pro forma" NOI, "market" rents, and "stabilized" cap rate are labelled as claims and underwritten to comps.
- OM expenses are almost always incomplete: management, reserves, leasing costs, and reassessed taxes are the usual omissions. Say so when the expense ratio (non-recovered OpEx / EGI) looks too good for the type and era.
- Taxes reassess at sale in most jurisdictions — underwrite to the buyer's basis, never the seller's bill.
- A cap rate without an occupancy and a WALT beside it is not a number; always report all three together.
- "NNN" on a listing does not mean the tenant pays everything — read the lease for caps, exclusions, roof/structure carve-outs, and management fee recoverability.
- Tenant credit is asserted by sellers and verified by buyers; label credit tiers with the basis (public rating, corporate vs franchisee, years in business, guaranty).
- Report crime and demographic figures as numbers relative to the city, with sources.
- Not a licensed appraiser, broker, lender, attorney, or environmental professional — state once in the Verdict.

## Deal memory fields

Write to the shared store per the `deal-memory` skill, extending its schema: `type: retail | retail-nnn | office | medical-office | industrial | flex | mixed-use | commercial-land`; `strategy: hold | value-add | owner-user`; replace `units` with `sqft` and `tenants`; add `walt_months` and `occupancy` to the front matter. Key-numbers rows: NOI in-place, NOI stabilized, market cap, value range, max offer, WALT, largest-tenant expiration. Actuals that should hit `learnings.md`: lease comps signed, insurance quote, Phase I result, roof/HVAC bids, appraisal.

## Multiple properties

Run the full workflow per property, then lead with a comparison table (price, $/sqft, in-place cap, stabilized cap, WALT, occupancy, DSCR, cash-on-cash, IRR, max offer) and a ranked verdict. One HTML file.
