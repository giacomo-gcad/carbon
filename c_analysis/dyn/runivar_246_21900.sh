#!/bin/bash
## SET REGION
g.region --q n=-29 s=-30 w=119 e=120 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_246@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_246/z_cep_agc2018_100m_fm_246_21900.csv
exit
