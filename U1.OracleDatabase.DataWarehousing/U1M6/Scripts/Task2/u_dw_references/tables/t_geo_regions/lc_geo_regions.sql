--alter table u_dw_references.lc_geo_regions
--   drop constraint FK_LC_GEO_REGIONS;
--
--alter table u_dw_references.lc_geo_regions
--   drop constraint FK_LOC2LC_GEO_REGIONS;
--
--drop table u_dw_references.lc_geo_regions cascade constraints;

--==============================================================
-- Table: lc_geo_regions                                        
--==============================================================
create table u_dw_references.lc_geo_regions 
(
   geo_id               NUMBER(22,0)         not null,
   region_id            NUMBER(22,0)         not null,
   region_code          VARCHAR2(30 CHAR),
   region_desc          VARCHAR2(200 CHAR)   not null,
   localization_id      NUMBER(22,0)         not null,
   constraint PK_LC_GEO_REGIONS primary key (geo_id, localization_id)
         using index tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01;

comment on table u_dw_references.lc_geo_regions is
'Localization table: T_GEO_SYSTEMS';

comment on column u_dw_references.lc_geo_regions.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.lc_geo_regions.region_id is
'ID Code of Geographical Continent - Regions';

comment on column u_dw_references.lc_geo_regions.region_code is
'Code of Continent Regions';

comment on column u_dw_references.lc_geo_regions.region_desc is
'Description of Continent Regions';

comment on column u_dw_references.lc_geo_regions.localization_id is
'Identificator of Supported References Languages';

alter table u_dw_references.lc_geo_regions
   add constraint CHK_LC_GEO_REGIONS_CODE check (region_code is null or (region_code = upper(region_code)));

alter table u_dw_references.lc_geo_regions
   add constraint FK_LC_GEO_REGIONS foreign key (geo_id)
      references u_dw_references.t_geo_regions (geo_id)
      on delete cascade;

alter table u_dw_references.lc_geo_regions
   add constraint FK_LOC2LC_GEO_REGIONS foreign key (localization_id)
      references u_dw_references.t_localizations (localization_id)
      on delete cascade;
