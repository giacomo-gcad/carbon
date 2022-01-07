#!/bin/bash
date
start1=`date +%s`


DIR="/globes/USERS/GIACOMO/c_stock/bgb_processing"
source ${DIR}/bgb_parameters.conf

INAGB="/spatial_data/Original_Datasets/GlobBiomass/archives/v3/"
INFILE="agb_2018.vrt"
RLZ=${DIR}"/AGB/reclass_agb.rcl"

# IMPORT AGB INTO GRASS
grass ${PERMANENT_MAPSET} --exec g.mapset -c ${CARBON_MAPSET}
grass ${CARBON_MAPSET_PATH} --exec r.external  input=${INAGB}/${INFILE} output=agb2018_100m
grass ${CARBON_MAPSET_PATH} --exec g.region raster=agb2018_100m

echo  ${INFILE}" imported"

# RECLASS AGB to ranges (0 = NULL; <75 = 1; 76 to 125 = 2; >125 = 3)
grass ${CARBON_MAPSET_PATH} --exec r.reclass --overwrite input=agb2018_100m output=agb2018_100m_rcl rules=${RLZ}

echo  ${INFILE}" reclassed"

end=`date +%s`
runtime=$(((end-start1) / 60))
echo "PROCEDURE COMPLETED. Script $(basename "$0") executed in ${runtime} minutes"
exit
