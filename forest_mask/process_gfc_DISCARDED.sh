# !/bin/bash
# Script to process AGB dataset to derive Deaad Wood Biomass and Litter stocks
# Coefficients are derived from reclassification of annual rainfall (from Worldclim), elevation (from Gebco 2020) and Ecozones (FROM FAO-GEZ 2010)
date
start1=`date +%s`

DIR="/globes/USERS/GIACOMO/c_stock/forest_mask"
source ${DIR}/forest_mask.conf


####################################################################################################
## PART 2: RECLASS TREECOVER and LOSSYEAR
echo "#!/bin/bash
## RECLASSIFIY AND RESAMPLE GEBCO
g.region --quiet raster=${tree_in}
r.reclass input=${tree_in} output=${tree_out} rules=\"${RCLTREE}\"  --q --o
r.reclass input=${loss_in} output=${loss_out} rules=\"${RCLLOSS}\"  --q --o
exit
" > ./reclass_gfc.sh
chmod u+x reclass_gfc.sh
grass ${CARBON_MAPSET_PATH} --exec ./reclass_gfc.sh  >${LOGPATH}/reclass_gfc.log 2>&1

wait
end2=`date +%s`
runtime=$(((end2-start1)))
echo "-----------------------------------------------------------"
echo "treecover and lossyear reclassed in ${runtime} seconds"
echo "-----------------------------------------------------------"

####################################################################################################
## PART 3: OVERLAY TREECOVER AND GAIN USING MAX value
echo "#!/bin/bash
g.region --quiet raster=${AGB} -p
r.mapcalc --overwrite expression=\"delete_me_100 =  max( ${tree_out},${gain} ) \"
r.mapcalc --overwrite expression=\"forest_mask_100m = delete_me_100 * ${loss_out} \"
g.remove type=raster name=delete_me_100 -f
exit
" > ./compute_mask_100m.sh
chmod u+x compute_mask_100m.sh
grass ${CARBON_MAPSET_PATH} --exec ./compute_mask_100m.sh >${LOGPATH}/compute_mask_100m.log 2>&1

wait
end3=`date +%s`
runtime=$(((end3-end2)))
echo "---------------------------------------------------"
echo "compute_mask_100m.sh executed in ${runtime} seconds"
echo "---------------------------------------------------"

date
end7=`date +%s`
runtime=$(((end7-start1) / 60))
echo "PROCEDURE COMPLETED. Script $(basename "$0") executed in ${runtime} minutes"
exit
