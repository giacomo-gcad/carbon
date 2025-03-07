-- FOR EACH CARBON POOL, SELECT ONLY EID TILES WITH NON NULL VALUES (RANGE>0)
DROP TABLE IF EXISTS all_eid; CREATE TEMPORARY TABLE all_eid AS 
SELECT eid eid_txt,SUBSTRING(eid,5,3)::numeric eid, x_min,x_max,y_min,y_max FROM delli.eid_index;
DROP TABLE IF EXISTS agc; CREATE TEMPORARY TABLE agc AS
SELECT DISTINCT eid  FROM results_202501_cep_in.r_univar_cep_agc2021_100m_202501 WHERE range > 0 ORDER BY eid;
DROP TABLE IF EXISTS bgc; CREATE TEMPORARY TABLE bgc AS
SELECT DISTINCT eid  FROM results_202501_cep_in.r_univar_cep_bgc2021_100m_202501 WHERE range > 0 ORDER BY eid;
DROP TABLE IF EXISTS dwc; CREATE TEMPORARY TABLE dwc AS
SELECT DISTINCT eid  FROM results_202501_cep_in.r_univar_cep_dw_carbon_100m_202501 WHERE range > 0 ORDER BY eid;
DROP TABLE IF EXISTS ltc; CREATE TEMPORARY TABLE ltc AS
SELECT DISTINCT eid  FROM results_202501_cep_in.r_univar_cep_lit_carbon_100m_202501 WHERE range > 0 ORDER BY eid;
DROP TABLE IF EXISTS gsoc; CREATE TEMPORARY TABLE gsoc AS
SELECT DISTINCT eid  FROM results_202501_cep_in.r_univar_cep_gsoc_16_100m_202501 WHERE range > 0 ORDER BY eid;
DROP TABLE IF EXISTS totc; CREATE TEMPORARY TABLE totc AS
SELECT DISTINCT eid  FROM results_202501_cep_in.r_univar_cep_total_carbon_2021_202501 WHERE range > 0 ORDER BY eid;

--aaaa AS (SELECT a.eid eid_agc, b.eid eid_bgc, c.eid eid_dwc, d.eid eid_ltc, e.eid eid_gsoc, f.eid eid_totc
--FROM agc a FULL JOIN bgc b USING(eid) FULL JOIN dwc c USING(eid) FULL JOIN ltc d USING(eid)
--FULL JOIN gsoc e USING(eid) FULL JOIN totc f USING(eid) ORDER BY a.eid)
--SELECT * FROM aaaa WHERE eid_totc IS NULL and  eid_gsoc IS NOT NULL

SELECT eid_txt, x_min,x_max,y_min,y_max FROM all_eid a WHERE a.eid IN (SELECT eid FROM agc);
SELECT eid_txt, x_min,x_max,y_min,y_max FROM all_eid a WHERE a.eid IN (SELECT eid FROM bgc);
SELECT eid_txt, x_min,x_max,y_min,y_max FROM all_eid a WHERE a.eid IN (SELECT eid FROM dwc);
SELECT eid_txt, x_min,x_max,y_min,y_max FROM all_eid a WHERE a.eid IN (SELECT eid FROM ltc);
SELECT eid_txt, x_min,x_max,y_min,y_max FROM all_eid a WHERE a.eid IN (SELECT eid FROM gsoc);
SELECT eid_txt, x_min,x_max,y_min,y_max FROM all_eid a WHERE a.eid IN (SELECT eid FROM totc);

