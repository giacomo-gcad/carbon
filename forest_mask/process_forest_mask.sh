#!/bin/bash
# Script to process AGB dataset to derive Deaad Wood Biomass and Litter stocks 
# Coefficients are derived from reclassification of annual rainfall (from Worldclim), elevation (from Gebco 2020) and Ecozones (FROM FAO-GEZ 2010)
date
start1=`date +%s`

echo " "
echo "Script $(basename "$0") started at $(date)                                        "
echo "----------------------------------------------------------------------------------"
echo " "

DIR="/globes/USERS/GIACOMO/c_stock/forest_mask"
source ${DIR}/forest_mask.conf

####################################################################################################
## PART 1: IMPORT, RECLASS and RESAMPLE COPERNICUS LC 2019
# grass ${CATRASTERS_MAPSET_PATH} --exec r.external input=${LC_TIF} output=${COPERNICUS_LC_2019}  #TO BE RUN ONLY FIRST TIME

echo "#!/bin/bash
g.region --quiet raster=${AGB} -p 
r.reclass input=${COPERNICUS_LC_2019} output=${COPERNICUS_LC_2019}_rcl rules=\"${RCL_LC}\"  --q --o 
r.resample input=${COPERNICUS_LC_2019}_rcl output=${COPERNICUS_LC_2019}_rcl_100m --q --o
r.null map=${COPERNICUS_LC_2019}_rcl_100m null=0
exit
" > ./process_lc.sh
chmod u+x process_lc.sh
grass ${CARBON_MAPSET_PATH} --exec ./process_lc.sh

wait
end1=`date +%s`
runtime=$(((end1-start1)))
echo "---------------------------------------------------"
echo "copernicus_lc processed in ${runtime} seconds"
echo "---------------------------------------------------"

####################################################################################################
## PART 2: RASTERIZE MANGROVES DATASET AND IMPORT IN GRASS
gdal_rasterize -burn 1 -of Gtiff -co "COMPRESS=DEFLATE" -co "NUM_THREADS=16" -co "BIGTIFF=YES" -te -180 -60 180 80 -tr 0.00088888888888 0.00088888888888 -ot Byte ${MANGROVE_PATH}/${MANGROVE_SHP} ${MANGROVE_PATH}/${MANGROVE}.tif

echo "Mangroves rasterized. 1=mangroves, 0=no mangroves"
wait

echo "#!/bin/bash
g.region --quiet raster=${AGB}
r.external --o input=${MANGROVE_PATH}/${MANGROVE}.tif output=${MANGROVE}
r.reclass input=${MANGROVE} output=delete_me rules=\"${RCLMANGR}\" --o
r.mapcalc --overwrite expression=\" ${MANGROVE}_rcl_100m = delete_me \"
r.null map=${MANGROVE}_rcl_100m null=0
g.remove type=raster name=delete_me -f
exit
" > ./process_mangrove.sh
chmod u+x process_mangrove.sh
grass ${CARBON_MAPSET_PATH} --exec ./process_mangrove.sh

wait
end2=`date +%s`
runtime=$(((end2-end1)))
echo "---------------------------------------------------"
echo "mangroves processed in ${runtime} seconds"
echo "---------------------------------------------------"

####################################################################################################
## PART 3: IMPORT IN GRASS, RECLASS AND RESAMPLE TO 100m OILPALM
grass ${CARBON_MAPSET_PATH} --exec r.external input=${OILPALM_PATH}/${OILPALM}.vrt output=${OILPALM} #TO BE RUN ONLY FIRST TIME

echo "#!/bin/bash
g.region --quiet raster=${AGB}
r.reclass input=${OILPALM} output=${OILPALM}_rcl rules=\"${RCLOIL}\" --o
r.resample input=${OILPALM}_rcl output=${OILPALM}_rcl_100m --o
r.null map=${OILPALM}_rcl_100m null=1
exit
" > ./process_oilpalm.sh
chmod u+x process_oilpalm.sh
grass ${CARBON_MAPSET_PATH} --exec ./process_oilpalm.sh

wait
end3=`date +%s`
runtime=$(((end3-end2)))
echo "---------------------------------------------------"
echo "oilpalm processed in ${runtime} seconds"
echo "---------------------------------------------------"


####################################################################################################
## PART 4: COMBINE MASKS
echo "#!/bin/bash
g.region --quiet raster=${AGB} 
r.mapcalc --overwrite expression=\"forest_mask_100m = ${COPERNICUS_LC_2019}_rcl_100m * ${OILPALM}_rcl_100m * ${MANGROVE}_rcl_100m \"
r.null map=forest_mask_100m setnull=0
exit
" > ./prepare_mask.sh
chmod u+x prepare_mask.sh
grass ${CARBON_MAPSET_PATH} --exec ./prepare_mask.sh

wait
end4=`date +%s`
runtime=$(((end4-end3)))
echo "---------------------------------------------------"
echo "final forest mask computed in ${runtime} seconds"
echo "---------------------------------------------------"

## FINAL CLEAN UP
rm -f ./process_lc.sh
rm -f ./process_oilpalm.sh
rm -f ./process_mangrove.sh
rm -f ./prepare_mask.sh
rm -f ./prepare_tutto.sh

date
end8=`date +%s`
runtime=$(((end8-start1) / 60))

echo "-----------------------------------------------------------------------------"
echo "PROCEDURE COMPLETED. Script $(basename "$0") executed in ${runtime} minutes"

exit
