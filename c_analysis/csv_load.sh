#!/bin/bash
##COMPUTE STATISTICS ON CEP AND A USER DEFINED CATEGORICAL RASTER

echo "-----------------------------------------------------------------------------------"
echo "--- Script $(basename "$0") started at $(date)"
echo "-----------------------------------------------------------------------------------"

startdate=`date +%s`

# READ VARIABLES FROM CONFIGURATION FILE
SERVICEDIR="/globes/USERS/GIACOMO/c_stock/c_analysis"
source ${SERVICEDIR}/c_analysis.conf
RESULTSPATH=${SERVICEDIR}"/results"
## OVERRIDE NCORES DEFINED IN CONF FILE

# AGC
echo "Importing AGC..."
FINALCSV="r_univar_cep_agc2018_100m_202101"
psql ${dbpar2} -t -v vNAME=${FINALCSV} -v vSCHEMA=ind_carbon -f ./sql/create_table_runivar.sql
psql ${dbpar2} -t -c "\copy ind_carbon.${FINALCSV} FROM '${RESULTSPATH}/${FINALCSV}.csv' delimiter '|' csv"

# BGC
echo "Importing BGC..."
FINALCSV="r_univar_cep_bgc2018_100m_202101"
psql ${dbpar2} -t -v vNAME=${FINALCSV} -v vSCHEMA=ind_carbon -f ./sql/create_table_runivar.sql
psql ${dbpar2} -t -c "\copy ind_carbon.${FINALCSV} FROM '${RESULTSPATH}/${FINALCSV}.csv' delimiter '|' csv"

# DW
echo "Importing DW..."
FINALCSV="r_univar_cep_dw_carbon_100m_202101"
psql ${dbpar2} -t -v vNAME=${FINALCSV} -v vSCHEMA=ind_carbon -f ./sql/create_table_runivar.sql
psql ${dbpar2} -t -c "\copy ind_carbon.${FINALCSV} FROM '${RESULTSPATH}/${FINALCSV}.csv' delimiter '|' csv"

# LIT
echo "Importing LIT..."
FINALCSV="r_univar_cep_lit_carbon_100m_202101"
psql ${dbpar2} -t -v vNAME=${FINALCSV} -v vSCHEMA=ind_carbon -f ./sql/create_table_runivar.sql
psql ${dbpar2} -t -c "\copy ind_carbon.${FINALCSV} FROM '${RESULTSPATH}/${FINALCSV}.csv' delimiter '|' csv"

# GSOC
echo "Importing GSOC..."
FINALCSV="r_univar_cep_gsoc_15_100m_202101"
psql ${dbpar2} -t -v vNAME=${FINALCSV} -v vSCHEMA=ind_carbon -f ./sql/create_table_runivar.sql
psql ${dbpar2} -t -c "\copy ind_carbon.${FINALCSV} FROM '${RESULTSPATH}/${FINALCSV}.csv' delimiter '|' csv"

# TOTAL C
echo "Importing TOTAL C..."
FINALCSV="r_univar_cep_total_carbon_202101"
psql ${dbpar2} -t -v vNAME=${FINALCSV} -v vSCHEMA=ind_carbon -f ./sql/create_table_runivar.sql
psql ${dbpar2} -t -c "\copy ind_carbon.${FINALCSV} FROM '${RESULTSPATH}/${FINALCSV}.csv' delimiter '|' csv"

enddate=`date +%s`
runtime=$(((enddate-startdate) / 60))

echo "---------------------------------------------------------------------------------------"
echo "Script $(basename "$0") ended at $(date)"
echo "---------------------------------------------------------------------------------------"
echo "Stats on CEP and ${IN_RASTER} computed in "${runtime}" minutes using "${NCORES}" cores "
echo "---------------------------------------------------------------------------------------"
exit