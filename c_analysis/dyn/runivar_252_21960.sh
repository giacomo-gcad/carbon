#!/bin/bash
## SET REGION
g.region --q n=-29 s=-30 w=179 e=180 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_252@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_252/z_cep_agc2018_100m_fm_252_21960.csv
exit

