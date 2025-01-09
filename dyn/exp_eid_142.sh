#!/bin/bash
## SET REGION
g.region --q n=-50 s=-60 w=150 e=160 align=agc2021_100m_fm
# ## EXPORT TILE
r.out.gdal --o type=Float32 input=agc2021_100m_fm@CARBON output=/spatial_data/Derived_Datasets/RASTER/Carbon/v5_2021/amount/with_fm/agc2021_100m_fm/tiles/agc2021_100m_fm_eid_142.tif createopt=COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES -f -c
exit
# 
