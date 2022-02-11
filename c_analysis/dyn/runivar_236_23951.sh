#!/bin/bash
## SET REGION
g.region --q n=-23 s=-24 w=10 e=11 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_236@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_236/z_cep_agc2018_100m_fm_236_23951.csv
exit

