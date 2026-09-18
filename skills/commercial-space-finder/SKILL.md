---
name: commercial-space-finder
description: Find and rank currently listed commercial spaces or buildings matching a lease box or buy box — retail, restaurant (second-generation or convertible), office/medical, industrial/flex/warehouse, pad sites — for lease or sale in a metro, city, ZIP, or corridor, by searching live listings (LoopNet, Crexi, Realmo, CityFeet, brokers), pulling sqft, rate/price and structure, zoning, parking, grease-trap/drive-thru/dock details, running a fast fit screen (occupancy cost vs revenue, cost to open, rough cap, own-vs-lease), and delivering a ranked HTML shortlist with links, red flags, and a handoff to commercial-property-analysis. Use ANY time the user wants commercial space FOUND rather than one address analyzed, e.g. "find restaurant space in", "spaces I can turn into a restaurant", "what's for lease in", "buildings for sale under $X", "drive-thru pad", "office for my company", "where can I open a [business]". Residential searches go to deal-finder; one commercial address goes to commercial-property-analysis.
---

# Commercial space finder

Turn a lease box or buy box into a ranked shortlist of real, currently listed commercial spaces. The reader wants to spend their next hour touring the right four spaces instead of scrolling LoopNet, so the output must be concrete (address, sqft, rate or price, link), current (as-of date on every listing), honestly screened (rough math labeled rough), and end with a clear next step.

This skill sits before `commercial-property-analysis` (underwrite one address). It does fast screening, not underwriting — never present its numbers as a valuation or an offer recommendation.

## Workflow

1. **Read deal memory first.** Per the `deal-memory` skill, check for a market cache or prior search for this place; reuse the box and mark what's new/gone if refreshing.

2. **Build the box.** Read `references/box.md`. Essentials: geography, **lease or buy (or both)**, use/concept, size range, and budget (monthly occupancy cost for lease; max price for buy). For restaurants, the concept drives everything — capture service style (QSR/drive-thru, fast-casual, full-service, bar, coffee), target seats, and whether second-generation kitchen space is required or a conversion is acceptable. If geography, lease-vs-buy, or use is missing, ask once with a short question; everything else takes a default and is stated in the report. Write the box as the first thing the reader sees.

3. **Search listings in parallel.** Read `references/data-sources.md` for URL patterns by site and type, then fire searches for each sub-market × type × lease/sale in one turn. LoopNet search-result pages and Realmo usually fetch; Crexi and CityFeet often don't (use snippets). Fetch each promising listing once for sqft, rate/price, structure, term, TI, zoning, parking, year built, lot, drive-thru, grease trap/hood/exhaust, dock doors/clear height, traffic count, co-tenants, DOM, and broker. Don't retry a page that refuses.

4. **Collect candidates.** Aim for 8–20 across lease and sale. Record: address, sub-market, type/subtype, sqft (and divisibility), rate ($/SF/yr **with structure**) or price ($ and $/SF), NNN/CAM estimate if stated, term/TI if stated, zoning, parking count/ratio, key infrastructure (for restaurants: hood/grease trap/walk-in/patio/drive-thru; for industrial: doors/clear/power), year built, traffic/visibility, co-tenants/anchor, listing URL, source, as-of date. Drop hard-criterion misses (wrong geography, size outside range by >25%, use not permitted by zoning or listing).

5. **Classify readiness.** Tag each candidate: **second-gen** (built out for the use — for restaurants, existing hood/grease trap/kitchen), **shell/convertible** (raw or different prior use; conversion cost applies), **pad/land** (build-to-suit or ground lease). Read `references/screening-math.md` for default conversion cost ranges by type; the cost to open is the biggest hidden variable in a restaurant search and is stated per candidate.

6. **Run the fast screen.** Per `references/screening-math.md`: for **lease** candidates, all-in monthly occupancy cost (base + NNN/CAM + utilities est.) and occupancy-cost ratio against the user's expected revenue (restaurants target ≤ 6–10%), plus estimated cost to open (TI net of landlord allowance + FF&E + soft) and months to open. For **sale** candidates, $/SF vs sold comps, rough NOI if leased, rough cap, and for owner-users the monthly ownership cost via SBA 504 vs the lease alternative. Compute the **fit score** from the rubric. Label everything **rough estimate** with assumptions shown once.

7. **Flag red flags.** Long DOM or repeated rate cuts; "rate upon request" on everything (thin market signal); zoning that requires a conditional use for the concept (restaurants, bars, drive-thrus often do); parking below the code ratio for restaurants (typically 1 per 100 SF of dining); no grease trap and no easy sewer route; prior use with environmental history; landlord exclusive-use conflicts (an existing pizza tenant blocks a pizza concept); co-tenancy/anchor vacancy; flood zone; short remaining term on a sublease; sale listings with a short-term tenant in place (delivery timing).

8. **Rank and shortlist.** Sort by fit score; present the top 3–5 as cards with a one-line thesis ("Second-gen with hood and drive-thru; $19 NNN puts occupancy at ~7% of a $1.2M revenue plan; parking ratio unverified") and red flags. Then the full screen table including fails and why.

9. **Hand off and persist.** End with: the top pick(s) to send to `commercial-property-analysis` (buy or lease-vs-buy) and, for leases, the LOI terms worth asking for (TI allowance, free rent months, term/options, controllable-CAM cap, exclusive use); the exact box for re-running; which criterion to loosen if too few pass, with the effect quantified. Write the market card and any deal records per `deal-memory`.

## Report structure

```
Header          Search title, geography, lease/buy, use, as-of date/time, verdict line (N of M candidates pass)
Box             Table of every criterion — value, user-stated or default
Shortlist       Top 3–5 cards: address, sub-market, type, readiness tag, sqft, rate+structure or price, est. all-in monthly, occupancy-cost %, est. cost to open, months to open, parking, zoning, key infrastructure, fit score, thesis, red flags, link
Screen table    All candidates with the same columns condensed, pass/fail, fail reason, link
Assumptions     NNN/CAM default, utilities, conversion cost ranges, TI allowance default, revenue plan used, SBA/bank terms for buy — with sources
Market context  3–5 lines: active listings by type in the geography, asking-rate range by sub-market and structure, typical TI/term, vacancy from the latest brokerage report
What was missed Sources that refused, sub-markets with no matches, off-market/broker-only inventory not visible
Next step       Candidate(s) for commercial-property-analysis; LOI asks; box to re-run; criterion to loosen
Sources         Numbered, with as-of timestamps
```

## Output

One self-contained HTML file in `/mnt/user-data/outputs/` named `commercial-finder-<place-slug>-<yyyymmdd>.html`, presented with `present_files`. Read `/mnt/skills/public/frontend-design/SKILL.md` first. Design intent: a screening sheet — dense table, light vanilla-JS sort (no libraries), phone-readable shortlist cards, pass/fail and fit score the only strong color, links open in new tabs, print stylesheet. Append the `<!-- deal-memory -->` block.

Then a 3–5 sentence chat summary: how many passed, the #1 pick and why, the biggest caveat, and the offer to run the full analysis.

## Refreshing a search

Reuse the box verbatim unless changed; mark shortlist entries new / still listed / rate-changed / gone; same file-name pattern with the new date.

## Honesty rules

- Every candidate comes from a fetched or snippeted listing with a URL. Never fabricate an address, rate, or price. If fewer than three real candidates exist, say so and show what was searched.
- "Rate upon request" is reported as such; estimate a range only from comparable quoted listings in the same sub-market, labelled `est`.
- A quoted rate without its structure (NNN vs gross) is incomplete — always state which, and estimate NNN charges separately when the listing doesn't.
- Conversion and cost-to-open figures are ranges from reference tables, not bids; label them rough.
- Zoning permitted-use and parking ratios must be verified with the city; the report says which candidates need a conditional-use permit check.
- Listings go stale within days; as-of date on the header and every card.
- Not a licensed broker or advisor — say it once, in Next step.
