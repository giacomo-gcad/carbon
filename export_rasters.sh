#!/bin/bash
## EXPORT CARBON LAYERS

DIR="/spatial_data/Derived_Datasets/RASTER/Carbon/v5_2021/amount/with_fm/"

g.region --q raster=agc2021_100m_fm@CARBON

r.out.gdal --o type=Float32 input=agc2021_100m_fm@CARBON output=${DIR}agc2021_100m_fm.tif createopt="COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES" -f -c
echo "agc done"
r.out.gdal --o type=Float32 input=bgc2021_100m_fm@CARBON output=${DIR}bgc2021_100m_fm.tif createopt="COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES" -f -c
echo "bgc done"
r.out.gdal --o type=Float32 input=dw_carbon_100m_fm@CARBON output=${DIR}dw_carbon_100m_fm.tif createopt="COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES" -f -c
echo "dwc done"
r.out.gdal --o type=Float32 input=lit_carbon_100m_fm@CARBON output=${DIR}lit_carbon_100m_fm.tif createopt="COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES" -f -c
echo "lit done"
r.out.gdal --o type=Float32 input=total_carbon_fm@CARBON output=${DIR}total_carbon_fm.tif createopt="COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES" -f -c
echo "tot done"

exit
