#!/bin/bash
## SET REGION
g.region --q n=-17 s=-18 w=-20 e=-19 align=agc2018_100m_fm@CARBON
## ANALYZE IN_RASTER WITH R.UNIVAR
r.univar --q -t map=agc2018_100m_fm@CARBON zones=ceptile_269@CEP_202101 output=/globes/USERS/GIACOMO/c_stock/c_analysis/results/tmp_269/z_cep_agc2018_100m_fm_269_26081.csv
exit
