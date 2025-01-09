#!/bin/bash
## SET REGION
g.region --q n=-30 s=-40 w=-100 e=-90 align=agc2021_100m_fm
# ## EXPORT TILE
r.out.gdal --o type=Float32 input=agc2021_100m_fm@CARBON output=/spatial_data/Derived_Datasets/RASTER/Carbon/v5_2021/amount/with_fm/agc2021_100m_fm/tiles/agc2021_100m_fm_eid_189.tif createopt=COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES -f -c
exit
# 
