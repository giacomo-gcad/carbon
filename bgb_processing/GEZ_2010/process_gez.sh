#!/bin/bash
date
start1=`date +%s`

DIR="/globes/USERS/GIACOMO/c_stock/bgb_processing"
source ${DIR}/bgb_parameters.conf

INGEZ="/globesUSERS?GIACOMO?c_stock/bgb_processing/GEZX_2010/output_data/gez_2010.vrt"
OUTGEZ="gez_2010@CATRASTERS"
GEZ_RCL="gez_2010_rcl"
RLZ=${WORKING_DIR}"/GEZ_2010/reclass_gez.txt"

# # IMPORT THE GEZ LAYER PRODUCED BY EDUARDO IN GRASS DB
# grass ${CARBON_MAPSET_PATH} --exec r.external --overwrite input=${INGEZ} output=${OUTGEZ}

# # reclassify GEZ to values suitable for final cross (algternative method to r.cross)
grass ${CARBON_MAPSET_PATH} --exec r.reclass --overwrite input=${OUTGEZ} output=${GEZ_RCL} rules=${RLZ} # reclassify GEZ

end=`date +%s`
runtime=$(((end-start1) / 60))
echo "PROCEDURE COMPLETED. Script $(basename "$0") executed in ${runtime} minutes"
exit
