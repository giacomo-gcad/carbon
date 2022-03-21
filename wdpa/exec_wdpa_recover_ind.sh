#!/bin/bash
# RECOVER INDIAN PAs FROM 202101 WDPA VERSION

date
start1=`date +%s`

# READ VARIABLES FROM CONFIGURATION FILE
source wdpa_preprocessing.conf	
# # OVERRIDE wdpadate FROM .conf file
wdpadate=202101
dbpar1="host=${host} user=${user} dbname=${db}"
dbpar2="-h ${host} -U ${user} -d ${db} -w"

## PRE-PROCESS WDPA
echo "Now pre-processing data..."

psql ${dbpar2}  -t -c "DROP TABLE IF EXISTS ${wdpa_schema}.wdpa_ind_202101;
CREATE TABLE ${wdpa_schema}.wdpa_ind_202101 AS (SELECT * FROM  ${wdpa_schema}.wdpa_202101 WHERE iso3 ILIKE '%IND%')"

echo "Tables with indian wdpa, recovered from 202101 wdpa version, created."

date
end1=`date +%s`
runtime=$((end1-start1))
echo "Script $(basename "$0") (part 1) executed in ${runtime} seconds"
exit

