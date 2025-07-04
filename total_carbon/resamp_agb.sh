#!/bin/bash
g.region raster=agb2022_100m
## CONVERT AGB (DENSITY) IN ABOVE GROUND CARBON AMOUNT. OUTPUT UNITS: Mg
r.mapcalc --overwrite expression="agc2022_100m=float(agb2022_100m / 2 * area() / 10000 )" 
r.support map=agc2022_100m title="Above Ground Carbon map" units="Mg" description="Above Ground Carbon (amount in Mg)"
## APPLY FOREST MASK
r.mapcalc --overwrite expression=" agc2022_100m_fm = float(agc2022_100m * forest_mask_100m) "
r.support map=agc2022_100m_fm title="Above Ground Carbon map (only forest)" units="Mg" description="Above Ground Carbon (amount in Mg, only forest)"
exit

