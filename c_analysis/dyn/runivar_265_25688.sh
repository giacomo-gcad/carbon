#!/bin/bash
## SET REGION
g.region --q n=-18 s=-19 w=-53 e=-52 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_265@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_265/z_cep_agc2018_100m_fm_265_25688.csv
exit
