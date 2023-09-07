#!/bin/bash
## SET REGION 
g.region --quiet raster=worldclim_prec_01@CONRASTERS
## GET ANNUAL PRECIPITATION
r.mapcalc "del_me1 = worldclim_prec_01 + worldclim_prec_02 + worldclim_prec_03 + worldclim_prec_04 + worldclim_prec_05 + worldclim_prec_06 + worldclim_prec_07 + worldclim_prec_08 + worldclim_prec_09 + worldclim_prec_10 + worldclim_prec_11 + worldclim_prec_12" --q --o
echo "Annual precipitation computed"

# GROW ANNUAL PRECIPITATION RASTER
g.region e=180 w=-180 s=-90 n=90 res=0:03:00.0
r.grow --overwrite --quiet input=del_me1 output=grow_prec radius=300.0 metric=euclidean #  grow the cells of each class. "radius" corresponds to the Xsize of the tile (in cells)	
echo "Annual precipitation grown"

# MERGE ANNUAL PRECIPITATION RASTERS
r.reclass input=del_me1 output=del_me2 rules="/globes/USERS/GIACOMO/c_stock/dwb_lit_processing/rcl/prec_reclass.rcl"  --q --o
r.reclass input=grow_prec output=grow_prec_classes rules="/globes/USERS/GIACOMO/c_stock/dwb_lit_processing/rcl/prec_reclass.rcl"  --q --o
g.region --quiet raster=agb2020_100m
r.resamp.interp input=grow_prec_classes output=grow_prec_classes_100m method=nearest  --q --o &
r.resamp.interp input=del_me2 output=del_me3 method=nearest  --q --o
r.mapcalc --overwrite --q expression="prec_classes_100m = round(if(isnull(del_me3), grow_prec_classes_100m, del_me3))"
r.category prec_classes_100m separator=: rules=- << EOF
1:<1000 mm/yr
2:1000 - 1600 mm/yr
3:>1600 mm/yr
EOF
g.remove type=raster name=del_me3 -f
g.remove type=raster name=del_me2 -f
g.remove type=raster name=del_me1 -f
g.remove type=raster name=grow_prec_classes_100m -f
g.remove type=raster name=grow_prec_classes -f
g.remove type=raster name=grow_prec -f
exit

