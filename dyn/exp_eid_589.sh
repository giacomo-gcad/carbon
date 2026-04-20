#!/bin/bash
## SET REGION
g.region --q n=80 s=70 w=-60 e=-50 align=ltc2022_100m
# ## EXPORT TILE
r.out.gdal --o type=Float32 input=ltc2022_100m@CARBON output=/data/datasets/carbon/ltc2022_100m//tiles/ltc2022_100m_589.tif createopt=COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES -f -c
exit
# 
