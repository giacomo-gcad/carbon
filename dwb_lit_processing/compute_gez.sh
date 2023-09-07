#!/bin/bash
## IMPORT GEZ RASTER
# g.mapset CATRASTERS
# r.external input=/globes/USERS/GIACOMO/c_stock/bgb_processing/GEZ_2010/output_data/gez_2010.vrt output=gez_2010 --overwrite
## RECLASS GEZ
# g.mapset "CARBON"
r.reclass input=gez_2010@CATRASTERS output=gez_classes_100m rules="/globes/USERS/GIACOMO/c_stock/dwb_lit_processing/rcl/gez_reclass.rcl"  --q --o
r.category gez_classes_100m separator=: rules=- << EOF
100:Tropical
200:Temperate/Boreal
EOF
exit

