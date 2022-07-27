--drop view u_dw_references.cu_lng_scopes;

--==============================================================
-- View: cu_lng_scopes                                          
--==============================================================
create or replace view u_dw_references.cu_lng_scopes as
SELECT src.lng_scope_id
     , src.lng_scope_code AS src_scope_code
     , NVL ( lc.lng_scope_code, '-' ) AS lng_scope_code
     , NVL ( lc.lng_scope_desc, 'Not Defined' ) AS lng_scope_desc
     , NVL ( lc.localization_id, -99 ) AS localization_id
  FROM w_lng_scopes src
     , lc_lng_scopes lc
 WHERE lc.lng_scope_id(+) = src.lng_scope_id
   AND lc.localization_id(+) = pkg_session_params.get_user_localization_id
with read only;

comment on column u_dw_references.cu_lng_scopes.lng_scope_id is
'Idemtificator of Language Scopes - ISO 639-3';

comment on column u_dw_references.cu_lng_scopes.src_scope_code is
'Code of Languages Scopes - ISO 639-3';
