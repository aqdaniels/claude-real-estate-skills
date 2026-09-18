---
name: market-scan
description: Produce a sourced real-estate investment market report for a metro, city, county, ZIP, or neighborhood — economy and population, home prices and inventory, rents and vacancy, price-to-rent and yield math, landlord/tenant and STR rules, property tax and insurance climate, hazard risk, sub-market tiers, and a strategy-fit verdict — as a polished HTML report. Use this skill ANY time the user asks about a place rather than a specific property, e.g. "where should I invest", "is [city] a good rental market", "compare [city A] vs [city B]", "best ZIPs in [metro] for cash flow", "what's the market like in [place]", "should I buy in [state]", "is [city] overvalued", "landlord friendly states", or names a market and asks whether to buy there. Also trigger when the user has a budget and strategy but no address yet. If a street address is given, use property-analysis or multifamily-analysis instead; this is the step before that.
---

# Market scan

Turn a place name into an investment decision: is this market worth hunting in, for which strategy, and in which sub-markets. The reader is deciding where to point their capital and time before they ever look at a listing, so the report must separate facts (with sources and dates) from judgment, and must say plainly when a metric couldn't be found.

This skill sits upstream of `deal-finder` (which finds listings in a chosen market) and `property-analysis` / `multifamily-analysis` (which underwrite one address). End the report by pointing at the next step.

## Workflow

1. **Frame the question.** Identify the geography (metro, city, county, ZIP, neighborhood) and the user's strategy and constraints if stated: budget, long-term rental vs STR vs flip vs house-hack, cash-flow vs appreciation priority, out-of-state vs local, unit count. If strategy isn't stated, assume long-term buy-and-hold rental and say so in the report. If the geography is ambiguous (e.g., "Columbus"), ask once; otherwise proceed. For a state-level question, pick the 3–5 most relevant metros and treat it as a comparison.

2. **Research in parallel.** Fire all of these searches in the same turn. Query patterns, preferred sources, and fetch-reliability notes are in `references/data-sources.md` — read it before searching.
   - Population and household growth (Census QuickFacts / ACS, recent estimates)
   - Jobs: unemployment, job growth, largest employers, employer concentration (BLS, local EDC)
   - Income: median household income, income growth
   - Home prices: median sale price, $/sqft, YoY, 5-year trend, inventory, months of supply, DOM (Redfin/Zillow/Realtor market pages)
   - Rents: median rent by bedroom count, YoY rent growth, vacancy rate, HUD Fair Market Rents (Zillow Observed Rent Index, ApartmentList, Zumper, HUD)
   - Supply pipeline: permits issued, units under construction, notable developments
   - Property tax: effective rate, assessment practice, homestead vs non-homestead treatment, reassessment on sale
   - Insurance: homeowners/landlord premium trends, carrier exits, state-run insurer status, flood/wind exposure
   - Regulation: landlord-tenant law summary, eviction timeline, rent control/stabilization, security deposit rules, registration/inspection requirements, STR ordinance and permit availability
   - Hazards: FEMA National Risk Index for the county, dominant perils, climate trend for insurance
   - Sub-markets: which ZIPs or neighborhoods are cash-flow tier vs appreciation tier vs avoid; recent price and rent by ZIP
   - Investor sentiment: recent local news on the market, institutional buying, migration in/out

   `web_fetch` the three or four most data-dense pages (Redfin market page, Census QuickFacts, a rent report, the county tax/assessor overview) to get complete tables rather than snippets. Don't burn more than one fetch attempt on a page that refuses.

3. **Reconcile and date-stamp.** Sources lag each other by months; always state the "as of" period for each metric. When price or rent figures disagree by more than ~10%, show the range and name the sources. Flag anomalies: rents flat while prices spike (yield compression), inventory jumping (softening), permits far above household growth (oversupply risk).

4. **Run the math.** Use `references/scoring.md`. Compute price-to-rent ratio, gross rental yield, and a "median deal" pro forma: median-priced typical rental in that market at current rates with default expense ratio → cash flow, cap rate, cash-on-cash, DSCR. Show inputs. Then score the market on the cash-flow, appreciation, and risk axes per the rubric and translate to a strategy fit.

5. **Tier the sub-markets.** Name 3–6 ZIPs or neighborhoods with a one-line reason each and the tier they fall in (Cash flow / Balanced / Appreciation / Avoid). Base tiers on found data; if ZIP-level data is thin, say so and give the reader the query to run.

6. **Write the verdict.** One paragraph. Answer what the user asked (invest here? which strategy? which sub-markets? which of the compared markets?). Name the two or three drivers and the one thing to verify locally (an agent conversation, a property-manager quote, an insurance quote) before committing.

7. **Render.** Produce the HTML report (see Output), then a 3–5 sentence chat summary with the verdict. Offer to run `deal-finder` on the top-tier sub-markets as the natural next step.

## Report structure

Use this order. Drop a section only if irrelevant to the question, never because data was hard to find — an empty section with "Not found; check [source]" beats a missing one.

```
Header          Market name, geography level, as-of month, strategy assumed, verdict badge (Strong / Reasonable / Selective / Pass)
At a glance     6–8 key figures: median price, median rent, price-to-rent, gross yield, YoY price, YoY rent, vacancy, pop growth
Economy         Population & household trend, jobs & unemployment, major employers + concentration, income
Housing market  Price trend table (1/3/5-yr), $/sqft, inventory, months of supply, DOM, list-to-sale ratio, new construction share
Rental market   Rent by bedroom table, rent growth, vacancy, HUD FMR vs market, renter share, STR context
Investment math Median-deal pro forma with inputs; sensitivity (price or rate that makes it work); score card (cash flow / appreciation / risk)
Operating climate Property tax, insurance outlook, landlord-tenant summary, eviction timeline, rent control, licensing, STR rules
Risk            Hazards (NRI), insurance trajectory, supply pipeline vs demand, employer concentration, affordability (price-to-income), policy risk
Sub-markets     Tier table: ZIP/neighborhood, tier, median price, median rent, yield, one-line rationale
Verdict         Paragraph + "verify locally" checklist + next step (deal-finder criteria to use)
Sources         Numbered list; every figure traceable to one, with as-of date
```

## Comparing markets

Run the workflow per market, then lead with a side-by-side comparison table (the At-a-glance figures plus the three scores) and a ranked verdict with reasons. One HTML file; stacked sections or tabs per market.

## Output

Default deliverable is one self-contained HTML file in `/mnt/user-data/outputs/` named `market-scan-<place-slug>.html`, presented with `present_files`. Read `/mnt/skills/public/frontend-design/SKILL.md` first for design quality.

Design intent: analyst brief, not a relocation brochure. Dense, quiet, phone-readable. Tabular numerals; ranges shown as ranges; every metric carries an as-of date and a source number. Verdict badge and tier colors are the only strong color. Small inline bar or sparkline for the price and rent trend tables is welcome (inline SVG, no external libraries). Print stylesheet so Save-as-PDF works.

If the user asks for a DXC-branded deliverable, use `dxc-docx` or `dxc-pptx` and keep the same structure.

## Honesty rules

- Never invent a rent, price, growth rate, tax rate, or eviction timeline. If it isn't in a fetched or snippeted source, write "not found" and name where to look.
- Every model-derived number is labeled **estimate** with inputs shown.
- Market medians hide dispersion; say once that the median-deal pro forma is a market-level indicator, not an underwriting of any property.
- Landlord-tenant and STR rules change; state the source date and tell the reader to confirm with the municipality or a local attorney.
- Report demographics as numbers with sources. Do not characterize residents, and do not use neighborhood shorthand that implies who lives there.
- Not a licensed advisor — say it once, in the Verdict.
