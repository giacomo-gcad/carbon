#!/bin/bash
g.region raster=agc2022_100m
r.mapcalc --overwrite expression="total_carbon_2022_fm = float(gsoc_16_100m_fm + agc2022_100m_fm + bgc2022_100m_fm + dwc2022_100m_fm + ltc2022_100m_fm )"
r.support map=total_carbon_2022_fm title="Total Carbon map (only forest)" units="Mg" description="Sum of 5 Carbon pools (in Mg, only forest)"
exit

