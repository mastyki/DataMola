--drop view u_dw_references.cu_cntr_group_systems;

--==============================================================
-- View: cu_cntr_group_systems                                  
--==============================================================
create or replace view u_dw_references.cu_cntr_group_systems as
SELECT src.geo_id
     , src.grp_system_id AS grp_system_id
     , NVL ( lc.grp_system_code, '-' ) AS grp_system_code
     , NVL ( lc.grp_system_desc, 'Not Defined' ) AS grp_system_desc
     , NVL ( lc.localization_id, -99 ) AS localization_id
  FROM w_cntr_group_systems src
     , lc_cntr_group_systems lc
 WHERE lc.geo_id(+) = src.geo_id
   AND lc.localization_id(+) = pkg_session_params.get_user_localization_id
with read only;

comment on column u_dw_references.cu_cntr_group_systems.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.cu_cntr_group_systems.grp_system_id is
'ID Code of Grouping System Specifications';
