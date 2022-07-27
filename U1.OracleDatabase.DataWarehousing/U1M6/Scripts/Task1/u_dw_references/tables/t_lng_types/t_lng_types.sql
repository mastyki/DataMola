--alter table u_dw_references.lc_lng_types
--   drop constraint FK_T_LNG_TYPES2LC_LNG_TYPES;
--
--alter table u_dw_references.t_languages
--   drop constraint FK_T_LNG_TYPES2T_LANGUAGES;
--
--drop table u_dw_references.t_lng_types cascade constraints;

--==============================================================
-- Table: t_lng_types                                           
--==============================================================
create table u_dw_references.t_lng_types 
(
   lng_type_id          NUMBER(22,0)         not null,
   lng_type_code        VARCHAR2(30 CHAR)    not null,
   constraint PK_T_LNG_TYPES primary key (lng_type_id)
)
organization index tablespace TS_REFERENCES_DATA_01;

comment on column u_dw_references.t_lng_types.lng_type_id is
'Identificator of Language Types - ISO 639-3';

comment on column u_dw_references.t_lng_types.lng_type_code is
'Code of Language Types - ISO 639-3';

alter table u_dw_references.t_lng_types
   add constraint CHK_T_LNG_TYPES_LNG_TYPE_CODE check (lng_type_code = upper(lng_type_code));
