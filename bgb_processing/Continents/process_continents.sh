#!/bin/bash
date
start1=`date +%s`

DIR="/globes/USERS/GIACOMO/c_stock/bgb_processing"
source ${DIR}/bgb_parameters.conf

INCON="/globes/USERS/GIACOMO/c_stock/bgb_processing/Continents/output_data/continents.vrt"
OUTCON="continents"
CON_RCL="continents_rcl"
RLZ=${WORKING_DIR}"/Continents/reclass_continents.rcl"

# # IMPORT THE GEZ LAYER PRODUCED BY EDUARDO IN GRASS DB
# grass ${CARBON_MAPSET_PATH} --exec r.external --overwrite input=${INCON} output=${OUTCON}

# # reclassify GEZ to values suitable for final cross (algternative method to r.cross)
grass ${CARBON_MAPSET_PATH} --exec r.reclass --overwrite input=${OUTCON} output=${CON_RCL} rules=${RLZ} # reclassify continents

end=`date +%s`
runtime=$(((end-start1) / 60))
echo "PROCEDURE COMPLETED. Script $(basename "$0") executed in ${runtime} minutes"
exit
