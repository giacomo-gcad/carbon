#!/bin/bash
g.region raster=ltb2022_100m
## CONVERT LIT_BIOMASS (DENSITY) IN LITTER CARBON AMOUNT. OUTPUT UNITS: Mg
r.mapcalc --overwrite expression="ltc2022_100m=float(ltb2022_100m / 2 * area() / 10000) "
r.support map=ltc2022_100m title="Litter Carbon map" units="Mg" description="Litter Carbon (amount in Mg)"
## APPLY FOREST MASK
r.mapcalc --overwrite expression=" ltc2022_100m_fm = float(ltc2022_100m * forest_mask_100m) "
r.support map=ltc2022_100m_fm title="Litter Carbon map (only forest)" units="Mg" description="Litter Carbon (amount in Mg, only forest)"
exit

