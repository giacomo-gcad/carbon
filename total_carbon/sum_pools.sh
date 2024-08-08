#!/bin/bash
g.region raster=agc2021_100m
r.mapcalc --overwrite expression="total_carbon_2021 = float(gsoc_16_100m + agc2021_100m + bgc2021_100m + dw_carbon_100m + lit_carbon_100m) "
r.support map=total_carbon_2021_fm title="Total Carbon map " units="Mg" description="Sum of 5 Carbon pools (in Mg)"
exit

