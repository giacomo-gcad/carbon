#!/bin/bash
## SET REGION
g.region --q n=-25 s=-26 w=-60 e=-59 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_229@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_229/z_cep_agc2018_100m_fm_229_23161.csv
exit
