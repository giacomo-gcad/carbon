#!/bin/bash
## SET REGION
g.region --q n=-19 s=-20 w=-155 e=-154 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_255@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_255/z_cep_agc2018_100m_fm_255_25226.csv
exit
