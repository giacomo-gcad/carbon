#!/bin/bash
## FIRST PART OF WDPA PRE-PROCESSING
## MAKE POINTS BUFFERS

date
start1=`date +%s`

# READ VARIABLES FROM CONFIGURATION FILE
source wdpa_preprocessing.conf	
# # OVERRIDE wdpadate FROM .conf file
wdpadate=201804

# set local
LC_TIME=en_US.utf8

# SET DERIVED VARIABLES
arch=${pref}"_"${m2}${y1}"_"${suff}
fpath="/spatial_data/Original_Datasets/WDPA/uncompressed/WDPA_Apr2018_Public.gdb" #MODIFIED BY GD ON 20220208
poly=`ogrinfo -ro $fpath | grep poly | awk '{print $2}'`
point=`ogrinfo -ro $fpath | grep point | awk '{print $2}'`
cpoly=`ogrinfo -ro -al -so $fpath ${poly} | grep 'Feature Count' | awk '{print $3}'`
cpoint=`ogrinfo -ro -al -so $fpath ${point} | grep 'Feature Count' | awk '{print $3}'`
((ctot=${cpoly}+${cpoint}))
atts_tab=${atts_table}"_"${y1}${m1}
polytab=${poly_table}"_"${y1}${m1}
pointtab=${point_table}"_"${y1}${m1}
dbpar1="host=${host} user=${user} dbname=${db}"
dbpar2="-h ${host} -U ${user} -d ${db} -w"

## PRE-PROCESS WDPA
echo "Now pre-processing data..."

psql ${dbpar2}	-v vSCHEMA=${wdpa_schema} \
				-v vDATE=${wdpadate} \
				-v vgeomidx='_geom_idx' \
				-v vwdpaididx='_wdpaid_idx' \
				-v vidx='_idx' \
				-v vINNAME_POLY=${polytab} \
				-v vINNAME_POINT=${pointtab} \
				-v THRESHOLD=${area_threshold} \
				-f ${SQLDIR}/wdpa_preprocessing_part_1.sql


wait 
echo "---------------------------------------------------------------------------------------------"
echo "Table with relevant geoms created."
echo "Now manually implement in pgAdmin the procedure ./fix_wdpa_geom.sql for repairing geometries."
echo "This has to be done STEP BY STEP with visual check of results after each step."
echo "---------------------------------------------------------------------------------------------"

date
end1=`date +%s`
runtime=$(((end1-start1) / 60))
echo "Script $(basename "$0") (part 1) executed in ${runtime} minutes"
exit

