--alter table u_dw_references.lc_geo_parts
--   drop constraint FK_LC_CONTINENTS;
--
--alter table u_dw_references.lc_geo_parts
--   drop constraint FK_LOC2CONTINENTS;
--
--drop table u_dw_references.lc_geo_parts cascade constraints;

--==============================================================
-- Table: lc_geo_parts                                          
--==============================================================
create table u_dw_references.lc_geo_parts 
(
   geo_id               NUMBER(22,0)         not null,
   part_id              NUMBER(22,0)         not null,
   part_code            VARCHAR2(30 CHAR),
   part_desc            VARCHAR2(200 CHAR)   not null,
   localization_id      NUMBER(22,0)         not null,
   constraint PK_LC_GEO_PARTS primary key (geo_id, localization_id)
         using index tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01;

comment on table u_dw_references.lc_geo_parts is
'Localization table: T_GEO_SYSTEMS';

comment on column u_dw_references.lc_geo_parts.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.lc_geo_parts.part_id is
'ID Code of Part of World';

comment on column u_dw_references.lc_geo_parts.part_code is
'Code of Part of World';

comment on column u_dw_references.lc_geo_parts.part_desc is
'Description of Part of World';

comment on column u_dw_references.lc_geo_parts.localization_id is
'Identificator of Supported References Languages';

alter table u_dw_references.lc_geo_parts
   add constraint CHK_LC_CONTINENTS_CODE check (part_code is null or (part_code = upper(part_code)));

alter table u_dw_references.lc_geo_parts
   add constraint FK_LC_CONTINENTS foreign key (geo_id)
      references u_dw_references.t_geo_parts (geo_id)
      on delete cascade;

alter table u_dw_references.lc_geo_parts
   add constraint FK_LOC2CONTINENTS foreign key (localization_id)
      references u_dw_references.t_localizations (localization_id)
      on delete cascade;
