#!/bin/bash
# PROCESS 5 CARBON POOLS TO DERIVE TOTAL CARBON LAYER

date
start1=`date +%s`

DIR="/globes/USERS/GIACOMO/c_stock/total_carbon"
source ${DIR}/total_c.conf

export GRASS_COMPRESSOR=ZLIB # added on 20201008

############### RESAMPLING CARBON POOLS ###################

############### AGB
echo "#!/bin/bash
g.region raster=${AGB}
## CONVERT AGB (DENSITY) IN ABOVE GROUND CARBON AMOUNT. OUTPUT UNITS: Mg
r.mapcalc --overwrite expression=\"${AGC}=float(${AGB} / 2 * area() / 10000 )\" 
r.support map=${AGC} title=\"Above Ground Carbon map\" units=\"Mg\" description=\"Above Ground Carbon (amount in Mg)\"
## APPLY FOREST MASK
r.mapcalc --overwrite expression=\" ${AGC}_fm = float(${AGC} * ${FORESTMASK}) \"
r.support map=${AGC}_fm title=\"Above Ground Carbon map (only forest)\" units=\"Mg\" description=\"Above Ground Carbon (amount in Mg, only forest)\"
exit
" > ./resamp_agb.sh
chmod u+x resamp_agb.sh
grass ${CARBON_MAPSET_PATH} --exec ./resamp_agb.sh >${LOGPATH}/resamp_agb.log 2>&1

wait
echo "AGB converted and masked"

############### BGB
echo "#!/bin/bash
g.region raster=${BGB}
## CONVERT BGB (DENSITY) IN BELOW GROUND CARBON AMOUNT. OUTPUT UNITS: Mg
r.mapcalc --overwrite expression=\"${BGC}=float(${BGB} / 2 * area() / 10000) \"
r.support map=${BGC} title=\"Below Ground Carbon map\" units=\"Mg\" description=\"Below Ground Carbon (amount in Mg)\"
## APPLY FOREST MASK
r.mapcalc --overwrite expression=\" ${BGC}_fm = float(${BGC} * ${FORESTMASK}) \"
r.support map=${BGC}_fm title=\"Below Ground Carbon map (only forest)\" units=\"Mg\" description=\"Below Ground Carbon (amount in Mg, only forest)\"
exit
" > ./resamp_bgb.sh
chmod u+x resamp_bgb.sh
grass ${CARBON_MAPSET_PATH} --exec ./resamp_bgb.sh >${LOGPATH}/resamp_bgb.log 2>&1

wait
echo "BGC converted and masked"

############### DWB
echo "#!/bin/bash
g.region raster=${DWB}
## CONVERT DW_BIOMASS (DENSITY) IN DEAD WOOD CARBON AMOUNT. OUTPUT UNITS: Mg
r.mapcalc --overwrite expression=\"${DWC}=float(${DWB} / 2 * area() / 10000) \"
r.support map=${DWC} title=\"Dead Wood Carbon map\" units=\"Mg\" description=\"Dead Wood Carbon (amount in Mg)\"
## APPLY FOREST MASK
r.mapcalc --overwrite expression=\" ${DWC}_fm = float(${DWC} * ${FORESTMASK}) \"
r.support map=${DWC}_fm title=\"Dead Wood Carbon map (only forest)\" units=\"Mg\" description=\"Dead Wood Carbon (amount in Mg, only forest)\"
exit
" > ./resamp_dwb.sh
chmod u+x resamp_dwb.sh
grass ${CARBON_MAPSET_PATH} --exec ./resamp_dwb.sh >${LOGPATH}/resamp_dwb.log 2>&1

wait
echo "DWB converted and masked"

############### LITTER
echo "#!/bin/bash
g.region raster=${LTB}
## CONVERT LIT_BIOMASS (DENSITY) IN LITTER CARBON AMOUNT. OUTPUT UNITS: Mg
r.mapcalc --overwrite expression=\"${LTC}=float(${LTB} / 2 * area() / 10000) \"
r.support map=${LTC} title=\"Litter Carbon map\" units=\"Mg\" description=\"Litter Carbon (amount in Mg)\"
## APPLY FOREST MASK
r.mapcalc --overwrite expression=\" ${LTC}_fm = float(${LTC} * ${FORESTMASK}) \"
r.support map=${LTC}_fm title=\"Litter Carbon map (only forest)\" units=\"Mg\" description=\"Litter Carbon (amount in Mg, only forest)\"
exit
" > ./resamp_lit.sh
chmod u+x resamp_lit.sh
grass ${CARBON_MAPSET_PATH} --exec ./resamp_lit.sh >${LOGPATH}/resamp_lit.log 2>&1

wait
echo "LIT converted and masked"

############### GSOC
echo "#!/bin/bash
g.region raster=${GSOC1km} align=${AGC} -p
## CONVERT SOIL CARBON DENSITY IN SOIL CARBON AMOUNT. OUTPUT UNITS: Mg
r.resample input=${GSOC1km} output=${GSOC}_delete_me --o --q
r.mapcalc --overwrite expression=\"${GSOC}=float(${GSOC}_delete_me * area() / 10000 )\" ## Amount of C (in Mg) within each 100m pixel
r.null map=${GSOC} null=0
r.support map=${GSOC} title=\"Soil Carbon map, 100m res.\" units=\"Mg\" description=\"Soil Carbon 100m res. (GSOC 1.6, amount in Mg)\"
g.remove type=raster name=${GSOC}_delete_me -f
## APPLY FOREST MASK
r.mapcalc --overwrite expression=\" ${GSOC}_fm = float(${GSOC} * ${FORESTMASK}) \"
r.support map=${GSOC}_fm title=\"Soil Carbon map (only forest)\" units=\"Mg\" description=\"Soil Carbon (GSOC 1.6, amount in Mg, only forest)\"
exit
" > ./convert_gsoc.sh
chmod u+x convert_gsoc.sh
grass ${CARBON_MAPSET_PATH} --exec ./convert_gsoc.sh >${LOGPATH}/convert_gsoc.log 2>&1

wait	
echo "GSOC converted and masked"

echo " "

end1=`date +%s`
runtime=$(((end1-start1) / 60))
echo "----------------------------------------------------"
echo "Resampling carbon pools completed in ${runtime} minutes"
echo "----------------------------------------------------"

############### COMPUTING TOTAL CARBON LAYER ###############

###   AGC + BGC + GSOC + DEADWOOD_CARBON + LITTER_CARBON ###
echo "#!/bin/bash
g.region raster=${AGC}
r.mapcalc --overwrite expression=\"${CARBONTOT} = float(${GSOC} + ${AGC} + ${BGC} + ${DWC} + ${LTC}) \"
r.support map=${CARBONTOT} title=\"Total Carbon map \" units=\"Mg\" description=\"Sum of 5 Carbon pools (in Mg)\"
exit
" > ./sum_pools.sh
chmod u+x sum_pools.sh
grass ${CARBON_MAPSET_PATH} --exec ./sum_pools.sh >${LOGPATH}/sum_pools.log 2>&1

###   AGC + BGC + GSOC + DEADWOOD_CARBON + LITTER_CARBON (only forest)  ###
echo "#!/bin/bash
g.region raster=${AGC}
r.mapcalc --overwrite expression=\"${CARBONTOT}_fm = float(${GSOC}_fm + ${AGC}_fm + ${BGC}_fm + ${DWC}_fm + ${LTC}_fm )\"
r.support map=${CARBONTOT}_fm title=\"Total Carbon map (only forest)\" units=\"Mg\" description=\"Sum of 5 Carbon pools (in Mg, only forest)\"
exit
" > ./sum_pools_fm.sh
chmod u+x sum_pools_fm.sh
grass ${CARBON_MAPSET_PATH} --exec ./sum_pools_fm.sh >${LOGPATH}/sum_pools_fm.log 2>&1
wait

end2=`date +%s`
runtime=$(((end2-end1) / 60))
echo "----------------------------------------------------"
echo "Sum up of carbon pools completed in ${runtime} minutes"
echo "----------------------------------------------------"

echo " "

finalruntime=$(((end2-start1) / 60))
echo "----------------------------------------------------"
echo "Total Carbon Layer computed in ${finalruntime} minutes"
echo "----------------------------------------------------"

