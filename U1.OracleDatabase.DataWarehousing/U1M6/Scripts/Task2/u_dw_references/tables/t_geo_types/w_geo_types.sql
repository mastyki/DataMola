drop view u_dw_references.w_geo_types;

--==============================================================
-- View: w_geo_types                                            
--==============================================================
create or replace view u_dw_references.w_geo_types as
SELECT geo_type_id
     , geo_type_code
     , geo_type_desc
  FROM t_geo_types;

 comment on table u_dw_references.w_geo_types is
'Work View: T_GEO_TYPES';

comment on column u_dw_references.w_geo_types.geo_type_id is
'ID of unique Type - abstraction code for Geo Objects ';

comment on column u_dw_references.w_geo_types.geo_type_code is
'Code of Geography Type Objects';

comment on column u_dw_references.w_geo_types.geo_type_desc is
'Description of Geography Type Objects (Not Localizable)';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_geo_types to u_dw_ext_references;
