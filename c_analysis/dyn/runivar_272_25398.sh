#!/bin/bash
## SET REGION
g.region --q n=-19 s=-20 w=17 e=18 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_272@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_272/z_cep_agc2018_100m_fm_272_25398.csv
exit
