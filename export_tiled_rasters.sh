#!/bin/bash
## EXPORT TILED CARBON REASTER, USING CEP GRID

echo "-----------------------------------------------------------------------------------"
echo "--- Script $(basename "$0") started at $(date)"
echo "-----------------------------------------------------------------------------------"

startdate=`date +%s`

# READ VARIABLES FROM CONFIGURATION FILE
CARBONDIR="/globes/USERS/GIACOMO/c_stock"
source ${CARBONDIR}/total_carbon/total_c.conf

c_opt="COMPRESS=DEFLATE,BIGTIFF=YES,TILED=YES"

for IN_RASTER in agc2021_100m_fm bgc2021_100m_fm dw_carbon_100m_fm lit_carbon_100m_fm total_carbon_fm
do
	# MAKE TILES
	OUTDIR1="/spatial_data/Derived_Datasets/RASTER/Carbon/v5_2021/amount/with_fm/${IN_RASTER}/"
	OUTDIR2="/spatial_data/Derived_Datasets/RASTER/Carbon/v5_2021/amount/with_fm/${IN_RASTER}/tiles/"
	mkdir -p ${OUTDIR1}
	mkdir -p ${OUTDIR2}
	
	for obj in $(cat ${CARBONDIR}/carbon_tiles_index.csv)
	do
		eid=$(echo ${obj} | while IFS="|" read a b c d e f; do echo ${a}; done)
		eid_v=${eid:4}
		wcoor=$(echo ${obj} | while IFS="|" read a b c d e f; do echo ${b}; done)
		ecoor=$(echo ${obj} | while IFS="|" read a b c d e f; do echo ${c}; done)
		scoor=$(echo ${obj} | while IFS="|" read a b c d e f; do echo ${d}; done)
		ncoor=$(echo ${obj} | while IFS="|" read a b c d e f; do echo ${e}; done)
		
		region_str="g.region --q n=${ncoor} s=${scoor} w=${wcoor} e=${ecoor} align=${IN_RASTER}"
		echo "#!/bin/bash
## SET REGION
${region_str}
# ## EXPORT TILE
r.out.gdal --o type=Float32 input=${IN_RASTER}@CARBON output=${OUTDIR2}${IN_RASTER}_${eid_v}.tif createopt=${c_opt} -f -c
exit
# " > ${CARBONDIR}/dyn/exp_${eid}.sh
		chmod u+x ${CARBONDIR}/dyn/exp_${eid}.sh
		grass ${CARBON_MAPSET_PATH} -f --exec ${CARBONDIR}/dyn/exp_${eid}.sh
		wait
	done

	echo dyn/exp_${eid}*.sh |xargs rm -f
	echo "${IN_RASTER} exported"

	# MAKE VRT
	cd ${OUTDIR1}
	gdalbuildvrt ${IN_RASTER}.vrt tiles/*.tif -overwrite
	echo "${IN_RASTER} Virtual raster created"
done

enddate=`date +%s`
runtime=$(((enddate-startdate) / 60))

echo "-----------------------------------------------------"
echo "Script $(basename "$0") ended at $(date)"
echo "-----------------------------------------------------"
echo "TILED CARBON RASTERS EXPORTED "${runtime}" minutes"
echo "-----------------------------------------------------"

exit
