#!/bin/bash
g.region raster=agc2022_100m
r.mapcalc --overwrite expression="total_carbon_2022 = float(gsoc_16_100m + agc2022_100m + bgc2022_100m + dwc2022_100m + ltc2022_100m) "
r.support map=total_carbon_2022 title="Total Carbon map " units="Mg" description="Sum of 5 Carbon pools (in Mg)"
exit

