#!/bin/bash
date
start1=`date +%s`

echo " "
echo "Script $(basename "$0") started at $(date)                                        "
echo "----------------------------------------------------------------------------------"
echo " "

DIR="/globes/USERS/GIACOMO/c_stock/bgb_processing"
source ${DIR}/bgb_parameters.conf

INC="/spatial_data/Original_Datasets/SDPT/uncompressed"
OUTC=${DIR}"/Plantation/output_data"
RLZ=${DIR}"/Plantation/reclass_plantations.rcl"

input_gpkg="sdpt_v2_v20231128.gpkg"
layers_tmp=""

## CREATE LAYERS LIST FILE
# ogrinfo ${INC}/${input_gpkg} >${INC}/layerslist.txt

# # CREATE GLOBAL GRID WITH VALUE=1
#grass ${CARBON_MAPSET_PATH} --exec g.region raster=${AGB}
#grass ${CARBON_MAPSET_PATH} --exec r.mapcalc --o --q expression="fill_grid = 1"

date
echo "Global grid created"

# # RASTERIZE SINGLE LAYERS
for ll in $(sed 1,2d ${INC}/layerslist_ll.txt| cut -d ' ' -f 2)
do
	#grass ${CARBON_MAPSET_PATH} --exec ${WORKING_DIR}/Plantation/slave_process_plantations_v2.sh ${ll} ${INC} ${input_gpkg}
	layers_tmp=${layers_tmp}","${ll}
done

date
echo "Plantations v.2 layers in latlong rasterized"
echo " "

### REPEAT PROCEDURE ON 14 LAYERS WITH DIFFERENT PROJECTIONS
tmp_pp=""
for pp in $(cat ${INC}/layerslist_pp.txt| cut -d ' ' -f 2)
do
	#ogr2ogr -update -overwrite -t_srs EPSG:4326 -nln ${pp}_ll ${INC}/${input_gpkg} ${INC}/${input_gpkg} ${pp}
	#grass ${CARBON_MAPSET_PATH} --exec ${WORKING_DIR}/Plantation/slave_process_plantations_v2.sh ${pp}_ll ${INC} ${input_gpkg}
	tmp_pp=${tmp_pp}","${pp}_ll
done

layers_pp=$(echo ${tmp_pp} | cut -c 2-)

date
echo "Plantations v.2 projected layers reprojected and rasterized"
echo " "

##############################################################

# # MOSAIC ALL LAYERS INTO A SINGLE ONE
# concatenate the two partial lists and add fillgrid at the end of the list of layers to be patched
layers=$(echo ${layers_tmp}","${layers_pp}",fill_grid" | cut -c 2-)

echo "-----------------------------------------------------------------------------"
echo "The final list of layers that will be patched is: "${layers}
grass ${CARBON_MAPSET_PATH} --exec g.region raster=${AGB}

echo "Now patching all layers..."
grass ${CARBON_MAPSET_PATH} --exec r.patch  --q --o -s input=${layers} output=tree_plantations_v2 memory=16000 nprocs=4

date
echo "Plantations v.2 layers mosaicked"
echo " "

# # RECLASS PLANTATIONS
grass ${CARBON_MAPSET_PATH} --exec r.reclass  --q --o input=tree_plantations_v2 output=tree_plantations_v2_rcl rules=${RLZ} 

# # EXPORT TREE PLANTATIONS v2 IN TIFF
# grass ${CARBON_MAPSET_PATH} --exec r.out.gdal --q --o type=Byte input=tree_plantations_v2_rcl output=${OUTC}/tree_plantations_v2_rcl.tif createopt="COMPRESS=DEFLATE"

# # CLEAN MAPSET
#grass ${CARBON_MAPSET_PATH} --exec g.remove --q type=raster pattern=*plant_v2 -f

wait

echo "Plantation dataset (v.2) reclassed"

end=`date +%s`
runtime=$(((end-start1) / 60))
echo "PROCEDURE COMPLETED. Script $(basename "$0") executed in ${runtime} minutes"
exit
