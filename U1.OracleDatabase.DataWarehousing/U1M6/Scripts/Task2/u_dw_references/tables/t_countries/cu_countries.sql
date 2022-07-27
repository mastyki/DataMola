--drop view u_dw_references.cu_countries;

--==============================================================
-- View: cu_countries                                           
--==============================================================
create or replace view u_dw_references.cu_countries as
SELECT src.geo_id
     , src.country_id AS country_id
     , NVL ( lc.country_code_a2, '-' ) AS country_code_a2
     , NVL ( lc.country_code_a3, '-' ) AS country_code_a3
     , NVL ( lc.country_desc, 'Not Defined' ) AS region_desc
     , NVL ( lc.localization_id, -99 ) AS localization_id
  FROM w_countries src
     , lc_countries lc
 WHERE lc.geo_id(+) = src.geo_id
   AND lc.localization_id(+) = pkg_session_params.get_user_localization_id
with read only;

comment on column u_dw_references.cu_countries.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.cu_countries.country_id is
'ID Code of Country';
