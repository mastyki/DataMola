--drop view u_dw_references.w_geo_regions;

--==============================================================
-- View: w_geo_regions                                          
--==============================================================
create or replace view u_dw_references.w_geo_regions as
select
   geo_id,
   region_id
from
   t_geo_regions;

 comment on table u_dw_references.w_geo_regions is
'Work View: T_CONTINENTS';

comment on column u_dw_references.w_geo_regions.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.w_geo_regions.region_id is
'ID Code of Geographical Continent - Regions';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_geo_regions to u_dw_ext_references;
