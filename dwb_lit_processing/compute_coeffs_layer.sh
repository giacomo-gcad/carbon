#!/bin/bash
## PREPARE COEFFICIENTS LAYERS
g.region --quiet raster=agb2020_100m
r.recode --q --o input=gep_classes_100m output=dwb_coeffs rules=/globes/USERS/GIACOMO/c_stock/dwb_lit_processing/rcl/deadwood_coeffs.rcl
r.recode --q --o input=gep_classes_100m output=lit_coeffs rules=/globes/USERS/GIACOMO/c_stock/dwb_lit_processing/rcl/litter_coeffs.rcl
exit

