#!/bin/bash
### PLEASE CHECK THE CHANGEME LINES!

# EXECUTE AS ./execute.sh > logs/execute.log 2>&1

## CAN COMMENT WITH  if [ ]; then ## .... fi; ##

###------------------------------------------------------------------------------------------------------------------------------------------------#
# TIMER START
START_T1=$(date +%s)
###------------------------------------------------------------------------------------------------------------------------------------------------#

# PARAMETERS
source c_analysis.conf

echo "DEFINED PARAMETERS ARE = "

echo "--GENERAL---------------"
echo "V_COUNTRY IS = " ${V_COUNTRY}
echo "V_ECOREGION IS = "  ${V_ECOREGION}
echo "V_WDPA IS = "  ${V_WDPA}
echo  "V_CEP IS = " ${V_CEP}
echo  "V_RCEP_IN IS = " ${V_RCEP_IN}
echo  "V_RCEP_OUT IS = " ${V_RCEP_OUT}

## CAN COMMENT WITH
#if [ ]; then
#fi; ##

###------------------------------------------------------------------------------------------------------------------------------------------------
echo "-- CARBON ---------------"
echo  "V_THEME_301 - CARBON ABOVE GROUND IS = " ${V_THEME_301}
echo  "V_THEME_302 - CARBON BELOW GROUND IS = " ${V_THEME_302}
echo  "V_THEME_303 - CARBON SOIL ORGANIC IS = " ${V_THEME_303}
echo  "V_THEME_304 - CARBON TOTAL IS = " ${V_THEME_304}
echo  "V_THEME_305 - DEAD WOOD CARBON IS = " ${V_THEME_305}
echo  "V_THEME_306 - LITTER CARBON IS = " ${V_THEME_306}

###--300 CARBON
###----301 CARBON ABOVE GROUND -------------------------------------------------------------------------------------------------------------------------------------------------
psql ${dbpar2} -f ./${SQL}/301_cep_carbon_above_ground_aggregations.sql -v v_rcep_in=${V_RCEP_IN} -v v_theme=${V_THEME_301} -v v_rcep_out=${V_RCEP_OUT}
wait ## OUTPUTS: country_carbon_above_ground # ecoregion_carbon_above_ground # wdpa_carbon_above_ground
###----302 CARBON BELOW GROUND -------------------------------------------------------------------------------------------------------------------------------------------------
psql ${dbpar2} -f ./${SQL}/302_cep_carbon_below_ground_aggregations.sql -v v_rcep_in=${V_RCEP_IN} -v v_theme=${V_THEME_302} -v v_rcep_out=${V_RCEP_OUT}
wait ## OUTPUTS: country_carbon_below_ground # ecoregion_carbon_below_ground # wdpa_carbon_below_ground
###----303 CARBON SOIL -------------------------------------------------------------------------------------------------------------------------------------------------
psql ${dbpar2} -f ./${SQL}/303_cep_carbon_soil_organic_aggregations.sql -v v_rcep_in=${V_RCEP_IN} -v v_theme=${V_THEME_303} -v v_rcep_out=${V_RCEP_OUT}
wait ## OUTPUTS: country_carbon_soil_organic # ecoregion_carbon_soil_organic # wdpa_carbon_soil_organic
###----304 CARBON TOTAL -------------------------------------------------------------------------------------------------------------------------------------------------
psql ${dbpar2} -f ./${SQL}/304_cep_carbon_total_aggregations.sql -v v_rcep_in=${V_RCEP_IN} -v v_theme=${V_THEME_304} -v v_rcep_out=${V_RCEP_OUT}
wait ## OUTPUTS: # country_carbon_soil_organic # ecoregion_carbon_soil_organic # wdpa_carbon_soil_organic
###----305 DW CARBON  -------------------------------------------------------------------------------------------------------------------------------------------------
psql ${dbpar2} -f ./${SQL}/305_cep_dw_carbon_aggregations.sql -v v_rcep_in=${V_RCEP_IN} -v v_theme=${V_THEME_305} -v v_rcep_out=${V_RCEP_OUT}
wait ## OUTPUTS: # country_dw_carbon # ecoregion_dw_carbon # wdpa_dw_carbon
###----306 LIT CARBON  -------------------------------------------------------------------------------------------------------------------------------------------------
psql ${dbpar2} -f ./${SQL}/306_cep_lit_carbon_aggregations.sql -v v_rcep_in=${V_RCEP_IN} -v v_theme=${V_THEME_306} -v v_rcep_out=${V_RCEP_OUT}
wait ## OUTPUTS: # country_lit_carbon # ecoregion_lit_carbon # wdpa_lit_carbon

echo "analysis done"
# stop timer
END_T1=$(date +%s)
TOTAL_DIFF=$(($END_T1 - $START_T1))
echo "TOTAL SCRIPT TIME: $TOTAL_DIFF"
