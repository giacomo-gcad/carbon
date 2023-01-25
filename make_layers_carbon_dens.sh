#!/bin/bash
## CREATE CARBON DENSITY LAYERS AND EXPORT

DIR="/spatial_data/Derived_Datasets/RASTER/Carbon/"
DIRpar="/globes/USERS/GIACOMO/c_stock/total_carbon/"
source ${DIRpar}total_c.conf

echo "-----------------------------------------------------------------------------------"
echo "Script $(basename "$0") started at $(date)"
echo "-----------------------------------------------------------------------------------"
start=`date +%s`

g.mapset CARBON

## WITHOUT FOREST MASK

# date
# echo "Now computing maps without forest mask"

# g.region raster=total_carbon -p
# r.mapcalc --o "agc2018_100m_dens = float(agb2018_100m / 2)" &
# r.mapcalc --o "bgc2018_100m_dens = float(bgb2018_100m / 2)" &
# r.mapcalc --o "dw_carbon_100m_dens = float(dw_biomass_100m / 2)" &
# r.mapcalc --o "lit_carbon_100m_dens = float(lit_biomass_100m / 2)" &
# r.mapcalc --o "gsoc_15_100m_dens = float( gsoc_15_100m / ( area() / 10000))" &
# r.mapcalc --o "total_carbon_dens = float(total_carbon / ( area() / 10000 ))"

wait

echo "Now setting the NULL value to 0 ..."
r.null map=agc2018_100m_dens null=0 &
r.null map=bgc2018_100m_dens null=0 &
r.null map=dw_carbon_100m_dens null=0 &
r.null map=lit_carbon_100m_dens null=0 &
r.null map=gsoc_15_100m_dens null=0 &
r.null map=total_carbon_dens null=0

wait

echo "Now exporting in tif maps without forest mask"

r.out.gdal --o --q input=agc2018_100m_dens output=${DIR}agc2018_100m_dens.tif createopt="COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES" -c
r.out.gdal --o --q input=bgc2018_100m_dens output=${DIR}bgc2018_100m_dens.tif createopt="COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES" -c
r.out.gdal --o --q input=dw_carbon_100m_dens output=${DIR}dw_carbon_100m_dens.tif createopt="COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES" -c
r.out.gdal --o --q input=lit_carbon_100m_dens output=${DIR}lit_carbon_100m_dens.tif createopt="COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES" -c
r.out.gdal --o --q input=gsoc_15_100m_dens output=${DIR}gsoc_15_100m_dens.tif createopt="COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES" -c
r.out.gdal --o --q input=total_carbon_dens output=${DIR}total_carbon_dens.tif createopt="COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES" -c

## WITH FOREST MASK

date
echo "Now computing maps with forest mask"

g.region raster=total_carbon -p
r.mapcalc --o "agc2018_100m_dens_fm = agc2018_100m_dens * forest_mask_100m" &
r.mapcalc --o "bgc2018_100m_dens_fm = bgc2018_100m_dens * forest_mask_100m" &
r.mapcalc --o "dw_carbon_100m_dens_fm = dw_carbon_100m_dens * forest_mask_100m" &
r.mapcalc --o "lit_carbon_100m_dens_fm = lit_carbon_100m_dens * forest_mask_100m " &
r.mapcalc --o "gsoc_15_100m_dens_fm = gsoc_15_100m_dens * forest_mask_100m " &
r.mapcalc --o "total_carbon_dens_fm = total_carbon_dens * forest_mask_100m "

wait

echo "Now exporting in tif maps with forest mask"

r.out.gdal --o --q input=agc2018_100m_dens_fm output=${DIR}agc2018_100m_dens_fm.tif createopt="COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES" -c
r.out.gdal --o --q input=bgc2018_100m_dens_fm output=${DIR}bgc2018_100m_dens_fm.tif createopt="COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES" -c
r.out.gdal --o --q input=dw_carbon_100m_dens_fm output=${DIR}dw_carbon_100m_dens_fm.tif createopt="COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES" -c
r.out.gdal --o --q input=lit_carbon_100m_dens_fm output=${DIR}lit_carbon_100m_dens_fm.tif createopt="COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES" -c
r.out.gdal --o --q input=gsoc_15_100m_dens_fm output=${DIR}gsoc_15_100m_dens_fm.tif createopt="COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES" -c
r.out.gdal --o --q input=total_carbon_dens_fm output=${DIR}total_carbon_dens_fm.tif createopt="COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES" -c

end=`date +%s`
runtime=$(((end-start) / 60))

echo "-----------------------------------------------------------------------------------"
echo "Script $(basename "$0") ended at $(date)"
echo "-----------------------------------------------------------------------------------"
echo "Carbon layers exported in "${runtime}" minutes"
echo "-----------------------------------------------------------------------------------"
exit
