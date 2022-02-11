#!/bin/bash
## SET REGION
g.region --q n=-19 s=-20 w=-56 e=-55 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_265@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_265/z_cep_agc2018_100m_fm_265_25325.csv
exit

