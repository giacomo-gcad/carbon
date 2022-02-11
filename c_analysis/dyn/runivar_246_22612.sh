#!/bin/bash
## SET REGION
g.region --q n=-27 s=-28 w=111 e=112 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_246@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_246/z_cep_agc2018_100m_fm_246_22612.csv
exit

