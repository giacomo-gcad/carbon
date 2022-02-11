#!/bin/bash
## SET REGION
g.region --q n=-17 s=-18 w=-147 e=-146 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_256@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_256/z_cep_agc2018_100m_fm_256_25954.csv
exit

