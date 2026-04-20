#!/bin/bash
## SET REGION
g.region --q n=30 s=20 w=-170 e=-160 align=ltc2022_100m
# ## EXPORT TILE
r.out.gdal --o type=Float32 input=ltc2022_100m@CARBON output=/data/datasets/carbon/ltc2022_100m//tiles/ltc2022_100m_398.tif createopt=COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES -f -c
exit
# 
