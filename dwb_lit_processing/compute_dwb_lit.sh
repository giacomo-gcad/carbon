#!/bin/bash
## PREPARE COEFFICIENTS LAYERS
g.region --quiet raster=agb2018_100m
r.recode --q --o input=gep_classes_100m output=dwb_coeffs rules=/globes/USERS/GIACOMO/c_stock/dwb_lit_processing/rcl/deadwood_coeffs.rcl
r.recode --q --o input=gep_classes_100m output=lit_coeffs rules=/globes/USERS/GIACOMO/c_stock/dwb_lit_processing/rcl/litter_coeffs.rcl
## COMPUTE DWB AND LIT
r.mapcalc --overwrite expression="dw_bionamss_100m = if(isnull(agb2018_100m_rcl), null(), agb2018_100m * dwb_coeffs )" &					              
r.mapcalc --overwrite expression="lit_biomass_100m = if(isnull(agb2018_100m_rcl), null(), agb2018_100m * lit_coeffs )"
exit

