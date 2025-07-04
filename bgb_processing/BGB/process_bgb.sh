#!/bin/bash
date
start1=`date +%s`

echo " "
echo "Script $(basename "$0") started at $(date)                                        "
echo "----------------------------------------------------------------------------------"
echo " "

DIR="/globes/USERS/GIACOMO/c_stock/bgb_processing"
source ${DIR}/bgb_parameters.conf
	
AGB="agb2022_100m"
RCOEFF=${DIR}"/BGB/assign_r_coeffs.rcl"
IPCC_COEFFS="ipcc2019_coeffs"
OUTBGB="bgb2022_100m"

echo "Input AGB : "${AGB}
echo "Recode file : "${RCOEFF}
echo "Output BGB : "${OUTBGB}

grass ${CARBON_MAPSET_PATH} --exec g.region raster=${AGB}
grass ${CARBON_MAPSET_PATH} --exec r.recode --q --o input=rcl_cross output=${IPCC_COEFFS} rules=${RCOEFF}
wait
date
echo "rcl_cross recoded with R coeffs"

grass ${CARBON_MAPSET_PATH} --exec r.mapcalc --q --o expression="${OUTBGB} = ${AGB} * ${IPCC_COEFFS} "
wait
echo "Below Ground Biomass computed."

date
end=`date +%s`
runtime=$(((end-start1) / 60))
echo "PROCEDURE COMPLETED. Script $(basename "$0") executed in ${runtime} minutes"
exit
