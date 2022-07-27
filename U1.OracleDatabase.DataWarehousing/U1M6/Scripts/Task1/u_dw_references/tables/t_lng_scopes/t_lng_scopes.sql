alter table u_dw_references.lc_lng_scopes
   drop constraint FK_T_LNG_SCOPES2LC_LNG_SCOPES;

alter table u_dw_references.t_languages
   drop constraint FK_T_LNG_SCOPES2T_LANGUAGES;

drop table u_dw_references.t_lng_scopes cascade constraints;

--==============================================================
-- Table: t_lng_scopes                                          
--==============================================================
create table u_dw_references.t_lng_scopes 
(
   lng_scope_id         NUMBER(22,0)         not null,
   lng_scope_code       VARCHAR2(1 CHAR)     not null,
   constraint PK_T_LNG_SCOPES primary key (lng_scope_id)
)
organization index tablespace TS_REFERENCES_DATA_01;

comment on column u_dw_references.t_lng_scopes.lng_scope_id is
'Idemtificator of Language Scopes - ISO 639-3';

comment on column u_dw_references.t_lng_scopes.lng_scope_code is
'Code of Languages Scopes - ISO 639-3';
