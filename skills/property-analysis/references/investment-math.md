# Investment math

Show every input in the report. Use the user's numbers when given; otherwise use these defaults and label them.

## Default assumptions

| Input | Default | Override when |
|---|---|---|
| Purchase price | Reconciled estimate (or list price if listed) | User names an offer price |
| Down payment | 20% investor / 10% owner-occupant | User states |
| Mortgage rate | Search `current 30 year mortgage rate` — do not assume | Always search; rates move |
| Term | 30 years | |
| Property tax | Assessor record × current millage; fall back to listing's tax history | If homestead exemption applies (LA: first $75k of value exempt for primary residence), recompute for the buyer's situation |
| Homeowners insurance | Source a figure for the ZIP/state if available; otherwise 1.0% of value in Gulf Coast states, 0.5% elsewhere, labelled estimate | Any quoted figure |
| Flood insurance | Zone X: ~$800–1,200/yr NFIP preferred risk; Zone AE/A: $2,000–5,000+/yr depending on elevation vs BFE; VE: higher. Always label "estimate — get a quote". | Elevation certificate or quote available |
| Maintenance reserve | 1% of value/yr (1.5% if pre-1960) | |
| Vacancy | 8% of gross rent (1 month/yr) | |
| Property management | 8–10% of gross rent if not self-managed | |
| CapEx reserve | 5% of gross rent | |
| Closing costs | 3% of price (buy), 6–8% (sell) | |
| Appreciation | Use the neighborhood's 5-yr trend from research; don't default to a national number | |

## Owner-occupant monthly cost

```
Loan            = Price × (1 − down%)
P&I             = Loan × r/12 / (1 − (1 + r/12)^−360)
Taxes           = Annual tax / 12
Insurance       = (Homeowners + Flood) / 12
HOA             = from listing
PMI             = if down < 20%: Loan × 0.5%–1.0% / 12 (label estimate)
Maintenance     = Value × 1% / 12
─────────────────────────────────────────────
Total monthly   = sum
Cash to close   = Down + Closing costs
```

Present as a table with "Ownership cost vs rent" — the rent estimate for a comparable home — so the reader sees the premium or discount to renting.

## Rental / investor

```
Gross rent (annual)     = Monthly rent × 12
Effective gross income  = Gross rent × (1 − vacancy)
Operating expenses      = Taxes + Insurance + Flood + Maintenance + Mgmt + CapEx + HOA + utilities landlord pays
NOI                     = EGI − Operating expenses
Cap rate                = NOI / Price
Debt service (annual)   = P&I × 12
Cash flow (annual)      = NOI − Debt service
Cash invested           = Down + Closing + Immediate repairs
Cash-on-cash            = Cash flow / Cash invested
DSCR                    = NOI / Debt service        (lenders typically want ≥ 1.20–1.25)
Gross rent multiplier   = Price / Gross rent
1% rule check           = Monthly rent / Price       (≥ 1% is strong; 0.6–0.8% common in appreciating markets)
```

## Sensitivity

Always include one small table answering "what would make this work":

- Price at which cap rate hits 7% (or cash flow hits $0 / $200/mo)
- Monthly cost at rate −1% and +1%
- Effect of Zone AE flood premium at the low vs high end of the range

## Offer guidance (Valuation section)

Anchor to comps' $/sqft, adjust for condition and lot, then:

- Seller's market (DOM < 20, >100% list-to-sale): offer at reconciled value; concessions unlikely
- Balanced (DOM 20–45): open 3–5% under reconciled value
- Buyer's market (DOM > 45, price cuts on listing): open 5–10% under; ask for inspection credits, rate buydown, or closing costs

Cite the DOM and list-to-sale ratio you based this on.

## Concessions to request

Every report includes a short "Ask the seller for" table in the Valuation section, sized to the market. Lead with a **seller-paid rate buydown** — it's the user's preferred concession, and in a buyer's market it usually beats an equivalent price cut for a buyer who plans to hold the loan.

Two forms; show both:

- **Permanent buydown (discount points).** Seller credit buys points at closing. Rule of thumb: 1 point (1% of loan) ≈ 0.25% off the rate; verify with the lender, it varies. Compute the new P&I and the monthly saving.
- **Temporary 2-1 buydown.** Rate is 2% lower in year 1, 1% lower in year 2, then the note rate. Cost ≈ the sum of the payment differences over 24 months, escrowed by the seller. Cheaper for the seller, less durable for the buyer; good when the buyer expects to refinance.

Table format:

| Concession | Ask | Cost to seller | Value to buyer |
|---|---|---|---|
| Permanent buydown, 2 pts | Rate 6.66% → ~6.16% | $6,390 (2% of $319.5k) | −$104/mo; $37k over 30 yrs |
| 2-1 temporary buydown | 4.66% / 5.66% / 6.66% | ~$6,900 | −$400/mo yr 1, −$205/mo yr 2 |
| Equivalent price cut | −$6,400 | $6,400 | −$41/mo |

The comparison row is the point: a seller credit of $X toward rate lowers the payment roughly 2–3× more than cutting the price by $X. Note the lender's cap on seller credits (conventional: 3% of price at <10% down, 6% at 10–25%; FHA 6%; VA 4%) so the ask is fundable.

Other concessions to list after the buydown, in the order that makes sense for the property: closing costs paid, inspection/repair credit (roof, termite, foundation findings), home warranty, prepaid HOA, appliances/furnishings, extended close or rent-back if the seller needs time. In a seller's market, drop this table to one line: "Concessions unlikely; ask for a 2-1 buydown only if the house sits past 30 days."

Always state that the buyer should get the credit written as "seller credit toward buyer's closing costs and prepaids, to be applied to discount points" so the lender can apply it, and that the final points price comes from the lender's rate sheet on lock day.

## Formatting

Currency to nearest dollar in tables, nearest $100 in prose. Percentages to one decimal. Ranges as "$312k–$338k", never a single false-precision number for an estimate.
