#!/bin/bash
date
start1=`date +%s`

echo " "
echo "Script $(basename "$0") started at $(date)                                        "
echo "----------------------------------------------------------------------------------"
echo " "

DIR="/globes/USERS/GIACOMO/c_stock/bgb_processing"
source ${DIR}/bgb_parameters.conf

GEZ="gez_2010_rcl"
CON="continents_rcl"
ESA="esalc_2021_rcl_100m"
QUE="quercus_100m_rcl"
PLF="tree_plantations_rcl"
AGB="agb2021_100m_rcl"
OUT="rcl_cross"
OUT_TABLE=${DIR}"/rcl_cross/output_data/rcl_cross_stats.csv" 

grass ${CARBON_MAPSET_PATH} --exec g.region raster=${AGB}
grass ${CARBON_MAPSET_PATH} --exec r.mapcalc "${OUT} = int( ${GEZ} + ${CON} + ${ESA} + ${PLF} + ${QUE} + ${AGB} )" --o --q
grass ${CARBON_MAPSET_PATH} --exec r.stats -a input=${OUT} output=${OUT_TABLE} separator=pipe null_value=0 --o --q

echo "re-classed layers cross performed and stats computed"
wait

date
end=`date +%s`
runtime=$(((end-start1) / 60))
echo "PROCEDURE COMPLETED. Script $(basename "$0") executed in ${runtime} minutes"
exit
