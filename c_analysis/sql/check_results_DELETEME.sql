SELECT 
a.wdpaid,
a.agb_mean_c_mg,
b.bgb_mean_c_mg,
c.dwc_mean_c_mg,
d.lit_mean_c_mg,
e.gsoc_mean_c_mg,
f.carbon_mean_c_mg
FROM ind_carbon.wdpa_carbon_above_ground a
LEFT JOIN ind_carbon.wdpa_carbon_below_ground b USING(wdpaid)
LEFT JOIN ind_carbon.wdpa_dw_carbon c USING(wdpaid)
LEFT JOIN ind_carbon.wdpa_lit_carbon d USING(wdpaid)
LEFT JOIN ind_carbon.wdpa_carbon_soil_organic e USING(wdpaid)
LEFT JOIN ind_carbon.wdpa_carbon_total f USING(wdpaid)
WHERE wdpaid=3225

------------------------------------
SELECT 
a.wdpaid,
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
WHERE wdpaid=32671


----------------------------

SELECT 
a.eid,
a.qid,
a.cid,
a.sum sum_agc,
b.sum sum_bgc,
c.sum sum_dwc,
d.sum sum_lit,
e.sum sum_soc,
f.sum sum_tot
FROM ind_carbon.r_univar_cep_agc2018_100m_202101 a
LEFT JOIN ind_carbon.r_univar_cep_bgc2018_100m_202101 b USING(eid,qid,cid)
LEFT JOIN ind_carbon.r_univar_cep_dw_carbon_100m_202101 c USING(eid,qid,cid)
LEFT JOIN ind_carbon.r_univar_cep_lit_carbon_100m_202101 d USING(eid,qid,cid)
LEFT JOIN ind_carbon.r_univar_cep_gsoc_15_100m_202101 e USING(eid,qid,cid)
LEFT JOIN ind_carbon.r_univar_cep_total_carbon_202101 f USING(eid,qid,cid)
WHERE cid=343554


