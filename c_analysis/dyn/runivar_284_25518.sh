#!/bin/bash
## SET REGION
g.region --q n=-19 s=-20 w=137 e=138 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_284@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_284/z_cep_agc2018_100m_fm_284_25518.csv
exit

