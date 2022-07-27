--drop view u_dw_references.vl_geo_parts;

--==============================================================
-- View: vl_geo_parts                                           
--==============================================================
create or replace view u_dw_references.vl_geo_parts as
select
   geo_id,
   part_id,
   part_code,
   part_desc,
   localization_id
from
   lc_geo_parts;

 comment on table u_dw_references.vl_geo_parts is
'Localazible View: T_CONTINENTS';

comment on column u_dw_references.vl_geo_parts.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.vl_geo_parts.part_id is
'ID Code of Part of World';

comment on column u_dw_references.vl_geo_parts.part_code is
'Code of Part of World';

comment on column u_dw_references.vl_geo_parts.part_desc is
'Description of Part of World';

comment on column u_dw_references.vl_geo_parts.localization_id is
'Identificator of Supported References Languages';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.vl_geo_parts to u_dw_ext_references;
