--drop table u_dw_ext_references.cls_languages_iso693 cascade constraints;

--==============================================================
-- Table: cls_languages_iso693                                  
--==============================================================
create table u_dw_ext_references.cls_languages_iso693 
(
   lng_3c_code           VARCHAR2( 3 CHAR ),
   lng_2b_code           VARCHAR2( 3 CHAR ),
   lng_2t_code           VARCHAR2( 3 CHAR ),
   lng_1c_code           VARCHAR2( 2 CHAR ),
   lng_scope             VARCHAR2( 2 CHAR ),
   lng_type              VARCHAR2( 1 CHAR ),
   lng_desc             VARCHAR2(200 CHAR)
)
tablespace TS_REFERENCES_EXT_DATA_01;

comment on table u_dw_ext_references.cls_languages_iso693 is
'Cleansing table for loading - Languages';

comment on column u_dw_ext_references.cls_languages_iso693.lng_3c_code is
'ISO 639-3 identifier';

comment on column u_dw_ext_references.cls_languages_iso693.lng_2b_code is
'ISO 639-2 identifier of the bibliographic applications';

comment on column u_dw_ext_references.cls_languages_iso693.lng_2t_code is
'ISO 639-2 identifier of the terminology applications code ';

comment on column u_dw_ext_references.cls_languages_iso693.lng_1c_code is
'ISO 639-1 identifier - common standart';

comment on column u_dw_ext_references.cls_languages_iso693.lng_scope is
'Identifier of the language scope';

comment on column u_dw_ext_references.cls_languages_iso693.lng_type is
'Identifier of the language type';

comment on column u_dw_ext_references.cls_languages_iso693.lng_desc is
'EdonymName of Language';
