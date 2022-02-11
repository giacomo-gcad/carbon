#!/bin/bash
## SET REGION
g.region --q n=-28 s=-29 w=71 e=72 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_242@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_242/z_cep_agc2018_100m_fm_242_22212.csv
exit

