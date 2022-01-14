#!/bin/bash
# PROCESS 5 CARBON POOLS TO DERIVE TOTAL CARBON LAYER

date
start1=`date +%s`

DIR="/globes/USERS/GIACOMO/c_stock/total_carbon"
source ${DIR}/total_c.conf

export GRASS_COMPRESSOR=ZLIB # added on 20201008

# SET MAPSET
# grass ${CARBON_MAPSET_PATH} --exec g.mapset CARBON

# ############### RESAMPLING CARBON POOLS ###################

# ############### AGB
# echo "#!/bin/bash
# g.region raster=${AGB}
# ## CONVERT AGB (DENSITY) IN ABOVE GROUND CARBON AMOUNT. OUTPUT UNITS: Mg
# r.mapcalc --overwrite expression=\"${AGC}=${AGB} / 2 * area() / 10000 \" 
# ## SET REGION FOR AGB 1km resolution
# g.region raster=${AGB} align=${GSOC}
# ##RESAMPLE AGC to GSOC RESOLUTION (1km) WITH AGGREGATION (SUM) OUTPUT UNITS: Mg
# r.resamp.stats --overwrite input=${AGC} output=${AGC1km} method=sum 
# r.support map=${AGC1km} title=\"Above Ground Carbon map\" units=\"Mg\" description=\"Above Ground Carbon (amount in Mg)\"
# " > ./resamp_agb.sh
# chmod u+x resamp_agb.sh
# grass ${CARBON_MAPSET_PATH} --exec ./resamp_agb.sh >${LOGPATH}/resamp_agb.log 2>&1

# wait
# echo "AGB resampled"

# ############### BGB
# echo "#!/bin/bash
# g.region raster=${BGB}
# ## CONVERT BGB (DENSITY) IN BELOW GROUND CARBON AMOUNT. OUTPUT UNITS: Mg
# r.mapcalc --overwrite expression=\"${BGC}=${BGB} / 2 * area() / 10000 \"
# ## SET REGION FOR BGB 1km resolution
# g.region raster=${BGC} align=${GSOC}
# ## RESAMPLE BGC to GSOC RESOLUTION (1km) WITH AGGREGATION (SUM) OUTPUT UNITS: Mg
# r.resamp.stats --overwrite input=${BGC} output=${BGC1km} method=sum
# r.support map=${BGC1km} title=\"Below Ground Carbon map\" units=\"Mg\" description=\"Below Ground Carbon (amount in Mg)\"
# " > ./resamp_bgb.sh
# chmod u+x resamp_bgb.sh
# grass ${CARBON_MAPSET_PATH} --exec ./resamp_bgb.sh >${LOGPATH}/resamp_bgb.log 2>&1

# wait
# echo "BGB resampled"

# ############### DWB
# echo "#!/bin/bash
# g.region raster=${DWB}
# ## CONVERT DW_BIOMASS (DENSITY) IN DEAD WOOD CARBON AMOUNT. OUTPUT UNITS: Mg
# r.mapcalc --overwrite expression=\"${DWC}=${DWB} / 2 * area() / 10000 \"
# ## SET REGION FOR DW_CARBON 1km resolution
# g.region raster=${DWC} align=${GSOC}
# ## RESAMPLE DW_CARBON to GSOC RESOLUTION (1km) WITH AGGREGATION (SUM) OUTPUT UNITS: Mg
# r.resamp.stats --overwrite input=${DWC} output=${DWC1km} method=sum
# r.support map=${DWC1km} title=\"Dead Wood Carbon map\" units=\"Mg\" description=\"Dead Wood Carbon (amount in Mg)\"
# " > ./resamp_dwb.sh
# chmod u+x resamp_dwb.sh
# grass ${CARBON_MAPSET_PATH} --exec ./resamp_dwb.sh >${LOGPATH}/resamp_dwb.log 2>&1

# wait
# echo "DWB resampled"

# ############### LITTER
# echo "#!/bin/bash
# g.region raster=${LITB}
# ## CONVERT lit_BIOMASS (DENSITY) IN DEAD WOOD CARBON AMOUNT. OUTPUT UNITS: Mg
# r.mapcalc --overwrite expression=\"${LITC}=${LITB} / 2 * area() / 10000 \"
# ## SET REGION FOR LIT_CARBON 1km resolution
# g.region raster=${LITC} align=${GSOC}
# ## RESAMPLE LIT_CARBON to GSOC RESOLUTION (1km) WITH AGGREGATION (SUM) OUTPUT UNITS: Mg
# r.resamp.stats --overwrite input=${LITC} output=${LITC1km} method=sum
# r.support map=${LITC1km} title=\"Litter Carbon map\" units=\"Mg\" description=\"Litter Carbon (amount in Mg)\"
# " > ./resamp_lit.sh
# chmod u+x resamp_lit.sh
# grass ${CARBON_MAPSET_PATH} --exec ./resamp_lit.sh >${LOGPATH}/resamp_lit.log 2>&1

# wait
# echo "LIT resampled"

############### GSOC
echo "#!/bin/bash
g.region raster=${GSOC1km} align=${AGC} -p
## CONVERT SOIL CARBON DENSITY IN SOIL CARBON AMOUNT. OUTPUT UNITS: Mg
r.resample input=${GSOC1km} output=${GSOC}_delete_me --o --q
r.mapcalc --overwrite expression=\"${GSOC}=${GSOC}_delete_me * area() / 10000 \" ## Amount of C (in Mg) within each 100m pixel
r.null map=${GSOC} null=0
r.support map=${GSOC} title=\"Soil Carbon map, 100m res.\" units=\"Mg\" description=\"Soil Carbon 100m res. (amount in Mg)\"
g.remove type=raster name=${GSOC}_delete_me -f
" > ./convert_gsoc.sh
chmod u+x convert_gsoc.sh
grass ${CARBON_MAPSET_PATH} --exec ./convert_gsoc.sh >${LOGPATH}/convert_gsoc.log 2>&1

wait	
echo "GSOC converted"

echo " "

end1=`date +%s`
runtime=$(((end1-start1) / 60))
echo "----------------------------------------------------"
echo "Resampling carbon pools completed in ${runtime} minutes"
echo "----------------------------------------------------"

############# COMPUTING TOTAL CARBON LAYER ####################
###   AGC + BGC + GSOC + DEWADWOOD_CARBON + LITTER_CARBON   ###
echo "#!/bin/bash
g.region raster=${AGC}
r.mapcalc --overwrite expression=\"${CARBONTOT}=${GSOC} + ${AGC} + ${BGC} + ${DWC} + ${LITC} \"
r.support map=${CARBONTOT} title=\"Total Carbon map\" units=\"Mg\" description=\"Sum of 5 carbon pools: AGC, BGC, GSOC, Dead Wood and Litter (amount in Mg)\"
" > ./sum_pools.sh
chmod u+x sum_pools.sh
grass ${CARBON_MAPSET_PATH} --exec ./sum_pools.sh >${LOGPATH}/sum_pools.log 2>&1

wait

end2=`date +%s`
runtime=$(((end2-end1) / 60))
echo "----------------------------------------------------"
echo "Sum up of carbon pools completed in ${runtime} minutes"
echo "----------------------------------------------------"

# CLEAN UP
rm -f resamp_*.sh
rm -f convert_gsoc.sh
rm -f sum_pools.sh

echo " "

finalruntime=$(((end2-start1) / 60))
echo "----------------------------------------------------"
echo "Total Carbon Layer computed in ${finalruntime} minutes"
echo "----------------------------------------------------"
