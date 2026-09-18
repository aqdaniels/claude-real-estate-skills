# Market math and scoring rubric

Two jobs: compute a "median deal" pro forma that shows what a typical rental in this market pencils to right now, then score the market on three axes and map to a strategy fit. Always show inputs and label outputs as estimates.

## Median-deal pro forma

Inputs (state each with source and as-of date):

| Input | Default if not stated | Source |
|---|---|---|
| Purchase price | Median sale price for the geography (SFR if the strategy is SFR) | Redfin/Zillow market page |
| Monthly rent | Median 3BR house rent (SFR) or median 2BR (multifamily unit) | ZORI / ApartmentList / Rentometer |
| Down payment | 25% investor conventional (3.5% FHA if house-hack, 20% DSCR) | user |
| Rate | Current 30-yr investment rate (search `investment property mortgage rate today`) | Freddie Mac PMMS + ~0.5–0.75 investor spread |
| Closing costs | 3% of price | |
| Property tax | Effective non-homestead rate × price | County assessor |
| Insurance | State-typical landlord premium; if unknown, 0.5% of price/yr (1.0–1.5% in FL/LA/TX coast) | state insurance source |
| Vacancy | 1 − occupancy; default 6% (higher if market vacancy > 7%) | Census HVS / market report |
| Maintenance + capex | 10% of rent (older stock: 12–15%) | |
| Property management | 8–10% of rent (0% if self-managed local) | |

Outputs:

- **Gross rental yield** = annual rent / price. Rough bands: <5% appreciation market, 5–8% balanced, >8% cash-flow market.
- **Price-to-rent** = price / annual rent (inverse of yield). <15 favors buying/investing, 15–20 balanced, >20 favors renting / appreciation-only thesis.
- **1% rule check** = monthly rent / price. Note it as a screen, not a decision rule; few metros clear 1% today.
- **NOI** = rent × (1 − vacancy) − tax − insurance − maintenance − management − other.
- **Cap rate** = NOI / price.
- **Debt service** = P&I on (price − down payment) at rate, 30 yr.
- **Cash flow** = NOI − debt service (monthly and annual).
- **Cash-on-cash** = annual cash flow / (down payment + closing costs).
- **DSCR** = NOI / annual debt service. Lenders typically want ≥1.20–1.25.
- **Break-even price** = the purchase price at which cash flow = 0 given the rent (solve for price). This tells the reader how far below median they'd need to buy.
- **Break-even rate** = the rate at which cash flow = 0 at median price.

Present as a table with a one-line reading: "At median price and rent, a 25%-down purchase runs about $X/month negative; you'd need to buy ~Y% below median or find rents Z% above median to break even."

## Scoring rubric

Score each axis 1–5 from the evidence, then explain the score in one sentence with the metric that drove it. Don't average into a single number — the three scores tell the reader more than a composite.

### Cash-flow score

| Score | Gross yield | Price-to-rent | Median-deal cash flow (25% down) |
|---|---|---|---|
| 5 | > 9% | < 11 | Clearly positive |
| 4 | 7.5–9% | 11–13 | Modestly positive |
| 3 | 6–7.5% | 13–17 | Near zero |
| 2 | 4.5–6% | 17–22 | Modestly negative |
| 1 | < 4.5% | > 22 | Clearly negative |

Adjust down one point if vacancy > 8% or insurance/tax burden exceeds 35% of gross rent.

### Appreciation score

| Score | Signal |
|---|---|
| 5 | Population growth > 1.5%/yr, job growth above national, months of supply < 3, permits below household growth, 5-yr HPI above national |
| 4 | Three of the five above |
| 3 | Mixed; growth near national averages |
| 2 | Flat or declining population, supply > 6 months, permits well above household formation |
| 1 | Population decline, job losses, rising inventory, price declines YoY |

### Risk score (5 = lowest risk)

Start at 5 and subtract one for each present:

- Insurance market distressed (state insurer growth, carrier exits, double-digit premium increases) or county NRI rating "Relatively High" or worse
- Employer concentration > 15% in one employer/sector, or a single dominant industry in a cyclical sector
- Landlord-unfriendly law: eviction timeline > 8 weeks, rent control/stabilization, just-cause eviction on SFR
- Affordability stretched: price-to-income > 5 and rising, or YoY price growth > 3× rent growth for two years
- Oversupply: permitted units > 2× household growth, or vacancy rising > 1.5 pts YoY

Floor at 1. Add a sentence for each deduction naming the source.

## Strategy fit

Map scores to a recommendation and a verdict badge:

| Pattern | Fit | Badge |
|---|---|---|
| Cash flow ≥ 4, Risk ≥ 3 | Buy-and-hold cash-flow market; deal-finder criteria: yield floor, older stock OK, PM factored | Strong |
| Appreciation ≥ 4, Cash flow 2–3, Risk ≥ 3 | Appreciation/hybrid; expect to subsidize early years; deal-finder: below-median buys, value-add | Reasonable |
| Cash flow 3, Appreciation 3, Risk ≥ 3 | Deal-dependent; only sub-market or off-market buys pencil | Selective |
| Risk ≤ 2 regardless of others | Pass, or specialist-only with insurance/legal diligence up front | Pass |
| Cash flow ≤ 2 and Appreciation ≤ 2 | Pass | Pass |

STR overlay: if the user's strategy is STR, replace the rent input with AirDNA ADR × occupancy × 30, add 25% expense uplift (furnishings, utilities, cleaning, platform fees), and cap the recommendation at "Selective" if the STR ordinance restricts permits, regardless of numbers.

## Sub-market tiers

For each ZIP/neighborhood with data: compute gross yield and note recent price and rent direction, then assign:

- **Cash flow**: yield in top third for the metro, stable or rising rents
- **Balanced**: mid-yield, price growth at or above metro
- **Appreciation**: low yield, strongest price growth, tightest inventory
- **Avoid**: falling rents or prices, high vacancy, or hazard/insurance concentration (e.g., repetitive-loss flood zones)

Say when the tier rests on one data point. Recommend that deal-finder start with the Cash-flow and Balanced tiers for a cash-flow strategy and the Balanced and Appreciation tiers for an appreciation strategy.
