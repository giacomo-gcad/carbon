#!/bin/bash
## SET REGION
g.region --q n=-27 s=-28 w=72 e=73 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_242@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_242/z_cep_agc2018_100m_fm_242_22573.csv
exit

