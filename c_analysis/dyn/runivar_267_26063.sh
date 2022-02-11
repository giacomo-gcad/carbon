#!/bin/bash
## SET REGION
g.region --q n=-17 s=-18 w=-38 e=-37 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_267@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_267/z_cep_agc2018_100m_fm_267_26063.csv
exit

