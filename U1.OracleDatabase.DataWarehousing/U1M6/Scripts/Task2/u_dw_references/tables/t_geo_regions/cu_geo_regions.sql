--drop view u_dw_references.cu_geo_regions;

--==============================================================
-- View: cu_geo_regions                                         
--==============================================================
create or replace view u_dw_references.cu_geo_regions as
SELECT src.geo_id
     , src.region_id AS src_continent_id
     , NVL ( lc.region_code, '-' ) AS region_code
     , NVL ( lc.region_desc, 'Not Defined' ) AS region_desc
     , NVL ( lc.localization_id, -99 ) AS localization_id
  FROM w_geo_regions src
     , lc_geo_regions lc
 WHERE lc.geo_id(+) = src.geo_id
   AND lc.localization_id(+) = pkg_session_params.get_user_localization_id
with read only;

comment on column u_dw_references.cu_geo_regions.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.cu_geo_regions.src_continent_id is
'ID Code of Geographical Continent - Regions';
