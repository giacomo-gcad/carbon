#!/bin/bash
## SET REGION
g.region --q n=-26 s=-27 w=-46 e=-45 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_230@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_230/z_cep_agc2018_100m_fm_230_22815.csv
exit

