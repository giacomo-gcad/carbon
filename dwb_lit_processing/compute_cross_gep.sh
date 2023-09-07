#!/bin/bash
g.region --quiet raster=agb2020_100m
r.mapcalc "gep_classes_100m = round( gez_classes_100m + elev_classes_100m + prec_classes_100m )" --q --o
r.stats -a input=gep_classes_100m output="/globes/USERS/GIACOMO/c_stock/dwb_lit_processing/gep_classes_stats.csv" separator=pipe --q --o
exit

