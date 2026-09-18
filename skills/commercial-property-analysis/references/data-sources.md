# Data sources and search patterns (commercial)

Search queries work best as the bare address plus one keyword. Commercial data is thinner and more paywalled than residential (CoStar is closed); triangulate from LoopNet/Crexi listings, brokerage reports, assessor records, and the listing broker's own OM. Fetch pages when the snippet only shows part of a number.

## Every property

| Need | Query pattern | Notes |
|---|---|---|
| Listing / OM | `<address> loopnet`, `<address> crexi`, `<address> for sale`, the broker's site | LoopNet and Crexi listing pages usually fetch; the OM is often a PDF link on the page — fetch it (use the pdf-reading skill). Capture: price, sqft, cap rate claimed, NOI claimed, occupancy, tenants, year built, lot, zoning, parking. |
| Sale / transfer history | `<address> sold`, assessor transfer record, `<address> crexi sale history` | Commercial sales are less often on Zillow; the assessor is the primary source. |
| Assessor / tax | `<county> assessor <address>`, `<address> parcel` | Assessed value, land vs improvement, tax bill, exemptions, owner entity (search the LLC — it tells you who's selling and often why). |
| **Lease comps** | `<submarket> <type> space for lease`, `<city> retail space for lease $ sqft`, `<city> warehouse for lease`, `<zip> office space lease rate`, LoopNet/Crexi "for lease" filtered by type and size | 3–5 active listings, same type and size class (±30%), same submarket, quoted $/sqft/yr **with expense structure** (NNN vs gross — a $22 gross and a $16 NNN can be the same rent). Note TI and free rent if advertised. |
| **Sold comps** | `<city> <type> sold <year>`, Crexi "sold" filter, `<submarket> <type> sale cap rate`, brokerage "recent transactions" pages | 3–6 sales ≤ 24 mo: $/sqft, cap rate if disclosed, occupancy and WALT at sale. Single-tenant NNN comps are national by tenant: `<tenant> NNN cap rate <year>`. |
| Submarket stats | `<city> <type> market report <quarter year>` (CBRE, Colliers, Cushman & Wakefield, JLL, Marcus & Millichap, Lee & Associates, NAI, local firms) | Vacancy, asking rent, absorption, new supply, cap-rate ranges by class. Fetch the PDF. |
| Tenant credit | `<guarantor> bankruptcy`, `<tenant> store closures <year>`, `<tenant> franchisee`, S&P/Moody's rating, SEC filings for public parents, `<tenant> <city> reviews` | Rate the guarantor, not the brand. |
| Zoning / use | `<city> zoning map`, `<city> zoning lookup <address>`, `<city> parking requirements <use>` | Permitted uses, parking ratio required vs provided, overlay districts, any pending rezoning or corridor plan. Nonconforming status matters for insurance and re-tenanting. |
| Traffic counts (retail) | `<road> <city> traffic count AADT`, state DOT traffic count map | Report AADT at the frontage and whether the site is on the going-home side. |
| Demographics (retail/office) | `<zip> demographics`, Census QuickFacts, `<address> daytime population` | 1/3/5-mile population, median HH income, daytime employment. |
| Environmental | `<address> environmental`, `<city> brownfield map`, state DEQ/TCEQ/DEP site search, `<address> underground storage tank`, historic aerials/street view, Sanborn maps for older parcels | Any gas station, dry cleaner, auto shop, print shop, or industrial history → Phase I ESA is non-negotiable and belongs in the verify list regardless. |
| Flood / hazard | `<address> FEMA flood zone`, fetch `https://msc.fema.gov/portal/search?AddressQuery=<url-encoded address>`, `<address> flood factor` | Zone, BFE, panel; First Street flood/wind/fire/heat where shown. Commercial flood policies (NFIP commercial caps at $500k building / $500k contents) — excess flood is a real cost. |
| Insurance climate | `<state> commercial property insurance <year>`, `<city> commercial insurance rates` | Direction and drivers unless a source quotes $/sqft. |
| Building systems | OM, listing photos, `<address> roof replacement permit`, permit portal | Roof type/age, RTU count/age, sprinklers, electrical service (amps/phase for industrial), elevator, ADA. |
| Permits / violations | `<city> permit search <address>`, `<city> code enforcement <address>` | Open permits, unpermitted work, fire marshal citations. |
| Lender terms | `commercial real estate loan rates <month year>`, `SBA 504 rate <month year>`, `SBA 7a rate`, `<state> credit union commercial real estate loan` | Rates change; never assume. |
| New-build cost (trade-off) | `<city> <type> construction cost per square foot <year>`, RSMeans/Cumming/Gordian city indexes, `<city> commercial land for sale`, `<city> <type> new construction lease rate` | Feeds `tradeoff.md`. |
| Incentives | `<city> opportunity zone map`, `<state> enterprise zone`, `Louisiana Restoration Tax Abatement`, `Louisiana ITEP`, `<city> PILOT`, `<city> facade grant` | Owner-users and value-add buyers should check all of them. |
| Crime (buyer link) | LexisNexis Community Crime Map `https://communitycrimemap.com/?address=<url-encoded full address>&startDate=90&endDate=0` where the local PD feeds it | Client-rendered — never cite as a data source; include as a link in Location and the verify list. |

## By property type — what changes

### Retail (strip, single-tenant NNN, pad)
- Value drivers: traffic count, visibility, signage, access (curb cuts, signalized), co-tenancy/anchor, parking ratio (4–5/1,000 sqft typical; restaurants 10+), daytime population, competing centers within 3 miles.
- Single-tenant NNN is a bond wrapped in a building: price = credit × remaining term × rent-to-market. Search `<tenant> NNN cap rate <year>` and note whether the rent is above market (residual risk at expiration).
- Restaurant space: grease trap, hood, and HVAC tonnage; percentage rent clauses; get sales.
- Red flags: dark anchor, co-tenancy triggers, exclusive-use clauses that block backfill, drive-through queue conflicts, tenants that are franchisees of struggling brands.

### Office / medical office
- Quote RSF and the load factor (RSF/USF); gross leases with base years are common — model the base-year exposure.
- Parking ratio (3–4/1,000 office; medical 5–6/1,000), elevator/ADA, HVAC zoning, after-hours HVAC billing.
- Medical: hospital proximity and affiliation, plumbing/med-gas build-out (high TI but sticky tenants), physician group vs health-system credit.
- Post-2020 office: underwrite renewal probability lower (50–60%) and downtime longer (12+ mo) unless the submarket report says otherwise; small suburban/medical office has held up far better than downtown Class B — say which this is.
- Red flags: single large tenant with a near-term expiration, deferred HVAC, no sprinklers in a building over 3 stories, functionally obsolete floor plates.

### Industrial / flex / warehouse
- Value drivers: clear height (≥ 24' modern, < 16' obsolete-ish), dock-high vs grade-level doors and count, truck court depth, column spacing, power (3-phase, amps), sprinklers (ESFR for bulk), office finish %, yard space and outdoor storage rights (IOS is its own asset class), highway/port/rail access.
- Rents quoted NNN $/sqft/yr; flex (office/warehouse mix) prices between office and warehouse — state the mix.
- Red flags: prior heavy-industrial use (Phase I), floor load limits, zoning that bans outdoor storage, roof age on metal buildings, low power for modern tenants, truck access through residential streets.

## Louisiana / New Orleans (Orleans, Jefferson, St. Tammany, St. Bernard)

| Need | Source | How |
|---|---|---|
| Parcel, assessed value, tax, sales | Orleans Parish Assessor (`qpublic.net/la/orleans`, `nolaassessor.com`); Jefferson Parish Assessor; St. Tammany Assessor | `<address> nola assessor` / `<address> jefferson parish assessor`. Commercial assessed at 15% of improvement value, 10% land; check for RTA, ITEP, or Opportunity Zone status. Owner entity on record — search it. |
| Tax bill | City of New Orleans Bureau of Treasury; Jefferson Parish Sheriff | `<address> nola property tax bill` |
| Permits, violations, blight | One Stop / NOLA permits, `data.nola.gov permits <address>` | Code enforcement, liens, fire marshal. |
| Zoning | NOLA CZO: `<address> nola zoning`, One Stop property viewer | Note overlay districts (e.g. Enhancement Corridor, HU-B1/B2, Historic District review by HDLC/VCC — facade and signage changes need approval). |
| Traffic counts | LA DOTD Traffic Count map (`ladotd traffic counts`) | AADT by segment. |
| Environmental | LDEQ EDMS (`ldeq edms <address>`), LDNR SONRIS (wells/tanks), EPA Envirofacts | Search the parcel and adjacent parcels. |
| Flood | FEMA MSC + city Flood Zone Lookup; LSU AgCenter FloodMaps | The 2016 remap put much of Orleans in Zone X but zones vary by block; all of New Orleans East and most of the metro is pump-dependent regardless — say so. Commercial flood insurance is priced and capped differently from residential; excess flood often needed. |
| Insurance | `Louisiana commercial property insurance <year>`, Louisiana Citizens commercial | Louisiana commercial premiums are among the highest in the country and wind deductibles of 2–5% are standard; get a quote before an offer. |
| Incentives | Louisiana Economic Development: Restoration Tax Abatement (5-yr freeze on improvement assessment, renewable), Enterprise Zone, Quality Jobs, ITEP (manufacturing); NOLA Opportunity Zones; Downtown Development District programs | Owner-users renovating an older building should model RTA. |
| Crime | NOPD calls for service on data.nola.gov; Community Crime Map (NOPD feed) | Per 1,000 residents vs citywide; link in the report. |
| Market reports | Corporate Realty, Stirling Properties, Latter & Blum Commercial, SRSA, NAI Latter & Blum, Colliers New Orleans | Local firms publish the best sub-$5M color for the metro; search `<firm> New Orleans <type> market report <year>`. |
