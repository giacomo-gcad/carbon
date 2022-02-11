#!/bin/bash
## SET REGION
g.region --q n=-18 s=-19 w=170 e=171 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_288@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_288/z_cep_agc2018_100m_fm_288_25911.csv
exit

