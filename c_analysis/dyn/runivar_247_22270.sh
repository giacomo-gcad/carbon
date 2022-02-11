#!/bin/bash
## SET REGION
g.region --q n=-28 s=-29 w=129 e=130 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_247@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_247/z_cep_agc2018_100m_fm_247_22270.csv
exit

