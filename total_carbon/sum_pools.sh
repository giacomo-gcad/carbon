#!/bin/bash
g.region raster=agc2024_100m
r.mapcalc --overwrite expression="total_carbon_2024 = float(gsoc_16_100m + agc2024_100m + bgc2024_100m + dwc2024_100m + ltc2024_100m) "
r.support map=total_carbon_2024 title="Total Carbon map " units="Mg" description="Sum of 5 Carbon pools (in Mg)"
exit

