--alter table u_dw_references.lc_lng_types
--   drop constraint FK_LOC2LNG_TYPES;
--
--alter table u_dw_references.lc_lng_types
--   drop constraint FK_T_LNG_TYPES2LC_LNG_TYPES;

--drop table u_dw_references.lc_lng_types cascade constraints;

--==============================================================
-- Table: lc_lng_types                                          
--==============================================================
create table u_dw_references.lc_lng_types 
(
   lng_type_id          NUMBER(22,0)         not null,
   lng_type_code        VARCHAR2(30 CHAR)    not null,
   lng_type_desc        VARCHAR2(200 CHAR)   not null,
   localization_id      NUMBER(22,0)         not null,
   constraint PK_LC_LNG_TYPES primary key (lng_type_id, localization_id)
         using index tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01;

comment on column u_dw_references.lc_lng_types.lng_type_id is
'Identificator of Language Types - ISO 639-3';

comment on column u_dw_references.lc_lng_types.lng_type_code is
'Code of Language Types - ISO 639-3';

comment on column u_dw_references.lc_lng_types.lng_type_desc is
'Description of Language Types - ISO 639-3';

comment on column u_dw_references.lc_lng_types.localization_id is
'Identificator of Supported References Languages';

alter table u_dw_references.lc_lng_types
   add constraint CHK_LC_LNG_TYPES_LNG_TYPE_CODE check (lng_type_code = upper(lng_type_code));

alter table u_dw_references.lc_lng_types
   add constraint FK_LOC2LNG_TYPES foreign key (localization_id)
      references u_dw_references.t_localizations (localization_id)
      on delete cascade;

alter table u_dw_references.lc_lng_types
   add constraint FK_T_LNG_TYPES2LC_LNG_TYPES foreign key (lng_type_id)
      references u_dw_references.t_lng_types (lng_type_id)
      on delete cascade;
