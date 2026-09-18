# Data sources and search patterns (commercial listings)

| Need | Pattern | Notes |
|---|---|---|
| Restaurant / retail for lease | `https://www.loopnet.com/search/restaurants/<city>-<st>/for-lease/`, `https://www.loopnet.com/search/retail-space/<city>-<st>/for-lease/`, `https://realmo.com/restaurants/for-lease/<st>/<city>/`, `<city> restaurant space for lease` | LoopNet search pages fetch and list address, size range, $/SF/yr, year built, broker; Realmo lists infrastructure notes (grease trap, drive-thru) and "similar for sale." Crexi and CityFeet often block fetches — use snippets. |
| Restaurant / retail for sale | `https://www.loopnet.com/search/restaurants/<city>-<st>/for-sale/`, `https://www.loopnet.com/search/listings/drive-through-restaurants/<city>-<st>/for-sale/`, `https://realmo.com/restaurants/for-sale/<st>/<city>/`, `<city> restaurant building for sale` | Capture price, cap if quoted, SF, lot, tenant status. |
| Office / medical | `.../office-space/<city>-<st>/for-lease/`, `.../medical-offices/...`, TenantBase `<city>` page | TenantBase lists $/mo suites — handy for small users. |
| Industrial / flex | `.../industrial-space/...`, `.../flex-space/...`, `.../warehouses/...` | Capture clear height, doors, power. |
| Pads / land | `.../land/<city>-<st>/for-lease/` (ground lease), `<city> pad site for lease` | |
| Sub-market rates | `<city> retail market report <year>` (Colliers, Cushman/Sage Partners, Moses Tucker, Kelley Commercial, Flake & Co, local firms), CommercialCafe/PropertyShark city pages | Asking-rate averages by type; use for the `est` range on "rate upon request." |
| Zoning / use | `<city> zoning map`, `<city> zoning code restaurant conditional use`, `<city> parking requirements restaurant` | Little Rock: C-3 general commercial permits restaurants; drive-thrus and bars often need a CUP; check the PZ portal. |
| Traffic counts | `<state> DOT traffic count map`, `<road> <city> AADT` | ARDOT for Arkansas. |
| Health / liquor | `<county> health department food permit`, `<state> ABC restaurant permit` | Note timelines; Arkansas ABC and Pulaski County Health add weeks to opening. |
| Brokerage listing pages | `<address> for lease` | Local firm pages (Kelley, Moses Tucker, Sage Partners, Rees, Flake & Co, Colliers Arkansas) often carry the flyer PDF with rate, NNN estimate, and site plan — fetch the flyer. |

Deduplicate: the same space appears on LoopNet, Crexi, Realmo, CityFeet, and the broker's site; key on address + suite.
