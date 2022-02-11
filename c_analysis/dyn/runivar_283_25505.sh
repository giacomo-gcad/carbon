#!/bin/bash
## SET REGION
g.region --q n=-19 s=-20 w=124 e=125 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_283@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_283/z_cep_agc2018_100m_fm_283_25505.csv
exit

