-- PAs
SELECT 
a.wdpaid,
z.pa_name,
z.iso3,
a.agb_tot_c_mg,
b.bgb_tot_c_mg,
c.dwc_tot_c_mg,
d.lit_tot_c_mg,
e.gsoc_tot_c_mg,
f.carbon_tot_c_mg
FROM ind_carbon.wdpa_carbon_above_ground a
LEFT JOIN ind_carbon.wdpa_carbon_below_ground b USING(wdpaid)
LEFT JOIN ind_carbon.wdpa_dw_carbon c USING(wdpaid)
LEFT JOIN ind_carbon.wdpa_lit_carbon d USING(wdpaid)
LEFT JOIN ind_carbon.wdpa_carbon_soil_organic e USING(wdpaid)
LEFT JOIN ind_carbon.wdpa_carbon_total f USING(wdpaid)
LEFT JOIN dopa_41.att_pa z ON a.wdpaid=z.pa
WHERE z.area_geo>=1
--WHERE wdpaid=32671
;

-- COUNTRIES
SELECT 
a.country_id,
z.iso3,
z.country_name,
ROUND(a.agb_tot_c_pg_total::numeric,6) agb_tot_c_pg,
ROUND(b.bgb_tot_c_pg_total::numeric,6) bgb_tot_c_pg,
ROUND(c.dwc_tot_c_pg_total::numeric,6) dwc_tot_c_pg,
ROUND(d.lit_tot_c_pg_total::numeric,6) lit_tot_c_pg,
ROUND(e.gsoc_tot_c_pg_total::numeric,6) gsoc_tot_c_pg,
ROUND(f.carbon_tot_c_pg_total::numeric,6) carbon_tot_c_pg
FROM ind_carbon.country_carbon_above_ground a
LEFT JOIN ind_carbon.country_carbon_below_ground b USING(country_id)
LEFT JOIN ind_carbon.country_dw_carbon c USING(country_id)
LEFT JOIN ind_carbon.country_lit_carbon d USING(country_id)
LEFT JOIN ind_carbon.country_carbon_soil_organic e USING(country_id)
LEFT JOIN ind_carbon.country_carbon_total f USING(country_id)
LEFT JOIN dopa_41.att_country z ON a.country_id=z.country
--WHERE z.iso3 ='IND'
;


---- WITH FILTER ON FOREST OVER 50%
SELECT a.country_id,z.country_name,z.iso3, 
ROUND(a.dwc_tot_c_pg_total::numeric,6) dwc_tot_c_pg,
ROUND(b.dwc_tot_c_pg_total::numeric,6) dwc_tot_c_pg_f_o50
FROM ind_carbon.country_dw_carbon a
LEFT JOIN ind_carbon.country_dw_carbon_forest_over50 b USING(country_id)
LEFT JOIN dopa_41.att_country z ON country_id=z.country
ORDER BY iso3;

SELECT a.wdpaid,z.iso3,z.pa_name,
ROUND(a.dwc_tot_c_mg::numeric,2) dwc_tot_c_mg,
ROUND(b.dwc_tot_c_mg::numeric,2) dwc_tot_c_mg_f_o50
FROM ind_carbon.wdpa_dw_carbon a
LEFT JOIN ind_carbon.wdpa_dw_carbon_forest_over50 b USING(wdpaid)
LEFT JOIN dopa_41.att_pa z ON wdpaid=z.pa
ORDER BY wdpaid;


