# Listing sources and search patterns

Listing sites are the one place where `web_search` snippets and `web_fetch` behave very differently. Search finds candidates; fetch gets the numbers. Test one fetch per site per session and fall back to snippets if refused.

## Search query patterns (web_search)

| Goal | Pattern |
|---|---|
| Broad SFR | `<city> homes for sale under <price>`, `<zip> houses for sale <beds> bedroom` |
| Small multifamily | `<city> duplex for sale`, `<city> fourplex for sale`, `<zip> multi family for sale`, `<city> "2 units" for sale` |
| 5+ units | `<city> apartment building for sale loopnet`, `<city> multifamily crexi <units> units` |
| Motivated / distressed | `<city> "as is" investor special for sale`, `<city> estate sale home`, `<city> price reduced homes`, `<city> pre foreclosure zillow`, `<city> HUD homes`, `<county> tax sale list <year>` |
| FSBO | `<city> for sale by owner`, `<city> fsbo.com`, `<city> craigslist real estate by owner` |
| STR-suitable | `<city> turnkey airbnb for sale`, `<city> furnished home for sale` |
| Land | `<county> land for sale <acres> acres`, `<city> lots for sale landwatch` |

Search results carry price, beds/baths, sqft, and often DOM in the snippet. Collect 8–20 candidates before fetching anything.

## Result-page URL patterns (web_fetch) — build from a search result, don't type from memory

Fetch only URLs that appeared in a search result or that the user provided. Once a site's result page URL is known from a result, its filter parameters can be adjusted; note in the report which pages fetched.

| Site | Reliability | Notes |
|---|---|---|
| homes.com | Good | Search result pages (`/<city>-<st>/homes-for-sale/` with price and type filters) return full listing cards: price, beds/baths/sqft, DOM, price cuts, agent. Neighborhood "sold" pages give comps for ARV. Start here. |
| realtor.com | Good–fair | Result pages usually fetch; listing detail pages sometimes do. Snippets are rich. |
| redfin.com | Fair | Market pages fetch; search result pages often 403. Listing snippets carry Redfin Estimate. |
| zillow.com | Poor | Fetch usually refused. Snippets carry Zestimate, Rent Zestimate, price history — search `<address> zillow` per candidate. |
| trulia.com | Fair | Detail pages sometimes fetch; snippets carry AVM. |
| loopnet.com / crexi.com | Fair | Search result pages sometimes fetch; listing pages often show price, units, cap rate, NOI in the snippet. Cap rates on listings are broker pro forma — say so. |
| auction.com / hubzu.com | Poor | Use snippets for address, opening bid, auction date. |
| hudhomestore.gov | Good | Direct fetch of state listing pages works. |
| landwatch.com / land.com | Fair | Result pages often fetch. |
| Brokerage IDX (local) | Good | Local brokerage search pages found via `<city> <type> for sale <price>` typically fetch cleanly and show MLS#, DOM, and status; excellent fallback when the national sites refuse. |

## Per-candidate data pass

For each shortlisted candidate (not every raw candidate), one search `<address>` plus one fetch of the best listing page. Capture:

- List price, price history / cuts, DOM, status (active, pending, contingent — drop pending unless the user wants to watch)
- Beds/baths, sqft, lot, year built, property type, units
- HOA, taxes as listed (note: often the seller's homestead-capped bill, not the buyer's)
- Rents if stated ("currently rented for", "lease through")
- Disclosures in text: flood zone, as-is, cash only, tenant-occupied, estate, foreclosure, "bonus unit", "in-law suite" (possible unpermitted unit)
- First Street flood/fire/wind factor if the listing shows it (Redfin/Realtor snippets)

## Rent estimates (one per ZIP × bedroom count)

| Source | Pattern | Notes |
|---|---|---|
| Zillow Rent Zestimate | `<address> rent zestimate` (shortlist only) | Snippet usually carries it. |
| Rentometer | `<zip> rent <beds> bedroom rentometer` | Median and range by ZIP. |
| Active rentals | `<zip> house for rent <beds> bedroom` | Take 3–5 actives as a sanity check; actives skew high vs achieved. |
| HUD FMR | `<county> fair market rent <fiscal year>` | Floor for Section 8 strategy. |
| AirDNA (STR) | `<city> airdna market` | ADR and occupancy from snippet; revenue = ADR × occupancy × 365. |

## Market context (denominator)

One search `<city> housing market redfin` or the ZIP equivalent for: number of homes for sale, median list price, median $/sqft, median DOM. Use the median $/sqft for the screen score's price component and quote the counts in the Market context section so the reader knows the shortlist came from N active listings, not five.

## Regulatory pre-check (only when strategy is STR or the user mentions Airbnb)

`<city> short term rental ordinance <year>` before searching. If non-owner-occupied STR is banned or permit-capped, say so at the top and switch the screen to MTR/LTR. New Orleans, most of Miami-Dade's incorporated cities, Honolulu, NYC, Los Angeles, and many resort towns restrict; unincorporated county land often allows.

## What this skill does not search

Say so in "What was missed": off-market/wholesale deal lists, pocket listings, direct-mail responses, MLS fields not exposed on public sites, and anything behind a login. The reader may want an agent or wholesaler feed for those.
