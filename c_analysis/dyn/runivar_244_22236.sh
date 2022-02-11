#!/bin/bash
## SET REGION
g.region --q n=-28 s=-29 w=95 e=96 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_244@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_244/z_cep_agc2018_100m_fm_244_22236.csv
exit

