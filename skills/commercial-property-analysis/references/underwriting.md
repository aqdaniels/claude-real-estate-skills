# Commercial underwriting (sub-$5M)

Show every input. Use the user's numbers when given; otherwise these defaults, labelled `est`. Quote rents and expenses as $/sqft/yr.

## Default assumptions

| Input | Default | Notes |
|---|---|---|
| Purchase price | List price for "at list" metrics; solve for max offer separately | |
| Down payment | 25% conventional investor (30% for office and single-tenant local credit); 10% SBA 504 / 7(a) owner-user; 20–30% bridge | Banks under $5M lend on the lower of DSCR- and LTV-constrained amounts |
| Rate | Search `commercial real estate loan rates <month year>`, `SBA 504 debenture rate <month year>`, `<state> bank owner occupied commercial loan rate` | Never assume. Bank CRE loans price off 5/7/10-yr Treasury + 2.25–3.25% |
| Term / amortization | Conventional: 5/7/10-yr fixed, 20–25-yr amortization, balloon; SBA 504: 20/25-yr fully amortizing debenture on 40% + bank 1st on 50%; 7(a): 25-yr; bridge: 12–36 mo interest-only | Balloon risk belongs in the sensitivity table |
| Vacancy & credit loss (stabilized) | Retail multi-tenant 7%; single-tenant credit 0–3%; office 10% (medical 7%); industrial/flex 5–7% | Use submarket vacancy if higher |
| Structural vacancy for rollover | Downtime per expiration: retail 6–9 mo, office 9–12 mo, industrial 4–6 mo; renewal probability 65% (retail/industrial), 60% (office) | Blend into a leasing-cost reserve for the stabilized NOI |
| Other income | Signage, billboard, cell, parking, late fees only if evidenced | |
| Recoveries | Per lease abstract; default 90% of recoverable expenses collected for NNN multi-tenant (vacancy leaks recoveries) | Vacant space's share is a landlord cost |
| Property tax | Buyer's basis × assessment ratio × millage — never the seller's bill. LA commercial: 15% ratio on improvements, 10% on land; ITEP/RTA only if in place | Check whether the state reassesses on sale (most do; CA does; LA reassesses on a cycle but the sale price anchors it) |
| Insurance | Quote if found; else Gulf Coast/coastal: $1.50–2.50/sqft/yr for retail/office, $0.90–1.50 industrial; inland: $0.60–1.00/sqft; add flood by zone; wind deductible 2–5% of TIV | Coastal commercial insurance has moved faster than rents; +30% is the stress case, not the outlier |
| CAM / utilities / R&M | From T12; else retail $2.50–4.00/sqft, office $4.00–7.00 (full-service), industrial $0.75–1.50 | Recoverable portion per leases |
| Management | 4% of EGI (multi-tenant), 2–3% (single-tenant NNN) — include even if self-managing; note whether leases allow recovery | |
| Admin / legal / accounting | 1–2% of EGI | |
| Capital reserve | $0.20–0.30/sqft/yr retail/industrial; $0.30–0.50 office | Above and beyond leasing costs |
| Leasing costs (reserve) | TI: retail 2nd-gen $10–25/sqft, office $20–40, industrial $3–8; commissions 4–6% of total lease value; amortize expected cost over the rollover schedule | Big, and the first thing OMs omit |
| Immediate capital | From inspection/OM; else by era: roof > 18 yrs, RTUs > 15 yrs, parking > 12 yrs → price them | Part of cash invested and of max offer |
| Rent growth / expense growth | Submarket trend; default 2.5% / 3% | For the 5- and 10-year view |
| Exit cap | Entry market cap + 25–50 bps | Never assume compression |
| Closing costs | 2–3% buy (more with Phase I, survey, ALTA, legal); 4–6% sell | |

Sanity check — **non-recovered expense ratio** (OpEx − recoveries) / EGI: NNN retail 10–20%, multi-tenant office (gross leases) 35–50%, industrial 10–20%. An OM showing NNN retail at 5% has left out management, reserves, or vacant-space carry.

## Income statement

```
Base rent (in-place)                 = Σ contract rent
+ Recovery income                    = Σ tenant share × recoverable expenses (per lease caps)
+ Other income
= Gross potential income
− Vacancy & credit loss              = % of base rent + recoveries on vacant/rollover space
= Effective gross income (EGI)
− Taxes (reassessed) − Insurance − CAM/utilities − R&M − Mgmt − Admin
= NOI before reserves
− Capital reserve − Leasing-cost reserve
= NOI (underwritten)                  ← use for DSCR and max offer

Repeat with market rents on every space, stabilized vacancy → NOI (stabilized)
```

Report the OM's NOI beside both and show the bridge (what was added or removed).

## Valuation

```
Income value (today)      = NOI in-place (before reserves, the way brokers quote it) / market cap
Income value (stabilized) = NOI stabilized / market cap  − cost to get there (TI, LC, downtime, capital) − entrepreneurial margin (10–15%)
Sales comps               = 3–6 same-type sales ≤ 24 mo: $/sqft, cap if disclosed, occupancy at sale; adjust for occupancy and WALT
Replacement cost          = land + construction cost/sqft (from tradeoff research) − depreciation; a ceiling for stabilized value
GRM check                 = price / gross rent (only for comps that disclosed it)
```

Market cap rate: prefer a sold listing in the submarket that disclosed NOI, then brokerage submarket surveys, then national by type. Sub-$5M, secondary Southern metros, 2026-era: multi-tenant retail 7.0–8.5%; single-tenant credit NNN 5.5–7.0% (longer term / better credit = lower); office 8.0–10.0% (medical 7.0–8.0%); industrial/flex 6.5–8.0%. Labelled `est` unless sourced. Adjust +50–100 bps for local credit, short WALT, or deferred capital.

## Financing structures

| Structure | When | Shape |
|---|---|---|
| Conventional bank | Investor, stabilized | 70–75% LTV, DSCR ≥ 1.25 on underwritten NOI, 5–10-yr fixed, 25-yr am, balloon, recourse |
| SBA 504 | Owner-user (occupies ≥ 51%) | Bank 1st 50% + CDC debenture 40% (fixed 20/25 yr) + 10% down; DSCR ≥ 1.15–1.25 on business cash flow; project cost can include improvements and closing |
| SBA 7(a) | Owner-user, smaller or mixed-use with business assets | Up to 90% LTV, 25-yr, variable (Prime + spread) common; higher fee |
| Bridge / private | Value-add, vacancy > 25%, credit-poor | 65–75% LTC, 12–36 mo, interest-only, 2–4 pts; exit to perm at stabilized DSCR |
| Seller financing | Any; ask | 10–30% carry-back at below-bank rate, 3–7 yr balloon; often the concession that makes a stubborn ask pencil |

Sizing:

```
Loan (LTV)        = Price × LTV
Loan (DSCR)       = NOI underwritten / target DSCR / annual constant   (constant = 12 × P&I per $1)
Loan              = min(LTV loan, DSCR loan)
Cash to close     = Price − Loan + closing + immediate capital + leasing costs funded up front + working reserve (3 mo debt service)
```

## Returns

```
Debt service            = P&I × 12
DSCR                    = NOI underwritten / Debt service
Cash flow               = NOI underwritten − Debt service
Cash-on-cash            = Cash flow / Cash to close
5- & 10-yr projection   = grow rents/expenses, apply rollover (renewal prob, downtime, TI/LC), sell at exit cap on forward NOI less selling costs, repay loan balance
Unlevered IRR           = on price + capital vs NOI stream + net sale
Levered IRR / multiple  = on cash to close vs cash flow stream + net sale proceeds
```

## Max offer

Solve for the price at which the user's floor binds:

```
Max offer (DSCR)        = (NOI / DSCR_target / constant) / LTV
Max offer (CoC)         = price where cash flow / cash to close = CoC_target   (iterate)
Max offer (cap)         = NOI in-place / cap_target
Max offer (value-add)   = stabilized value − all-in costs to stabilize − margin
Max offer               = min of the applicable floors, less immediate capital the seller won't credit
```

State which floor binds and by how much the ask exceeds it.

## Owner-user: rent vs own

```
Occupancy cost (lease)  = current rent + NNN/CAM the business pays now, grown at the lease's escalations
Occupancy cost (own)    = debt service + non-recovered opex + reserves − rent from any third-party tenants in the building
Tax effects             = depreciation (39-yr non-residential; cost segregation can accelerate), mortgage interest; note the business/entity structure matters — not tax advice
Equity build            = principal paydown + appreciation (2%/yr default)
Breakeven year          = when cumulative (own − lease) turns negative after equity build
```

The verdict for owner-user: does owning cost less than leasing on a cash basis within N years, and does the building fit the business's growth (room to expand or sublet)? An owner-user can rationally pay above the investor max offer, because the "tenant" is their own credit; say by how much.

## Concessions and structure (in order of leverage)

1. Price credit for verified immediate capital (roof, RTUs, parking, ADA)
2. Seller carry-back at below-market rate
3. Master lease / rent guaranty from seller on vacant or MTM space for 12–24 months
4. Seller-funded TI/LC escrow for known rollover
5. Estoppels and SNDAs as a closing condition; price reduction for any tenant that won't sign
6. Extended due diligence tied to Phase I and lease review
