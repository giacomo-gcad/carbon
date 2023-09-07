#!/bin/bash
g.region --quiet raster=agb2020_100m -p 
r.reclass input=copernicus_lc_2019 output=copernicus_lc_2019_rcl rules="/globes/USERS/GIACOMO/c_stock/forest_mask/rcl/copernicus_lc.rcl"  --q --o 
r.resample input=copernicus_lc_2019_rcl output=copernicus_lc_2019_rcl_100m --q --o
r.null map=copernicus_lc_2019_rcl_100m null=0
exit

