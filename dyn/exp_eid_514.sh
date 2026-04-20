#!/bin/bash
## SET REGION
g.region --q n=60 s=50 w=-90 e=-80 align=total_carbon_2022
# ## EXPORT TILE
r.out.gdal --o type=Float32 input=total_carbon_2022@CARBON output=/data/datasets/carbon/total_carbon_2022//tiles/total_carbon_2022_514.tif createopt=COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES -f -c
exit
# 
