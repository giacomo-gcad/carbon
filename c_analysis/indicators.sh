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

##if [ ]; then ##

echo "DEFINED PARAMETERS ARE = "

echo "--GENERAL---------------"
echo "V_COUNTRY IS = " ${V_COUNTRY}
echo "V_ECOREGION IS = "  ${V_ECOREGION}
echo "V_WDPA IS = "  ${V_WDPA}
echo  "V_CEP IS = " ${V_CEP}
echo  "V_RCEP_IN IS = " ${V_RCEP_IN}
echo  "V_RCEP_OUT IS = " ${V_RCEP_OUT}
echo  "V_R_NON_CEP IS = " ${V_R_NON_CEP}
echo  "V_TARGET IS = " ${V_TARGET}


###--100-200 INFORMATION-CONSERVATION
###----201 CONSERVATION COVERAGE ---------------------------------------------------------------------------------------------------------------------------------------------
psql ${dbpar2} -f ./${SQL}/country_prot_by_forest_perc.sql -v v_rcep_in=${V_RCEP_IN} -v v_rcep_out=${V_RCEP_OUT}
wait ## OUTPUTS: country_conservation_coverage # country_conservation_coverage_ecoregions_stats # ecoregion_conservation_coverages # wdpa_conservation_coverages


echo "analysis done"
# stop timer
END_T1=$(date +%s)
TOTAL_DIFF=$(($END_T1 - $START_T1))
echo "TOTAL SCRIPT TIME: $TOTAL_DIFF"
