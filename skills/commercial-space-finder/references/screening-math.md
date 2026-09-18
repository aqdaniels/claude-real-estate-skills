# Fast screening math (rough estimates)

Everything here is labeled **rough estimate**. Underwriting belongs to `commercial-property-analysis`.

## Lease candidates

```
All-in rent ($/SF/yr)   = base rent + NNN/CAM (quoted, or default below) 
Monthly occupancy       = all-in rent × SF ÷ 12 + utilities est.
Occupancy-cost ratio    = (monthly occupancy × 12) ÷ expected annual revenue
```

Defaults when the listing is silent (label `est`):

| Item | Default |
|---|---|
| NNN/CAM, strip retail | $4–7/SF/yr (secondary Southern metros); $7–12 in lifestyle/new centers |
| NNN/CAM, freestanding | Taxes + insurance + CAM ≈ $3–6/SF/yr |
| Gross-lease conversion | If quoted "gross" or "MG", treat NNN as $0 but confirm utilities/janitorial |
| Utilities, restaurant | $4–8/SF/yr (kitchen-heavy); office $1.50–2.50; warehouse $0.50–1.00 |
| Restaurant revenue/SF | See box.md; state the plan used |

Occupancy-cost ratio: ≤ 8% pass; 8–10% caution; > 10% fail. For office/industrial owner-users, screen on occupancy $/employee or $/SF vs the user's current cost instead.

## Cost to open (restaurant conversions)

| Readiness | Range (label rough) | Notes |
|---|---|---|
| Second-gen, same concept | $50–150/SF | Cosmetic, equipment refresh, signage |
| Second-gen, different concept | $100–250/SF | Line reconfiguration, new equipment package, some MEP |
| Shell / retail conversion | $250–450/SF | Hood, grease trap, sewer, HVAC upsizing, gas, electrical, restrooms, ADA; grease interceptor alone $15–50k depending on sewer route |
| Office/other → restaurant | $300–500/SF | Same plus demolition and often structural for hood penetration |
| Pad / build-to-suit | $400–700/SF + land or ground rent | 12–24 months |

```
Net cost to open   = (cost/SF × SF) − landlord TI allowance + FF&E + soft (permits, design, 10–15%) + pre-opening
Months to open     = second-gen 2–4; conversion 6–10; pad 12–24
```

TI allowance default when unstated: $0 for second-gen; $10–30/SF for shell in a landlord's new center; more negotiable with a strong guaranty.

## Sale candidates

```
$/SF                    = price ÷ building SF   (compare to sold comps and to asking range in the sub-market)
Rough NOI (if leased)   = quoted NOI, or in-place rent × SF × (1 − 7% vacancy) − non-recovered opex est. (15% of rent for NNN, 40% gross)
Rough cap               = rough NOI ÷ price
Owner-user monthly cost = SBA 504 P&I (10% down, blended rate from search) + taxes + insurance + maintenance reserve ($0.25/SF/yr) ÷ 12
Own vs lease            = owner-user monthly cost vs monthly occupancy of the best lease candidate of similar size
```

Screens: rough cap ≥ sub-market cap − 100 bps for leased buildings; for owner-user, own-cost ≤ 115% of the best lease alternative passes (equity build justifies a modest premium), > 130% fails.

## Fit score (0–100)

| Component | Points | Rule |
|---|---|---|
| Economics | 30 | Occupancy ratio (lease) or own-vs-lease / cap (sale): full points at pass, half at caution, 0 at fail |
| Readiness | 25 | Second-gen 25; convertible 12; pad 5 |
| Location fit | 20 | Sub-market matches the concept's customer (daytime/downtown, suburban family, highway); visibility/traffic/anchor evidence |
| Physical fit | 15 | Size in range 10; parking at or above ratio 5; drive-thru/patio if the concept needs it (else −5 if missing) |
| Timing & terms | 10 | Opens within the target window; term/options/TI stated |

Deduct 5–15 for each red flag by severity (zoning conditional use, exclusive-use conflict, environmental history, flood zone, sublease short term). Show the breakdown.
