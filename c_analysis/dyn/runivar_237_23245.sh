#!/bin/bash
## SET REGION
g.region --q n=-25 s=-26 w=24 e=25 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_237@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_237/z_cep_agc2018_100m_fm_237_23245.csv
exit
