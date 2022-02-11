#!/bin/bash
## SET REGION
g.region --q n=-28 s=-29 w=169 e=170 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_251@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_251/z_cep_agc2018_100m_fm_251_22310.csv
exit

