#!/bin/bash
##COMPUTE STATISTICS ON CEP AND A USER DEFINED CATEGORICAL RASTER

echo "-----------------------------------------------------------------------------------"
echo "--- Script $(basename "$0") started at $(date)"
echo "-----------------------------------------------------------------------------------"

startdate=`date +%s`

date
./exec_cep_agc_stats.sh >logs/agc_stats.log 2>&1
wait
echo "exec_cep_agc_stats.sh completed"

date
./exec_cep_bgc_stats.sh >logs/bgc_stats.log 2>&1
wait
echo "exec_cep_bgc_stats.sh completed"

date
./exec_cep_dw_stats.sh >logs/dw_stats.log 2>&1
wait
echo "exec_cep_dw_stats.sh completed"

date
./exec_cep_lit_stats.sh >logs/lit_stats.log 2>&1
wait
echo "exec_cep_lit_stats.sh completed"

date
./exec_cep_gsoc_stats.sh >logs/gsoc_stats.log 2>&1
wait
echo "exec_cep_gsoc_stats.sh completed"

date
./exec_cep_tot_carbon_stats.sh >logs/tot_carbon_stats.log 2>&1
wait
echo "exec_cep_tot_carbon_stats.sh completed"

enddate=`date +%s`
runtime=$(((enddate-startdate) / 60))

echo "---------------------------------------------------------------------------------------"
echo "Script $(basename "$0") ended at $(date)"
echo "---------------------------------------------------------------------------------------"
echo "Total time: "${runtime}" minutes "
echo "---------------------------------------------------------------------------------------"
exit
