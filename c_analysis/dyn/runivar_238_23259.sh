#!/bin/bash
## SET REGION
g.region --q n=-25 s=-26 w=38 e=39 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_238@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_238/z_cep_agc2018_100m_fm_238_23259.csv
exit
