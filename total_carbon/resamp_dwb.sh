#!/bin/bash
g.region raster=dwb2022_100m
## CONVERT DW_BIOMASS (DENSITY) IN DEAD WOOD CARBON AMOUNT. OUTPUT UNITS: Mg
r.mapcalc --overwrite expression="dwc2022_100m=float(dwb2022_100m / 2 * area() / 10000) "
r.support map=dwc2022_100m title="Dead Wood Carbon map" units="Mg" description="Dead Wood Carbon (amount in Mg)"
## APPLY FOREST MASK
r.mapcalc --overwrite expression=" dwc2022_100m_fm = float(dwc2022_100m * forest_mask_100m) "
r.support map=dwc2022_100m_fm title="Dead Wood Carbon map (only forest)" units="Mg" description="Dead Wood Carbon (amount in Mg, only forest)"
exit

