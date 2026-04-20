#!/bin/bash
## SET REGION
g.region --q n=40 s=30 w=-40 e=-30 align=ltc2022_100m
# ## EXPORT TILE
r.out.gdal --o type=Float32 input=ltc2022_100m@CARBON output=/data/datasets/carbon/ltc2022_100m//tiles/ltc2022_100m_447.tif createopt=COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES -f -c
exit
# 
