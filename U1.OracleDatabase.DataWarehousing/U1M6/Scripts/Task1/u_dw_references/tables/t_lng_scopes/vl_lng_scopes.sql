drop view u_dw_references.vl_lng_scopes;

--==============================================================
-- View: vl_lng_scopes                                          
--==============================================================
create or replace view u_dw_references.vl_lng_scopes as
SELECT lng_scope_id
     , lng_scope_code
     , lng_scope_desc
     , localization_id
  FROM lc_lng_scopes;

comment on column u_dw_references.vl_lng_scopes.lng_scope_id is
'Idemtificator of Language Scopes - ISO 639-3';

comment on column u_dw_references.vl_lng_scopes.lng_scope_code is
'Code of Languages Scopes - ISO 639-3';

comment on column u_dw_references.vl_lng_scopes.lng_scope_desc is
'Description of Language Scopes - ISO 639-3';

comment on column u_dw_references.vl_lng_scopes.localization_id is
'Identificator of Supported References Languages';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.vl_lng_scopes to u_dw_ext_references;
