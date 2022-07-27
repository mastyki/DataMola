--drop view u_dw_references.cu_geo_parts;

--==============================================================
-- View: cu_geo_parts                                           
--==============================================================
create or replace view u_dw_references.cu_geo_parts as
select
   src.geo_id,
   src.part_id as part_id,
   NVL( lc.part_code, '-' ) as part_code,
   NVL( lc.part_desc, 'Not Defined' ) as part_desc,
   NVL( lc.localization_id, -99 ) as localization_id
from
   w_geo_parts src,
   lc_geo_parts lc
where
   lc.geo_id(+) = src.geo_id
   AND lc.localization_id(+) = pkg_session_params.get_user_localization_id

with read only;

comment on column u_dw_references.cu_geo_parts.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.cu_geo_parts.part_id is
'ID Code of Geographical Part of World';
