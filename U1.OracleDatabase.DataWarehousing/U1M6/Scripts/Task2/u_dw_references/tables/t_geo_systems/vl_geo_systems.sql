drop view u_dw_references.vl_geo_systems;

--==============================================================
-- View: vl_geo_systems                                         
--==============================================================
create or replace view u_dw_references.vl_geo_systems as
SELECT geo_id
     , geo_system_id
     , geo_system_code
     , geo_system_desc
     , localization_id
  FROM lc_geo_systems;

 comment on table u_dw_references.vl_geo_systems is
'Localazible View: T_GEO_SYSTEMS';

comment on column u_dw_references.vl_geo_systems.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.vl_geo_systems.geo_system_id is
'ID Code of Geography System Specifications';

comment on column u_dw_references.vl_geo_systems.geo_system_code is
'Code of Geography System Specifications';

comment on column u_dw_references.vl_geo_systems.geo_system_desc is
'Description of Geography System Specifications';

comment on column u_dw_references.vl_geo_systems.localization_id is
'Identificator of Supported References Languages';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.vl_geo_systems to u_dw_ext_references;
