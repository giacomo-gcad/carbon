#!/bin/bash
g.region raster=lit_biomass_100m
## CONVERT LIT_BIOMASS (DENSITY) IN LITTER CARBON AMOUNT. OUTPUT UNITS: Mg
r.mapcalc --overwrite expression="lit_carbon_100m=float(lit_biomass_100m / 2 * area() / 10000) "
r.support map=lit_carbon_100m title="Litter Carbon map" units="Mg" description="Litter Carbon (amount in Mg)"
## APPLY FOREST MASK
r.mapcalc --overwrite expression=" lit_carbon_100m_fm = float(lit_carbon_100m * forest_mask_100m) "
r.support map=lit_carbon_100m_fm title="Litter Carbon map (only forest)" units="Mg" description="Litter Carbon (amount in Mg, only forest)"
exit

