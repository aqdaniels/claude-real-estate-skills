# Lease abstraction

The leases are the asset. Abstract every one (or the top tenants by rent when there are more than ~8, plus a summary row for the rest). Where the actual lease isn't available, abstract from the OM/rent roll and mark every field `OM` — the verify-before-offer checklist then says "obtain and read all leases."

## Abstract fields

| Field | What to capture | Why it matters |
|---|---|---|
| Tenant / DBA / entity | Legal tenant entity vs trade name; corporate or franchisee | Franchisee leases carry the operator's credit, not the brand's |
| Use | Permitted use, exclusive-use clause, prohibited uses | An exclusive (e.g. "only pizza restaurant in the center") limits who can fill vacant space |
| Premises | Suite, sqft (state whether RSF/GLA/usable), pro-rata share % | Pro-rata share drives recoveries; check it sums to ~100% |
| Base rent | Current annual and $/sqft/yr; rent schedule | Quote all commercial rent as $/sqft/yr; monthly is the residential habit |
| Escalations | Fixed % (typical 2–3%/yr), fixed step, CPI (capped?), flat | Flat leases lose value every year; CPI uncapped is a gift in inflation |
| Term | Commencement, expiration, remaining months | Feeds WALT and rollover |
| Options | Renewal count and length; rent at option: fixed, % bump, or FMV; notice window | An option at fixed below-market rent is a tenant asset that caps your upside |
| Structure | NNN / absolute NNN / modified gross / full-service gross | Decides who eats expense growth |
| Recoveries | Which expenses reimbursed (tax, insurance, CAM, mgmt fee), base-year or net, caps (controllable CAM cap %), exclusions (roof, structure, capital) | "NNN" with a 3% controllable-CAM cap and roof/structure excluded is mostly NNN |
| Guaranty | Corporate, personal, none; burn-off terms | Small-tenant leases without a personal guaranty are handshake deals |
| Security deposit | Amount, letter of credit | |
| Termination rights | Early termination, kick-out, co-tenancy (rent reduction if anchor leaves), go-dark right | Co-tenancy in a strip center means one anchor departure can cut rent across the center |
| Assignment/sublet | Landlord consent standard | |
| Landlord obligations | Roof, structure, HVAC replacement, parking, TI owed, free rent remaining | Unfunded landlord obligations are debt the buyer inherits |
| ROFR / ROFO / purchase option | On the premises or the whole property | A tenant ROFR can chill a resale |
| Status | Current on rent? Arrears? Estoppel received? | The estoppel is the only thing that turns OM claims into facts |

## Derived metrics

```
WALT (weighted average lease term)   = Σ (remaining months × annual rent) / Σ annual rent
Rollover schedule                    = for each of the next 5 calendar years, Σ annual rent of leases expiring / total annual rent
Top-tenant concentration             = largest tenant's rent / total rent   (and top 3)
Mark-to-market                       = Σ (market rent − contract rent) × sqft, by tenant; positive = upside, negative = risk at expiration
Occupancy (physical)                 = leased sqft / total sqft
Occupancy (economic)                 = in-place base rent / (in-place rent + vacant sqft × market rent)
```

## Credit tiers (state the basis)

| Tier | Basis | Underwriting treatment |
|---|---|---|
| Investment-grade | Public rating BBB−/Baa3 or better on the lease guarantor (not the brand) | Cap rate near market low; vacancy 0–3% |
| Credit / national | National or large regional operator, corporate lease, no rating or below IG | Market cap; vacancy 5% |
| Regional / established local | 5+ years in business, personal guaranty, verifiable | Market cap +25–50 bps; vacancy 7–10% |
| Local / startup | < 3 years, or no guaranty, or arrears | Underwrite the space as going vacant at expiration; cap +50–100 bps |

Verify: search the guarantor name for bankruptcy, store-closure lists, lawsuits, and news; for franchisees, the franchisor's health and the franchisee's unit count; for local tenants, Google review volume and trend, and whether the business is open at the property (street view date, recent reviews).

## Expense structures, in one table

| Structure | Tenant pays | Landlord eats | Watch for |
|---|---|---|---|
| Absolute NNN | Everything incl. roof/structure | Nothing | Single-tenant retail; value is pure credit + term |
| NNN | Taxes, insurance, CAM pro-rata | Roof/structure, capital, sometimes mgmt fee | Caps on controllable CAM; admin fee allowed on CAM? |
| Modified gross | Base rent + some pass-throughs (often utilities/janitorial) | The rest | Common in small office; know which line items |
| Full-service gross (base year) | Base rent; increases over a base year | All expenses at base-year level, forever | Office; base-year exposure grows every year; check gross-up clause |
| Percentage rent | Base + % of sales over a breakpoint | Varies | Restaurants/retail; get sales reports |

## Reading the rent roll for trouble

- Rents that step up sharply "next year" on every lease: the seller front-loaded free rent and is selling into the bump.
- Many leases signed in the last 12 months at rents above the comps: lease-and-sell; verify the tenants are open and paying.
- Expirations clustered in one year: the property is a lease-up deal wearing a stabilized cap rate.
- Related-party tenants (seller's own business, a family LLC): treat as vacant unless there's a market lease with a real guaranty — and for owner-user buyers, this is your opportunity.
- "MTM" or "holdover": vacancy in disguise; underwrite at market with downtime.
- Recovery income in the T12 higher than recoverable expenses: over-billing that reverses at reconciliation.
