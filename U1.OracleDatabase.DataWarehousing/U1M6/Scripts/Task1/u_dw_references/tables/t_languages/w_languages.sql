--drop view u_dw_references.w_languages;

--==============================================================
-- View: w_languages                                            
--==============================================================
create or replace view u_dw_references.w_languages as
SELECT lng_id
     , lng_3c_code
     , lng_2b_code
     , lng_2t_code
     , lng_1c_code
     , lng_scope_id
     , lng_type_id
     , lng_desc
  FROM t_languages;

comment on column u_dw_references.w_languages.lng_id is
'Identifier of the Language';

comment on column u_dw_references.w_languages.lng_3c_code is
'ISO 639-3 identifier';

comment on column u_dw_references.w_languages.lng_2b_code is
'ISO 639-2 identifier of the bibliographic applications';

comment on column u_dw_references.w_languages.lng_2t_code is
'ISO 639-2 identifier of the terminology applications code ';

comment on column u_dw_references.w_languages.lng_1c_code is
'ISO 639-1 identifier - common standart';

comment on column u_dw_references.w_languages.lng_scope_id is
'Idemtificator of Language Scopes - ISO 639-3';

comment on column u_dw_references.w_languages.lng_desc is
'Name of Language';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_languages to u_dw_ext_references;
