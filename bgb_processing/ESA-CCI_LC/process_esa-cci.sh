#!/bin/bash
date
start1=`date +%s`

DIR="/globes/USERS/GIACOMO/c_stock/bgb_processing"
source ${DIR}/bgb_parameters.conf

INFILE="esalc_2018"
OUTFILE="esalc_2018_100m_rcl"
RLZ=${DIR}"/ESA-CCI_LC/reclass_lc.rcl"
AGB="agb2018_100m"

# RESAMPLE TO 100 m RESOLUTION
echo "#!/bin/bash
# RWESAMPLE ESA CCI LAND COVER
g.region raster=${AGB}
# r.resamp.interp input=${INFILE}@CATRASTERS output=del_me method=nearest --q --o
r.mapcalc expression=\"${INFILE}_100m = int(del_me)\" --q --o
# RECLASS ESA CCI ALND COVER
r.reclass --overwrite input=${INFILE}_100m output=${OUTFILE} rules=${RLZ}
exit
g.remove type=raster name=del_me -f
" > ./process_lc.sh
chmod u+x process_lc.sh
grass ${CARBON_MAPSET_PATH} --exec ./process_lc.sh


echo  ${INFILE}" reclassed"

rm -f 	./process_lc.sh
end=`date +%s`
runtime=$(((end-start1) / 60))
echo "PROCEDURE COMPLETED. Script $(basename "$0") executed in ${runtime} minutes"
exit
