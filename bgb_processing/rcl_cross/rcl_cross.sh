#!/bin/bash
date
start1=`date +%s`

echo " "
echo "Script $(basename "$0") started at $(date)                                        "
echo "----------------------------------------------------------------------------------"
echo " "

DIR="/globes/USERS/GIACOMO/c_stock/bgb_processing"
source ${DIR}/bgb_parameters.conf

AGB="agb2022_100m_rcl"
ESA="esalc_2022_rcl_100m"
GEZ="gez_2010_rcl"
CON="continents_rcl"
QUE="quercus_100m_rcl"
PLF="tree_plantations_rcl"
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
