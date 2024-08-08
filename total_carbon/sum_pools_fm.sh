#!/bin/bash
g.region raster=agc2021_100m
r.mapcalc --overwrite expression="total_carbon_2021_fm = float(gsoc_16_100m_fm + agc2021_100m_fm + bgc2021_100m_fm + dw_carbon_100m_fm + lit_carbon_100m_fm )"
r.support map=total_carbon_2021_fm title="Total Carbon map (only forest)" units="Mg" description="Sum of 5 Carbon pools (in Mg, only forest)"
exit

