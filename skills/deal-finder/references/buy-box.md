# Buy box — criteria and defaults

The buy box is the contract for the search. Show it in full at the top of the report, mark each row as **stated** (from the user) or **default** (from this file), and make it trivial to correct. Ask only for the two essentials if missing (geography, max price); everything else defaults.

## Criteria table

| Criterion | Stated by user? | Default | Notes |
|---|---|---|---|
| Geography | ask if missing | — | Metro, city, list of ZIPs, or neighborhoods. If a `market-scan` report is in the conversation, default to its Cash-flow + Balanced tiers (cash-flow strategy) or Balanced + Appreciation tiers (appreciation strategy). |
| Max price | ask if missing | — | Treat as hard cap +5% tolerance (listings often negotiate). |
| Min price | — | 40% of max | Filters out land/teardowns when searching SFR. |
| Property type | — | SFR + 2–4 units | Options: SFR, 2–4 units, 5+ units, condo/townhome, STR-eligible, land. Condos default off unless stated (HOA risk). |
| Strategy | — | Long-term buy-and-hold rental | Options: LTR, house-hack, STR/MTR, BRRRR/value-add, flip, land-bank. Strategy changes the screen: see screening-math.md. |
| Beds / baths min | — | 3 / 1.5 (SFR); per-unit 2 / 1 (multi) | 3BR houses rent and resell more reliably than 2BR in most markets. |
| Sqft min | — | 1,000 (SFR) | |
| Year built min | — | 1950 | Older is fine if the user says so; older stock raises the expense ratio (see screening-math.md). |
| Condition | — | Any, but flag "as-is"/"cash only" | Options: turnkey, light rehab, heavy rehab OK. |
| Max DOM | — | None, but flag > 60 | Long DOM is a signal, not a filter. |
| Occupancy | — | Any | For house-hack, prefer at least one vacant unit. For LTR, tenant-occupied with leases is a plus if rents are near market. |
| Financing | — | 25% down conventional investor loan, 30-yr | Options: FHA 3.5% (house-hack, 1–4 units, owner-occupied), DSCR 20–25%, cash, seller finance. |
| Cash-flow floor | — | ≥ $100/month/unit after all expenses and debt service | Stated floors override. Many buyers use $200/door. |
| Yield floor | — | Gross yield ≥ 7% (LTR); ≥ 10% gross revenue yield (STR) | |
| DSCR floor | — | ≥ 1.20 | Lender threshold; below it, financing becomes the constraint. |
| Cap rate floor | — | ≥ 6% rough cap (5+ units: ≥ market cap for that class) | |
| Exclusions | — | Flood zone A/AE/VE if disclosed; HOA > 10% of rent; leasehold; 55+ communities | User can override any. |
| Max results to screen | — | 20 | Cap so the report stays readable. |

## Strategy presets

Pick the preset from the stated strategy and merge with any stated criteria.

**Long-term rental (default)** — as above.

**House-hack** — 2–4 units, FHA 3.5% or 5% conventional, owner occupies one unit. Screen on: other units' rent covers ≥ 70% of PITI (good) or ≥ 100% (excellent). Prefer at least one unit vacant or month-to-month.

**STR / mid-term** — Only in geographies where the STR ordinance permits non-owner-occupied rentals (check `<city> short term rental ordinance` before searching; if restricted, tell the user and switch to MTR or LTR screening). Prefer furnished-ready layouts, parking, proximity to the demand driver. Rent input = ADR × occupancy × 30 from AirDNA snippets; expense ratio 50–55%.

**BRRRR / value-add** — Include "as-is", "investor special", "needs TLC", "estate sale", long DOM and price-cut listings. Screen on ARV: search recently sold renovated comps in the ZIP; candidate passes if list price + rough rehab (from listing language: cosmetic ≈ $25/sqft, moderate ≈ $50/sqft, heavy ≈ $90/sqft, all rough) ≤ 75% of ARV.

**Flip** — Same as BRRRR but score on spread: ARV × 0.70 − rehab − list price. Report spread and margin; cash flow and DSCR are irrelevant and are omitted from the table.

**Land** — Skip rent math. Screen on price per acre vs recent lot sales, zoning (search `<county> zoning <parcel>`), utilities at road, flood zone, road frontage. Output the same shortlist shape with those columns.

## Writing the buy box in the report

One table, one row per criterion, three columns: Criterion · Value · Source (Stated / Default / From market-scan). Follow with one sentence: "Change any row and I'll re-run the search."
