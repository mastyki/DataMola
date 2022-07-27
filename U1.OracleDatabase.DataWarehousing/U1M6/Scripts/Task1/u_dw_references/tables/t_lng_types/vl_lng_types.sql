--drop view u_dw_references.vl_lng_types;

--==============================================================
-- View: vl_lng_types                                           
--==============================================================
create or replace view u_dw_references.vl_lng_types as
SELECT lng_type_id
     , lng_type_code
     , lng_type_desc
     , localization_id
  FROM lc_lng_types;

comment on column u_dw_references.vl_lng_types.lng_type_id is
'Identificator of Language Types - ISO 639-3';

comment on column u_dw_references.vl_lng_types.lng_type_code is
'Code of Language Types - ISO 639-3';

comment on column u_dw_references.vl_lng_types.lng_type_desc is
'Description of Language Types - ISO 639-3';

comment on column u_dw_references.vl_lng_types.localization_id is
'Identificator of Supported References Languages';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.vl_lng_types to u_dw_ext_references;
