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
