--drop view u_dw_references.vl_cntr_sub_groups;

--==============================================================
-- View: vl_cntr_sub_groups                                     
--==============================================================
create or replace view u_dw_references.vl_cntr_sub_groups as
SELECT geo_id
     , sub_group_id
     , sub_group_code
     , sub_group_desc
     , localization_id
  FROM lc_cntr_sub_groups;

 comment on table u_dw_references.vl_cntr_sub_groups is
'Localazible View: T_CNTR_GROUPS';

comment on column u_dw_references.vl_cntr_sub_groups.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.vl_cntr_sub_groups.sub_group_id is
'ID Code of Countries Sub Groups';

comment on column u_dw_references.vl_cntr_sub_groups.sub_group_code is
'Code of Countries Sub Groups';

comment on column u_dw_references.vl_cntr_sub_groups.sub_group_desc is
'Description of Countries Sub Groups';

comment on column u_dw_references.vl_cntr_sub_groups.localization_id is
'Identificator of Supported References Languages';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.vl_cntr_sub_groups to u_dw_ext_references;
