---
name: deal-finder
description: Find and rank currently listed investment properties matching the user's buy box — budget, markets/ZIPs, property type (SFR, small multifamily, STR, land), strategy, return floors — by searching live listings, pulling price/beds/sqft/DOM/rent estimates, running a fast screen (gross yield, 1% rule, rough cap rate, cash flow, DSCR), and delivering a ranked shortlist as an HTML report with links, theses, red flags, and a handoff to property-analysis or multifamily-analysis. Use this skill ANY time the user wants properties found rather than one analyzed, e.g. "find me deals in", "what's for sale in [place] under [price]", "search for duplexes in", "show me listings that cash flow", "what can I buy for $X in [city]", "look for a fourplex", "any good deals in [ZIP]", or gives criteria without an address. Also trigger after a market-scan when asked what to buy, or to refresh a prior search. If a single street address is given, use property-analysis or multifamily-analysis instead.
---

# Deal finder

Turn a buy box into a ranked shortlist of real, currently listed properties. The reader wants to spend their next hour looking at the right five listings instead of scrolling two hundred, so the output must be concrete (address, price, link), current (as-of date on every listing), honestly screened (rough math labeled rough), and end with a clear next step.

This skill sits between `market-scan` (choose the market) and `property-analysis` / `multifamily-analysis` (underwrite one address). It does fast screening, not underwriting — never present its numbers as a valuation or a recommendation to offer.

## Workflow

1. **Build the buy box.** Extract every criterion the user gave and fill gaps with the defaults in `references/buy-box.md`. Essentials: geography (metro, city, or ZIP list), max price, property type, strategy. If geography or budget is missing, ask once with a short question; everything else takes a default and is stated in the report. Write the buy box as the first thing the user sees so they can correct it. If a prior `market-scan` report exists in the conversation, pull its top-tier sub-markets and the strategy verdict into the buy box.

2. **Search listings in parallel.** Read `references/data-sources.md` for search URL patterns per site and per property type, then fire searches for each ZIP/neighborhood × property type in the same turn. Target sources by type:
   - SFR and 2–4 units: Homes.com, Realtor.com, Redfin, Zillow, Trulia; brokerage IDX pages surfaced by `<city> <type> for sale <price>`
   - 5+ units: LoopNet, Crexi, brokerage multifamily pages
   - Distressed/off-market signals: Auction.com, Hubzu, HUD Home Store, Zillow "pre-foreclosure"/FSBO filters, county tax-sale lists
   - Land: LandWatch, Land.com, Zillow lots

   `web_fetch` the two or three result pages that fetch reliably (Homes.com and Realtor.com search result pages usually do; Zillow and Redfin often don't) to get full listing cards rather than snippets. For each promising candidate, fetch the listing page once for price, beds/baths, sqft, lot, year built, DOM, price cuts, HOA, and any rent/lease info. Don't retry a page that refuses.

3. **Collect candidates.** Aim for 8–20 raw candidates across the search set. Record for each: address, list price, type/units, beds/baths, sqft, year built, DOM, price history, listing URL, source, as-of date, and anything in the listing that matters (tenant-occupied, rented at $X, as-is, cash only, HOA, flood disclosure). Drop candidates that clearly violate a hard criterion (over budget by >5%, wrong type, wrong geography).

4. **Estimate rent per candidate.** One search per distinct ZIP × bedroom count (not per property): `<zip> rent <beds> bedroom house` plus Rent Zestimate snippets. Use a listing's stated actual rents when present and flag whether they're above or below market. Record the rent estimate as a range and use the midpoint for math.

5. **Run the fast screen.** Use `references/screening-math.md`. For each candidate compute gross yield, monthly rent-to-price, rough NOI (default expense ratio by property age and type), rough cap rate, estimated debt service at the current investor rate and the user's down payment, rough monthly cash flow, cash-on-cash, and DSCR. Apply the user's floors (or defaults) as pass/fail, and compute the **screen score** from the rubric. All outputs are labeled **rough estimate** with the expense ratio and rate shown once at the top of the table.

6. **Flag red flags.** Per candidate, note anything from the listing or search snippets that should change the reader's enthusiasm: long DOM or repeated price cuts (why?), pre-1950 or 1970s build without renovation notes, "as-is"/"cash only", flood zone or First Street flood factor in the listing, HOA over 10% of rent, below-market in-place rents with long leases, assessed sqft mismatch, unpermitted units implied by "bonus unit" language, STR intent in a city with STR restrictions.

7. **Rank and shortlist.** Sort by screen score, then present the top 5 (fewer if fewer pass) as cards with a one-line thesis ("Clears the cash-flow floor at market rent with 15% cushion; roof age unknown") and the red flags. Below the cards, a full table of every candidate screened, including the ones that failed and why, so the reader can see what was rejected.

8. **Hand off.** End with: the top pick(s) to run through `property-analysis` (SFR) or `multifamily-analysis` (2+ units), the exact criteria used so the search can be re-run later, and any criterion the reader should loosen if too few passed (with the effect quantified: "raising max price to $X adds 4 candidates"). Offer to run the full analysis on #1 in the next turn.

## Report structure

```
Header          Search title, geography, as-of date/time, verdict line (N of M candidates pass the screen)
Buy box         Table of every criterion with value and whether it was user-stated or default
Shortlist       Top 3–5 cards: address, price, type, beds/baths/sqft/year, DOM, rent est. range, gross yield, rough cash flow, DSCR, screen score, thesis, red flags, listing link
Screen table    All candidates: address, price, $/sqft, beds/baths, year, DOM, rent est., yield, rough CF, DSCR, pass/fail, fail reason, link
Assumptions     Rate, down payment, expense ratio by type, vacancy, management, closing costs — with sources
Market context  3–5 lines: how many active listings in the geography met price/type, median $/sqft, typical DOM — so the shortlist has a denominator
What was missed Sources that refused fetches, ZIPs with no matches, listing types not searched (e.g., off-market/wholesale)
Next step       Which candidate(s) to send to property-analysis / multifamily-analysis; criteria to re-run; criterion to loosen if needed
Sources         Numbered list with as-of timestamps
```

## Output

Default deliverable is one self-contained HTML file in `/mnt/user-data/outputs/` named `deal-finder-<place-slug>-<yyyymmdd>.html`, presented with `present_files`. Read `/mnt/skills/public/frontend-design/SKILL.md` first for design quality.

Design intent: a screening sheet, not a listing site. Dense table, sortable if lightweight vanilla JS is used (no external libraries), phone-readable cards for the shortlist. Pass/fail and screen score are the only strong color. Every listing link opens in a new tab. Print stylesheet.

Then a 3–5 sentence chat summary: how many passed, the #1 pick and why, the biggest caveat, and the offer to run full analysis.

If the user asks for a DXC-branded deliverable, use `dxc-docx` or `dxc-pptx` and keep the same structure.

## Refreshing a search

When asked to re-run, reuse the buy box from the earlier report verbatim unless the user changes it, mark which shortlist entries are new, still listed, price-changed, or gone, and keep the same file name pattern with the new date.

## Honesty rules

- Every candidate must come from a fetched or snippeted listing with a URL. Never fabricate an address, price, or listing. If fewer than three real candidates are found, say so and show what was searched rather than padding the list.
- Listings go stale within days; put the as-of date on the header and on every card. Say once that availability and price must be confirmed on the listing.
- Screening math uses a default expense ratio and an estimated rent; label it **rough estimate** and do not call it a valuation, appraisal, or offer recommendation. That is property-analysis's job.
- Do not infer condition from photos you haven't seen or neighborhoods from names. Report what the listing says.
- Do not characterize neighborhoods by their residents. Location risk is reported as data (flood factor, crime relative to city, school rating) with a source, or left to property-analysis.
- Not a licensed agent or advisor — say it once, in Next step.
