#!/bin/bash
## SET REGION
g.region --q n=-18 s=-19 w=-95 e=-94 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_261@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_261/z_cep_agc2018_100m_fm_261_25646.csv
exit

