#!/bin/bash
## SET REGION
g.region --q n=-27 s=-28 w=105 e=106 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_245@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_245/z_cep_agc2018_100m_fm_245_22606.csv
exit
