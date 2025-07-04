#!/bin/bash
# Script to process AGB dataset to derive Deaad Wood Biomass and Litter stocks
# Coefficients are derived from reclassification of annual rainfall (from Worldclim), elevation (from Gebco 2023) and Ecozones (FROM FAO-GEZ 2010)
# N.B. Parts 1-5 need to be re-run only if precipitation, elevation or Ecological Zones change. Only Part 6 need to be re-run ifAGB version changes.

date
start1=`date +%s`

echo " "
echo "Script $(basename "$0") started at $(date)                                        "
echo "----------------------------------------------------------------------------------"
echo " "

# CONFIGURATION FILE (check/edit it before running the script)
DIR="/globes/USERS/GIACOMO/c_stock/dwb_ltb_processing"
source ${DIR}/dwb_ltc.conf


# ##################################################
# ## PROVIDE ACCFES TO RELEVANT MAPSETS
# grass ${CARBON_MAPSET_PATH} --exec g.mapsets operation=add mapset=CONRASTERS,CATRASTERS

# ##################################################
# ## PART 1: PROCESS RAINFALL (WORLDCLIM)

# echo "#!/bin/bash
# ## SET REGION 
# g.region --quiet raster=worldclim_prec_01@CONRASTERS
# ## GET ANNUAL PRECIPITATION
# r.mapcalc \"del_me1 = worldclim_prec_01 + worldclim_prec_02 + worldclim_prec_03 + worldclim_prec_04 + worldclim_prec_05 + worldclim_prec_06 + worldclim_prec_07 + worldclim_prec_08 + worldclim_prec_09 + worldclim_prec_10 + worldclim_prec_11 + worldclim_prec_12\" --q --o
# echo \"Annual precipitation computed\"

# # GROW ANNUAL PRECIPITATION RASTER
# g.region e=180 w=-180 s=-90 n=90 res=0:03:00.0
# r.grow --overwrite --quiet input=del_me1 output=grow_prec radius=300.0 metric=euclidean #  grow the cells of each class. \"radius\" corresponds to the Xsize of the tile (in cells)	
# echo \"Annual precipitation grown\"

# # MERGE ANNUAL PRECIPITATION RASTERS
# r.reclass input=del_me1 output=del_me2 rules=\"${RCL_DIR}/prec_reclass.rcl\"  --q --o
# r.reclass input=grow_prec output=grow_prec_classes rules=\"${RCL_DIR}/prec_reclass.rcl\"  --q --o
# g.region --quiet raster=${AGB}
# r.resamp.interp input=grow_prec_classes output=grow_prec_classes_100m method=nearest  --q --o &
# r.resamp.interp input=del_me2 output=del_me3 method=nearest  --q --o
# r.mapcalc --overwrite --q expression=\"prec_classes_100m = round(if(isnull(del_me3), grow_prec_classes_100m, del_me3))\"
# r.category prec_classes_100m separator=":" rules=- << EOF
# 1:<1000 mm/yr
# 2:1000 - 1600 mm/yr
# 3:>1600 mm/yr
# EOF
# g.remove type=raster name=del_me3 -f
# g.remove type=raster name=del_me2 -f
# g.remove type=raster name=del_me1 -f
# g.remove type=raster name=grow_prec_classes_100m -f
# g.remove type=raster name=grow_prec_classes -f
# g.remove type=raster name=grow_prec -f
# exit
# " > ./compute_prec.sh
# chmod u+x compute_prec.sh
# grass ${CARBON_MAPSET_PATH} --exec ./compute_prec.sh >${LOGPATH}/compute_prec.log 2>&1

# wait
# echo "Annual precipitation reclassed and merged"

# end1=`date +%s`
# runtime=$(((end1-start1)))
# echo "---------------------------------------------------"
# echo "compute_prec.sh executed in ${runtime} seconds"
# echo "---------------------------------------------------"

# ##################################################
# ## PART 2: PROCESS ELEVATION (GEBCO)
# echo "#!/bin/bash
# ## RECLASSIFIY AND RESAMPLE GEBCO
# g.region --quiet raster=${GEBCO}
# r.reclass input={GEBCO} output=elev_classes rules=\"${RCL_DIR}/gebco_reclass.rcl\"  --q --o
# g.region --quiet raster=${AGB}
# r.resamp.interp input=elev_classes output=elev_classes_100m method=nearest  --q --o
# r.category elev_classes_100m separator=":" rules=- << EOF
# 10:<= 2000 m
# 20:> 2000 m
# EOF
# g.remove type=raster name=elev_classes -f
# exit
# " > ./compute_elev.sh
# chmod u+x compute_elev.sh
# grass ${CARBON_MAPSET_PATH} --exec ./compute_elev.sh  >${LOGPATH}/compute_elev.log 2>&1

# wait
# end2=`date +%s`
# runtime=$(((end2-end1)))
# echo "---------------------------------------------------"
# echo "compute_elev.sh executed in ${runtime} seconds"
# echo "---------------------------------------------------"

# ##################################################
# ## PART 3: PROCESS Ecological Zones (FAO - GEZ 2010)
# ## N.B. HERE THE RECLASSIFIED GEZ RASTER PRODUCED BY EDUARDO IS IMPORTED. IT IS THE SAME DATASET USED TO DERIVE BELOW GROUND BIOMASS)
# echo "#!/bin/bash
# ## IMPORT GEZ RASTER
# # g.mapset CATRASTERS
# # r.external input=/globes/USERS/GIACOMO/c_stock/bgb_processing/GEZ_2010/output_data/gez_2010.vrt output=gez_2010 --overwrite
# ## RECLASS GEZ
# # g.mapset \"${CARBON_MAPSET}\"
# r.reclass input=gez_2010@CATRASTERS output=gez_classes_100m rules=\"${RCL_DIR}/gez_reclass.rcl\"  --q --o
# r.category gez_classes_100m separator=":" rules=- << EOF
# 100:Tropical
# 200:Temperate/Boreal
# EOF
# exit
# " > ./compute_gez.sh
# chmod u+x compute_gez.sh
# grass ${CARBON_MAPSET_PATH} --exec ./compute_gez.sh >${LOGPATH}/compute_gez.log 2>&1

# wait
# end3=`date +%s`
# runtime=$(((end3-end2)))
# echo "---------------------------------------------------"
# echo "compute_gez.sh executed in ${runtime} seconds"
# echo "---------------------------------------------------"

# ##################################################
# ## PART 4: SUM UP THE THREE RECLASSED LAYERS TO GET UNIQUE COMBINATIONS OF CLASSES (ALTERNATIVE TO R.CROSS)
# echo "#!/bin/bash
# g.region --quiet raster=${AGB}
# r.mapcalc \"gep_classes_100m = round( gez_classes_100m + elev_classes_100m + prec_classes_100m )\" --q --o
# r.stats -a input=gep_classes_100m output=\"${DIR}/gep_classes_stats.csv\" separator=pipe --q --o
# exit
# " > ./compute_cross_gep.sh
# chmod u+x compute_cross_gep.sh
# grass ${CARBON_MAPSET_PATH} --exec ./compute_cross_gep.sh >${LOGPATH}/compute_cross_gep.log 2>&1

# wait
# end4=`date +%s`
# runtime=$(((end4-end3)))
# echo "---------------------------------------------------"
# echo "compute_cross_gep.sh executed in ${runtime} seconds"
# echo "---------------------------------------------------"

# ## PART 5: PREPARE LAYER WITH COEFFICIENTS 
# echo "#!/bin/bash
# ## PREPARE COEFFICIENTS LAYERS
# g.region --quiet raster=${AGB}
# r.recode --q --o input=gep_classes_100m output=dwb_coeffs rules=${RCOEFF_DWB}
# r.recode --q --o input=gep_classes_100m output=ltc_coeffs rules=${RCOEFF_LTC}
# exit
# " > ./compute_coeffs_layer.sh
# chmod u+x compute_coeffs_layer.sh
# grass ${CARBON_MAPSET_PATH} --exec ./compute_coeffs_layer.sh >${LOGPATH}/compute_dwb_ltc.log 2>&1


####################################################################################################
#### THIS IS THE ONLY PART THAT NEED TO BE RE-RUN WHEN AGB VERSION CHANGES
## APPLY COEFFICIENTS TO AGB TO DERIVE DEAD WOOD BIOMASS AND LITTER
echo "#!/bin/bash
## COMPUTE DWB AND LTC
r.mapcalc --overwrite expression=\"dwb2022_100m = if(isnull(${AGB_RCL}), null(), ${AGB} * dwb_coeffs )\" &					              
r.mapcalc --overwrite expression=\"ltb2022_100m = if(isnull(${AGB_RCL}), null(), ${AGB} * ltc_coeffs )\"
exit
" > ./compute_dwb_ltc.sh
chmod u+x compute_dwb_ltc.sh
grass ${CARBON_MAPSET_PATH} --exec ./compute_dwb_ltc.sh >>${LOGPATH}/compute_dwb_ltc.log 2>&1

wait
grass ${CARBON_MAPSET_PATH} --exec r.support map=dwb2022_100m title="Dead Wood Biomass map" units="Mg/ha" description="Derived from AGB 2022 map" >>${LOGPATH}/compute_dwb_ltc.log 2>&1
grass ${CARBON_MAPSET_PATH} --exec r.support map=ltb2022_100m title="Litter Biomass map" units="Mg/ha" description="Derived from AGB 2022 map" >>${LOGPATH}/compute_dwb_ltc.log 2>&1

end5=`date +%s`
runtime=$(((end5-end4)))
echo "---------------------------------------------------"
echo "compute_dwb_ltc.sh executed in ${runtime} seconds"
echo "---------------------------------------------------"

# FINAL CLEAN UP
rm -f ./compute_prec.sh
rm -f ./compute_elev.sh
rm -f ./compute_gez.sh
rm -f ./compute_cross_gep.sh
rm -f ./compute_coeffs_layer.sh
rm -f ./compute_dwb_ltc.sh

date
end6=`date +%s`
runtime=$(((end6-start1) / 60))
echo "PROCEDURE COMPLETED. Script $(basename "$0") executed in ${runtime} minutes"
exit

