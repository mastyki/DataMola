--drop view u_dw_references.vl_geo_regions;

--==============================================================
-- View: vl_geo_regions                                         
--==============================================================
create or replace view u_dw_references.vl_geo_regions as
SELECT geo_id
     , region_id
     , region_code
     , region_desc
     , localization_id
  FROM lc_geo_regions;

 comment on table u_dw_references.vl_geo_regions is
'Localazible View: T_CONTINENTS';

comment on column u_dw_references.vl_geo_regions.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.vl_geo_regions.region_id is
'ID Code of Geographical Continent - Regions';

comment on column u_dw_references.vl_geo_regions.region_code is
'Code of Continent Regions';

comment on column u_dw_references.vl_geo_regions.region_desc is
'Description of Continent Regions';

comment on column u_dw_references.vl_geo_regions.localization_id is
'Identificator of Supported References Languages';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.vl_geo_regions to u_dw_ext_references;
