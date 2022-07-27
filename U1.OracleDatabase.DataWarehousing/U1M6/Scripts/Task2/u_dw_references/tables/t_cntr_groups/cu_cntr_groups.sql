--drop view u_dw_references.cu_cntr_groups;

--==============================================================
-- View: cu_cntr_groups                                         
--==============================================================
create or replace view u_dw_references.cu_cntr_groups as
SELECT src.geo_id
     , src.group_id AS group_id
     , NVL ( lc.group_code, '-' ) AS group_code
     , NVL ( lc.group_desc, 'Not Defined' ) AS group_desc
     , NVL ( lc.localization_id, -99 ) AS localization_id
  FROM w_cntr_groups src
     , lc_cntr_groups lc
 WHERE lc.geo_id(+) = src.geo_id
   AND lc.localization_id(+) = pkg_session_params.get_user_localization_id
with read only;

comment on column u_dw_references.cu_cntr_groups.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.cu_cntr_groups.group_id is
'ID Code of Countries Groups';
