# Multifamily underwriting

Show every input. Use the user's numbers when given; otherwise these defaults, labelled `est`.

## Default assumptions

| Input | Default | Notes |
|---|---|---|
| Purchase price | List price for "at list" metrics; solve for max offer separately | |
| Down payment | 25% investor (20% if 2–4 units conventional); 3.5% FHA or 5% conventional house-hack | FHA requires owner occupancy ≥ 1 yr and, for 3–4 units, the self-sufficiency test (see below) |
| Rate | Search `current 30 year mortgage rate` and `investment property mortgage rate` — investor loans price ~0.5–0.75% above owner-occupied | Never assume |
| Term | 30 yr for 1–4 units; 5–20 unit buildings typically 5/7/10-yr fixed, 25–30 yr amortization, commercial DSCR loan | |
| Gross potential rent (GPR) | Market rent roll × 12 | In-place rent roll shown alongside |
| Vacancy & credit loss | 8% (5% in tight markets, 10% for older/rougher stock) | Applied to GPR |
| Other income | Laundry, parking, storage, pet fees if evidenced; otherwise $0 | |
| Property tax | Buyer's basis × assessment ratio × millage; never the seller's bill. LA: 10% ratio, homestead ($7,500 assessed) applies only to the owner-occupied unit's share | |
| Insurance | Quote if found; else 1.2% of value for 2–4 units in Gulf Coast states (landlord policies run higher than HO-3), 0.6% elsewhere; add flood per zone | Multi-unit and non-owner-occupied both raise premiums |
| Utilities owner pays | From listing/T12; if master-metered and unknown, $75/unit/mo water-sewer-trash + $60/unit/mo gas/electric common | Separate metering is a value-add lever |
| Repairs & maintenance | 8% of EGI (10% pre-1960) | |
| CapEx reserve | $300/unit/yr (1–4 units), $250/unit/yr (5+) | Separate from R&M |
| Payroll (on-site manager, maintenance tech) | $0 for ≤ 20 units; ~$850–1,000/unit/yr for 21+ units | Lenders and appraisers expect it; seller pro formas for larger assets routinely omit it |
| Management | 8% of EGI (10% for ≤4 units) — include even if self-managing; your time isn't free and the lender/appraiser will | |
| Admin, legal, turnover, marketing | 3% of EGI | |
| Closing costs | 3% buy, 6–8% sell | |
| Immediate repairs | From inspection/listing; else 2% of price for pre-1980 stock | Part of cash invested |
| Rent growth / expense growth | Neighborhood trend from research; default 2% / 3% | Only for the 5-year view |

A sanity check: **expense ratio** (OpEx / EGI) for small older multifamily typically lands 40–50%. Seller pro formas showing 25–35% are omitting something — usually management, CapEx, or realistic taxes and insurance.

## Income statement

```
GPR (market)                    = Σ market rent × 12
− Vacancy & credit loss         = GPR × vacancy%
+ Other income
= EGI
− Taxes (reset) − Insurance − Flood − Utilities − R&M − CapEx − Mgmt − Admin − HOA
= NOI (stabilized)

Repeat with in-place rents → NOI (in-place)
```

## Valuation

```
Income value            = NOI (in-place) / market cap rate      ← what it's worth today
Stabilized value        = NOI (stabilized) / market cap rate    ← what it's worth once rents are at market
$/unit comps            = Σ (sold price / units) for 3–6 sales, same unit count ±1, ≤12 mo
GRM check               = Price / gross annual rent  (compare to sold comps' GRM where rents were disclosed)
```

Market cap rate: search brokerage reports and recent sold listings that disclose NOI. Absent that, use 6.5–8% for 2–4 units in secondary Southern metros, 5–6.5% in coastal primary metros, labelled `est`. Reconcile income value, $/unit and GRM into one range.

## Returns

```
Loan                    = Price × (1 − down%)
Debt service (annual)   = P&I × 12
DSCR                    = NOI / Debt service         (target ≥ 1.25; lenders on 5+ units require it)
Cash flow (annual)      = NOI − Debt service
Cash invested           = Down + Closing + Immediate repairs
Cash-on-cash            = Cash flow / Cash invested
Cap rate at list        = NOI (in-place) / List price
Stabilized cap at list  = NOI (stabilized) / List price
```

Show these for in-place and stabilized, and for each financing scenario.

## Max offer price

Solve, don't guess. Report the lowest of:

- **DSCR-constrained**: the price at which NOI (in-place) / debt service = 1.25 at the assumed down payment and rate
- **Cash-flow-constrained**: the price at which cash flow ≥ user's target (default $150/unit/mo after reserves)
- **Cap-rate-constrained**: NOI (in-place) / user's target cap (if given)

**Heavy value-add / distressed (vacant, post-foreclosure, rehab > ~$15k/unit):** the three constraints above don't apply because there is no in-place NOI to lend on. Use the developer-margin method instead:

```
Target all-in cost   = Stabilized value × 0.80   (0.75 if lease-up > 18 months or bridge debt > 9%)
Max offer            = Target all-in − verified rehab − closing/fees (~4%) − carry during rehab and lease-up
```

Carry = interest + insurance + taxes + security for the rehab period, net of any partial income. Show the max offer as a table indexed to rehab cost per unit, because the rehab number — not the ask — is the variable that decides the deal. Treat the seller's own rehab estimate as a floor. Do not use a 30-year P&I in this scenario; model bridge (65–70% LTC, interest-only) followed by a refinance at stabilization, and report post-refi cash-on-cash on the equity left in.

**Always check the seller's equity arithmetic.** A listing that claims "equity creation" or "instant equity" is usually computing ARV − purchase price. Recompute as ARV − (price + rehab + closing + carry) and state the result in the At-a-glance section. The same check applies to "cap rate" claims: ask whether the NOI is in-place or pro forma, and whether the expense ratio behind it is plausible.

Then note what stabilized rents would justify — that's the number you pay only if you're confident in the value-add and have the reserves to execute it.

## House-hack scenario (2–4 units)

Owner occupies one unit; the others rent.

```
Rental income counted by lender = 75% of the other units' market rent (FHA/conventional)
Owner's effective housing cost  = Total monthly (PITI + insurance + utilities + reserves) − net rent from other units
```

Compare the owner's effective cost to renting a similar unit. FHA specifics: 3.5% down, MIP for life of loan at <10% down, 1-yr occupancy; **3–4 units must pass the self-sufficiency test** — 75% of all units' market rent (including the owner's) ≥ full PITI. Conventional 5% down (Fannie Mae, 2023+) avoids the test but needs stronger credit.

## Sensitivity

Always include:

| Scenario | NOI | DSCR | Cash flow |
|---|---|---|---|
| Base (market rents) | | | |
| In-place rents only | | | |
| Rents −10% | | | |
| One unit vacant 3 mo | | | |
| Insurance +30% | | | |
| Rate +1% | | | |

Plus two break-evens: **rent per unit at which cash flow = 0** and **price at which cash flow = 0** at base rents.

## Concessions to request

Lead with a **seller-paid rate buydown** (user's standing preference) and show it against an equal price cut:

| Concession | Ask | Cost to seller | Value to buyer |
|---|---|---|---|
| Permanent buydown, 2 pts | rate −~0.5% | 2% of loan | monthly saving; 30-yr total |
| 2-1 temporary buydown | −2%/−1%/note | ≈ 24-month payment gap | yr-1 and yr-2 monthly saving |
| Equivalent price cut | −same $ | same $ | monthly saving (smaller) |

For bridge-financed or cash deals a rate buydown doesn't apply; say so and lead instead with: seller financing/carryback (interest-only, 5–6%, 24 months — the cheapest carry available), extended due diligence with contractor and Phase I access, inspection-tied rehab credits, and — when the property spans multiple parcels of record — a phased takedown option.

Seller-credit caps: conventional investment property 2% of price; owner-occupied 3%/6%/9% by down payment tier; FHA 6%. Then property-specific asks: rent-deficiency credit if units are under market, repair credits from inspection, security deposits and prorated rents transferred at closing, seller-paid separate metering, estoppel certificates from every tenant, and a rent guarantee for vacant units for 60–90 days. In a seller's market, one line.

## Formatting

Currency to the dollar in tables, nearest $100 in prose. Rates and returns to one decimal. Ranges as ranges. Per-unit figures ($/unit, rent/unit) whenever comparing buildings of different size.
