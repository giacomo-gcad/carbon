WITH eu27 AS (
SELECT unnest(lookup_country_id) country_id FROM dopa_42.dopa_regions 
 WHERE region_name='eu_27'),
summary AS (
SELECT iso3,country_name,
ROUND(a.dwc_mean_c_mg_total::numeric,4) dwc_mean_c_mg_total,
ROUND(b.dwc_tot_c_pg_total::numeric,6) dwc_tot_c_pg_total,
ROUND(a.dwc_mean_c_mg_prot::numeric,4) dwc_mean_c_mg_prot,
ROUND(b.dwc_tot_c_pg_prot::numeric,6) dwc_tot_c_pg_prot,
ROUND(a.dwc_mean_c_mg_unprot::numeric,4) dwc_mean_c_mg_unprot,
ROUND(b.dwc_tot_c_pg_unprot::numeric,6) dwc_tot_c_pg_unprot,
ROUND(c.ltc_mean_c_mg_total::numeric,4) ltc_mean_c_mg_total,
ROUND(b.ltc_tot_c_pg_total::numeric,6) ltc_tot_c_pg_total,
ROUND(c.ltc_mean_c_mg_prot::numeric,4) ltc_mean_c_mg_prot,
ROUND(b.ltc_tot_c_pg_prot::numeric,6) ltc_tot_c_pg_prot,
ROUND(c.ltc_mean_c_mg_unprot::numeric,4) ltc_mean_c_mg_unprot,
ROUND(b.ltc_tot_c_pg_unprot::numeric,6) ltc_tot_c_pg_unprot	
FROM dopa_42.dopa_country_all_inds b
LEFT JOIN results_202202_cep_out.country_carbon_dead_wood_dens a USING(country_id)
LEFT JOIN results_202202_cep_out.country_carbon_litter_dens c USING(country_id)
WHERE b.country_id IN (SELECT country_id FROM eu27) AND iso3 NOT ILIKE'%|%')

SELECT * FROM summary ORDER BY iso3
