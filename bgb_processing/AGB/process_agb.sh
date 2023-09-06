#!/bin/bash
date
start1=`date +%s`


DIR="/globes/USERS/GIACOMO/c_stock/bgb_processing"
source ${DIR}/bgb_parameters.conf

INAGB="/spatial_data/Original_Datasets/GlobBiomass/archives/v4/"
INFILE="agb_2020.vrt"
OUTFILE"agb2020_100m"
RLZ=${DIR}"/AGB/reclass_agb.rcl"

# IMPORT AGB INTO GRASS
grass ${PERMANENT_MAPSET} --exec g.mapset -c ${CARBON_MAPSET}
# agb2020_100m already imported, no need to run r.external
#grass ${CARBON_MAPSET_PATH} --exec r.external  input=${INAGB}/${INFILE} output=${OUTFILE}
grass ${CARBON_MAPSET_PATH} --exec g.region raster=${OUTFILE}

echo  ${INFILE}" imported"

# RECLASS AGB to ranges (0 = NULL; <75 = 1; 76 to 125 = 2; >125 = 3)
grass ${CARBON_MAPSET_PATH} --exec r.reclass --overwrite input=${OUTFILE} output=${OUTFILE}_rcl rules=${RLZ}

echo  ${OUTFILE}" reclassed"

end=`date +%s`
runtime=$(((end-start1) / 60))
echo "PROCEDURE COMPLETED. Script $(basename "$0") executed in ${runtime} minutes"
exit
