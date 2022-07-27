--drop table u_dw_ext_references.cls_lng_macro2ind_iso693 cascade constraints;

--==============================================================
-- Table: cls_lng_macro2ind_iso693                              
--==============================================================
create table u_dw_ext_references.cls_lng_macro2ind_iso693 
(
   macro_lng_code       VARCHAR2(3 CHAR),
   indiv_lng_code       VARCHAR2(3 CHAR)
)
tablespace TS_REFERENCES_EXT_DATA_01;

comment on table u_dw_ext_references.cls_lng_macro2ind_iso693 is
'Cleansing table for loading - Links from Macro Languages to Individual Languages';

comment on column u_dw_ext_references.cls_lng_macro2ind_iso693.macro_lng_code is
'LNG_ID: MacroLanguage - T_Languages';

comment on column u_dw_ext_references.cls_lng_macro2ind_iso693.indiv_lng_code is
'LNG_ID: Individual Language - T_Languages';
