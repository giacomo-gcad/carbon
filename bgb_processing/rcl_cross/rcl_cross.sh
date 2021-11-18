#!/bin/bash
date
start1=`date +%s`

DIR="/globes/USERS/GIACOMO/c_stock/bgb_processing"
source ${DIR}/bgb_parameters.conf

mkdir -p  ${DIR}"/output_data"

GEZ="gez_2010_rcl"
CON="continents_rcl"
ESA="esalc_2018_rcl_100m"
QUE="quercus_100m_rcl"
PLF="tree_plantations_rcl"
AGB="agb2018_100m_rcl"
OUT="rcl_cross"
OUT_TABLE=${DIR}"/rcl_cross/output_data/rcl_cross_cats.csv" 

grass ${CARBON_MAPSET_PATH} --exec g.region raster=${AGB}
grass ${CARBON_MAPSET_PATH} --exec r.mapcalc "${OUT} = ${GEZ} + ${CON} + ${ESA} + ${PLF} + ${QUE} + ${AGB}" --o --q
grass ${CARBON_MAPSET_PATH} --exec r.stats -a input=${OUT} output=${OUT_TABLE} separator=pipe null_value=0 --o --q

echo "re-classed layers cross performed and stats computed"
wait

date
end=`date +%s`
runtime=$(((end-start1) / 60))
echo "PROCEDURE COMPLETED. Script $(basename "$0") executed in ${runtime} minutes"
exit
