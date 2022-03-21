# Preparing a custom global WDPA  
  
 ## N.B. This part is presently only partially implemented and it's still under development

This procedure is used to prepare a custom version of WDPA including:  
- latest version of WDPA from WCMC  
- Chinese Protected Areas from WDPA April 2018  
- Indian Protected Areas from WDPA January 2021  
  
1. Import and preprocess WDPA April 2018 (last WDPA version with Chinese PAs)  
1.1 [exec_wdpa_import_chn.sh](./exec_wdpa_import_chn.sh)  
1.2 [exec_wdpa_preprocessing_part_1_chn.sh](./exec_wdpa_preprocessing_part_1_chn.sh)  
1.3 [fix_wdpa_geom_chn.sql](./sql/fix_wdpa_geom_chn.sql)  To be manually executed step by step  
1.4  [exec_wdpa_preprocessing_part_2_chn.sh](./exec_wdpa_preprocessing_part_2_chn.sh)  

The output is a PostgreSQL table containig ONLY Chinese protected areas, named **protected_sites.wdpa_201804_chn**, ready to be added to a recent version of WDPA.  


2. Select Indian protected areas from WDPA January 2021 version of WDPA (already processed for DOPA)  
Indian PAs are simply recovered from the already preprocesssed protected_sites.wdpa_202101 table, using the script [exec_wdpa_recover_ind.sh](./exec_wdpa_recover_ind.sh).  

The output is a PostgreSQL table containig ONLY Indian protected areas, named **protected_sites.wdpa_202101_ind**, ready to be added to a recent version of WDPA.  


3. Prepare the final wdpa table to be used for making CEP  
Here CHN and IND PAs are removed from  the latest version of WDPA. Then, the resulting table is merged with the two tables created in previous steps to get an unique, custon wpda table named **protected_sites.wdpa_for_carbon**  
This is done by the script [exec_wdpa_merge_dates.sh](./exec_wdpa_merge_dates.sh)  



