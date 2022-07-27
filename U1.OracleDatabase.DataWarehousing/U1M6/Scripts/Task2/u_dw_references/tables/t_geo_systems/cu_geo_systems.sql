drop view u_dw_references.cu_geo_systems;

--==============================================================
-- View: cu_geo_systems                                         
--==============================================================
create or replace view u_dw_references.cu_geo_systems as
SELECT src.geo_id
     , src.geo_system_id AS src_geo_system_id
     , NVL ( lc.geo_system_code, '-' ) AS geo_system_code
     , NVL ( lc.geo_system_desc, 'Not Defined' ) AS geo_system_desc
     , NVL ( lc.localization_id, -99 ) AS localization_id
  FROM w_geo_systems src
     , lc_geo_systems lc
 WHERE lc.geo_id(+) = src.geo_id
   AND lc.localization_id(+) = pkg_session_params.get_user_localization_id
with read only;

comment on column u_dw_references.cu_geo_systems.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.cu_geo_systems.src_geo_system_id is
'ID Code of Geography System Specifications';
