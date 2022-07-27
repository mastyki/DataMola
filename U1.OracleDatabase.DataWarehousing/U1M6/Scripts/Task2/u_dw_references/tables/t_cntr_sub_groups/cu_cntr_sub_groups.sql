--drop view u_dw_references.cu_cntr_sub_groups;

--==============================================================
-- View: cu_cntr_sub_groups                                     
--==============================================================
create or replace view u_dw_references.cu_cntr_sub_groups as
SELECT src.geo_id
     , src.sub_group_id AS sub_group_id
     , NVL ( lc.sub_group_code, '-' ) AS sub_group_code
     , NVL ( lc.sub_group_desc, 'Not Defined' ) AS sub_group_desc
     , NVL ( lc.localization_id, -99 ) AS localization_id
  FROM w_cntr_sub_groups src
     , lc_cntr_sub_groups lc
 WHERE lc.geo_id(+) = src.geo_id
   AND lc.localization_id(+) = pkg_session_params.get_user_localization_id
with read only;

comment on column u_dw_references.cu_cntr_sub_groups.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.cu_cntr_sub_groups.sub_group_id is
'ID Code of Countries Sub Groups';
