--drop view u_dw_references.w_geo_objects;

--==============================================================
-- View: w_geo_objects                                          
--==============================================================
create or replace view u_dw_references.w_geo_objects as
SELECT geo_id
     , geo_type_id
     , geo_code_id
  FROM t_geo_objects;

 comment on table u_dw_references.w_geo_objects is
'Work View: T_GEO_TYPES';

comment on column u_dw_references.w_geo_objects.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.w_geo_objects.geo_type_id is
'ID of unique Type - abstraction code for Geo Objects ';

comment on column u_dw_references.w_geo_objects.geo_code_id is
'NK: Source ID from source systems';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_geo_objects to u_dw_ext_references;
