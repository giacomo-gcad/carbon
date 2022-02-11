#!/bin/bash
## SET REGION
g.region --q n=-17 s=-18 w=-90 e=-89 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_262@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_262/z_cep_agc2018_100m_fm_262_26011.csv
exit

