--drop table u_dw_ext_references.cls_geo_countries2_iso3166 cascade constraints;

--==============================================================
-- Table: cls_geo_countries2_iso3166                            
--==============================================================
create table u_dw_ext_references.cls_geo_countries2_iso3166 
(
   country_desc         VARCHAR2(200 CHAR),
   country_code         VARCHAR2(30 CHAR)
)
tablespace TS_REFERENCES_EXT_DATA_01;

comment on table u_dw_ext_references.cls_geo_countries2_iso3166 is
'Cleansing table for loading - Countries';

comment on column u_dw_ext_references.cls_geo_countries2_iso3166.country_desc is
'ISO - Country Name';

comment on column u_dw_ext_references.cls_geo_countries2_iso3166.country_code is
'ISO - Alpha Name 3';

alter table u_dw_ext_references.cls_geo_countries2_iso3166
   add constraint CHK_CLS_GEO_COUNTRY2_CODE check (country_code is null or (country_code = upper(country_code)));
