alter table u_dw_references.lc_geo_regions
   drop constraint FK_LOC2LC_GEO_REGIONS;

drop table u_dw_references.lc_geo_regions cascade constraints;
drop view u_dw_references.w_geo_regions;
drop view u_dw_references.vl_geo_regions;
drop view u_dw_references.cu_geo_regions;
drop trigger u_dw_references.bu_t_geo_system
/

alter table u_dw_references.lc_geo_systems
   drop constraint FK_T_GEO_SYSTEMS2LC_GEO_SYSTEMS


alter table u_dw_references.t_geo_systems
   drop constraint FK_T_GEO_OBJECTS2T_GEO_SYSTEMS
/

alter table u_dw_references.lc_geo_systems
   drop constraint FK_LC_GEO_SYSTEMS;

alter table u_dw_references.lc_geo_systems
   drop constraint FK_LOC2GEO_SYSTEMS;

drop table u_dw_references.lc_geo_systems cascade constraints;
drop view u_dw_references.w_geo_systems;
drop view u_dw_references.vl_geo_systems;
drop view u_dw_references.cu_geo_systems;
drop table u_dw_references.t_geo_types cascade constraints;
drop view u_dw_references.w_geo_types;

drop table u_dw_ext_references.t_ext_geo_structure_iso3166 cascade constraints;
drop table u_dw_ext_references.t_ext_geo_countries2_iso3166 cascade constraints;
DROP TABLE u_dw_ext_references.t_ext_geo_countries_iso3166 CASCADE CONSTRAINTS PURGE;
DROP TABLE u_dw_ext_references.t_ext_cntr2structure_iso3166 CASCADE CONSTRAINTS;
drop table u_dw_ext_references.t_ext_cntr2grouping_iso3166 cascade constraints;
drop table u_dw_ext_references.t_ext_cntr_grouping_iso3166 cascade constraints;
drop table u_dw_ext_references.cls_geo_structure_iso3166 cascade constraints;
drop table u_dw_ext_references.cls_geo_countries2_iso3166 cascade constraints;
drop table u_dw_ext_references.cls_geo_countries_iso3166 cascade constraints;
drop table u_dw_ext_references.cls_cntr2structure_iso3166 cascade constraints;
drop table u_dw_ext_references.cls_cntr2grouping_iso3166 cascade constraints;
drop table u_dw_ext_references.cls_cntr_grouping_iso3166 cascade constraints;

--1
--drop sequence sq_geo_t_id;

ALTER USER u_dw_references quota unlimited on TS_REFERENCES_DATA_01;
ALTER USER u_dw_ext_references quota unlimited on TS_REFERENCES_EXT_DATA_01;

create sequence u_dw_references.sq_geo_t_id;

grant SELECT on u_dw_references.sq_geo_t_id to u_dw_ext_references;

--2

--drop table u_dw_references.t_geo_types cascade constraints;

--==============================================================
-- Table: t_geo_types
--==============================================================
create table u_dw_references.t_geo_types
(
   geo_type_id          NUMBER(22,0)         not null,
   geo_type_code        VARCHAR2(30 CHAR)    not null,
   geo_type_desc        VARCHAR2(200 CHAR)   not null,
   constraint PK_T_GEO_TYPES primary key (geo_type_id)
)
organization index
 tablespace TS_REFERENCES_DATA_01
    pctthreshold 10
 overflow tablespace TS_REFERENCES_DATA_01;

comment on table u_dw_references.t_geo_types is
'Reference store all abstraction types of geograhy objects';

comment on column u_dw_references.t_geo_types.geo_type_id is
'ID of unique Type - abstraction code for Geo Objects ';

comment on column u_dw_references.t_geo_types.geo_type_code is
'Code of Geography Type Objects';

comment on column u_dw_references.t_geo_types.geo_type_desc is
'Description of Geography Type Objects (Not Localizable)';

alter table u_dw_references.t_geo_types
   add constraint CHK_T_GEO_TYPES_GEO_TYPE_CODE check (geo_type_code = upper(geo_type_code));

--3
--drop view u_dw_references.w_geo_types;

--==============================================================
-- View: w_geo_types
--==============================================================
create or replace view u_dw_references.w_geo_types as
SELECT geo_type_id
     , geo_type_code
     , geo_type_desc
  FROM t_geo_types;

 comment on table u_dw_references.w_geo_types is
'Work View: T_GEO_TYPES';

comment on column u_dw_references.w_geo_types.geo_type_id is
'ID of unique Type - abstraction code for Geo Objects ';

comment on column u_dw_references.w_geo_types.geo_type_code is
'Code of Geography Type Objects';

comment on column u_dw_references.w_geo_types.geo_type_desc is
'Description of Geography Type Objects (Not Localizable)';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_geo_types to u_dw_ext_references;


--4
alter session set current_schema=u_dw_references;
INSERT INTO w_geo_types ( geo_type_id
                        , geo_type_code
                        , geo_type_desc )
     VALUES ( 2
            , 'GEO SYSTEM'
            , 'System of Specification' );

INSERT INTO w_geo_types ( geo_type_id
                        , geo_type_code
                        , geo_type_desc )
     VALUES ( 10
            , 'CONTINENT'
            , 'Referene: List of All Continets' );

INSERT INTO w_geo_types ( geo_type_id
                        , geo_type_code
                        , geo_type_desc )
     VALUES ( 11
            , 'REGIONS'
            , 'Referene: List of All Continets - Regions' );

INSERT INTO w_geo_types ( geo_type_id
                        , geo_type_code
                        , geo_type_desc )
     VALUES ( 12
            , 'COUNTRY'
            , 'Referene: List of All Countries' );



INSERT INTO w_geo_types ( geo_type_id
                        , geo_type_code
                        , geo_type_desc )
     VALUES ( 50
            , 'GROUP SYSTEM'
            , 'Grouping system of specification countries' );


INSERT INTO w_geo_types ( geo_type_id
                        , geo_type_code
                        , geo_type_desc )
     VALUES ( 51
            , 'COUNTRY GROUP'
            , 'Referene: List of All Countries Groups' );


INSERT INTO w_geo_types ( geo_type_id
                        , geo_type_code
                        , geo_type_desc )
     VALUES ( 52
            , 'COUNTRY SUB GROUP'
            , 'Referene: List of All Countries Sub Groups' );

Commit;

--Select * from u_dw_ext_references.t_ext_geo_countries2_iso3166;
--5
--alter table u_dw_references.t_geo_objects
--   drop constraint FK_T_GEO_TYPES2T_GEO_OBJECTS;
--
--alter table u_dw_references.t_geo_systems
--   drop constraint FK_T_GEO_OBJECTS2T_GEO_SYSTEMS;
--
--drop index u_dw_references.ui_geo_objects_codes;
--
--drop table u_dw_references.t_geo_objects cascade constraints;

--==============================================================
-- Table: t_geo_objects
--==============================================================
create table u_dw_references.t_geo_objects
(
   geo_id               NUMBER(22,0)         not null,
   geo_type_id          NUMBER(22,0)         not null,
   geo_code_id          NUMBER(22,0)         not null,
   constraint PK_T_GEO_OBJECTS primary key (geo_id)
         using index tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01;

comment on table u_dw_references.t_geo_objects is
'Abstarct Referense store all Geography objects';

comment on column u_dw_references.t_geo_objects.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.t_geo_objects.geo_type_id is
'Code of Geography Type Objects';

comment on column u_dw_references.t_geo_objects.geo_code_id is
'NK: Source ID from source systems';

--==============================================================
-- Index: ui_geo_objects_codes
--==============================================================
create unique index u_dw_references.ui_geo_objects_codes on u_dw_references.t_geo_objects (
   geo_type_id ASC,
   geo_code_id ASC
)
tablespace TS_REFERENCES_IDX_01;

alter table u_dw_references.t_geo_objects
   add constraint FK_T_GEO_TYPES2T_GEO_OBJECTS foreign key (geo_type_id)
      references u_dw_references.t_geo_types (geo_type_id);

--6
--drop view u_dw_references.w_geo_objects;

--==============================================================
-- View: w_geo_objects
--==============================================================
create or replace view u_dw_references.w_geo_objects as
SELECT geo_id
     , geo_type_id
     , geo_code_id
  FROM t_geo_objects;

 comment on table u_dw_references.w_geo_objects is
'Work View: T_GEO_TYPES';

comment on column u_dw_references.w_geo_objects.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.w_geo_objects.geo_type_id is
'ID of unique Type - abstraction code for Geo Objects ';

comment on column u_dw_references.w_geo_objects.geo_code_id is
'NK: Source ID from source systems';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_geo_objects to u_dw_ext_references;


--7

--alter table u_dw_references.t_geo_object_links
--   drop constraint FK_T_GEO_OBJECTS2GEO_LINK_C;
--
--alter table u_dw_references.t_geo_object_links
--   drop constraint FK_T_GEO_OBJECTS2GEO_LINK_P;
--
--drop table u_dw_references.t_geo_object_links cascade constraints;

--==============================================================
-- Table: t_geo_object_links
--==============================================================
create table u_dw_references.t_geo_object_links
(
   parent_geo_id        NUMBER(22,0)         not null,
   child_geo_id         NUMBER(22,0)         not null,
   link_type_id         NUMBER(22,0)         not null,
   constraint PK_T_GEO_OBJECT_LINKS primary key (parent_geo_id, child_geo_id, link_type_id)
         using index
       local
       tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01
 partition by list
 (link_type_id)
    (
        partition
             p_geo_sys2continents
            values (1)
             nocompress,
        partition
             p_continent2regions
            values (2)
             nocompress,
        partition
             p_region2countries
            values (3)
             nocompress,
        partition
             p_grp_sys2groups
            values (4)
             nocompress,
        partition
             p_group2sub_groups
            values (5)
             nocompress,
        partition
             p_sub_groups2countries
            values (6)
             nocompress
    );

comment on table u_dw_references.t_geo_object_links is
'Reference store: All links between Geo Objects';

comment on column u_dw_references.t_geo_object_links.parent_geo_id is
'Parent objects of Geo_IDs';

comment on column u_dw_references.t_geo_object_links.child_geo_id is
'Child objects of Geo_IDs';

comment on column u_dw_references.t_geo_object_links.link_type_id is
'Type of Links, between Geo_IDs';

alter table u_dw_references.t_geo_object_links
   add constraint FK_T_GEO_OBJECTS2GEO_LINK_C foreign key (child_geo_id)
      references u_dw_references.t_geo_objects (geo_id)
      on delete cascade;

alter table u_dw_references.t_geo_object_links
   add constraint FK_T_GEO_OBJECTS2GEO_LINK_P foreign key (parent_geo_id)
      references u_dw_references.t_geo_objects (geo_id)
      on delete cascade;

--8
--drop view u_dw_references.w_geo_object_links;

--==============================================================
-- View: w_geo_object_links
--==============================================================
create or replace view u_dw_references.w_geo_object_links as
SELECT parent_geo_id
     , child_geo_id
     , link_type_id
  FROM t_geo_object_links;

 comment on table u_dw_references.w_geo_object_links is
'Work View: T_GEO_OBJECT_LINKS';

comment on column u_dw_references.w_geo_object_links.parent_geo_id is
'Parent objects of Geo_IDs';

comment on column u_dw_references.w_geo_object_links.child_geo_id is
'Child objects of Geo_IDs';

comment on column u_dw_references.w_geo_object_links.link_type_id is
'Type of Links, between Geo_IDs';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_geo_object_links to u_dw_ext_references;

--10

--drop trigger u_dw_references.bi_t_cntr_group_systems
--/
--
--alter table u_dw_references.t_cntr_group_systems
--   drop constraint FK_T_GEO_OBJECTS2CNTR_G_SYSTEM
--/
--
--drop table u_dw_references.t_cntr_group_systems cascade constraints
--/

--==============================================================
-- Table: t_cntr_group_systems
--==============================================================
create table u_dw_references.t_cntr_group_systems
(
   geo_id               NUMBER(22,0)         not null,
   grp_system_id        NUMBER(22,0)         not null,
   constraint PK_T_CNTR_GROUP_SYSTEMS primary key (geo_id)
)
organization index tablespace TS_REFERENCES_DATA_01
/

comment on table u_dw_references.t_cntr_group_systems is
'Referense store:  Grouping Systems of Countries'
/

comment on column u_dw_references.t_cntr_group_systems.geo_id is
'Unique ID for All Geography objects'
/

comment on column u_dw_references.t_cntr_group_systems.grp_system_id is
'ID Code of Grouping System Specifications'
/

alter table u_dw_references.t_cntr_group_systems
   add constraint FK_T_GEO_OBJECTS2CNTR_G_SYSTEM foreign key (geo_id)
      references u_dw_references.t_geo_objects (geo_id)
      on delete cascade
      deferrable
/


create trigger u_dw_references.bi_t_cntr_group_systems before insert
on u_dw_references.t_cntr_group_systems for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    lc_geo_id      NUMBER := 0;
BEGIN
   IF :new.geo_id IS NOT NULL THEN
      raise_application_error ( -20000
                              , 'Geo_id have to be ''NULL''. New Values will be generated by triger.' );
   END IF;

   INSERT INTO w_geo_objects ( geo_id
                             , geo_type_id
                             , geo_code_id )
        VALUES ( sq_geo_t_id.NEXTVAL
               , 50 --GROUPING SYSTEMS
               , :new.grp_system_id )
     RETURNING geo_id
          INTO :new.geo_id;
--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

--11

--drop view u_dw_references.w_cntr_group_systems;

--==============================================================
-- View: w_cntr_group_systems
--==============================================================
create or replace view u_dw_references.w_cntr_group_systems as
SELECT geo_id
     , grp_system_id
  FROM t_cntr_group_systems;

 comment on table u_dw_references.w_cntr_group_systems is
'Work View: T_GEO_TYPES';

comment on column u_dw_references.w_cntr_group_systems.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.w_cntr_group_systems.grp_system_id is
'ID Code of Grouping System Specifications';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_cntr_group_systems to u_dw_ext_references;

--12

--alter table u_dw_references.lc_cntr_group_systems
--   drop constraint FK_LC_CNTR_GROUP_SYSTEMS;
--
--alter table u_dw_references.lc_cntr_group_systems
--   drop constraint FK_LOC2CNTR_GROUP_SYSTEMS;
--
--drop table u_dw_references.lc_cntr_group_systems cascade constraints;

--==============================================================
-- Table: lc_cntr_group_systems
--==============================================================
create table u_dw_references.lc_cntr_group_systems
(
   geo_id               NUMBER(22,0)         not null,
   grp_system_id        NUMBER(22,0)         not null,
   grp_system_code      VARCHAR2(30 CHAR),
   grp_system_desc      VARCHAR2(200 CHAR)   not null,
   localization_id      NUMBER(22,0)         not null,
   constraint PK_LC_CNTR_GROUP_SYSTEMS primary key (geo_id, localization_id)
         using index tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01;

comment on table u_dw_references.lc_cntr_group_systems is
'Localization table: T_GEO_SYSTEMS';

comment on column u_dw_references.lc_cntr_group_systems.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.lc_cntr_group_systems.grp_system_id is
'ID Code of Grouping System Specifications';

comment on column u_dw_references.lc_cntr_group_systems.grp_system_code is
'Code of Grouping System Specifications';

comment on column u_dw_references.lc_cntr_group_systems.grp_system_desc is
'Description of Grouping System Specifications';

comment on column u_dw_references.lc_cntr_group_systems.localization_id is
'Identificator of Supported References Languages';

alter table u_dw_references.lc_cntr_group_systems
   add constraint CHK_LC_GRP_SYSTEMS_CODE check (grp_system_code is null or (grp_system_code = upper(grp_system_code)));

alter table u_dw_references.lc_cntr_group_systems
   add constraint FK_LC_CNTR_GROUP_SYSTEMS foreign key (geo_id)
      references u_dw_references.t_cntr_group_systems (geo_id)
      on delete cascade;

alter table u_dw_references.lc_cntr_group_systems
   add constraint FK_LOC2CNTR_GROUP_SYSTEMS foreign key (localization_id)
      references u_dw_references.t_localizations (localization_id)
      on delete cascade;

--13

--drop view u_dw_references.vl_cntr_group_systems;

--==============================================================
-- View: vl_cntr_group_systems
--==============================================================
create or replace view u_dw_references.vl_cntr_group_systems as
SELECT geo_id
     , grp_system_id
     , grp_system_code
     , grp_system_desc
     , localization_id
  FROM lc_cntr_group_systems;

 comment on table u_dw_references.vl_cntr_group_systems is
'Localazible View: T_CNTR_GROUP_SYSTEMS';

comment on column u_dw_references.vl_cntr_group_systems.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.vl_cntr_group_systems.grp_system_id is
'ID Code of Grouping System Specifications';

comment on column u_dw_references.vl_cntr_group_systems.grp_system_code is
'Code of Grouping System Specifications';

comment on column u_dw_references.vl_cntr_group_systems.grp_system_desc is
'Description of Grouping System Specifications';

comment on column u_dw_references.vl_cntr_group_systems.localization_id is
'Identificator of Supported References Languages';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.vl_cntr_group_systems to u_dw_ext_references;


--14
--drop view u_dw_references.cu_cntr_group_systems;

--==============================================================
-- View: cu_cntr_group_systems
--==============================================================
create or replace view u_dw_references.cu_cntr_group_systems as
SELECT src.geo_id
     , src.grp_system_id AS grp_system_id
     , NVL ( lc.grp_system_code, '-' ) AS grp_system_code
     , NVL ( lc.grp_system_desc, 'Not Defined' ) AS grp_system_desc
     , NVL ( lc.localization_id, -99 ) AS localization_id
  FROM w_cntr_group_systems src
     , lc_cntr_group_systems lc
 WHERE lc.geo_id(+) = src.geo_id
   AND lc.localization_id(+) = pkg_session_params.get_user_localization_id
with read only;

comment on column u_dw_references.cu_cntr_group_systems.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.cu_cntr_group_systems.grp_system_id is
'ID Code of Grouping System Specifications';

--15
--drop trigger u_dw_references.bi_t_cntr_groups
--/
--
--alter table u_dw_references.t_cntr_groups
--   drop constraint FK_T_GEO_OBJECTS2CNTR_GROUPS
--/
--
--drop table u_dw_references.t_cntr_groups cascade constraints
--/

--==============================================================
-- Table: t_cntr_groups
--==============================================================
create table u_dw_references.t_cntr_groups
(
   geo_id               NUMBER(22,0)         not null,
   group_id             NUMBER(22,0)         not null,
   constraint PK_T_CNTR_GROUPS primary key (geo_id)
)
organization index tablespace TS_REFERENCES_DATA_01
/

comment on table u_dw_references.t_cntr_groups is
'Referense store: Grouping Countries - Groups'
/

comment on column u_dw_references.t_cntr_groups.geo_id is
'Unique ID for All Geography objects'
/

comment on column u_dw_references.t_cntr_groups.group_id is
'ID Code of Countries Groups'
/

alter table u_dw_references.t_cntr_groups
   add constraint FK_T_GEO_OBJECTS2CNTR_GROUPS foreign key (geo_id)
      references u_dw_references.t_geo_objects (geo_id)
      on delete cascade
      deferrable
/


create trigger u_dw_references.bi_t_cntr_groups before insert
on u_dw_references.t_cntr_groups for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    lc_geo_id      NUMBER := 0;
BEGIN
   IF :new.geo_id IS NOT NULL THEN
      raise_application_error ( -20000
                              , 'Geo_id have to be ''NULL''. New Values will be generated by triger.' );
   END IF;

   INSERT INTO w_geo_objects ( geo_id
                             , geo_type_id
                             , geo_code_id )
        VALUES ( sq_geo_t_id.NEXTVAL
               , 51 --Countries Groups
               , :new.group_id )
     RETURNING geo_id
          INTO :new.geo_id;
--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

--16

--drop view u_dw_references.w_cntr_groups;

--==============================================================
-- View: w_cntr_groups
--==============================================================
create or replace view u_dw_references.w_cntr_groups as
SELECT geo_id
     , group_id
  FROM t_cntr_groups;

 comment on table u_dw_references.w_cntr_groups is
'Work View: T_CNTR_GROUPS';

comment on column u_dw_references.w_cntr_groups.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.w_cntr_groups.group_id is
'ID Code of Countries Groups';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_cntr_groups to u_dw_ext_references;

--17

--alter table u_dw_references.lc_cntr_groups
--   drop constraint FK_LC_CNTR_GROUPS;
--
--alter table u_dw_references.lc_cntr_groups
--   drop constraint FK_LOC2CNTR_GROUPS;
--
--drop table u_dw_references.lc_cntr_groups cascade constraints;

--==============================================================
-- Table: lc_cntr_groups
--==============================================================
create table u_dw_references.lc_cntr_groups
(
   geo_id               NUMBER(22,0)         not null,
   group_id             NUMBER(22,0)         not null,
   group_code           VARCHAR2(30 CHAR),
   group_desc           VARCHAR2(200 CHAR)   not null,
   localization_id      NUMBER(22,0)         not null,
   constraint PK_LC_CNTR_GROUPS primary key (geo_id, localization_id)
         using index tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01;

comment on table u_dw_references.lc_cntr_groups is
'Localization table: T_GEO_SYSTEMS';

comment on column u_dw_references.lc_cntr_groups.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.lc_cntr_groups.group_id is
'ID Code of Countries Groups';

comment on column u_dw_references.lc_cntr_groups.group_code is
'Code of Countries Groups';

comment on column u_dw_references.lc_cntr_groups.group_desc is
'Description of Countries Groups';

comment on column u_dw_references.lc_cntr_groups.localization_id is
'Identificator of Supported References Languages';

alter table u_dw_references.lc_cntr_groups
   add constraint CHK_LC_CNTR_GROUPS_CODE check (group_code is null or (group_code = upper(group_code)));

alter table u_dw_references.lc_cntr_groups
   add constraint FK_LC_CNTR_GROUPS foreign key (geo_id)
      references u_dw_references.t_cntr_groups (geo_id)
      on delete cascade;

alter table u_dw_references.lc_cntr_groups
   add constraint FK_LOC2CNTR_GROUPS foreign key (localization_id)
      references u_dw_references.t_localizations (localization_id)
      on delete cascade;

--18

--drop view u_dw_references.vl_cntr_groups;

--==============================================================
-- View: vl_cntr_groups
--==============================================================
create or replace view u_dw_references.vl_cntr_groups as
SELECT geo_id
     , GROUP_ID
     , group_code
     , group_desc
     , localization_id
  FROM lc_cntr_groups;

 comment on table u_dw_references.vl_cntr_groups is
'Localazible View: T_CNTR_GROUPS';

comment on column u_dw_references.vl_cntr_groups.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.vl_cntr_groups.GROUP_ID is
'ID Code of Countries Groups';

comment on column u_dw_references.vl_cntr_groups.group_code is
'Code of Countries Groups';

comment on column u_dw_references.vl_cntr_groups.group_desc is
'Description of Countries Groups';

comment on column u_dw_references.vl_cntr_groups.localization_id is
'Identificator of Supported References Languages';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.vl_cntr_groups to u_dw_ext_references;

--19

--drop view u_dw_references.vl_cntr_groups;

--==============================================================
-- View: vl_cntr_groups
--==============================================================
create or replace view u_dw_references.vl_cntr_groups as
SELECT geo_id
     , GROUP_ID
     , group_code
     , group_desc
     , localization_id
  FROM lc_cntr_groups;

 comment on table u_dw_references.vl_cntr_groups is
'Localazible View: T_CNTR_GROUPS';

comment on column u_dw_references.vl_cntr_groups.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.vl_cntr_groups.GROUP_ID is
'ID Code of Countries Groups';

comment on column u_dw_references.vl_cntr_groups.group_code is
'Code of Countries Groups';

comment on column u_dw_references.vl_cntr_groups.group_desc is
'Description of Countries Groups';

comment on column u_dw_references.vl_cntr_groups.localization_id is
'Identificator of Supported References Languages';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.vl_cntr_groups to u_dw_ext_references;

--20

--drop view u_dw_references.cu_cntr_groups;

--==============================================================
-- View: cu_cntr_groups
--==============================================================
create or replace view u_dw_references.cu_cntr_groups as
SELECT src.geo_id
     , src.group_id AS group_id
     , NVL ( lc.group_code, '-' ) AS group_code
     , NVL ( lc.group_desc, 'Not Defined' ) AS group_desc
     , NVL ( lc.localization_id, -99 ) AS localization_id
  FROM w_cntr_groups src
     , lc_cntr_groups lc
 WHERE lc.geo_id(+) = src.geo_id
   AND lc.localization_id(+) = pkg_session_params.get_user_localization_id
with read only;

comment on column u_dw_references.cu_cntr_groups.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.cu_cntr_groups.group_id is
'ID Code of Countries Groups';

--21

--drop trigger u_dw_references.bi_t_cntr_sub_groups
--/
--
--alter table u_dw_references.t_cntr_sub_groups
--   drop constraint FK_T_GEO_OBJECTS2CNTR_S_GROUPS
--/
--
--drop table u_dw_references.t_cntr_sub_groups cascade constraints
--/

--==============================================================
-- Table: t_cntr_sub_groups
--==============================================================
create table u_dw_references.t_cntr_sub_groups
(
   geo_id               NUMBER(22,0)         not null,
   sub_group_id         NUMBER(22,0)         not null,
   constraint PK_T_CNTR_SUB_GROUPS primary key (geo_id)
)
organization index tablespace TS_REFERENCES_DATA_01
/

comment on table u_dw_references.t_cntr_sub_groups is
'Referense store: Grouping Countries - Sub Groups'
/

comment on column u_dw_references.t_cntr_sub_groups.geo_id is
'Unique ID for All Geography objects'
/

comment on column u_dw_references.t_cntr_sub_groups.sub_group_id is
'ID Code of Countries Sub Groups'
/

alter table u_dw_references.t_cntr_sub_groups
   add constraint FK_T_GEO_OBJECTS2CNTR_S_GROUPS foreign key (geo_id)
      references u_dw_references.t_geo_objects (geo_id)
      on delete cascade
      deferrable
/


create trigger u_dw_references.bi_t_cntr_sub_groups before insert
on u_dw_references.t_cntr_sub_groups for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    lc_geo_id      NUMBER := 0;
BEGIN
   IF :new.geo_id IS NOT NULL THEN
      raise_application_error ( -20000
                              , 'Geo_id have to be ''NULL''. New Values will be generated by triger.' );
   END IF;

   INSERT INTO w_geo_objects ( geo_id
                             , geo_type_id
                             , geo_code_id )
        VALUES ( sq_geo_t_id.NEXTVAL
               , 52 --Countries Sub Groups
               , :new.sub_group_id )
     RETURNING geo_id
          INTO :new.geo_id;
--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

--22

--drop view u_dw_references.w_cntr_sub_groups;

--==============================================================
-- View: w_cntr_sub_groups
--==============================================================
create or replace view u_dw_references.w_cntr_sub_groups as
SELECT geo_id
     , sub_group_id
  FROM t_cntr_sub_groups;

 comment on table u_dw_references.w_cntr_sub_groups is
'Work View: T_CNTR_SUB_GROUPS';

comment on column u_dw_references.w_cntr_sub_groups.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.w_cntr_sub_groups.sub_group_id is
'ID Code of Countries Sub Groups';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_cntr_sub_groups to u_dw_ext_references;

--23

--alter table u_dw_references.lc_cntr_sub_groups
--   drop constraint FK_LC_CNTR_SUB_GROUPS;
--
--alter table u_dw_references.lc_cntr_sub_groups
--   drop constraint FK_LOC2CNTR_SUB_GROUPS;
--
--drop table u_dw_references.lc_cntr_sub_groups cascade constraints;

--==============================================================
-- Table: lc_cntr_sub_groups
--==============================================================
create table u_dw_references.lc_cntr_sub_groups
(
   geo_id               NUMBER(22,0)         not null,
   sub_group_id         NUMBER(22,0)         not null,
   sub_group_code       VARCHAR2(30 CHAR),
   sub_group_desc       VARCHAR2(200 CHAR)   not null,
   localization_id      NUMBER(22,0)         not null,
   constraint PK_LC_CNTR_SUB_GROUPS primary key (geo_id, localization_id)
         using index tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01;

comment on table u_dw_references.lc_cntr_sub_groups is
'Localization table: T_GEO_SYSTEMS';

comment on column u_dw_references.lc_cntr_sub_groups.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.lc_cntr_sub_groups.sub_group_id is
'ID Code of Countries Sub Groups';

comment on column u_dw_references.lc_cntr_sub_groups.sub_group_code is
'Code of Countries Sub Groups';

comment on column u_dw_references.lc_cntr_sub_groups.sub_group_desc is
'Description of Countries Sub Groups';

comment on column u_dw_references.lc_cntr_sub_groups.localization_id is
'Identificator of Supported References Languages';

alter table u_dw_references.lc_cntr_sub_groups
   add constraint CHK_LC_CNTR_SUB_GROUPS_CODE check (sub_group_code is null or (sub_group_code = upper(sub_group_code)));

alter table u_dw_references.lc_cntr_sub_groups
   add constraint FK_LC_CNTR_SUB_GROUPS foreign key (geo_id)
      references u_dw_references.t_cntr_sub_groups (geo_id)
      on delete cascade;

alter table u_dw_references.lc_cntr_sub_groups
   add constraint FK_LOC2CNTR_SUB_GROUPS foreign key (localization_id)
      references u_dw_references.t_localizations (localization_id)
      on delete cascade;


--24

alter table u_dw_references.lc_cntr_sub_groups
   drop constraint FK_LC_CNTR_SUB_GROUPS;

alter table u_dw_references.lc_cntr_sub_groups
   drop constraint FK_LOC2CNTR_SUB_GROUPS;

drop table u_dw_references.lc_cntr_sub_groups cascade constraints;

--==============================================================
-- Table: lc_cntr_sub_groups
--==============================================================

alter table u_dw_references.lc_cntr_sub_groups
   drop constraint FK_LC_CNTR_SUB_GROUPS;
--
alter table u_dw_references.lc_cntr_sub_groups
   drop constraint FK_LOC2CNTR_SUB_GROUPS;
--
drop table u_dw_references.lc_cntr_sub_groups cascade constraints;

--==============================================================
-- Table: lc_cntr_sub_groups
--==============================================================
create table u_dw_references.lc_cntr_sub_groups
(
   geo_id               NUMBER(22,0)         not null,
   sub_group_id         NUMBER(22,0)         not null,
   sub_group_code       VARCHAR2(30 CHAR),
   sub_group_desc       VARCHAR2(200 CHAR)   not null,
   localization_id      NUMBER(22,0)         not null,
   constraint PK_LC_CNTR_SUB_GROUPS primary key (geo_id, localization_id)
         using index tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01;

comment on table u_dw_references.lc_cntr_sub_groups is
'Localization table: T_GEO_SYSTEMS';

comment on column u_dw_references.lc_cntr_sub_groups.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.lc_cntr_sub_groups.sub_group_id is
'ID Code of Countries Sub Groups';

comment on column u_dw_references.lc_cntr_sub_groups.sub_group_code is
'Code of Countries Sub Groups';

comment on column u_dw_references.lc_cntr_sub_groups.sub_group_desc is
'Description of Countries Sub Groups';

comment on column u_dw_references.lc_cntr_sub_groups.localization_id is
'Identificator of Supported References Languages';

alter table u_dw_references.lc_cntr_sub_groups
   add constraint CHK_LC_CNTR_SUB_GROUPS_CODE check (sub_group_code is null or (sub_group_code = upper(sub_group_code)));

alter table u_dw_references.lc_cntr_sub_groups
   add constraint FK_LC_CNTR_SUB_GROUPS foreign key (geo_id)
      references u_dw_references.t_cntr_sub_groups (geo_id)
      on delete cascade;

alter table u_dw_references.lc_cntr_sub_groups
   add constraint FK_LOC2CNTR_SUB_GROUPS foreign key (localization_id)
      references u_dw_references.t_localizations (localization_id)
      on delete cascade;

--25
--drop view u_dw_references.vl_cntr_sub_groups;

--==============================================================
-- View: vl_cntr_sub_groups
--==============================================================
create or replace view u_dw_references.vl_cntr_sub_groups as
SELECT geo_id
     , sub_group_id
     , sub_group_code
     , sub_group_desc
     , localization_id
  FROM lc_cntr_sub_groups;

 comment on table u_dw_references.vl_cntr_sub_groups is
'Localazible View: T_CNTR_GROUPS';

comment on column u_dw_references.vl_cntr_sub_groups.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.vl_cntr_sub_groups.sub_group_id is
'ID Code of Countries Sub Groups';

comment on column u_dw_references.vl_cntr_sub_groups.sub_group_code is
'Code of Countries Sub Groups';

comment on column u_dw_references.vl_cntr_sub_groups.sub_group_desc is
'Description of Countries Sub Groups';

comment on column u_dw_references.vl_cntr_sub_groups.localization_id is
'Identificator of Supported References Languages';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.vl_cntr_sub_groups to u_dw_ext_references;

--26

--drop view u_dw_references.cu_cntr_sub_groups;

--==============================================================
-- View: cu_cntr_sub_groups
--==============================================================
create or replace view u_dw_references.cu_cntr_sub_groups as
SELECT src.geo_id
     , src.sub_group_id AS sub_group_id
     , NVL ( lc.sub_group_code, '-' ) AS sub_group_code
     , NVL ( lc.sub_group_desc, 'Not Defined' ) AS sub_group_desc
     , NVL ( lc.localization_id, -99 ) AS localization_id
  FROM w_cntr_sub_groups src
     , lc_cntr_sub_groups lc
 WHERE lc.geo_id(+) = src.geo_id
   AND lc.localization_id(+) = pkg_session_params.get_user_localization_id
with read only;

comment on column u_dw_references.cu_cntr_sub_groups.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.cu_cntr_sub_groups.sub_group_id is
'ID Code of Countries Sub Groups';

--28

--drop table u_dw_ext_references.t_ext_geo_structure_iso3166 cascade constraints;

--==============================================================
-- Table: t_ext_geo_structure_iso3166
--==============================================================
create table u_dw_ext_references.t_ext_geo_structure_iso3166
(
   child_code           NUMBER(10,0),
   parent_code          NUMBER(10,0),
   structure_desc       VARCHAR2(200 CHAR),
   structure_level      VARCHAR2(200 CHAR)
)
organization external (
    type oracle_loader
    default directory ext_references
    access parameters (records delimited by 0x'0D' nobadfile nodiscardfile nologfile fields terminated by ';' missing field values are NULL (child_code integer external (4), parent_code integer external, structure_desc char(200), structure_level char(200) ) )
    location ('iso_3166_geo_un.tab')
)
reject limit unlimited;

--28

--drop table u_dw_ext_references.t_ext_cntr_grouping_iso3166 cascade constraints;

--==============================================================
-- Table: t_ext_cntr_grouping_iso3166
--==============================================================
create table u_dw_ext_references.t_ext_cntr_grouping_iso3166
(
   child_code           NUMBER(10,0),
   parent_code          NUMBER(10,0),
   group_desc           VARCHAR2(200 CHAR),
   group_level          VARCHAR2(200 CHAR)
)
organization external (
    type oracle_loader
    default directory ext_references
    access parameters (records delimited by 0x'0D0A' nobadfile nodiscardfile nologfile fields terminated by ';' missing field values are NULL ( child_code integer external (4), parent_code integer external, group_desc char(200), group_level char(200) ) )
    location ('iso_3166_groups_un.tab')
)
reject limit unlimited;

--comment on table u_dw_ext_references.t_ext_cntr_grouping_iso3166 is
--'External table for loading - Geography stucture of WORLD';

--29

DROP TABLE u_dw_ext_references.t_ext_geo_countries_iso3166 CASCADE CONSTRAINTS PURGE;

--==============================================================
-- Table: t_ext_geo_countries_iso3166
--==============================================================
CREATE TABLE u_dw_ext_references.t_ext_geo_countries_iso3166
(
   country_id     NUMBER ( 10 )
 , country_desc   VARCHAR2 ( 200 CHAR )
 , country_code   VARCHAR2 ( 3 )
)
ORGANIZATION external (
TYPE oracle_loader
    DEFAULT directory ext_references
    ACCESS parameters (records delimited by 0x'0D0A' nobadfile nodiscardfile nologfile fields terminated by ';' missing field values are NULL (country_id integer external (4), country_desc char(200), country_code char(3) ) )
    location ('iso_3166.tab')
)
reject LIMIT unlimited;

--30

--DROP TABLE u_dw_ext_references.t_ext_cntr2structure_iso3166 CASCADE CONSTRAINTS;

--==============================================================
-- Table: t_ext_cntr2structure_iso3166
--==============================================================
create table u_dw_ext_references.t_ext_cntr2structure_iso3166
(
   country_id           NUMBER(10,0),
   county_desc          VARCHAR2(200 CHAR),
   structure_code       NUMBER(10,0),
   structure_desc       VARCHAR2(200 CHAR)
)
organization external (
    type oracle_loader
    default directory ext_references
    access parameters (records delimited by 0x'0D0A' nobadfile nodiscardfile nologfile fields terminated by ';' missing field values are NULL ( country_id integer external (4), county_desc char(200), structure_code integer external, structure_desc char(200) ) )
    location ('iso_3166_geo_un_contries.tab')
)
reject limit unlimited;

--31

--drop table u_dw_ext_references.t_ext_cntr2grouping_iso3166 cascade constraints;

--==============================================================
-- Table: t_ext_cntr2grouping_iso3166
--==============================================================
create table u_dw_ext_references.t_ext_cntr2grouping_iso3166
(
   country_id           NUMBER(10,0),
   county_desc          VARCHAR2(200 CHAR),
   group_code           NUMBER(10,0),
   group_desc           VARCHAR2(200 CHAR)
)
organization external (
    type oracle_loader
    default directory ext_references
    access parameters (records delimited by 0x'0D0A' nobadfile nodiscardfile nologfile fields terminated by ';' missing field values are NULL ( country_id integer external (4), county_desc char(200), group_code integer external, group_desc char(200) ) )
    location ('iso_3166_groups_un_contries.tab')
)
reject limit unlimited;

comment on table u_dw_ext_references.t_ext_cntr2grouping_iso3166 is
'External table for loading - Countries';


--33

--drop table u_dw_ext_references.t_ext_geo_countries2_iso3166 cascade constraints;

--==============================================================
-- Table: t_ext_geo_countries2_iso3166
--==============================================================
create table u_dw_ext_references.t_ext_geo_countries2_iso3166
(
   country_desc          VARCHAR2(200 CHAR),
   country_code         VARCHAR2(30 CHAR)
)
organization external (
    type oracle_loader
    default directory ext_references
    access parameters (records delimited by 0x'0D0A' nobadfile nodiscardfile nologfile fields terminated by ';' missing field values are NULL (country_desc char(200), country_code char(3) ) )
    location ('iso_3166_2.tab')
)
reject limit unlimited;


Select * from u_dw_ext_references.t_ext_geo_countries2_iso3166;

--35

--drop table u_dw_ext_references.cls_geo_structure_iso3166 cascade constraints;

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

--36

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

--37

--drop table u_dw_ext_references.cls_geo_countries_iso3166 cascade constraints;

--==============================================================
-- Table: cls_geo_countries_iso3166
--==============================================================
create table u_dw_ext_references.cls_geo_countries_iso3166
(
   country_id           NUMBER(10,0),
   country_desc         VARCHAR2(200 CHAR),
   country_code         VARCHAR2(30 CHAR)
)
tablespace TS_REFERENCES_EXT_DATA_01;

comment on table u_dw_ext_references.cls_geo_countries_iso3166 is
'Cleansing table for loading - Countries';

comment on column u_dw_ext_references.cls_geo_countries_iso3166.country_id is
'ISO - Country ID';

comment on column u_dw_ext_references.cls_geo_countries_iso3166.country_desc is
'ISO - Country Name';

comment on column u_dw_ext_references.cls_geo_countries_iso3166.country_code is
'ISO - Alpha Name 3';

alter table u_dw_ext_references.cls_geo_countries_iso3166
   add constraint CHK_CLS_GEO_COUNTRY_CODE check (country_code is null or (country_code = upper(country_code)));

--38

--drop table u_dw_ext_references.cls_cntr2structure_iso3166 cascade constraints;

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


--39

--drop table u_dw_ext_references.cls_cntr2grouping_iso3166 cascade constraints;

--==============================================================
-- Table: cls_cntr2grouping_iso3166
--==============================================================
create table u_dw_ext_references.cls_cntr2grouping_iso3166
(
   country_id           NUMBER(10,0),
   county_desc          VARCHAR2(200 CHAR),
   group_code           NUMBER(10,0),
   group_desc           VARCHAR2(200 CHAR)
)
tablespace TS_REFERENCES_EXT_DATA_01;

comment on table u_dw_ext_references.cls_cntr2grouping_iso3166 is
'Cleansing table for loading - Links Countries to GeoLocation Sructure world Dividing  (USA standart)';

comment on column u_dw_ext_references.cls_cntr2grouping_iso3166.country_id is
'ISO - Country ID';

comment on column u_dw_ext_references.cls_cntr2grouping_iso3166.county_desc is
'ISO - Country Desc';

comment on column u_dw_ext_references.cls_cntr2grouping_iso3166.group_code is
'Code of Group Element';

--40

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


comment on column u_dw_ext_references.cls_cntr2grouping_iso3166.group_desc is
'Description of Group Element';

--41

drop trigger u_dw_references.bu_t_geo_system
/

alter table u_dw_references.lc_geo_systems
   drop constraint FK_T_GEO_SYSTEMS2LC_GEO_SYSTEMS
/

alter table u_dw_references.t_geo_systems
   drop constraint FK_T_GEO_OBJECTS2T_GEO_SYSTEMS
/

drop table u_dw_references.t_geo_systems cascade constraints
/

--==============================================================
-- Table: t_geo_systems
--==============================================================
create table u_dw_references.t_geo_systems
(
   geo_id               NUMBER(22,0)         not null,
   geo_system_id        NUMBER(22,0)         not null,
   constraint PK_T_GEO_SYSTEMS primary key (geo_id)
)
organization index tablespace TS_REFERENCES_DATA_01
/

comment on table u_dw_references.t_geo_systems is
'Abstarct Referense store all Geography objects'
/

comment on column u_dw_references.t_geo_systems.geo_id is
'Unique ID for All Geography objects'
/

comment on column u_dw_references.t_geo_systems.geo_system_id is
'ID Code of Geography System Specifications'
/

alter table u_dw_references.t_geo_systems
   add constraint FK_T_GEO_OBJECTS2T_GEO_SYSTEMS foreign key (geo_id)
      references u_dw_references.t_geo_objects (geo_id)
      on delete cascade
      deferrable
/


create trigger u_dw_references.bu_t_geo_system before insert
on u_dw_references.t_geo_systems for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    lc_geo_id      NUMBER := 0;
BEGIN
   IF :new.geo_id IS NOT NULL THEN
      raise_application_error ( -20000
                              , 'Geo_id have to be ''NULL''. New Values will be generated by triger.' );
   END IF;

   INSERT INTO w_geo_objects ( geo_id
                             , geo_type_id
                             , geo_code_id )
        VALUES ( sq_geo_t_id.NEXTVAL
               , 2 --SYSTEMS
               , :new.geo_system_id )
     RETURNING geo_id
          INTO :new.geo_id;
--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

SElect * from w_geo_types;

--42

--drop view u_dw_references.w_geo_systems;

--==============================================================
-- View: w_geo_systems
--==============================================================
create or replace view u_dw_references.w_geo_systems as
SELECT geo_id
     , geo_system_id
  FROM t_geo_systems;

 comment on table u_dw_references.w_geo_systems is
'Work View: T_GEO_SYSTEMS';

comment on column u_dw_references.w_geo_systems.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.w_geo_systems.geo_system_id is
'ID Code of Geography System Specifications';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_geo_systems to u_dw_ext_references;

--43

--alter table u_dw_references.lc_geo_systems
--   drop constraint FK_LC_GEO_SYSTEMS;
--
--alter table u_dw_references.lc_geo_systems
--   drop constraint FK_LOC2GEO_SYSTEMS;
--
--drop table u_dw_references.lc_geo_systems cascade constraints;

--==============================================================
-- Table: lc_geo_systems
--==============================================================
create table u_dw_references.lc_geo_systems
(
   geo_id               NUMBER(22,0)         not null,
   geo_system_id        NUMBER(22,0)         not null,
   geo_system_code      VARCHAR2(30 CHAR),
   geo_system_desc      VARCHAR2(200 CHAR)   not null,
   localization_id      NUMBER(22,0)         not null,
   constraint PK_LC_GEO_SYSTEMS primary key (geo_id, localization_id)
         using index tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01;

comment on table u_dw_references.lc_geo_systems is
'Localization table: T_GEO_SYSTEMS';

comment on column u_dw_references.lc_geo_systems.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.lc_geo_systems.geo_system_id is
'ID Code of Geography System Specifications';

comment on column u_dw_references.lc_geo_systems.geo_system_code is
'Code of Geography System Specifications';

comment on column u_dw_references.lc_geo_systems.geo_system_desc is
'Description of Geography System Specifications';

comment on column u_dw_references.lc_geo_systems.localization_id is
'Identificator of Supported References Languages';

alter table u_dw_references.lc_geo_systems
   add constraint CHK_LC_GEO_SYSTEMS_CODE check (geo_system_code is null or (geo_system_code = upper(geo_system_code)));

alter table u_dw_references.lc_geo_systems
   add constraint FK_LC_GEO_SYSTEMS foreign key (geo_id)
      references u_dw_references.t_geo_systems (geo_id)
      on delete cascade;

alter table u_dw_references.lc_geo_systems
   add constraint FK_LOC2GEO_SYSTEMS foreign key (localization_id)
      references u_dw_references.t_localizations (localization_id)
      on delete cascade;

--44

--drop view u_dw_references.vl_geo_systems;

--==============================================================
-- View: vl_geo_systems
--==============================================================
create or replace view u_dw_references.vl_geo_systems as
SELECT geo_id
     , geo_system_id
     , geo_system_code
     , geo_system_desc
     , localization_id
  FROM lc_geo_systems;

 comment on table u_dw_references.vl_geo_systems is
'Localazible View: T_GEO_SYSTEMS';

comment on column u_dw_references.vl_geo_systems.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.vl_geo_systems.geo_system_id is
'ID Code of Geography System Specifications';

comment on column u_dw_references.vl_geo_systems.geo_system_code is
'Code of Geography System Specifications';

comment on column u_dw_references.vl_geo_systems.geo_system_desc is
'Description of Geography System Specifications';

comment on column u_dw_references.vl_geo_systems.localization_id is
'Identificator of Supported References Languages';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.vl_geo_systems to u_dw_ext_references;

--45

--drop view u_dw_references.cu_geo_systems;

--==============================================================
-- View: cu_geo_systems
--==============================================================
create or replace view u_dw_references.cu_geo_systems as
SELECT src.geo_id
     , src.geo_system_id AS src_geo_system_id
     , NVL ( lc.geo_system_code, '-' ) AS geo_system_code
     , NVL ( lc.geo_system_desc, 'Not Defined' ) AS geo_system_desc
     , NVL ( lc.localization_id, -99 ) AS localization_id
  FROM w_geo_systems src
     , lc_geo_systems lc
 WHERE lc.geo_id(+) = src.geo_id
   AND lc.localization_id(+) = pkg_session_params.get_user_localization_id
with read only;

comment on column u_dw_references.cu_geo_systems.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.cu_geo_systems.src_geo_system_id is
'ID Code of Geography System Specifications';

--46

--drop trigger u_dw_references.bi_t_geo_parts
--/

--alter table u_dw_references.lc_geo_parts
 --  drop constraint FK_LC_CONTINENTS
--/

--alter table u_dw_references.t_geo_parts
 --  drop constraint FK_T_GEO_OBJECTS2PARTS
--/

--drop table u_dw_references.t_geo_parts cascade constraints
--/
--
--==============================================================
-- Table: t_geo_parts
--==============================================================
create table u_dw_references.t_geo_parts
(
   geo_id               NUMBER(22,0)         not null,
   part_id              NUMBER(22,0)         not null,
   constraint PK_T_GEO_PARTS primary key (geo_id)
)
organization index tablespace TS_REFERENCES_DATA_01
/

comment on table u_dw_references.t_geo_parts is
'Referense store: Geographical Parts of Worlds'
/

comment on column u_dw_references.t_geo_parts.geo_id is
'Unique ID for All Geography objects'
/

comment on column u_dw_references.t_geo_parts.part_id is
'ID Code of Geographical Part of World'
/

alter table u_dw_references.t_geo_parts
   add constraint FK_T_GEO_OBJECTS2PARTS foreign key (geo_id)
      references u_dw_references.t_geo_objects (geo_id)
      on delete cascade
      deferrable
/


create trigger u_dw_references.bi_t_geo_parts before insert
on u_dw_references.t_geo_parts for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    lc_geo_id      NUMBER := 0;
BEGIN
   IF :new.geo_id IS NOT NULL THEN
      raise_application_error ( -20000
                              , 'Geo_id have to be ''NULL''. New Values will be generated by triger.' );
   END IF;

   INSERT INTO w_geo_objects ( geo_id
                             , geo_type_id
                             , geo_code_id )
        VALUES ( sq_geo_t_id.NEXTVAL
               , 10 --Part of World
               , :new.part_id )
     RETURNING geo_id
          INTO :new.geo_id;
--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

--47

--drop view u_dw_references.w_geo_parts;

--==============================================================
-- View: w_geo_parts
--==============================================================
create or replace view u_dw_references.w_geo_parts as
select
   geo_id,
   part_id
from
   t_geo_parts;

 comment on table u_dw_references.w_geo_parts is
'Work View: T_GEO_PARTS';

comment on column u_dw_references.w_geo_parts.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.w_geo_parts.part_id is
'ID Code of Geographical Part of World';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_geo_parts to u_dw_ext_references;

--48

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

--49

--drop view u_dw_references.vl_geo_parts;

--==============================================================
-- View: vl_geo_parts
--==============================================================
create or replace view u_dw_references.vl_geo_parts as
select
   geo_id,
   part_id,
   part_code,
   part_desc,
   localization_id
from
   lc_geo_parts;

 comment on table u_dw_references.vl_geo_parts is
'Localazible View: T_CONTINENTS';

comment on column u_dw_references.vl_geo_parts.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.vl_geo_parts.part_id is
'ID Code of Part of World';

comment on column u_dw_references.vl_geo_parts.part_code is
'Code of Part of World';

comment on column u_dw_references.vl_geo_parts.part_desc is
'Description of Part of World';

comment on column u_dw_references.vl_geo_parts.localization_id is
'Identificator of Supported References Languages';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.vl_geo_parts to u_dw_ext_references;


--50

--drop view u_dw_references.cu_geo_parts;

--==============================================================
-- View: cu_geo_parts
--==============================================================
create or replace view u_dw_references.cu_geo_parts as
select
   src.geo_id,
   src.part_id as part_id,
   NVL( lc.part_code, '-' ) as part_code,
   NVL( lc.part_desc, 'Not Defined' ) as part_desc,
   NVL( lc.localization_id, -99 ) as localization_id
from
   w_geo_parts src,
   lc_geo_parts lc
where
   lc.geo_id(+) = src.geo_id
   AND lc.localization_id(+) = pkg_session_params.get_user_localization_id

with read only;

comment on column u_dw_references.cu_geo_parts.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.cu_geo_parts.part_id is
'ID Code of Geographical Part of World';

--51

--drop trigger u_dw_references.bu_t_regions
--/
--
--alter table u_dw_references.lc_geo_regions
--   drop constraint FK_LC_GEO_REGIONS
--/
--
--alter table u_dw_references.t_geo_regions
--   drop constraint FK_T_GEO_OBJECTS2GEO_REGIONS
--/
--
--drop table u_dw_references.t_geo_regions cascade constraints
--/

--==============================================================
-- Table: t_geo_regions
--==============================================================
create table u_dw_references.t_geo_regions
(
   geo_id               NUMBER(22,0)         not null,
   region_id            NUMBER(22,0)         not null,
   constraint PK_T_GEO_REGIONS primary key (geo_id)
)
organization index tablespace TS_REFERENCES_DATA_01
/

comment on table u_dw_references.t_geo_regions is
'Referense store: Geographical Continents - Regions'
/

comment on column u_dw_references.t_geo_regions.geo_id is
'Unique ID for All Geography objects'
/

comment on column u_dw_references.t_geo_regions.region_id is
'ID Code of Geographical Continent - Regions'
/

alter table u_dw_references.t_geo_regions
   add constraint FK_T_GEO_OBJECTS2GEO_REGIONS foreign key (geo_id)
      references u_dw_references.t_geo_objects (geo_id)
      on delete cascade
      deferrable
/


create trigger u_dw_references.bu_t_regions before insert
on u_dw_references.t_geo_regions for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    lc_geo_id      NUMBER := 0;
BEGIN
   IF :new.geo_id IS NOT NULL THEN
      raise_application_error ( -20000
                              , 'Geo_id have to be ''NULL''. New Values will be generated by triger.' );
   END IF;

   INSERT INTO w_geo_objects ( geo_id
                             , geo_type_id
                             , geo_code_id )
        VALUES ( sq_geo_t_id.NEXTVAL
               , 11 --Regions
               , :new.region_id )
     RETURNING geo_id
          INTO :new.geo_id;
--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

--53

--drop view u_dw_references.w_geo_regions;

--==============================================================
-- View: w_geo_regions
--==============================================================
create or replace view u_dw_references.w_geo_regions as
select
   geo_id,
   region_id
from
   t_geo_regions;

 comment on table u_dw_references.w_geo_regions is
'Work View: T_CONTINENTS';

comment on column u_dw_references.w_geo_regions.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.w_geo_regions.region_id is
'ID Code of Geographical Continent - Regions';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_geo_regions to u_dw_ext_references;

--55

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

--56

--drop view u_dw_references.vl_geo_regions;

--==============================================================
-- View: vl_geo_regions
--==============================================================
create or replace view u_dw_references.vl_geo_regions as
SELECT geo_id
     , region_id
     , region_code
     , region_desc
     , localization_id
  FROM lc_geo_regions;

 comment on table u_dw_references.vl_geo_regions is
'Localazible View: T_CONTINENTS';

comment on column u_dw_references.vl_geo_regions.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.vl_geo_regions.region_id is
'ID Code of Geographical Continent - Regions';

comment on column u_dw_references.vl_geo_regions.region_code is
'Code of Continent Regions';

comment on column u_dw_references.vl_geo_regions.region_desc is
'Description of Continent Regions';

comment on column u_dw_references.vl_geo_regions.localization_id is
'Identificator of Supported References Languages';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.vl_geo_regions to u_dw_ext_references;



--57

--drop view u_dw_references.cu_geo_regions;

--==============================================================
-- View: cu_geo_regions
--==============================================================
create or replace view u_dw_references.cu_geo_regions as
SELECT src.geo_id
     , src.region_id AS src_continent_id
     , NVL ( lc.region_code, '-' ) AS region_code
     , NVL ( lc.region_desc, 'Not Defined' ) AS region_desc
     , NVL ( lc.localization_id, -99 ) AS localization_id
  FROM w_geo_regions src
     , lc_geo_regions lc
 WHERE lc.geo_id(+) = src.geo_id
   AND lc.localization_id(+) = pkg_session_params.get_user_localization_id
with read only;

comment on column u_dw_references.cu_geo_regions.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.cu_geo_regions.src_continent_id is
'ID Code of Geographical Continent - Regions';

--58

--drop trigger u_dw_references.bu_t_countries
--/
--
--alter table u_dw_references.lc_countries
--   drop constraint FK_LC_COUNTRIES
--/
--
--alter table u_dw_references.t_countries
--   drop constraint FK_T_GEO_OBJECTS2COUNTRIES
--/
--
--drop table u_dw_references.t_countries cascade constraints
--/

--==============================================================
-- Table: t_countries
--==============================================================
create table u_dw_references.t_countries
(
   geo_id               NUMBER(22,0)         not null,
   country_id           NUMBER(22,0)         not null,
   constraint PK_T_COUNTRIES primary key (geo_id)
)
organization index tablespace TS_REFERENCES_DATA_01
/

comment on table u_dw_references.t_countries is
'Referense store: Geographical Countries'
/

comment on column u_dw_references.t_countries.geo_id is
'Unique ID for All Geography objects'
/

comment on column u_dw_references.t_countries.country_id is
'ID Code of Country'
/

alter table u_dw_references.t_countries
   add constraint FK_T_GEO_OBJECTS2COUNTRIES foreign key (geo_id)
      references u_dw_references.t_geo_objects (geo_id)
      on delete cascade
      deferrable
/


create trigger u_dw_references.bu_t_countries before insert
on u_dw_references.t_countries for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    lc_geo_id      NUMBER := 0;
BEGIN
   IF :new.geo_id IS NOT NULL THEN
      raise_application_error ( -20000
                              , 'Geo_id have to be ''NULL''. New Values will be generated by triger.' );
   END IF;

   INSERT INTO w_geo_objects ( geo_id
                             , geo_type_id
                             , geo_code_id )
        VALUES ( sq_geo_t_id.NEXTVAL
               , 12 --Country
               , :new.country_id )
     RETURNING geo_id
          INTO :new.geo_id;
--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

--59

--drop view u_dw_references.w_countries;

--==============================================================
-- View: w_countries
--==============================================================
CREATE OR REPLACE VIEW u_dw_references.w_countries
AS
   SELECT geo_id
        , country_id
     FROM t_countries;

COMMENT ON TABLE u_dw_references.w_countries IS
'Work View: T_COUNTRIES';

COMMENT ON COLUMN u_dw_references.w_countries.geo_id IS
'Unique ID for All Geography objects';

COMMENT ON COLUMN u_dw_references.w_countries.country_id IS
'ID Code of Country';

GRANT DELETE,INSERT,UPDATE,SELECT ON u_dw_references.w_countries TO u_dw_ext_references;


--60

--alter table u_dw_references.lc_countries
--   drop constraint FK_LC_COUNTRIES;
--
--alter table u_dw_references.lc_countries
--   drop constraint FK_LOC2COUNTRIES;
--
--drop table u_dw_references.lc_countries cascade constraints;

--==============================================================
-- Table: lc_countries
--==============================================================
create table u_dw_references.lc_countries
(
   geo_id               NUMBER(22,0)         not null,
   country_id           NUMBER(22,0)         not null,
   country_code_a2      VARCHAR2(30 CHAR),
   country_code_a3      VARCHAR2(30 CHAR),
   country_desc         VARCHAR2(200 CHAR)   not null,
   localization_id      NUMBER(22,0)         not null,
   constraint PK_LC_COUNTRIES primary key (geo_id, localization_id)
         using index tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01;

comment on table u_dw_references.lc_countries is
'Localization table: T_COUNTRIES';

comment on column u_dw_references.lc_countries.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.lc_countries.country_id is
'ID Code of Country';

comment on column u_dw_references.lc_countries.country_code_a2 is
'Code of Countries - ALPHA 2';

comment on column u_dw_references.lc_countries.country_code_a3 is
'Code of Countries - ALPHA 3';

comment on column u_dw_references.lc_countries.country_desc is
'Description of Countries';

comment on column u_dw_references.lc_countries.localization_id is
'Identificator of Supported References Languages';

alter table u_dw_references.lc_countries
   add constraint CHK_LC_COUNTRIES_CODE_A2 check (country_code_a2 is null or (country_code_a2 = upper(country_code_a2)));

alter table u_dw_references.lc_countries
   add constraint CHK_LC_COUNTRIES_CODE_A3 check (country_code_a3 is null or (country_code_a3 = upper(country_code_a3)));

alter table u_dw_references.lc_countries
   add constraint FK_LC_COUNTRIES foreign key (geo_id)
      references u_dw_references.t_countries (geo_id)
      on delete cascade;

alter table u_dw_references.lc_countries
   add constraint FK_LOC2COUNTRIES foreign key (localization_id)
      references u_dw_references.t_localizations (localization_id)
      on delete cascade;

--61

--drop view u_dw_references.vl_countries;

--==============================================================
-- View: vl_countries
--==============================================================
create or replace view u_dw_references.vl_countries as
SELECT geo_id
     , country_id
     , country_code_a2
     , country_code_a3
     , country_desc
     , localization_id
  FROM lc_countries;

 comment on table u_dw_references.vl_countries is
'Localazible View: T_CONTINENTS';

comment on column u_dw_references.vl_countries.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.vl_countries.country_id is
'ID Code of Country';

comment on column u_dw_references.vl_countries.country_code_a2 is
'Code of Countries - ALPHA 2';

comment on column u_dw_references.vl_countries.country_code_a3 is
'Code of Countries - ALPHA 3';

comment on column u_dw_references.vl_countries.country_desc is
'Description of Countries';

comment on column u_dw_references.vl_countries.localization_id is
'Identificator of Supported References Languages';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.vl_countries to u_dw_ext_references;

--62

--drop view u_dw_references.cu_countries;

--==============================================================
-- View: cu_countries
--==============================================================
create or replace view u_dw_references.cu_countries as
SELECT src.geo_id
     , src.country_id AS country_id
     , NVL ( lc.country_code_a2, '-' ) AS country_code_a2
     , NVL ( lc.country_code_a3, '-' ) AS country_code_a3
     , NVL ( lc.country_desc, 'Not Defined' ) AS region_desc
     , NVL ( lc.localization_id, -99 ) AS localization_id
  FROM w_countries src
     , lc_countries lc
 WHERE lc.geo_id(+) = src.geo_id
   AND lc.localization_id(+) = pkg_session_params.get_user_localization_id
with read only;

comment on column u_dw_references.cu_countries.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.cu_countries.country_id is
'ID Code of Country';

--63

drop table u_dw_references.t_address_types cascade constraints;

/*==============================================================*/
/* Table: t_address_types                                     */
/*==============================================================*/
create table u_dw_references.t_address_types
(
   adress_type_id     NUMBER(22,0)         not null,
   adress_type_code   VARCHAR2(30 CHAR)    not null,
   adress_type_desc   VARCHAR2(200 CHAR)   not null,
   constraint PK_T_ADDRESS_TYPES primary key (adress_type_id)
         using index tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01;

alter table u_dw_references.t_address_types
   add constraint CKC_ADRESS_TYPE_CODE_T_ADDRES check (adress_type_code = upper(adress_type_code));

--alter table u_dw_references.t_addresses
--   drop constraint FK_Adress2ADRS_Types;

--drop table u_dw_references.t_addresses cascade constraints;

/*==============================================================*/
/* Table: t_addresses                                         */
/*==============================================================*/

alter session set current_schema=u_dw_references;
ALTER USER u_dw_references quota unlimited on TS_DW_DATA_01;
create table u_dw_references.t_addresses
(
   adress_id          NUMBER(22,0)         not null,
   adress_type_id     NUMBER(22,0)         not null,
   country_id         NUMBER(22,0)         not null,
   zip                VARCHAR(200)         not null,
   state_id           NUMBER(22,0)         not null,
   district_id        NUMBER(22,0)         not null,
   city_id            NUMBER(22,0)         not null,
   street_id          NUMBER(22,0)         not null,
   building_num       VARCHAR2(30 CHAR)    not null,
   apartment_num      VARCHAR2(30 CHAR),
   constraint PK_T_ADDRESSES primary key (adress_id)
         using index tablespace TS_DW_IDX_01
)
tablespace TS_DW_DATA_01;

comment on table u_dw_references.t_addresses is
'Catalogue of System Adresses';

alter table u_dw_references.t_addresses
   add constraint CKC_BUILDING_NUM_T_ADDRES check (building_num = upper(building_num));

alter table u_dw_references.t_addresses
   add constraint CKC_APARTMENT_NUM_T_ADDRES check (apartment_num is null or (apartment_num = upper(apartment_num)));

alter table u_dw_references.t_addresses
   add constraint FK_Adress2ADRS_Types foreign key (adress_type_id)
      references u_dw_references.t_address_types (adress_type_id)
      on delete cascade;

--70

CREATE OR REPLACE PACKAGE pkg_load_ext_ref_geography
-- Package Reload Data From External Sources to DataBase - Geography objects
--
AS
   -- Extract Data from external source = External Table
   -- Load All Countries from ISO 3166 Alpha 3
   PROCEDURE load_cls_languages_alpha3;

   -- Extract Data from external source = External Table
   -- Load All Countries from ISO 3166 Alpha 2
   PROCEDURE load_cls_languages_alpha2;

   -- Load All Countries from ISO 3166 to References
   PROCEDURE load_ref_geo_countries;

   -- Extract Data from external source = External Table
   -- Load All Geography objects from ISO 3166
   PROCEDURE load_cls_geo_structure;

   -- Extract Data from external source = External Table
   -- Load All Geography objects from ISO 3166
   PROCEDURE load_cls_geo_structure2cntr;

   -- Load Geography System from ISO 3166 to References
   PROCEDURE load_ref_geo_systems;

   -- Load Geography Continents from ISO 3166 to References
   PROCEDURE load_ref_geo_parts;

   -- Load Geography Regions from ISO 3166 to References
   PROCEDURE load_ref_geo_regions;

   -- Extract Data from external source = External Table
   -- Load All Geography objects - Groups from ISO 3166
   PROCEDURE load_cls_countries_grouping;

     -- Extract Data from external source = External Table
   -- Load All Geography objects - Groups Links to Countries from ISO 3166
   PROCEDURE load_cls_countries2groups;

    -- Load Countries Grouping System from ISO 3166 to References
   PROCEDURE load_ref_cntr_group_systems;

    -- Load Countries Groups from ISO 3166 to References
   PROCEDURE load_ref_cntr_groups;

    -- Load Countries Groups from ISO 3166 to References
   PROCEDURE load_ref_cntr_sub_groups;

    -- Load Countries links to Geography from ISO 3166 to References
   PROCEDURE load_lnk_geo_structure;

   -- Load Countries links to Geography Regions from ISO 3166 to References
   PROCEDURE load_lnk_geo_countries;

   -- Load Countries links to Grouping Systems from ISO 3166 to References
   PROCEDURE load_lnk_cntr_grouping;

   -- Load Countries links to Groups from ISO 3166 to References
   PROCEDURE load_lnk_cntr2groups;

END pkg_load_ext_ref_geography;
/

--71

alter session set current_schema=u_dw_ext_references;

CREATE OR REPLACE PACKAGE BODY pkg_load_ext_ref_geography
AS
   -- Extract Data from external source = External Table
   -- Load All Countries from ISO 3166 Alpha 3
   PROCEDURE load_cls_languages_alpha3
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_GEO_COUNTRIES_ISO3166';

      --Extract data
      INSERT INTO cls_geo_countries_iso3166 ( country_id
                                            , country_desc
                                            , country_code )
         SELECT country_id
              , country_desc
              , country_code
           FROM t_ext_geo_countries_iso3166;

      --Commit Data
      COMMIT;
   END load_cls_languages_alpha3;

   -- Extract Data from external source = External Table
   -- Load All Countries from ISO 3166 Alpha 3
   PROCEDURE load_cls_languages_alpha2
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_GEO_COUNTRIES2_ISO3166';

      --Extract data
      INSERT INTO cls_geo_countries2_iso3166 ( country_desc
                                             , country_code )
         SELECT country_desc
              , country_code
           FROM t_ext_geo_countries2_iso3166;

      --Commit Data
      COMMIT;
   END load_cls_languages_alpha2;

   -- Load All Countries from ISO 3166 to References
   PROCEDURE load_ref_geo_countries
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_references.w_countries trg
            WHERE trg.country_id NOT IN (     SELECT DISTINCT country_id FROM cls_geo_countries_iso3166);

      --Merge Source data
      MERGE INTO u_dw_references.w_countries trg
           USING (  SELECT DISTINCT country_id
                      FROM cls_geo_countries_iso3166
                  ORDER BY country_id) cls
              ON ( trg.country_id = cls.country_id )
      WHEN NOT MATCHED THEN
         INSERT            ( country_id )
             VALUES ( cls.country_id );

      --Merge Source Localizable Data
      MERGE INTO u_dw_references.vl_countries trg
           USING (  SELECT MAX ( geo_id ) AS geo_id
                         , MAX ( country_id ) AS country_id
                         , country_desc
                         , MAX ( country_code_alpha3 ) AS country_code_alpha3
                         , MAX ( country_code_alpha2 ) AS country_code_alpha2
                         , 1 AS localization_id
                      FROM (SELECT trg.geo_id
                                 , trg.country_id
                                 , trg.country_desc
                                 , trg.country_code_alpha3
                                 , lkp.country_code_alpha2
                                 , trg.look_country_desc AS target_desc
                                 , lkp.look_country_desc AS lookup_desc
                              FROM (SELECT trg.geo_id
                                         , trg.country_id
                                         , src.country_desc
                                         , UPPER ( src.country_desc ) || '%' look_country_desc
                                         , src.country_code AS country_code_alpha3
                                      FROM u_dw_references.w_countries trg
                                         , cls_geo_countries_iso3166 src
                                     WHERE src.country_id(+) = trg.country_id) trg
                                 , (SELECT NULL AS geo_id
                                         , NULL AS country_id
                                         , NULL AS country_desc
                                         , src2.country_desc AS look_country_desc
                                         , NULL AS country_code_alpha3
                                         , src2.country_code AS country_code_alpha2
                                      FROM cls_geo_countries2_iso3166 src2) lkp
                             WHERE lkp.look_country_desc(+) LIKE trg.look_country_desc
                            UNION ALL
                            SELECT trg.geo_id
                                 , trg.country_id
                                 , trg.country_desc
                                 , trg.country_code_alpha3
                                 , lkp.country_code_alpha2
                                 , trg.look_country_desc AS target_desc
                                 , lkp.look_country_desc AS lookup_desc
                              FROM (SELECT trg.geo_id
                                         , trg.country_id
                                         , src.country_desc
                                         , UPPER ( src.country_desc ) look_country_desc
                                         , src.country_code AS country_code_alpha3
                                      FROM u_dw_references.w_countries trg
                                         , cls_geo_countries_iso3166 src
                                     WHERE src.country_id(+) = trg.country_id) trg
                                 , (SELECT NULL AS geo_id
                                         , NULL AS country_id
                                         , NULL AS country_desc
                                         , SUBSTR ( src2.country_desc
                                                  , 1
                                                  , DECODE ( INSTR ( src2.country_desc
                                                                   , ',' )
                                                           , 0, 201
                                                           , INSTR ( src2.country_desc
                                                                   , ',' ) )
                                                    - 1 )
                                           || '%'
                                              AS look_country_desc
                                         , NULL AS country_code_alpha3
                                         , src2.country_code AS country_code_alpha2
                                      FROM cls_geo_countries2_iso3166 src2) lkp
                             WHERE trg.look_country_desc(+) LIKE lkp.look_country_desc)
                     WHERE country_id IS NOT NULL
                  GROUP BY country_desc
                  ORDER BY country_id) cls
              ON ( trg.country_id = cls.country_id
              AND trg.localization_id = cls.localization_id )
      WHEN NOT MATCHED THEN
         INSERT            ( geo_id
                           , country_id
                           , country_code_a2
                           , country_code_a3
                           , country_desc
                           , localization_id )
             VALUES ( cls.geo_id
                    , cls.country_id
                    , cls.country_code_alpha2
                    , cls.country_code_alpha3
                    , cls.country_desc
                    , cls.localization_id )
      WHEN MATCHED THEN
         UPDATE SET trg.country_desc = cls.country_desc
                  , trg.country_code_a2 = cls.country_code_alpha2
                  , trg.country_code_a3 = cls.country_code_alpha3;

      --Commit Resulst
      COMMIT;
   END load_ref_geo_countries;

   -- Extract Data from external source = External Table
   -- Load All Geography objects - Structures from ISO 3166
   PROCEDURE load_cls_geo_structure
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_GEO_STRUCTURE_ISO3166';

      --Extract data
      INSERT INTO cls_geo_structure_iso3166 ( child_code
                                            , parent_code
                                            , structure_desc
                                            , structure_level )
         SELECT child_code
              , parent_code
              , structure_desc
              , structure_level
           FROM t_ext_geo_structure_iso3166;

      --Commit Data
      COMMIT;
   END load_cls_geo_structure;

   -- Extract Data from external source = External Table
   -- Load All Geography objects - Contries from ISO 3166
   PROCEDURE load_cls_geo_structure2cntr
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_CNTR2STRUCTURE_ISO3166';

      --Extract data
      INSERT INTO cls_cntr2structure_iso3166 ( country_id
                                             , county_desc
                                             , structure_code
                                             , structure_desc )
         SELECT country_id
              , county_desc
              , structure_code
              , structure_desc
           FROM t_ext_cntr2structure_iso3166;

      --Commit Data
      COMMIT;
   END load_cls_geo_structure2cntr;

   -- Load Geography System from ISO 3166 to References
   PROCEDURE load_ref_geo_systems
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_references.w_geo_systems trg
            WHERE trg.geo_system_id NOT IN (SELECT DISTINCT child_code
                                              FROM cls_geo_structure_iso3166
                                             WHERE UPPER ( structure_level ) = 'WORLD');

      --Merge Source data
      MERGE INTO u_dw_references.w_geo_systems trg
           USING (SELECT DISTINCT child_code
                    FROM cls_geo_structure_iso3166
                   WHERE UPPER ( structure_level ) = 'WORLD') cls
              ON ( trg.geo_system_id = cls.child_code )
      WHEN NOT MATCHED THEN
         INSERT            ( geo_system_id )
             VALUES ( cls.child_code );

      --Merge Source Localizable Data
      MERGE INTO u_dw_references.vl_geo_systems trg
           USING (SELECT geo_id
                       , geo_system_id
                       , CASE WHEN ( geo_system_id = 1 ) THEN 'WORLD' ELSE NULL END geo_system_code
                       , CASE WHEN ( geo_system_id = 1 ) THEN 'The UN World structure' ELSE NULL END geo_system_desc
                       , 1 AS localization_id
                    FROM u_dw_references.w_geo_systems src
                       , cls_geo_structure_iso3166 cls
                   WHERE cls.child_code(+) = src.geo_system_id) cls
              ON ( trg.geo_system_id = cls.geo_system_id
              AND trg.localization_id = cls.localization_id )
      WHEN NOT MATCHED THEN
         INSERT            ( geo_id
                           , geo_system_id
                           , geo_system_code
                           , geo_system_desc
                           , localization_id )
             VALUES ( cls.geo_id
                    , cls.geo_system_id
                    , cls.geo_system_code
                    , cls.geo_system_desc
                    , cls.localization_id )
      WHEN MATCHED THEN
         UPDATE SET trg.geo_system_desc = cls.geo_system_desc
                  , trg.geo_system_code = cls.geo_system_code;

      --Commit Resulst
      COMMIT;
   END load_ref_geo_systems;

   -- Load Geography System from ISO 3166 to References
   PROCEDURE load_ref_geo_parts
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_references.w_geo_parts trg
            WHERE trg.part_id NOT IN (SELECT DISTINCT child_code
                                        FROM cls_geo_structure_iso3166
                                       WHERE UPPER ( structure_level ) = 'CONTINENTS');

      --Merge Source data
      MERGE INTO u_dw_references.w_geo_parts trg
           USING (SELECT DISTINCT child_code
                    FROM cls_geo_structure_iso3166
                   WHERE UPPER ( structure_level ) = 'CONTINENTS') cls
              ON ( trg.part_id = cls.child_code )
      WHEN NOT MATCHED THEN
         INSERT            ( part_id )
             VALUES ( cls.child_code );

      --Merge Source Localizable Data
      MERGE INTO u_dw_references.vl_geo_parts trg
           USING (SELECT geo_id
                       , src.part_id
                       , NULL part_code
                       , structure_desc AS part_desc
                       , 1 AS localization_id
                    FROM u_dw_references.w_geo_parts src
                       , cls_geo_structure_iso3166 cls
                   WHERE cls.child_code(+) = src.part_id
                     AND UPPER ( cls.structure_level ) = 'CONTINENTS') cls
              ON ( trg.part_id = cls.part_id
              AND trg.localization_id = cls.localization_id )
      WHEN NOT MATCHED THEN
         INSERT            ( geo_id
                           , part_id
                           , part_code
                           , part_desc
                           , localization_id )
             VALUES ( cls.geo_id
                    , cls.part_id
                    , cls.part_code
                    , cls.part_desc
                    , cls.localization_id )
      WHEN MATCHED THEN
         UPDATE SET trg.part_desc = cls.part_desc
                  , trg.part_code = cls.part_code;

      --Commit Resulst
      COMMIT;
   END load_ref_geo_parts;

   -- Load Geography System from ISO 3166 to References
   PROCEDURE load_ref_geo_regions
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_references.w_geo_regions trg
            WHERE trg.region_id NOT IN (SELECT DISTINCT child_code
                                          FROM cls_geo_structure_iso3166
                                         WHERE UPPER ( structure_level ) = 'REGIONS');

      --Merge Source data
      MERGE INTO u_dw_references.w_geo_regions trg
           USING (SELECT DISTINCT child_code
                    FROM cls_geo_structure_iso3166
                   WHERE UPPER ( structure_level ) = 'REGIONS') cls
              ON ( trg.region_id = cls.child_code )
      WHEN NOT MATCHED THEN
         INSERT            ( region_id )
             VALUES ( cls.child_code );

      --Merge Source Localizable Data
      MERGE INTO u_dw_references.vl_geo_regions trg
           USING (SELECT geo_id
                       , src.region_id
                       , NULL region_code
                       , structure_desc AS region_desc
                       , 1 AS localization_id
                    FROM u_dw_references.w_geo_regions src
                       , cls_geo_structure_iso3166 cls
                   WHERE cls.child_code(+) = src.region_id
                     AND UPPER ( cls.structure_level ) = 'REGIONS') cls
              ON ( trg.region_id = cls.region_id
              AND trg.localization_id = cls.localization_id )
      WHEN NOT MATCHED THEN
         INSERT            ( geo_id
                           , region_id
                           , region_code
                           , region_desc
                           , localization_id )
             VALUES ( cls.geo_id
                    , cls.region_id
                    , cls.region_code
                    , cls.region_desc
                    , cls.localization_id )
      WHEN MATCHED THEN
         UPDATE SET trg.region_desc = cls.region_desc
                  , trg.region_code = cls.region_code;

      --Commit Resulst
      COMMIT;
   END load_ref_geo_regions;

   -- Extract Data from external source = External Table
   -- Load All Geography objects - Groups from ISO 3166
   PROCEDURE load_cls_countries_grouping
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_CNTR_GROUPING_ISO3166';

      --Extract data
      INSERT INTO cls_cntr_grouping_iso3166 ( child_code
                                            , parent_code
                                            , group_desc
                                            , group_level )
         SELECT child_code
              , parent_code
              , group_desc
              , group_level
           FROM t_ext_cntr_grouping_iso3166;

      --Commit Data
      COMMIT;
   END load_cls_countries_grouping;

   -- Extract Data from external source = External Table
   -- Load All Geography objects - Groups Links to Countries from ISO 3166
   PROCEDURE load_cls_countries2groups
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_cntr2grouping_iso3166';

      --Extract data
      INSERT INTO cls_cntr2grouping_iso3166 ( country_id
                                            , county_desc
                                            , group_code
                                            , group_desc )
         SELECT country_id
              , county_desc
              , group_code
              , group_desc
           FROM t_ext_cntr2grouping_iso3166;

      --Commit Data
      COMMIT;
   END load_cls_countries2groups;

   -- Load Countries Grouping System from ISO 3166 to References
   PROCEDURE load_ref_cntr_group_systems
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_references.w_cntr_group_systems trg
            WHERE trg.grp_system_id NOT IN (SELECT DISTINCT child_code
                                              FROM cls_cntr_grouping_iso3166
                                             WHERE UPPER ( group_level ) = 'ALL');

      --Merge Source data
      MERGE INTO u_dw_references.w_cntr_group_systems trg
           USING (SELECT DISTINCT child_code
                    FROM cls_cntr_grouping_iso3166
                   WHERE UPPER ( group_level ) = 'ALL') cls
              ON ( trg.grp_system_id = cls.child_code )
      WHEN NOT MATCHED THEN
         INSERT            ( grp_system_id )
             VALUES ( cls.child_code );

      --Merge Source Localizable Data
      MERGE INTO u_dw_references.vl_cntr_group_systems trg
           USING (SELECT geo_id
                       , grp_system_id
                       , CASE WHEN ( grp_system_id = 1 ) THEN 'MAIN' ELSE NULL END grp_system_code
                       , cls.group_desc grp_system_desc
                       , 1 AS localization_id
                    FROM u_dw_references.w_cntr_group_systems src
                       , cls_cntr_grouping_iso3166 cls
                   WHERE cls.child_code(+) = src.grp_system_id) cls
              ON ( trg.grp_system_id = cls.grp_system_id
              AND trg.localization_id = cls.localization_id )
      WHEN NOT MATCHED THEN
         INSERT            ( geo_id
                           , grp_system_id
                           , grp_system_code
                           , grp_system_desc
                           , localization_id )
             VALUES ( cls.geo_id
                    , cls.grp_system_id
                    , cls.grp_system_code
                    , cls.grp_system_desc
                    , cls.localization_id )
      WHEN MATCHED THEN
         UPDATE SET trg.grp_system_desc = cls.grp_system_desc
                  , trg.grp_system_code = cls.grp_system_code;

      --Commit Resulst
      COMMIT;
   END load_ref_cntr_group_systems;

   -- Load Countries Groups from ISO 3166 to References
   PROCEDURE load_ref_cntr_groups
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_references.w_cntr_groups trg
            WHERE trg.GROUP_ID NOT IN (SELECT DISTINCT child_code
                                         FROM cls_cntr_grouping_iso3166
                                        WHERE UPPER ( group_level ) = 'GROUPS');

      --Merge Source data
      MERGE INTO u_dw_references.w_cntr_groups trg
           USING (SELECT DISTINCT child_code
                    FROM cls_cntr_grouping_iso3166
                   WHERE UPPER ( group_level ) = 'GROUPS') cls
              ON ( trg.GROUP_ID = cls.child_code )
      WHEN NOT MATCHED THEN
         INSERT            ( GROUP_ID )
             VALUES ( cls.child_code );

      --Merge Source Localizable Data
      MERGE INTO u_dw_references.vl_cntr_groups trg
           USING (SELECT geo_id
                       , src.GROUP_ID
                       , NULL group_code
                       , group_desc AS group_desc
                       , 1 AS localization_id
                    FROM u_dw_references.w_cntr_groups src
                       , cls_cntr_grouping_iso3166 cls
                   WHERE cls.child_code(+) = src.GROUP_ID
                     AND UPPER ( group_level ) = 'GROUPS') cls
              ON ( trg.GROUP_ID = cls.GROUP_ID
              AND trg.localization_id = cls.localization_id )
      WHEN NOT MATCHED THEN
         INSERT            ( geo_id
                           , GROUP_ID
                           , group_code
                           , group_desc
                           , localization_id )
             VALUES ( cls.geo_id
                    , cls.GROUP_ID
                    , cls.group_code
                    , cls.group_desc
                    , cls.localization_id )
      WHEN MATCHED THEN
         UPDATE SET trg.group_desc = cls.group_desc
                  , trg.group_code = cls.group_code;

      --Commit Resulst
      COMMIT;
   END load_ref_cntr_groups;

   -- Load Countries Groups from ISO 3166 to References
   PROCEDURE load_ref_cntr_sub_groups
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_references.w_cntr_sub_groups trg
            WHERE trg.sub_group_id NOT IN (SELECT DISTINCT child_code
                                             FROM cls_cntr_grouping_iso3166
                                            WHERE UPPER ( group_level ) = 'GROUP ITEMS');

      --Merge Source data
      MERGE INTO u_dw_references.w_cntr_sub_groups trg
           USING (SELECT DISTINCT child_code
                    FROM cls_cntr_grouping_iso3166
                   WHERE UPPER ( group_level ) = 'GROUP ITEMS') cls
              ON ( trg.sub_group_id = cls.child_code )
      WHEN NOT MATCHED THEN
         INSERT            ( sub_group_id )
             VALUES ( cls.child_code );

      --Merge Source Localizable Data
      MERGE INTO u_dw_references.vl_cntr_sub_groups trg
           USING (SELECT geo_id
                       , src.sub_group_id
                       , NULL sub_group_code
                       , group_desc AS sub_group_desc
                       , 1 AS localization_id
                    FROM u_dw_references.w_cntr_sub_groups src
                       , cls_cntr_grouping_iso3166 cls
                   WHERE cls.child_code(+) = src.sub_group_id
                     AND UPPER ( group_level ) = 'GROUP ITEMS') cls
              ON ( trg.sub_group_id = cls.sub_group_id
              AND trg.localization_id = cls.localization_id )
      WHEN NOT MATCHED THEN
         INSERT            ( geo_id
                           , sub_group_id
                           , sub_group_code
                           , sub_group_desc
                           , localization_id )
             VALUES ( cls.geo_id
                    , cls.sub_group_id
                    , cls.sub_group_code
                    , cls.sub_group_desc
                    , cls.localization_id )
      WHEN MATCHED THEN
         UPDATE SET trg.sub_group_desc = cls.sub_group_desc
                  , trg.sub_group_code = cls.sub_group_code;

      --Commit Resulst
      COMMIT;
   END load_ref_cntr_sub_groups;

   -- Load Countries links to Geography from ISO 3166 to References
   PROCEDURE load_lnk_geo_structure
   AS
   BEGIN
      --Merge Source data
      MERGE INTO u_dw_references.w_geo_object_links trg
           USING (SELECT p_obj.geo_id parent_geo_id
                       , c_obj.geo_id child_geo_id
                       , CASE
                            WHEN p_obj.geo_type_id = 2
                             AND c_obj.geo_type_id = 10 THEN
                               1
                            WHEN p_obj.geo_type_id = 10
                             AND c_obj.geo_type_id = 11 THEN
                               2
                            ELSE
                               NULL
                         END
                            AS link_type_id
                    FROM (SELECT child_code
                               , parent_code
                               , structure_desc
                               , CASE
                                    WHEN UPPER ( structure_level ) = 'WORLD' THEN 2
                                    WHEN UPPER ( structure_level ) = 'CONTINENTS' THEN 10
                                    WHEN UPPER ( structure_level ) = 'REGIONS' THEN 11
                                    ELSE NULL
                                 END
                                    AS type_id
                            FROM cls_geo_structure_iso3166) cls
                       , u_dw_references.w_geo_objects p_obj
                       , u_dw_references.w_geo_objects c_obj
                   WHERE cls.parent_code IS NOT NULL
                     AND p_obj.geo_code_id = cls.parent_code
                     AND p_obj.geo_type_id < cls.type_id
                     AND c_obj.geo_code_id = cls.child_code
                     AND c_obj.geo_type_id = cls.type_id) cls
              ON ( trg.parent_geo_id = cls.parent_geo_id
              AND trg.child_geo_id = cls.child_geo_id
              AND trg.link_type_id = cls.link_type_id )
      WHEN NOT MATCHED THEN
         INSERT            ( parent_geo_id
                           , child_geo_id
                           , link_type_id )
             VALUES ( cls.parent_geo_id
                    , cls.child_geo_id
                    , cls.link_type_id );

      --Commit Resulst
      COMMIT;
   END load_lnk_geo_structure;

   -- Load Countries links to Geography Regions from ISO 3166 to References
   PROCEDURE load_lnk_geo_countries
   AS
   BEGIN
      --Merge Source data
      MERGE INTO u_dw_references.w_geo_object_links trg
           USING (SELECT reg.geo_id AS parent_geo_id
                       , cntr.geo_id AS child_geo_id
                       , cls.county_desc
                       , cls.structure_desc
                       , 3 AS link_type_id
                    FROM cls_cntr2structure_iso3166 cls
                       , u_dw_references.w_countries cntr
                       , u_dw_references.w_geo_regions reg
                   WHERE cls.country_id = cntr.country_id
                     AND cls.structure_code = reg.region_id) cls
              ON ( trg.parent_geo_id = cls.parent_geo_id
              AND trg.child_geo_id = cls.child_geo_id
              AND trg.link_type_id = cls.link_type_id )
      WHEN NOT MATCHED THEN
         INSERT            ( parent_geo_id
                           , child_geo_id
                           , link_type_id )
             VALUES ( cls.parent_geo_id
                    , cls.child_geo_id
                    , cls.link_type_id );

      --Commit Resulst
      COMMIT;
   END load_lnk_geo_countries;

   -- Load Countries links to Grouping Systems from ISO 3166 to References
   PROCEDURE load_lnk_cntr_grouping
   AS
   BEGIN
      --Merge Source data
      MERGE INTO u_dw_references.w_geo_object_links trg
           USING (SELECT p_obj.geo_id parent_geo_id
                       , c_obj.geo_id child_geo_id
                       , CASE
                            WHEN p_obj.geo_type_id = 50
                             AND c_obj.geo_type_id = 51 THEN
                               4
                            WHEN p_obj.geo_type_id = 51
                             AND c_obj.geo_type_id = 52 THEN
                               5
                            ELSE
                               NULL
                         END
                            AS link_type_id
                    FROM (SELECT child_code
                               , parent_code
                               , group_desc
                               , CASE
                                    WHEN UPPER ( group_level ) = 'ALL' THEN 50
                                    WHEN UPPER ( group_level ) = 'GROUPS' THEN 51
                                    WHEN UPPER ( group_level ) = 'GROUP ITEMS' THEN 52
                                    ELSE NULL
                                 END
                                    AS type_id
                            FROM cls_cntr_grouping_iso3166) cls
                       , u_dw_references.w_geo_objects p_obj
                       , u_dw_references.w_geo_objects c_obj
                   WHERE cls.parent_code IS NOT NULL
                     AND p_obj.geo_code_id = cls.parent_code
                     AND p_obj.geo_type_id < cls.type_id
                     AND p_obj.geo_type_id > 49 --constant deviding by type
                     AND c_obj.geo_code_id = cls.child_code
                     AND c_obj.geo_type_id = cls.type_id) cls
              ON ( trg.parent_geo_id = cls.parent_geo_id
              AND trg.child_geo_id = cls.child_geo_id
              AND trg.link_type_id = cls.link_type_id )
      WHEN NOT MATCHED THEN
         INSERT            ( parent_geo_id
                           , child_geo_id
                           , link_type_id )
             VALUES ( cls.parent_geo_id
                    , cls.child_geo_id
                    , cls.link_type_id );

      --Commit Resulst
      COMMIT;
   END load_lnk_cntr_grouping;

   -- Load Countries links to Groups from ISO 3166 to References
   PROCEDURE load_lnk_cntr2groups
   AS
   BEGIN
      --Merge Source data
      MERGE INTO u_dw_references.w_geo_object_links trg
           USING (SELECT spb.geo_id AS parent_geo_id
                       , cntr.geo_id AS child_geo_id
                       , 6 AS link_type_id
                       , cls.county_desc
                    FROM cls_cntr2grouping_iso3166 cls
                       , u_dw_references.w_cntr_sub_groups spb
                       , u_dw_references.w_countries cntr
                   WHERE cntr.country_id = cls.country_id
                     AND spb.sub_group_id = cls.group_code) cls
              ON ( trg.parent_geo_id = cls.parent_geo_id
              AND trg.child_geo_id = cls.child_geo_id
              AND trg.link_type_id = cls.link_type_id )
      WHEN NOT MATCHED THEN
         INSERT            ( parent_geo_id
                           , child_geo_id
                           , link_type_id )
             VALUES ( cls.parent_geo_id
                    , cls.child_geo_id
                    , cls.link_type_id );

      --Commit Resulst
      COMMIT;
   END load_lnk_cntr2groups;
END pkg_load_ext_ref_geography;
/


--80
alter session set current_schema=u_dw_ext_references;
   --Transport Countries
exec   pkg_load_ext_ref_geography.load_cls_languages_alpha3;
exec   pkg_load_ext_ref_geography.load_cls_languages_alpha2;
exec   pkg_load_ext_ref_geography.load_ref_geo_countries;


BEGIN
   --Cleansing
   pkg_load_ext_ref_geography.load_cls_geo_structure;
   pkg_load_ext_ref_geography.load_cls_geo_structure2cntr;
   pkg_load_ext_ref_geography.load_cls_countries_grouping;
   pkg_load_ext_ref_geography.load_cls_countries2groups;
   --Transport References
   pkg_load_ext_ref_geography.load_ref_geo_systems;
   pkg_load_ext_ref_geography.load_ref_geo_parts;
   pkg_load_ext_ref_geography.load_ref_geo_regions;
   pkg_load_ext_ref_geography.load_ref_cntr_group_systems;
   pkg_load_ext_ref_geography.load_ref_cntr_groups;
   pkg_load_ext_ref_geography.load_ref_cntr_sub_groups;
   --Transport Links
   pkg_load_ext_ref_geography.load_lnk_geo_structure;
   pkg_load_ext_ref_geography.load_lnk_geo_countries;
   pkg_load_ext_ref_geography.load_lnk_cntr_grouping;
   pkg_load_ext_ref_geography.load_lnk_cntr2groups;
END;
/

alter session set current_schema=u_dw_references;

select * from t_addresses;
select * from t_address_types;

select * from t_cntr_group_systems;
select * from lc_cntr_group_systems;

select * from t_cntr_groups;
select * from lc_cntr_groups;

select * from t_cntr_sub_groups;
select * from lc_cntr_sub_groups;

select * from t_countries;
select * from lc_countries;

select * from t_geo_object_links;

select * from t_geo_objects;

select * from t_geo_parts;
select * from lc_geo_parts;

select * from t_geo_regions;
select * from lc_geo_regions;

select * from t_geo_systems;
select * from lc_geo_systems;

select * from t_geo_types;