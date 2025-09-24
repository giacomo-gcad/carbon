#!/bin/bash
g.region raster=gsoc_16 align=agc2022_100m -p
## CONVERT SOIL CARBON DENSITY IN SOIL CARBON AMOUNT. OUTPUT UNITS: Mg
r.resample input=gsoc_16 output=gsoc_16_100m_delete_me --o --q
r.mapcalc --overwrite expression="gsoc_16_100m=float(gsoc_16_100m_delete_me * area() / 10000 )" ## Amount of C (in Mg) within each 100m pixel
r.null map=gsoc_16_100m null=0
r.support map=gsoc_16_100m title="Soil Carbon map, 100m res." units="Mg" description="Soil Carbon 100m res. (GSOC 1.6, amount in Mg)"
g.remove type=raster name=gsoc_16_100m_delete_me -f
## APPLY FOREST MASK
r.mapcalc --overwrite expression=" gsoc_16_100m_fm = float(gsoc_16_100m * forest_mask_100m) "
r.support map=gsoc_16_100m_fm title="Soil Carbon map (only forest)" units="Mg" description="Soil Carbon (GSOC 1.6, amount in Mg, only forest)"
exit

