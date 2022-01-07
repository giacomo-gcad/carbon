#!/bin/bash
# PROCESS 5 CARBON POOLS TO DERIVE TOTAL CARBON LAYER

date
start1=`date +%s`

DIR="/globes/USERS/GIACOMO/c_stock/total_carbon"
source ${DIR}/total_c.conf

export GRASS_COMPRESSOR=ZLIB # added on 20201008

# SET MAPSET
# grass ${CARBON_MAPSET_PATH} --exec g.mapset CARBON

############### RESAMPLING CARBON POOLS ###################

# ############### AGB
# echo "#!/bin/bash
# g.region raster=agb2018_100m
# ## CONVERT AGB (DENSITY) IN ABOVE GROUND CARBON AMOUNT. OUTPUT UNITS: Mg
# r.mapcalc --overwrite expression=\"agc2018_100m=agb2018_100m@CARBON / 2 * area() / 10000 \" 
# ## SET REGION FOR AGB 1km resolution
# g.region raster=agb2018_100m res=0:00:30 
# ##RESAMPLE AGC to GSOC RESOLUTION (1km) WITH AGGREGATION (SUM) OUTPUT UNITS: Mg
# r.resamp.stats --overwrite input=agc2018_100m output=agc2018_1km method=sum 
# " > ./resamp_agb.sh
# chmod u+x resamp_agb.sh
# grass ${CARBON_MAPSET_PATH} --exec ./resamp_agb.sh >${LOGPATH}/resamp_agb.log 2>&1

# wait
# echo "AGB resampled"

# ############### BGB
# echo "#!/bin/bash
# g.region raster=bgb2018_100m
# ## CONVERT BGB (DENSITY) IN BELOW GROUND CARBON AMOUNT. OUTPUT UNITS: Mg
# r.mapcalc --overwrite expression=\"bgc2018_100m=bgb2018_100m@CARBON / 2 * area() / 10000 \"
# ## SET REGION FOR BGB 1km resolution
# g.region raster=bgb2018_100m res=0:00:30
# ## RESAMPLE BGB to GSOC RESOLUTION (1km) WITH AGGREGATION (SUM) OUTPUT UNITS: Mg
# r.resamp.stats --overwrite input=bgc2018_100m output=bgc2018_1km method=sum
# " > ./resamp_bgb.sh
# chmod u+x resamp_bgb.sh
# grass ${CARBON_MAPSET_PATH} --exec ./resamp_bgb.sh >${LOGPATH}/resamp_bgb.log 2>&1

# wait
# echo "BGB resampled"

############### DWB
echo "#!/bin/bash
g.region raster=dw_biomass_100m
## CONVERT DW_BIOMASS (DENSITY) IN DEAD WOOD CARBON AMOUNT. OUTPUT UNITS: Mg
r.mapcalc --overwrite expression=\"dw_carbon_100m=dw_biomass_100m@CARBON / 2 * area() / 10000 \"
## SET REGION FOR DW_CARBON 1km resolution
g.region raster=dw_carbon_100m res=0:00:30
## RESAMPLE DW_CARBON to GSOC RESOLUTION (1km) WITH AGGREGATION (SUM) OUTPUT UNITS: Mg
r.resamp.stats --overwrite input=dw_carbon_100m output=dw_carbon_1km method=sum
" > ./resamp_dwb.sh
chmod u+x resamp_dwb.sh
grass ${CARBON_MAPSET_PATH} --exec ./resamp_dwb.sh >${LOGPATH}/resamp_dwb.log 2>&1

wait
echo "DWB resampled"

############### LITTER
echo "#!/bin/bash
g.region raster=lit_biomass_100m
## CONVERT lit_BIOMASS (DENSITY) IN DEAD WOOD CARBON AMOUNT. OUTPUT UNITS: Mg
r.mapcalc --overwrite expression=\"lit_carbon_100m=lit_biomass_100m@CARBON / 2 * area() / 10000 \"
## SET REGION FOR LIT_CARBON 1km resolution
g.region raster=lit_carbon_100m res=0:00:30
## RESAMPLE LIT_CARBON to GSOC RESOLUTION (1km) WITH AGGREGATION (SUM) OUTPUT UNITS: Mg
r.resamp.stats --overwrite input=lit_carbon_100m output=lit_carbon_1km method=sum
" > ./resamp_lit.sh
chmod u+x resamp_lit.sh
grass ${CARBON_MAPSET_PATH} --exec ./resamp_lit.sh >${LOGPATH}/resamp_lit.log 2>&1

wait
echo "LIT resampled"

# ############### GSOC
# echo "#!/bin/bash
# g.region raster=gsoc_15@CARBON
# ## CONVERT SOIL CARBON DENSITY IN SOIL CARBON AMOUNT. OUTPUT UNITS: Mg
# r.mapcalc --overwrite expression=\"gsoc_15_tot=gsoc_15@CARBON * 100 * area() / 1000000 \"
# " > ./convert_gsoc.sh
# chmod u+x convert_gsoc.sh
# grass ${CARBON_MAPSET_PATH} --exec ./convert_gsoc.sh >${LOGPATH}/convert_gsoc.log 2>&1

# wait
# echo "GSOC converted"

echo " "

end1=`date +%s`
runtime=$(((end1-start1) / 60))
echo "----------------------------------------------------"
echo "Resampling carbon pools completed in ${runtime} minutes"
echo "----------------------------------------------------"

############# COMPUTING TOTAL CARBON LAYER ####################
###   AGC + BGC + GSOC + DEWADWOOD_CARBON + LITTER_CARBON   ###
echo "#!/bin/bash
g.region raster=cep_202101@CEP_202101 align=agc2018_1km
r.mapcalc --overwrite expression=\"carbon_tot=gsoc_15_tot + agc2018_1km + bgc2018_1km + dw_carbon_1km + lit_carbon_1km \"
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