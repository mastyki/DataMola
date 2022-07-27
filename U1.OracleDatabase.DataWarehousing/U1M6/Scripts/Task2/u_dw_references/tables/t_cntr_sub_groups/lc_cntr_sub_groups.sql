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
