#!/bin/bash
## SET REGION
g.region --q n=-10 s=-20 w=160 e=170 align=total_carbon_fm
# ## EXPORT TILE
r.out.gdal --o type=Float32 input=total_carbon_fm@CARBON output=/spatial_data/Derived_Datasets/RASTER/Carbon/v5_2021/amount/with_fm/total_carbon_fm/tiles/agc2021_100m_fm_287.tif createopt=COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES -f -c
exit
# 
