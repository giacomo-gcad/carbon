#!/bin/bash
g.region raster=bgb2021_100m
## CONVERT BGB (DENSITY) IN BELOW GROUND CARBON AMOUNT. OUTPUT UNITS: Mg
r.mapcalc --overwrite expression="bgc2021_100m=float(bgb2021_100m / 2 * area() / 10000) "
r.support map=bgc2021_100m title="Below Ground Carbon map" units="Mg" description="Below Ground Carbon (amount in Mg)"
## APPLY FOREST MASK
r.mapcalc --overwrite expression=" bgc2021_100m_fm = float(bgc2021_100m * forest_mask_100m) "
r.support map=bgc2021_100m_fm title="Below Ground Carbon map (only forest)" units="Mg" description="Below Ground Carbon (amount in Mg, only forest)"
exit

