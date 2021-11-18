#!/bin/bash
date
start1=`date +%s`

DIR="/globes/USERS/GIACOMO/c_stock/bgb_processing"
source ${DIR}/bgb_parameters.conf

LC="esalc_2018@CATRASTERS"
LC_RCL="esalc_2018_rcl"
LC_RCL_100=${LC_RCL}"_100m"

RLZ=${WORKING_DIR}"/LandCover/reclass_lc.rcl"

## RECLASS LC
grass ${CARBON_MAPSET_PATH} --exec r.reclass input=${LC} output=${LC_RCL} rules=${RLZ}  --q --o
wait

## RESAMPLE TO AGB RESOLUTION 
grass ${CARBON_MAPSET_PATH} --exec g.region --quiet raster=${AGB}
grass ${CARBON_MAPSET_PATH} --exec r.resamp.interp input=${LC_RCL} output=${LC_RCL_100} method=nearest --q --o
wait

date
end=`date +%s`
runtime=$(((end-start1) / 60))
echo "PROCEDURE COMPLETED. Script $(basename "$0") executed in ${runtime} minutes"
exit
