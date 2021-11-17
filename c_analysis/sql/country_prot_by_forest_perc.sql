-- SET THE OUTPUT_SCHEME IN THE LAST LINES!!!
---------------------------------------------------------------------------------------
-- country_block
---------------------------------------------------------------------------------------
DROP TABLE IF EXISTS stoca; CREATE TEMPORARY TABLE stoca AS (SELECT  wdpaid, iso3,area_geo,
UNNEST(lc_copernicus_code) cop_class,
UNNEST(lc_copernicus_tot_sqkm) cop_area
FROM  dopa_41.dopa_wdpa_all_inds WHERE marine<2 AND area_geo>=1);

DROP TABLE IF EXISTS stoca2; CREATE TEMPORARY TABLE stoca2 AS (SELECT wdpaid, iso3,area_geo,
SUM(cop_area) area_tot,
SUM(cop_area)/area_geo*100 tree_perc
FROM stoca WHERE cop_class>=111 AND cop_class<=126
GROUP BY wdpaid, iso3,area_geo ORDER BY wdpaid);

---------------------------------------------------------------------------------------
DROP TABLE IF EXISTS pas_tree_over10;CREATE TEMPORARY TABLE pas_tree_over10 AS
SELECT a.wdpaid,a.iso3,b.qid,b.cid FROM stoca2 a LEFT JOIN cep.index_pa_cep_last b ON a.wdpaid=b.pa
WHERE tree_perc>=10 ORDER BY tree_perc;

DROP TABLE IF EXISTS pas_tree_over50;CREATE TEMPORARY TABLE pas_tree_over50 AS
SELECT a.wdpaid,a.iso3,b.qid,b.cid FROM stoca2 a LEFT JOIN cep.index_pa_cep_last b ON a.wdpaid=b.pa
WHERE tree_perc>=50 ORDER BY tree_perc;

DROP TABLE IF EXISTS pas_tree_over90;CREATE TEMPORARY TABLE pas_tree_over90 AS
SELECT a.wdpaid,a.iso3,b.qid,b.cid FROM stoca2 a LEFT JOIN cep.index_pa_cep_last b ON a.wdpaid=b.pa
WHERE tree_perc>=90 ORDER BY tree_perc;
---------------------------------------------------------------------------------------
DROP TABLE IF EXISTS t_country_tot;CREATE TEMPORARY TABLE t_country_tot AS
SELECT country,iso3,SUM(sqkm) country_tot_sqkm FROM :v_rcep_in.index_country_cep_last 
GROUP BY country,iso3 ORDER BY iso3;
DROP TABLE IF EXISTS t_country_land;CREATE TEMPORARY TABLE t_country_land AS
SELECT country,iso3,SUM(sqkm) country_land_sqkm FROM :v_rcep_in.index_country_cep_last WHERE is_marine IS FALSE
GROUP BY country,iso3 ORDER BY iso3;
DROP TABLE IF EXISTS t_country_land_prot_o10;CREATE TEMPORARY TABLE t_country_land_prot_o10 AS
SELECT country,iso3,SUM(sqkm) country_land_prot_sqkm_o10 FROM :v_rcep_in.index_country_cep_last 
WHERE qid IN (SELECT DISTINCT qid FROM pas_tree_over10) AND cid IN (SELECT DISTINCT cid FROM pas_tree_over10) AND is_marine IS FALSE AND is_protected IS TRUE 
GROUP BY country,iso3 ORDER BY iso3;
DROP TABLE IF EXISTS t_country_land_prot_o50;CREATE TEMPORARY TABLE t_country_land_prot_o50 AS
SELECT country,iso3,SUM(sqkm) country_land_prot_sqkm_o50 FROM :v_rcep_in.index_country_cep_last 
WHERE qid IN (SELECT DISTINCT qid FROM pas_tree_over50) AND cid IN (SELECT DISTINCT cid FROM pas_tree_over50) AND is_marine IS FALSE AND is_protected IS TRUE 
GROUP BY country,iso3 ORDER BY iso3;
DROP TABLE IF EXISTS t_country_land_prot_o90;CREATE TEMPORARY TABLE t_country_land_prot_o90 AS
SELECT country,iso3,SUM(sqkm) country_land_prot_sqkm_o90 FROM :v_rcep_in.index_country_cep_last 
WHERE qid IN (SELECT DISTINCT qid FROM pas_tree_over90) AND cid IN (SELECT DISTINCT cid FROM pas_tree_over90) AND is_marine IS FALSE AND is_protected IS TRUE 
GROUP BY country,iso3 ORDER BY iso3;

---------------------------------------------------------------------------------------
-- country
DROP TABLE IF EXISTS output_country; CREATE TEMPORARY TABLE output_country AS
SELECT
a.country country_id,a.country_name,a.iso3,
country_tot_sqkm,
country_land_sqkm,ROUND((country_land_sqkm/country_tot_sqkm*100)::numeric,3) country_land_perc_country_tot,
country_land_prot_sqkm_o10,ROUND((country_land_prot_sqkm_o10/country_land_sqkm*100)::numeric,3) country_land_prot_perc_country_land_o10,
country_land_prot_sqkm_o50,ROUND((country_land_prot_sqkm_o50/country_land_sqkm*100)::numeric,3) country_land_prot_perc_country_land_o50,
country_land_prot_sqkm_o90,ROUND((country_land_prot_sqkm_o90/country_land_sqkm*100)::numeric,3) country_land_prot_perc_country_land_o90
FROM :v_rcep_in.atts_country_last a
LEFT JOIN t_country_tot b USING(iso3)
LEFT JOIN t_country_land c USING(iso3)
LEFT JOIN t_country_land_prot_o10 d USING(iso3)
LEFT JOIN t_country_land_prot_o50 e USING(iso3)
LEFT JOIN t_country_land_prot_o90 f USING(iso3)
GROUP BY a.country,a.country_name,a.iso3,b.country_tot_sqkm,c.country_land_sqkm,d.country_land_prot_sqkm_o10,e.country_land_prot_sqkm_o50,f.country_land_prot_sqkm_o90;

--------------------------------------------------------------------------------------
-- OUTPUT BLOC --SET OUTPUT SCHEME
--------------------------------------------------------------------------------------
-- country table
DROP TABLE IF EXISTS ind_carbon.country_prot_by_forest_perc CASCADE;CREATE TABLE ind_carbon.country_prot_by_forest_perc AS
SELECT * FROM output_country ORDER BY iso3;

