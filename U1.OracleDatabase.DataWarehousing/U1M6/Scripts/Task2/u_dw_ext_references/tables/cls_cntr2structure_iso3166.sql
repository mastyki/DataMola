drop table u_dw_ext_references.cls_cntr2structure_iso3166 cascade constraints;

--==============================================================
-- Table: cls_cntr2structure_iso3166                            
--==============================================================
create table u_dw_ext_references.cls_cntr2structure_iso3166 
(
   country_id           NUMBER(10,0),
   county_desc          VARCHAR2(200 CHAR),
   structure_code       NUMBER(10,0),
   structure_desc       VARCHAR2(200 CHAR)
)
tablespace TS_REFERENCES_EXT_DATA_01;

comment on table u_dw_ext_references.cls_cntr2structure_iso3166 is
'Cleansing table for loading - Links Countries to GeoLocation Sructure world Dividing  (USA standart)';

comment on column u_dw_ext_references.cls_cntr2structure_iso3166.country_id is
'ISO - Country ID';

comment on column u_dw_ext_references.cls_cntr2structure_iso3166.county_desc is
'ISO - Country Desc';

comment on column u_dw_ext_references.cls_cntr2structure_iso3166.structure_code is
'Code of Structure Element';

comment on column u_dw_ext_references.cls_cntr2structure_iso3166.structure_desc is
'Description of Structure Element';
