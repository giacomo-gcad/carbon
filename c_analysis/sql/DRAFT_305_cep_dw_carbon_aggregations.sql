-- reports by land only
-- SELECT THE THEME;
DROP TABLE IF EXISTS theme; CREATE TEMPORARY TABLE theme AS SELECT * FROM ind_carbon.r_univar_cep_dw_carbon_100m_202101;
-- SELECT THE GRID;
DROP TABLE IF EXISTS grid_index; CREATE TEMPORARY TABLE grid_index AS SELECT qid,eid FROM results_202101_cep_in.grid_vector ORDER BY qid,eid;
-- SELECT THE AREA;
DROP TABLE IF EXISTS area_index; CREATE TEMPORARY TABLE area_index AS SELECT eid,cid,area_m2 FROM results_202101_cep_in.cid_area_by_tile ORDER BY eid,cid;
------------------------------------------------------------
-- SELECT RELEVANT CIDs
DROP TABLE IF EXISTS cid_list; CREATE TEMPORARY TABLE cid_list AS SELECT eid,qid,cid FROM results_202101_cep_in.r_univar_cep_gfc_treecover_over30_202101 -- EDIT THE DATA SOURCE ACCORDING TO DESIRED FILTER
WHERE mean>=50 -- EDIT THIS CONDITION TO CHANGE SUBSET OF CIDS TO BE ANALYSED
ORDER BY eid,qid,cid;
------------------------------------------------------------
DROP TABLE IF EXISTS country_index; CREATE TEMPORARY TABLE country_index AS SELECT * FROM results_202101_cep_in.index_country_cep_last JOIN grid_index USING (qid)
WHERE cid IN (SELECT cid FROM cid_list);
DROP TABLE IF EXISTS ecoregion_index; CREATE TEMPORARY TABLE ecoregion_index AS SELECT * FROM results_202101_cep_in.index_ecoregion_cep_last JOIN grid_index USING (qid)
WHERE cid IN (SELECT cid FROM cid_list);
DROP TABLE IF EXISTS pa_index; CREATE TEMPORARY TABLE pa_index AS SELECT * FROM results_202101_cep_in.index_pa_cep_last JOIN grid_index USING (qid)
WHERE cid IN (SELECT cid FROM cid_list);

------------------------------------------------------------------
-- COUNTRY
DROP TABLE IF EXISTS country_land; CREATE TEMPORARY TABLE country_land AS
WITH
a AS (SELECT DISTINCT country,country_name,iso3,eid,cid FROM country_index WHERE is_marine = FALSE),
b AS (SELECT eid,cid,min,max,mean,sum FROM theme),
c AS (SELECT eid,cid,area_m2 FROM area_index)
SELECT country,MIN(min),MAX(max),SUM(mean*area_m2)/SUM(area_m2) mean,SUM(sum) sum FROM a JOIN b USING(eid,cid) JOIN c USING(eid,cid) GROUP BY country ORDER BY country;

DROP TABLE IF EXISTS country_land_prot; CREATE TEMPORARY TABLE country_land_prot AS
WITH
a AS (SELECT DISTINCT country,country_name,iso3,eid,cid FROM country_index WHERE is_marine = FALSE AND is_protected = TRUE),
b AS (SELECT eid,cid,min,max,mean,sum FROM theme),
c AS (SELECT eid,cid,area_m2 FROM area_index)
SELECT country,MIN(min),MAX(max),SUM(mean*area_m2)/SUM(area_m2) mean,SUM(sum) sum FROM a JOIN b USING(eid,cid) JOIN c USING(eid,cid) GROUP BY country ORDER BY country;

DROP TABLE IF EXISTS country_land_unprot; CREATE TEMPORARY TABLE country_land_unprot AS
WITH
a AS (SELECT DISTINCT country,country_name,iso3,eid,cid FROM country_index WHERE is_marine = FALSE AND is_protected = FALSE),
b AS (SELECT eid,cid,min,max,mean,sum FROM theme),
c AS (SELECT eid,cid,area_m2 FROM area_index)
SELECT country,MIN(min),MAX(max),SUM(mean*area_m2)/SUM(area_m2) mean,SUM(sum) sum FROM a JOIN b USING(eid,cid) JOIN c USING(eid,cid) GROUP BY country ORDER BY country;

----------------------------------------
-- ECOREGION
DROP TABLE IF EXISTS eco_land; CREATE TEMPORARY TABLE eco_land AS
WITH
a AS (SELECT DISTINCT ecoregion,ecoregion_name,eid,cid FROM ecoregion_index WHERE is_marine IS FALSE),
b AS (SELECT eid,cid,min,max,mean,sum FROM theme),
c AS (SELECT eid,cid,area_m2 FROM area_index)
SELECT ecoregion,MIN(min),MAX(max),SUM(mean*area_m2)/SUM(area_m2) mean,SUM(sum) sum FROM a JOIN b USING(eid,cid) JOIN c USING(eid,cid) GROUP BY ecoregion ORDER BY ecoregion;

DROP TABLE IF EXISTS eco_land_prot; CREATE TEMPORARY TABLE eco_land_prot AS
WITH
a AS (SELECT DISTINCT ecoregion,ecoregion_name,eid,cid FROM ecoregion_index WHERE is_marine IS FALSE AND is_protected = TRUE),
b AS (SELECT eid,cid,min,max,mean,sum FROM theme),
c AS (SELECT eid,cid,area_m2 FROM area_index)
SELECT ecoregion,MIN(min),MAX(max),SUM(mean*area_m2)/SUM(area_m2) mean,SUM(sum) sum FROM a JOIN b USING(eid,cid) JOIN c USING(eid,cid) GROUP BY ecoregion ORDER BY ecoregion;

DROP TABLE IF EXISTS eco_land_unprot; CREATE TEMPORARY TABLE eco_land_unprot AS
WITH
a AS (SELECT DISTINCT ecoregion,ecoregion_name,eid,cid FROM ecoregion_index WHERE is_marine IS FALSE AND is_protected = FALSE),
b AS (SELECT eid,cid,min,max,mean,sum FROM theme),
c AS (SELECT eid,cid,area_m2 FROM area_index)
SELECT ecoregion,MIN(min),MAX(max),SUM(mean*area_m2)/SUM(area_m2) mean,SUM(sum) sum FROM a JOIN b USING(eid,cid) JOIN c USING(eid,cid) GROUP BY ecoregion ORDER BY ecoregion;

----------------------------------------
-- PROTECTION
DROP TABLE IF EXISTS pa_land; CREATE TEMPORARY TABLE pa_land AS
WITH
a AS (SELECT DISTINCT pa,pa_name,iso3,eid,cid FROM pa_index WHERE marine IN (0,1)),
b AS (SELECT eid,cid,min,max,mean,sum FROM theme),
c AS (SELECT eid,cid,area_m2 FROM area_index)
SELECT pa,MIN(min),MAX(max),SUM(mean*area_m2)/SUM(area_m2) mean,SUM(sum) sum FROM a JOIN b USING(eid,cid) JOIN c USING(eid,cid) GROUP BY pa ORDER BY pa;

-------------------------------------------------------------
-- OUTPUTS
-------------------------------------------------------------
-- country
DROP TABLE IF EXISTS ind_carbon.country_dw_carbon_forest_over50;
CREATE TABLE ind_carbon.country_dw_carbon_forest_over50 AS
SELECT
a.country country_id,a.min dwc_min_c_mg_total,a.max dwc_max_c_mg_total,a.mean dwc_mean_c_mg_total,a.sum/1000000000 dwc_tot_c_pg_total,
b.min dwc_min_c_mg_prot,b.max dwc_max_c_mg_prot,b.mean dwc_mean_c_mg_prot,b.sum/1000000000 dwc_tot_c_pg_prot,
c.min dwc_min_c_mg_unprot,c.max dwc_max_c_mg_unprot,c.mean dwc_mean_c_mg_unprot,c.sum/1000000000 dwc_tot_c_pg_unprot
FROM country_land a 
LEFT JOIN country_land_prot b USING(country)
LEFT JOIN country_land_unprot c USING(country);
-- ecoregion
DROP TABLE IF EXISTS ind_carbon.ecoregion_dw_carbon_forest_over50;
CREATE TABLE ind_carbon.ecoregion_dw_carbon_forest_over50 AS
SELECT
a.ecoregion eco_id,a.min dwc_min_c_mg_total,a.max dwc_max_c_mg_total,a.mean dwc_mean_c_mg_total,a.sum/1000000000 dwc_tot_c_pg_total,
b.min dwc_min_c_mg_prot,b.max dwc_max_c_mg_prot,b.mean dwc_mean_c_mg_prot,b.sum/1000000000 dwc_tot_c_pg_prot,
c.min dwc_min_c_mg_unprot,c.max dwc_max_c_mg_unprot,c.mean dwc_mean_c_mg_unprot,c.sum/1000000000 dwc_tot_c_pg_unprot
FROM eco_land a 
LEFT JOIN eco_land_prot b USING(ecoregion)
LEFT JOIN eco_land_unprot c USING(ecoregion);
-- pa
DROP TABLE IF EXISTS ind_carbon.wdpa_dw_carbon_forest_over50;
CREATE TABLE ind_carbon.wdpa_dw_carbon_forest_over50 AS
SELECT pa wdpaid,min dwc_min_c_mg,max dwc_max_c_mg,mean dwc_mean_c_mg,sum dwc_tot_c_mg FROM pa_land;