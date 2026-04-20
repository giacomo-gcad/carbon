#!/bin/bash
SERVICEDIR="/globes/USERS/GIACOMO/pollutants/scripts"
source ${SERVICEDIR}/pollutants.conf

lyr=$1
inc=$2
input_gpkg=$3

v.external --q --o input=${inc}/${input_gpkg} layer=${lyr} output=${lyr}
g.region vector=${lyr} align=${AGB}
v.to.rast --q --o input=${lyr} output=${lyr} use=value value=2 memory=32000

echo ${lyr} "rasterized"

wait
exit
