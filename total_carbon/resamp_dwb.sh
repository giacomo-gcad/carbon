#!/bin/bash
g.region raster=dw_biomass_100m
## CONVERT DW_BIOMASS (DENSITY) IN DEAD WOOD CARBON AMOUNT. OUTPUT UNITS: Mg
r.mapcalc --overwrite expression="dw_carbon_100m=float(dw_biomass_100m / 2 * area() / 10000) "
r.support map=dw_carbon_100m title="Dead Wood Carbon map" units="Mg" description="Dead Wood Carbon (amount in Mg)"
## APPLY FOREST MASK
r.mapcalc --overwrite expression=" dw_carbon_100m_fm = float(dw_carbon_100m * forest_mask_100m) "
r.support map=dw_carbon_100m_fm title="Dead Wood Carbon map (only forest)" units="Mg" description="Dead Wood Carbon (amount in Mg, only forest)"
exit

