--drop view u_dw_references.w_cntr_groups;

--==============================================================
-- View: w_cntr_groups                                          
--==============================================================
create or replace view u_dw_references.w_cntr_groups as
SELECT geo_id
     , group_id     
  FROM t_cntr_groups;

 comment on table u_dw_references.w_cntr_groups is
'Work View: T_CNTR_GROUPS';

comment on column u_dw_references.w_cntr_groups.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.w_cntr_groups.group_id is
'ID Code of Countries Groups';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_cntr_groups to u_dw_ext_references;
