drop table u_dw_ext_references.cls_geo_structure_iso3166 cascade constraints;

--==============================================================
-- Table: cls_geo_structure_iso3166                             
--==============================================================
create table u_dw_ext_references.cls_geo_structure_iso3166 
(
   child_code           NUMBER(10,0),
   parent_code          NUMBER(10,0),
   structure_desc       VARCHAR2(200 CHAR),
   structure_level      VARCHAR2(200 CHAR)
)
tablespace TS_REFERENCES_EXT_DATA_01;

comment on table u_dw_ext_references.cls_geo_structure_iso3166 is
'Cleansing table for loading - Structure of GeoLocation world Dividing (USA standart)';

comment on column u_dw_ext_references.cls_geo_structure_iso3166.child_code is
'Code of Structure Element';

comment on column u_dw_ext_references.cls_geo_structure_iso3166.parent_code is
'Parent Code of Structure Element';

comment on column u_dw_ext_references.cls_geo_structure_iso3166.structure_desc is
'Description of Structure Element';

comment on column u_dw_ext_references.cls_geo_structure_iso3166.structure_level is
'Level grouping Code of Structure Element';
