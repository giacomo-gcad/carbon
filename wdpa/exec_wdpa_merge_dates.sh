#!/bin/bash
# RECOVER INDIAN PAs FROM 202101 WDPA VERSION

date
start1=`date +%s`

# READ VARIABLES FROM CONFIGURATION FILE
source wdpa_preprocessing.conf	
# # OVERRIDE wdpadate FROM .conf file
dbpar1="host=${host} user=${user} dbname=${db}"
dbpar2="-h ${host} -U ${user} -d ${db} -w"

wdpa_last=${wdpa_schema}".wdpa_202202"
wdpa_chn=${wdpa_schema}".wdpa_chn_201804"
wdpa_ind=${wdpa_schema}".wdpa_ind_202101"
tab_out="wdpa_for_carbon"
wdpa_out=${wdpa_schema}.${tab_out}
## PRE-PROCESS WDPA
echo "Now pre-processing data..."

psql ${dbpar2} -v vLAST=${wdpa_last} -v vCHN=${wdpa_chn} -v vIND=${wdpa_ind} -v vOUT=${wdpa_out} -f ${SQLDIR}/wdpa_merge_dates.sql

echo "Latest wdpa merged with chinese and indian PAs."

date
end1=`date +%s`
runtime=$((end1-start1))
echo "Script $(basename "$0") executed in ${runtime} seconds"
exit

