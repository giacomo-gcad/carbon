#!/bin/bash
## SET REGION
g.region --q n=-18 s=-19 w=-120 e=-119 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_259@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_259/z_cep_agc2018_100m_fm_259_25621.csv
exit

