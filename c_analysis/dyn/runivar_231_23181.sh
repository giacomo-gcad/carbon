#!/bin/bash
## SET REGION
g.region --q n=-25 s=-26 w=-40 e=-39 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_231@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_231/z_cep_agc2018_100m_fm_231_23181.csv
exit
