#!/bin/bash
## SET REGION
g.region --q n=-27 s=-28 w=150 e=151 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_250@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_250/z_cep_agc2018_100m_fm_250_22651.csv
exit

