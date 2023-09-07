#!/bin/bash
## RECLASSIFIY AND RESAMPLE GEBCO
g.region --quiet raster=gebco2023
r.reclass input=gebco2023 output=elev_classes rules="/globes/USERS/GIACOMO/c_stock/dwb_lit_processing/rcl/gebco_reclass.rcl"  --q --o
g.region --quiet raster=agb2020_100m
r.resamp.interp input=elev_classes output=elev_classes_100m method=nearest  --q --o
r.category elev_classes_100m separator=: rules=- << EOF
10:<= 2000 m
20:> 2000 m
EOF
g.remove type=raster name=elev_classes -f
exit

