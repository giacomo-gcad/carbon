# Analysis of carbon pools in protected areas, countries and ecoregions  

Here using the same procedure of DOPA workflow for the [analysis of continuous rasters](https://github.com/giacomo-gcad/dopa_workflow/tree/master/cep_analysis#CONTINUOUS_RASTERS) is used.  

Two main steps:  

### 1. Computation of basic statistics in grass  

The grass funcion r.univar is iteratively run in parallel over each qid of CEP (see details on CEP [here](https://andreamandrici.github.io/dopa_workflow/flattening/)).  
One script for each carbon pool:  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[exec_cep_agc_stats.sh](./c_analysis/exec_cep_agc_stats.sh)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[exec_cep_bgc_stats.sh](./c_analysis/exec_cep_bgc_stats.sh)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[exec_cep_dw_stats.sh](./c_analysis/exec_cep_dw_stats.sh)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[exec_cep_lit_stats.sh](./c_analysis/exec_cep_lit_stats.sh)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[exec_cep_gsoc_stats.sh](./c_analysis/exec_cep_gsoc_stats.sh)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[exec_cep_tot_carbon_stats.sh](./c_analysis/exec_cep_tot_carbon_stats.sh)  

Each scripts produce as output a csv file with basic stats for each elementary object (cid) of CEP.  


### 2. Data aggregation (to be completed)  

[...]

