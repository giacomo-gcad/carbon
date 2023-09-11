#!/bin/bash
# PROCESS 5 CARBON POOLS TO DERIVE TOTAL CARBON LAYER

date
start1=`date +%s`

DIR="/globes/USERS/GIACOMO/c_stock/total_carbon"
source ${DIR}/total_c.conf


# CLEAN UP
grass ${CARBON_MAPSET_PATH} --exec g.remove -f type=raster name=copernicus_lc_2018_rcl_100m
grass ${CARBON_MAPSET_PATH} --exec g.remove -f type=raster name=copernicus_lc_2018_rcl
grass ${CARBON_MAPSET_PATH} --exec g.remove -f type=raster name=oilpalm_rcl_100m
grass ${CARBON_MAPSET_PATH} --exec g.remove -f type=raster name=oilpalm_rcl
grass ${CARBON_MAPSET_PATH} --exec g.remove -f type=raster name=oilpalm
grass ${CARBON_MAPSET_PATH} --exec g.remove -f type=raster name=mangrove_2016
grass ${CARBON_MAPSET_PATH} --exec g.remove -f type=raster name=mangrove_2016_rcl_100m

rm -f resamp_*.sh
rm -f convert_gsoc.sh
rm -f sum_pools*.sh

echo " "

finalruntime=$(( end2-start1 ))
echo "----------------------------------------------------"
echo "Mapset cleaned up in ${finalruntime} seconds"
echo "----------------------------------------------------"
