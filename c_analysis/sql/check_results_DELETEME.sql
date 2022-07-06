--------------------------------------------------------------------
-- TOT CARBON IN PAs
DROP TABLE IF EXISTS totcarb_pa; CREATE TEMPORARY TABLE totcarb_pa AS
SELECT 
a.wdpaid,z.pa_name,z.iso3,y.country_name,z.area_geo area_tot_sqkm,
a.agb_tot_c_mg agc_tot_mg,b.bgb_tot_c_mg bgc_tot_mg,c.dwc_tot_c_mg dwc_tot_mg,d.lit_tot_c_mg lit_tot_mg,e.gsoc_tot_c_mg  gsoc_tot_mg,f.carbon_tot_c_mg carbon_tot_mg
--,
--(a.agb_tot_c_mg+b.bgb_tot_c_mg+c.dwc_tot_c_mg+d.lit_tot_c_mg+e.gsoc_tot_c_mg) computed_tot_c_mg
FROM ind_carbon.wdpa_carbon_above_ground a
LEFT JOIN ind_carbon.wdpa_carbon_below_ground b USING(wdpaid)
LEFT JOIN ind_carbon.wdpa_dw_carbon c USING(wdpaid)
LEFT JOIN ind_carbon.wdpa_lit_carbon d USING(wdpaid)
LEFT JOIN ind_carbon.wdpa_carbon_soil_organic e USING(wdpaid)
LEFT JOIN ind_carbon.wdpa_carbon_total f USING(wdpaid)
LEFT JOIN ind_carbon_cep.atts_pa_last z ON a.wdpaid=z.pa
LEFT JOIN ind_carbon_cep.atts_country_last y USING(iso3)
WHERE f.carbon_tot_c_mg>0;

-- MEAN CARBON IN PAs
DROP TABLE IF EXISTS meancarb_pa; CREATE TEMPORARY TABLE meancarb_pa AS
SELECT 
a.wdpaid,z.pa_name,z.iso3,y.country_name,z.area_geo,
a.agb_mean_c_mg agc_mean_mg,b.bgb_mean_c_mg bgc_mean_mg,c.dwc_mean_c_mg dwc_mean_mg,d.lit_mean_c_mg lit_mean_mg,e.gsoc_mean_c_mg  gsoc_mean_mg,f.carbon_mean_c_mg carbon_mean_mg
--,
--(a.agb_mean_c_mg+b.bgb_mean_c_mg+c.dwc_mean_c_mg+d.lit_mean_c_mg+e.gsoc_mean_c_mg) computed_mean_c_mg
FROM ind_carbon.wdpa_carbon_above_ground a
LEFT JOIN ind_carbon.wdpa_carbon_below_ground b USING(wdpaid)
LEFT JOIN ind_carbon.wdpa_dw_carbon c USING(wdpaid)
LEFT JOIN ind_carbon.wdpa_lit_carbon d USING(wdpaid)
LEFT JOIN ind_carbon.wdpa_carbon_soil_organic e USING(wdpaid)
LEFT JOIN ind_carbon.wdpa_carbon_total f USING(wdpaid)
LEFT JOIN ind_carbon_cep.atts_pa_last z ON a.wdpaid=z.pa
LEFT JOIN ind_carbon_cep.atts_country_last y USING(iso3)
WHERE f.carbon_tot_c_mg>0;

--------------------------------------------------------------------
-- TOT CARBON IN COUNTRIES (PROT AND UNPROT)
DROP TABLE IF EXISTS totcarb_country; CREATE TEMPORARY TABLE totcarb_country AS
SELECT 
z.country_id,
z.iso3,
z.country_name,
z.country_land_sqkm,
a.agb_tot_c_pg_total agc_tot_pg,a.agb_tot_c_pg_prot agc_prot_pg,
b.bgb_tot_c_pg_total bgc_tot_pg,b.bgb_tot_c_pg_prot bgc_prot_pg,
c.dwc_tot_c_pg_total dwc_tot_pg,c.dwc_tot_c_pg_prot dwc_prot_pg,
d.lit_tot_c_pg_total lit_tot_pg,d.lit_tot_c_pg_prot lit_prot_pg,
e.gsoc_tot_c_pg_total gsoc_tot_pg,e.gsoc_tot_c_pg_prot gsoc_prot_pg,
f.carbon_tot_c_pg_total carbon_tot_pg,f.carbon_tot_c_pg_prot carbon_prot_pg
--,
--(a.agb_tot_c_pg_total+b.bgb_tot_c_pg_total+c.dwc_tot_c_pg_total+d.lit_tot_c_pg_total+e.gsoc_tot_c_pg_total) computed_tot_c_pg
FROM dopa_42.dopa_country_all_inds z
LEFT JOIN ind_carbon.country_carbon_above_ground a USING(country_id)
LEFT JOIN ind_carbon.country_carbon_below_ground b USING(country_id)
LEFT JOIN ind_carbon.country_dw_carbon c USING(country_id)
LEFT JOIN ind_carbon.country_lit_carbon d USING(country_id)
LEFT JOIN ind_carbon.country_carbon_soil_organic e USING(country_id)
LEFT JOIN ind_carbon.country_carbon_total f USING(country_id)
WHERE country_land_sqkm IS NOT NULL
ORDER BY z.iso3;

-- MEAN CARBON IN COUNTRIES (PROT AND UNPROT)
DROP TABLE IF EXISTS meancarb_country; CREATE TEMPORARY TABLE meancarb_country AS
SELECT 
z.country_id,
z.iso3,
z.country_name,
z.country_land_sqkm,
a.agb_mean_c_mg_total agc_mean_mg,a.agb_mean_c_mg_prot agc_mean_prot_mg,
b.bgb_mean_c_mg_total bgc_mean_mg,b.bgb_mean_c_mg_prot bgc_mean_prot_mg,
c.dwc_mean_c_mg_total dwc_mean_mg,c.dwc_mean_c_mg_prot dwc_mean_prot_mg,
d.lit_mean_c_mg_total lit_mean_mg,d.lit_mean_c_mg_prot lit_mean_prot_mg,
e.gsoc_mean_c_mg_total gsoc_mean_mg,e.gsoc_mean_c_mg_prot gsoc_mean_prot_mg,
f.carbon_mean_c_mg_total carbon_mean_mg,f.carbon_mean_c_mg_prot carbon_mean_prot_mg
--,
--(a.agb_tot_c_pg_total+b.bgb_tot_c_pg_total+c.dwc_tot_c_pg_total+d.lit_tot_c_pg_total+e.gsoc_tot_c_pg_total) computed_tot_c_pg
FROM dopa_42.dopa_country_all_inds z
LEFT JOIN ind_carbon.country_carbon_above_ground a USING(country_id)
LEFT JOIN ind_carbon.country_carbon_below_ground b USING(country_id)
LEFT JOIN ind_carbon.country_dw_carbon c USING(country_id)
LEFT JOIN ind_carbon.country_lit_carbon d USING(country_id)
LEFT JOIN ind_carbon.country_carbon_soil_organic e USING(country_id)
LEFT JOIN ind_carbon.country_carbon_total f USING(country_id)
WHERE country_land_sqkm IS NOT NULL
ORDER BY z.iso3;

--------------------------------------------------------------------
-- TOT CARBON IN ECOREGIONS (PROT AND UNPROT)
DROP TABLE IF EXISTS totcarb_eco; CREATE TEMPORARY TABLE totcarb_eco AS
SELECT 
z.ecoregion eco_id,
z.ecoregion_name,
z.second_level_code, z.second_level,
y.ecoregion_tot_sqkm,
a.agb_tot_c_pg_total agc_tot_pg,a.agb_tot_c_pg_prot agc_prot_pg,
b.bgb_tot_c_pg_total bgc_tot_pg,b.bgb_tot_c_pg_prot bgc_prot_pg,
c.dwc_tot_c_pg_total dwc_tot_pg,c.dwc_tot_c_pg_prot dwc_prot_pg,
d.lit_tot_c_pg_total lit_tot_pg,d.lit_tot_c_pg_prot lit_prot_pg,
e.gsoc_tot_c_pg_total gsoc_tot_pg,e.gsoc_tot_c_pg_prot gsoc_prot_pg,
f.carbon_tot_c_pg_total carbon_tot_pg,f.carbon_tot_c_pg_prot carbon_prot_pg
--,
--(a.agb_tot_c_pg_total+b.bgb_tot_c_pg_total+c.dwc_tot_c_pg_total+d.lit_tot_c_pg_total+e.gsoc_tot_c_pg_total) computed_tot_c_pg
FROM dopa_42.att_ecoregion z
LEFT JOIN ind_carbon.ecoregion_carbon_above_ground a ON z.ecoregion=a.eco_id
LEFT JOIN ind_carbon.ecoregion_carbon_below_ground b ON z.ecoregion=b.eco_id
LEFT JOIN ind_carbon.ecoregion_dw_carbon c ON z.ecoregion=c.eco_id
LEFT JOIN ind_carbon.ecoregion_lit_carbon d ON z.ecoregion=d.eco_id
LEFT JOIN ind_carbon.ecoregion_carbon_soil_organic e ON z.ecoregion=e.eco_id
LEFT JOIN ind_carbon.ecoregion_carbon_total f ON z.ecoregion=f.eco_id
LEFT JOIN dopa_42.dopa_ecoregion_all_inds y ON z.ecoregion=y.eco_id
WHERE z.is_marine IS FALSE AND z.ecoregion!=100001
ORDER BY z.ecoregion;


--------------------------------------------------------------------
-- MEAN CARBON IN ECOREGIONS (PROT AND UNPROT)
DROP TABLE IF EXISTS meancarb_eco; CREATE TEMPORARY TABLE meancarb_eco AS
SELECT 
z.ecoregion eco_id,
z.ecoregion_name,
z.second_level_code, z.second_level,
y.ecoregion_tot_sqkm,
a.agb_mean_c_mg_total agc_mean_mg,a.agb_mean_c_mg_prot agc_mean_prot_mg,
b.bgb_mean_c_mg_total bgc_mean_mg,b.bgb_mean_c_mg_prot bgc_mean_prot_mg,
c.dwc_mean_c_mg_total dwc_mean_mg,c.dwc_mean_c_mg_prot dwc_mean_prot_mg,
d.lit_mean_c_mg_total lit_mean_mg,d.lit_mean_c_mg_prot lit_mean_prot_mg,
e.gsoc_mean_c_mg_total gsoc_mean_mg,e.gsoc_mean_c_mg_prot gsoc_mean_prot_mg,
f.carbon_mean_c_mg_total carbon_mean_mg,f.carbon_mean_c_mg_prot carbon_mean_prot_mg
--,
--(a.agb_tot_c_pg_total+b.bgb_tot_c_pg_total+c.dwc_tot_c_pg_total+d.lit_tot_c_pg_total+e.gsoc_tot_c_pg_total) computed_tot_c_pg
FROM dopa_42.att_ecoregion z
LEFT JOIN ind_carbon.ecoregion_carbon_above_ground a USING(eco_id)
LEFT JOIN ind_carbon.ecoregion_carbon_below_ground b USING(eco_id)
LEFT JOIN ind_carbon.ecoregion_dw_carbon c USING(eco_id)
LEFT JOIN ind_carbon.ecoregion_lit_carbon d USING(eco_id)
LEFT JOIN ind_carbon.ecoregion_carbon_soil_organic e USING(eco_id)
LEFT JOIN ind_carbon.ecoregion_carbon_total f USING(eco_id)
LEFT JOIN dopa_42.dopa_ecoregion_all_inds y ON z.ecoregion=y.eco_id
WHERE is_marine IS FALSE AND z.ecoregion!=100001
ORDER BY z.ecoregion;

--------------------------------------------------------------------
-- TOT CARBON IN BIOMES (PROT AND UNPROT)
DROP TABLE IF EXISTS totcarb_biome; CREATE TEMPORARY TABLE totcarb_biome AS
WITH intermedio AS (SELECT 
z.ecoregion eco_id, z.ecoregion_name, z.second_level_code biome_code, z.second_level biome, y.ecoregion_tot_sqkm,
a.agb_tot_c_pg_total agc_tot_pg,a.agb_tot_c_pg_prot agc_prot_pg,
b.bgb_tot_c_pg_total bgc_tot_pg,b.bgb_tot_c_pg_prot bgc_prot_pg,
c.dwc_tot_c_pg_total dwc_tot_pg,c.dwc_tot_c_pg_prot dwc_prot_pg,
d.lit_tot_c_pg_total lit_tot_pg,d.lit_tot_c_pg_prot lit_prot_pg,
e.gsoc_tot_c_pg_total gsoc_tot_pg,e.gsoc_tot_c_pg_prot gsoc_prot_pg,
f.carbon_tot_c_pg_total carbon_tot_pg,f.carbon_tot_c_pg_prot carbon_prot_pg
FROM dopa_42.att_ecoregion z
LEFT JOIN ind_carbon.ecoregion_carbon_above_ground a ON z.ecoregion=a.eco_id
LEFT JOIN ind_carbon.ecoregion_carbon_below_ground b ON z.ecoregion=b.eco_id
LEFT JOIN ind_carbon.ecoregion_dw_carbon c ON z.ecoregion=c.eco_id
LEFT JOIN ind_carbon.ecoregion_lit_carbon d ON z.ecoregion=d.eco_id
LEFT JOIN ind_carbon.ecoregion_carbon_soil_organic e ON z.ecoregion=e.eco_id
LEFT JOIN ind_carbon.ecoregion_carbon_total f ON z.ecoregion=f.eco_id
LEFT JOIN dopa_42.dopa_ecoregion_all_inds y ON z.ecoregion=y.eco_id
WHERE z.is_marine IS FALSE AND z.ecoregion!=100001 ORDER BY z.ecoregion)

SELECT biome_code, biome, 
ROUND(SUM(ecoregion_tot_sqkm::numeric),2) biome_tot_sqkm,
ROUND(SUM(agc_tot_pg::numeric),8) agc_tot_pg,
ROUND(SUM(agc_prot_pg::numeric),10) agc_prot_pg,
ROUND(SUM(bgc_tot_pg::numeric),10) bgc_tot_pg,
ROUND(SUM(bgc_prot_pg::numeric),10) bgc_prot_pg,
ROUND(SUM(dwc_tot_pg::numeric),10) dwc_tot_pg,
ROUND(SUM(dwc_prot_pg::numeric),10) dwc_prot_pg,
ROUND(SUM(lit_tot_pg::numeric),10) lit_tot_pg,
ROUND(SUM(lit_prot_pg::numeric),10) lit_prot_pg,
ROUND(SUM(gsoc_tot_pg::numeric),10) gsoc_tot_pg,
ROUND(SUM(gsoc_prot_pg::numeric),10) gsoc_prot_pg,
ROUND(SUM(carbon_tot_pg::numeric),10) carbon_tot_pg,
ROUND(SUM(carbon_prot_pg::numeric),10) carbon_prot_pg
FROM intermedio GROUP BY biome_code, biome ORDER BY biome_code;



