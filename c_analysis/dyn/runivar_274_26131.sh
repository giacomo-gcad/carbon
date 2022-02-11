#!/bin/bash
## SET REGION
g.region --q n=-17 s=-18 w=30 e=31 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_274@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_274/z_cep_agc2018_100m_fm_274_26131.csv
exit

