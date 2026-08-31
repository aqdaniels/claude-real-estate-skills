# Data sources and search patterns (multifamily)

Shared with property-analysis; multifamily-specific rows are marked **[MF]**.

Search queries work best as the bare address plus one keyword. Fetch pages when the snippet only shows part of a number.

## National sources (use for every address)

| Need | Query pattern | Notes |
|---|---|---|
| Listing / AVM | `<address> zillow`, `<address> redfin`, `<address> trulia` | Zillow/Redfin listing pages often block fetches (405/robots) — the search snippet usually carries price, beds/baths/sqft, last sale and market stats, and Trulia snippets carry the AVM. Try one fetch, then fall back to snippets. Also search `<address> $<list price>` — brokerage IDX pages (e.g. crescentcityliving.com in New Orleans) surface MLS number, DOM and agent. Street names get misspelled across sources; search both spellings. Zillow and Redfin both expose beds/baths/sqft/year/lot, price history, tax history, and Zestimate/Redfin Estimate. Note which one is stale. |
| Comps | `<street name> <city> recently sold`, `<neighborhood> <city> sold homes <year>` | Prefer Redfin's "sold" filter pages and Zillow "recently sold". Take 3–6 sold (not pending/listed) within ~0.5 mi, ±20% sqft, ≤12 months. |
| **[MF]** Rent comps per unit | `<neighborhood> <city> <beds> bedroom apartment for rent`, `<zip> duplex for rent`, `<address> zillow rental`, Rentometer | Get 2–3 real active listings per unit type (beds/sqft within ±15%), ≤1 mi, with price and date. Index-only estimates go in a separate "AVM" line. Note whether comps include utilities. |
| **[MF]** Sold multifamily comps | `<city> duplex sold <year>`, `<neighborhood> multifamily sold`, Homes.com/Redfin sold filtered "multi-family" | Record $/unit and $/sqft; GRM if the listing disclosed rents. Unit count ±1. |
| **[MF]** Market cap rates | `<city> multifamily cap rate <year>`, `<city> duplex fourplex cap rate`, CBRE/Marcus & Millichap/Colliers market reports, LoopNet/Crexi sold listings with NOI | Prefer a sold listing that states NOI over a survey number. |
| **[MF]** Landlord-tenant law | `<state> landlord tenant law security deposit notice`, `<city> rental registration inspection program`, `<city> rent control` | Eviction timeline, deposit limits, notice periods, required registration. |
| **[MF]** Legal unit count / zoning | `<city> zoning lookup <address>`, `<address> certificate of occupancy` | An "illegal" third unit is a lender and insurance problem; check zoning allows the count. |
| **[MF]** Lender rules | `FHA multi unit self sufficiency test`, `Fannie Mae 5% down multifamily owner occupied`, `current investment property mortgage rate` | Only when running house-hack or investor financing — rules change. |
| Rent estimate | `<address> rent zestimate`, `<zip> rent <beds> bedroom` | Cross-check with 2–3 active rentals of similar size in the same ZIP. |
| Flood zone | `<address> FEMA flood zone`, fetch `https://msc.fema.gov/portal/search?AddressQuery=<url-encoded address>` | Report zone (X, AE, A, VE…), BFE if shown, panel number and effective date. X = minimal, AE/A = high-risk with BFE, VE = coastal high-risk. |
| Flood factor / climate | `<address> flood factor`, `<address> firststreet` | First Street Foundation scores appear on Redfin/Realtor listings as Flood/Fire/Heat/Wind factors — capture all four. |
| Schools | `<address> greatschools`, `<school district> report card <year>` | Report assigned schools with rating and source year. |
| Crime | `<city> crime map`, `<neighborhood> <city> crime rate`, `<address> crimegrade` | Prefer the city's own open-data portal. Express as relative to city median. |
| Walk/transit | `<address> walk score` | |
| Neighborhood trend | `<neighborhood> <city> median home price trend`, `<zip> housing market` | Redfin/Zillow market pages give median sale price, $/sqft, DOM, YoY. |
| Permits / violations | `<city> permit search <address>` | Portal varies by city — see state section. |
| Insurance context | `<state> homeowners insurance market <year>`, `<zip> flood insurance cost` | Direction and drivers only unless a source quotes a figure. |

## Louisiana / New Orleans (Orleans, Jefferson, St. Tammany, St. Bernard)

New Orleans has unusually good open portals — hit them directly.

| Need | Source | How |
|---|---|---|
| Parcel, assessed value, tax, homestead, sales | Orleans Parish Assessor | `<address> nola assessor` → fetch the `qpublic.net/la/orleans` or `nolaassessor.com` record. Shows land/improvement value, homestead status, transfer history with prices, lot dimensions, square footage per assessor. |
| Tax bill and payment status | City of New Orleans Bureau of Treasury | `<address> nola property tax bill` |
| Permits, violations, blight, liens | One Stop / NOLA permits | `<address> onestopapp nola` or `data.nola.gov permits <address>` — code enforcement cases and lien history are public here. |
| Crime (data) | NOPD calls for service on data.nola.gov | `data.nola.gov calls for service <year>` filtered by block; report incidents per 1,000 residents vs citywide. CrimeGrade/Niche give neighborhood-level rates when block data isn't reachable. |
| Crime (buyer link) | LexisNexis Community Crime Map (NOPD feed): `https://communitycrimemap.com/?address=<url-encoded full address>&startDate=<days back>&endDate=0` | Client-rendered — fetch returns nothing, so never cite it as a data source. Always include it in the report's Location section and verify checklist as a property-centered link (use 90 days), since it shows NOPD incidents by type around the exact house rather than neighborhood averages. |
| Flood | FEMA + SWBNO/City "Flood Zone Lookup" | The 2016 remap moved much of the city to Zone X, but zones vary block by block — never infer a parcel's zone from the ZIP. If msc.fema.gov can't be fetched, report the zone as unverified, cite what nearby listings advertise, and always note that all of New Orleans East is below sea level and pump-dependent regardless of zone. |
| Flood + elevation (primary LA check) | LSU AgCenter Louisiana Flood Maps portal: `http://maps.lsuagcenter.com/floodmaps/?FIPS=<parish FIPS>` (Orleans 22071, Jefferson 22051, St. Tammany 22103, St. Bernard 22087, East Baton Rouge 22033) | The page fetches, but zone/BFE load client-side on map click — you cannot read a parcel's zone from it. Always cite it in the report as the place for the buyer to check: it overlays Effective vs Preliminary FIRMs (so pending remaps are visible), and dropping a pin returns zone, BFE, USGS LIDAR ground elevation, and LRC design wind speed. Ground elevation minus BFE is the number that drives NFIP pricing. Note: educational tool, not for rating insurance — FEMA MSC remains the official source. |
| Elevation certificate | `<address> elevation certificate` | An elevation certificate materially changes NFIP premiums; note whether one exists and ask the seller for it. |
| Insurance | Louisiana Citizens, LA Department of Insurance | Louisiana's homeowners market has been volatile (carrier insolvencies, Citizens depopulation, Fortify Homes roof grants). Search `<year> Louisiana homeowners insurance market` for current state. FORTIFIED roof status is worth flagging. |
| Neighborhood context | Data Center (datacenterresearch.org) neighborhood profiles | Demographics, housing stock, vacancy by official neighborhood. |
| Schools | NOLA Public Schools (all charters), Louisiana Dept of Ed school performance scores | Assignment is by application (OneApp/NCAP), not strictly by address — say so. |
| **[MF]** Doubles & shotgun doubles | Listing photos + assessor sqft | New Orleans stock is heavily side-by-side doubles (often 1,000–1,400 sf per side) and camelbacks. Assessor sqft is total, not per side. Many were single-family converted or vice-versa — confirm the assessor shows 2 units and the C of O matches. |
| **[MF]** Homestead on doubles | Orleans Assessor | Owner-occupant gets homestead on their side only; the rental side is taxed at full rate. Split the tax line accordingly in house-hack underwriting. |
| **[MF]** Landlord-tenant (LA) | `Louisiana landlord tenant law`, `New Orleans Healthy Homes ordinance` | Louisiana is landlord-favorable (5-day notice to vacate for nonpayment, no deposit cap, deposit returned within 1 month). New Orleans' Healthy Homes registration/inspection program applies to rentals — check current status and fee. |
| **[MF]** Insurance for rentals (LA) | `Louisiana landlord insurance cost`, Louisiana Citizens dwelling fire | Non-owner-occupied doubles often end up on Citizens or surplus lines; budget high and get a quote before offering. |
| Short-term rental rules | City of New Orleans STR regulations | Non-commercial STR permits are heavily restricted; check if the user mentions Airbnb. |

## Other states worth a dedicated section when it comes up

For 5+ unit buildings anywhere: LoopNet and Crexi listings usually include an offering memorandum with a T12 and rent roll — fetch it; cross-check its rents against active listings, since OMs quote pro forma.

Add a section here when a state's portals differ materially (e.g., Texas CAD sites, Florida property appraiser + Citizens, California parcel viewers + wildfire zones). Keep the same table shape.

## Era-based inspection flags

Multifamily additions: pre-1978 → lead-based paint disclosure is mandatory and abatement matters more with tenant children; shared walls/fire separation between units; separate electrical panels and meters; one water heater serving two units; common-area egress and smoke/CO detectors per unit.


Use year built to pre-populate the Risk section's "verify in person" items:

- Pre-1960: knob-and-tube or cloth wiring, galvanized plumbing, lead paint, asbestos siding/floor tile, foundation settlement
- 1960–1980: aluminum branch wiring, Federal Pacific / Zinsco panels, cast iron drain lines, original single-pane windows
- 1980–2005: polybutylene supply lines (1978–1995), Chinese drywall (Gulf Coast, 2004–2007 builds/rebuilds), EIFS stucco
- Post-Katrina New Orleans (2006+): confirm rebuild permits were closed; check for Chinese drywall in 2005–2008 rebuilds
- Any age in South Louisiana: termite contract status (Formosan), roof age vs 2020–2021 hurricane seasons, slab vs pier foundation, drainage/subsidence
