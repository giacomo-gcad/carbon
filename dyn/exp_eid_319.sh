#!/bin/bash
## SET REGION
g.region --q n=0 s=-10 w=120 e=130 align=total_carbon_2022
# ## EXPORT TILE
r.out.gdal --o type=Float32 input=total_carbon_2022@CARBON output=/data/datasets/carbon/total_carbon_2022//tiles/total_carbon_2022_319.tif createopt=COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES -f -c
exit
# 
