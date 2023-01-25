#!/bin/bash
## CLIP AND EXPORT LAYERS FOR EU27 - NO GO AREAS

DIR="/spatial_data/Derived_Datasets/RASTER/Carbon/"

g.region raster=agc2018_100m@CARBON -p

r.out.gdal --o type=Float32 input=agc2018_100m@CARBON output=${DIR}agc2018_100m.tif createopt="COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES" -c
echo "agc done"
r.out.gdal --o type=Float32 input=bgc2018_100m@CARBON output=${DIR}bgc2018_100m.tif createopt="COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES" -c
echo "bgc done"
r.out.gdal --o type=Float32 input=dw_carbon_100m@CARBON output=${DIR}dw_carbon_100m.tif createopt="COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES" -c
echo "dwc done"
r.out.gdal --o type=Float32 input=lit_carbon_100m@CARBON output=${DIR}lit_carbon_100m.tif createopt="COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES" -c
echo "lit done"
r.out.gdal --o type=Float32 input=total_carbon@CARBON output=${DIR}total_carbon.tif createopt="COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES" -c
echo "tot done"

exit
