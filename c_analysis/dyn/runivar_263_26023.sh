#!/bin/bash
## SET REGION
g.region --q n=-17 s=-18 w=-78 e=-77 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_263@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_263/z_cep_agc2018_100m_fm_263_26023.csv
exit

