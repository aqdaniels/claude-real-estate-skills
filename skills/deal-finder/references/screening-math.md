# Fast-screen math and scoring

This is a screen, not underwriting. The goal is to rank twenty listings in one pass with one set of assumptions, then send the winners to property-analysis or multifamily-analysis for real numbers. State the assumptions once above the table and label every output **rough estimate**.

## Inputs

| Input | How to get it | Default |
|---|---|---|
| List price | Listing | — |
| Rent estimate | One search per ZIP × bedroom count; midpoint of range; use in-place rent if listing states it and note gap to market | — |
| Rate | `investment property mortgage rate today` (or FHA/DSCR rate per financing preset) | current 30-yr fixed + 0.625 investor spread |
| Down payment | Buy box financing preset | 25% |
| Closing costs | | 3% of price |
| Expense ratio | See table below | by type and age |
| Vacancy | Included in expense ratio | — |

## Expense ratio (share of gross rent, all-in operating expenses incl. vacancy, taxes, insurance, maintenance, capex reserve, management)

| Type / age | Low-tax, low-insurance state | High-tax or coastal-insurance state (FL, LA, TX coast, NJ, IL) |
|---|---|---|
| SFR built ≥ 2000 | 38% | 45% |
| SFR 1970–1999 | 42% | 50% |
| SFR pre-1970 | 47% | 55% |
| 2–4 units, any age | 45% | 52% |
| 5+ units | 45% (use listing's actual expenses if given; cap at listing's pro forma + 5 pts) | 50% |
| STR / MTR | 52% | 58% |

If the listing includes HOA, add HOA / rent to the ratio. If the user self-manages locally, subtract 8 points.

## Formulas

- Gross yield = rent × 12 / price
- Rent-to-price (1% rule) = rent / price
- Rough NOI = rent × 12 × (1 − expense ratio)
- Rough cap rate = NOI / price
- Loan = price × (1 − down%)
- Monthly P&I = standard amortization at rate, 30 years
- Rough monthly cash flow = NOI / 12 − P&I
- Cash-on-cash = cash flow × 12 / (down payment + closing costs)
- DSCR = NOI / (P&I × 12)
- Cash-flow cushion = (NOI / 12 − P&I) / P&I — how far rent could fall before negative

Round to the nearest $10 for monthly figures and one decimal for ratios; false precision misleads on a screen.

## Pass / fail

A candidate **passes** if it meets every floor in the buy box (cash flow, yield, DSCR, cap rate) and no hard exclusion applies. Record the first failing criterion as the fail reason so the reader sees which floor is binding across the set. If most candidates fail the same floor, say so in Next step and quantify what loosening it would do.

## Screen score (0–100)

Rank passing candidates by score; show score for failing ones too so near-misses are visible.

| Component | Points | How |
|---|---|---|
| Cash flow per unit vs floor | 30 | 0 at floor, 30 at 3× floor, linear |
| Gross yield vs floor | 20 | 0 at floor, 20 at floor + 4 pts, linear |
| DSCR | 15 | 0 at 1.20, 15 at 1.60, linear |
| Price vs ZIP median $/sqft | 15 | 15 if ≥ 15% below ZIP median $/sqft, 0 if at or above |
| Motivation signals | 10 | +4 DOM > 45, +3 any price cut, +3 listing language ("motivated", "estate", "relocating", "bring offers") |
| Red-flag deductions | −up to 30 | −10 as-is/cash-only, −10 flood zone A/AE/VE or flood factor ≥ 7/10, −5 pre-1950 without renovation notes, −5 HOA > 10% of rent, −5 STR intent where ordinance restricts, −5 in-place rents > 15% below market with leases > 6 months remaining |

Cap at 100, floor at 0. Show the component breakdown on the shortlist cards so the reader can see why #1 is #1.

## Strategy variants

- **House-hack**: replace cash flow with *coverage* = other units' rent × (1 − expense ratio) / PITI on the whole property. Pass at ≥ 0.70; score 30 pts from 0.70 → 1.20.
- **BRRRR / value-add**: add ARV from renovated sold comps in the ZIP; pass if price + rough rehab ≤ 0.75 × ARV. Score adds 20 pts for equity created = ARV − (price + rehab), 0 at 0 → 20 at 25% of ARV; drop the $/sqft component.
- **Flip**: score = margin only: (ARV × 0.70 − rehab − price) / price. Pass at ≥ 10%.
- **STR**: rent input = ADR × occupancy × 30; cash flow floor default $300/month given volatility; add −10 if ordinance requires a permit that is capped or lotteried.
- **Land**: no score; rank by $/acre vs comps and buildability checklist (zoning, utilities, access, flood).

## What the screen can't see

Say this once in the Assumptions section: the screen doesn't know condition, roof and mechanical age, actual taxes after reassessment, actual insurance quotes, or the true flood zone. Those are exactly what property-analysis and multifamily-analysis go find. A high screen score means "worth the hour," not "worth the offer."
