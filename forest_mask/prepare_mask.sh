#!/bin/bash
g.region --quiet raster=agb2018_100m -p 
r.mapcalc --overwrite expression="forest_mask_100m = copernicus_lc_2018_rcl_100m * oilpalm_rcl_100m "

