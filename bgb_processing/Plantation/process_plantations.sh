#!/bin/bash
date
start1=`date +%s`

DIR="/globes/USERS/GIACOMO/c_stock/bgb_processing"
source ${DIR}/bgb_parameters.conf

INC=${DIR}"/Plantation/input_data"
OUTC=${DIR}"/Plantation/output_data"
RLZ=${DIR}"/Plantation/reclass_plantations.txt"

# # Convert GeoDatabase file format to Geopackage file format
ogr2ogr -f GPKG -spat -180 -90 180 90 -nln tree_plantations -nlt PROMOTE_TO_MULTI -dim XY ${INC}/plantations_v1_3_dl.gpkg ${INC}/plantations_v1_3_dl.gdb #started 9.40

echo "Plantation gdb converted to geopackage"



# Rasterizes the 'input_data' to (approx.) 100m cell size and returns a binary dataset (2 = Planted Forest; 1 = Natural Forest; 0 = NoData)
gdal_rasterize -burn 2 -l tree_plantations -of GTiff -a_nodata 1 -te  -180 -90 180 90 -tr 0.000888889 0.000888889 -ot Byte -co COMPRESS=LZW ${INC}/plantations_v1_3_dl.gpkg ${OUTC}/tree_plantations_temp.tif # >/dev/null
gdal_translate -ot Byte -a_nodata 0 -co COMPRESS=LZW ${OUTC}/tree_plantations_temp.tif ${OUTC}/tree_plantations.tif # >/dev/null
rm ${OUTC}/tree_plantations_temp.tif

echo "Plantation dataset rasterized"

# IMPORT LAYER IN GRASS
grass ${CARBON_MAPSET_PATH} --exec r.external input=${OUTC}/tree_plantations.tif output=tree_plantations --q --o

grass ${CARBON_MAPSET_PATH} --exec r.reclass --overwrite input=tree_plantations output=tree_plantations_rcl rules=${RLZ} 


wait

echo "Plantation dataset imported in GRASS"

end=`date +%s`
runtime=$(((end-start1) / 60))
echo "PROCEDURE COMPLETED. Script $(basename "$0") executed in ${runtime} minutes"
exit
