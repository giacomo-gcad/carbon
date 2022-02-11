#!/bin/bash
## SET REGION
g.region --q n=-18 s=-19 w=36 e=37 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_274@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_274/z_cep_agc2018_100m_fm_274_25777.csv
exit

