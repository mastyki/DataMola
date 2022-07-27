--drop table u_dw_ext_references.cls_cntr_grouping_iso3166 cascade constraints;

--==============================================================
-- Table: cls_cntr_grouping_iso3166                             
--==============================================================
create table u_dw_ext_references.cls_cntr_grouping_iso3166 
(
   child_code           NUMBER(10,0),
   parent_code          NUMBER(10,0),
   group_desc           VARCHAR2(200 CHAR),
   group_level          VARCHAR2(200 CHAR)
)
tablespace TS_REFERENCES_EXT_DATA_01;

comment on table u_dw_ext_references.cls_cntr_grouping_iso3166 is
'Cleansing table for loading - Structure of GeoLocation world Dividing (USA standart)';

comment on column u_dw_ext_references.cls_cntr_grouping_iso3166.child_code is
'Code of Group Element';

comment on column u_dw_ext_references.cls_cntr_grouping_iso3166.parent_code is
'Parent Code of Group Element';

comment on column u_dw_ext_references.cls_cntr_grouping_iso3166.group_desc is
'Description of GroupElement';

comment on column u_dw_ext_references.cls_cntr_grouping_iso3166.group_level is
'Level grouping Code of Group Element';
