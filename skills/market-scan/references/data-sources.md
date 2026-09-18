# Data sources and search patterns — market level

Queries work best as `<place> <metric>` plus a year when recency matters. Prefer primary/statistical sources for economy and demographics, brokerage data pages for prices and rents, and the municipality itself for tax and regulation. Always capture the as-of period.

## Economy and demographics

| Need | Query pattern | Notes |
|---|---|---|
| Population, households, income, renter share | `<city> quickfacts census`, fetch `https://www.census.gov/quickfacts/<cityslug>` | QuickFacts fetches reliably and gives population estimate, change since 2020, median household income, owner-occupied rate, median home value, median gross rent. Also `<county> ACS median gross rent`. |
| Migration | `<metro> net migration <year>`, `<state> population change <year>` | Census Vintage estimates, Redfin migration reports, U-Haul/United Van Lines indexes (directional only). |
| Jobs & unemployment | `<metro> unemployment rate BLS`, `<metro> job growth <year>` | BLS LAUS/CES metro pages; local EDC or chamber pages list largest employers. Note employer concentration: if one employer or sector is >15% of jobs, flag it. |
| Income growth | `<metro> median household income trend` | FRED series `MHI<state>` or metro-level ACS. |

## Housing market

| Need | Query pattern | Notes |
|---|---|---|
| Median price, $/sqft, DOM, inventory, YoY | `<city> housing market redfin`, fetch `https://www.redfin.com/city/<id>/<ST>/<City>/housing-market` | Redfin market pages usually fetch and carry median sale price, YoY, $/sqft, DOM, sale-to-list, homes sold, competitiveness score. Zillow `home-values` pages give ZHVI and forecast but block fetches more often — use snippets. Realtor.com and Homes.com market pages are alternates. |
| 3–5 year trend | `<metro> home price index FRED`, `<metro> Case-Shiller` (top 20 metros only) | FHFA HPI by metro on FRED fetches well: `https://fred.stlouisfed.org/series/ATNHPIUS<msacode>Q`. |
| Inventory / months of supply | `<metro> months of supply <year>`, `<city> active listings inventory` | Redfin Data Center, local Realtor association monthly reports (search `<metro> association of realtors market report`). |
| New construction / permits | `<metro> building permits <year>`, `<county> housing units authorized` | Census Building Permits Survey; compare permitted units to household growth. |
| Affordability | `<metro> price to income ratio` | Or compute: median price / median household income. >5 is stretched for most non-coastal markets. |

## Rental market

| Need | Query pattern | Notes |
|---|---|---|
| Median rent, YoY | `<city> rent report apartmentlist`, `<city> zumper rent`, `<city> zillow observed rent index` | ApartmentList and Zumper monthly reports give rent by bedroom and YoY; Zillow ZORI is the smoothest series. Report the range across sources. |
| Rent by bedroom count | `<city> average rent 2 bedroom <year>`, `<zip> rent 3 bedroom house` | For SFR rentals prefer house rents (Zillow Rent Zestimate ranges, Rentometer by ZIP) over apartment indices. |
| HUD Fair Market Rent | `<county> HUD fair market rent <fiscal year>`, fetch `https://www.huduser.gov/portal/datasets/fmr.html` | FMR by bedroom count for the metro; useful as a floor and for Section 8 strategies. |
| Vacancy | `<metro> rental vacancy rate`, `<city> apartment vacancy <year>` | Census HVS (metro, quarterly), CoStar/Yardi/RealPage press summaries. Under 5% is tight; over 8% is soft. |
| STR performance | `<city> airbnb occupancy ADR airdna`, `<city> short term rental market <year>` | AirDNA market summary snippets carry ADR, occupancy, revenue. Pair with the STR ordinance search below — performance without permit availability is meaningless. |

## Operating climate

| Need | Query pattern | Notes |
|---|---|---|
| Property tax rate | `<county> effective property tax rate`, `<county> assessor millage <year>`, `<state> property tax on rental property` | Report effective rate on market value and how reassessment works at sale (California Prop 13, Florida Save Our Homes cap loss on sale, Texas no-income-tax high-millage, Louisiana homestead exemption not available to investors). Non-homestead rate is what an investor pays. |
| Insurance climate | `<state> homeowners insurance market <year>`, `<state> landlord insurance cost`, `<state> citizens insurance depopulation` | Florida, Louisiana, California, Texas coast, Colorado wildfire zones are the volatile states. Direction and drivers unless a source quotes premiums. |
| Landlord-tenant law | `<state> landlord tenant law summary`, `<state> eviction process timeline <year>`, `<city> rent control` | Nolo state guides, state attorney general/consumer pages, local legal-aid summaries. Capture: notice periods, eviction timeline (weeks), security deposit limit and return window, late-fee limits, rent control/stabilization, just-cause eviction, source-of-income protections. |
| Rental licensing / inspection | `<city> rental registration ordinance`, `<city> rental inspection program` | Many cities require registration and periodic inspection; note fee and cadence. |
| STR regulation | `<city> short term rental ordinance <year>`, `<city> STR permit requirements` | Capture: allowed zones, owner-occupancy requirement, permit cap/lottery, annual fee, tax. New Orleans, NYC, Honolulu, and many Florida/California cities are restrictive; unincorporated county land often isn't. |

## Hazards and risk

| Need | Query pattern | Notes |
|---|---|---|
| Composite hazard risk | `<county> FEMA national risk index`, fetch `https://hazards.fema.gov/nri/map` (snippet only) | NRI gives county risk rating and the dominant perils (hurricane, riverine flood, wildfire, tornado, hail, earthquake). Also `<county> nri risk rating`. |
| Flood exposure share | `<city> percent homes flood zone`, `<city> first street flood risk` | First Street city summaries give share of properties at risk. |
| Climate insurance trajectory | `<state> insurance rate increase <year>`, `<state> insurer exits` | Ties into the insurance row above; report both. |

## Sub-markets

| Need | Query pattern | Notes |
|---|---|---|
| ZIP-level price and rent | `<zip> housing market`, `<zip> median rent`, `<neighborhood> <city> home prices redfin` | Redfin/Zillow neighborhood and ZIP pages. Aim for 4–6 ZIPs spanning the price range; compute yield per ZIP. |
| Neighborhood context | `<neighborhood> <city> niche`, `<city> neighborhood map data` | Use for boundaries and housing stock, not for characterizing residents. |
| Local investor perspective | `<city> real estate investing <year> biggerpockets`, `<city> rental market news <year>` | Forums are sentiment, not data — use to find claims worth verifying, then verify. |

## Fetch reliability (as observed)

- Fetch reliably: census.gov QuickFacts, fred.stlouisfed.org, huduser.gov, redfin.com market pages, apartmentlist.com research posts, nolo.com, most city .gov ordinance pages.
- Often refuse: zillow.com, realtor.com, airdna.co, costar.com. Use search snippets and don't retry more than once.
- Client-rendered (fetch returns nothing useful): FEMA NRI map, most GIS viewers. Cite them as places for the reader to check, not as data sources.

## State notes

Add a short block when a state's tax or regulatory structure materially changes the math. Keep the same table shape as above.

- **Louisiana**: homestead exemption ($7,500 assessed / $75,000 market) does not apply to rentals; Orleans Parish reassesses quadrennially and taxes jumped after the 2024 reassessment; homeowners insurance is the dominant expense line — always find the current Citizens depopulation status and FORTIFIED roof incentives. New Orleans STR rules are among the strictest in the US (owner-occupancy, one per block, lottery).
- **Florida**: Save Our Homes cap resets at sale, so a buyer's tax bill is often 30–60% above the seller's — always quote the county property appraiser's "buyer's estimate." Non-homestead 10% cap. Citizens Property Insurance status and roof-age underwriting rules matter for anything pre-2005. STR rules vary by city; state law preempts local bans on rentals under 30 days in some cases but not in others.
- **Texas**: no state income tax, high effective property tax (often 1.8–2.5%); appraisal districts (CADs) publish values; 10% homestead cap doesn't apply to rentals.
- **California**: Prop 13 base-year reassessment at sale; statewide rent cap (AB 1482) plus local ordinances; wildfire zones affect insurability (FAIR Plan).
