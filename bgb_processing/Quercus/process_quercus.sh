	#!/bin/bash
date
start1=`date +%s`

DIR="/globes/USERS/GIACOMO/c_stock/bgb_processing"
source ${DIR}/bgb_parameters.conf

INFILE="quercus_brus_2012_wgs84"
TEMPFILE="quercus"
OUTFILE=${TEMPFILE}_100m
RLZ=${DIR}"/Quercus/reclass_quercus.rcl"
AGB="agb2018_100m"

# IMPORT FILE AND REMOVE NULL VALUE
grass ${CARBON_MAPSET_PATH} --exec g.region raster=${AGB}
grass ${CARBON_MAPSET_PATH} --exec r.import extent=region resample=nearest input=${DIR}/Quercus/input_data/${INFILE}.tif output=${TEMPFILE} --q --o
grass ${CARBON_MAPSET_PATH} --exec r.null --q map=${TEMPFILE} null=0

# RESAMPLE TO 100 m RESOLUTION
grass ${CARBON_MAPSET_PATH} --exec g.region raster=${AGB}
grass ${CARBON_MAPSET_PATH} --exec r.resamp.interp input=${TEMPFILE} output=${OUTFILE} method=nearest  --q --o
grass ${CARBON_MAPSET_PATH} --exec g.remove type=raster name=${TEMPFILE} -f

# RECLASS QUERCUS
grass ${CARBON_MAPSET_PATH} --exec r.reclass --overwrite input=${OUTFILE} output=${OUTFILE}_rcl rules=${RLZ}

echo  ${INFILE}" reclassed"

end=`date +%s`
runtime=$(((end-start1) / 60))
echo "PROCEDURE COMPLETED. Script $(basename "$0") executed in ${runtime} minutes"
exit
