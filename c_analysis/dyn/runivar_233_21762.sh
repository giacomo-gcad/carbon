#!/bin/bash
## SET REGION
g.region --q n=-29 s=-30 w=-19 e=-18 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_233@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_233/z_cep_agc2018_100m_fm_233_21762.csv
exit
