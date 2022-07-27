alter table u_dw_references.lc_lng_scopes
   drop constraint FK_LOC2LNG_SCOPES;

alter table u_dw_references.lc_lng_types
   drop constraint FK_LOC2LNG_TYPES;

drop table u_dw_references.t_localizations cascade constraints;

--==============================================================
-- Table: t_localizations                                       
--==============================================================
create table u_dw_references.t_localizations 
(
   localization_id      NUMBER(22,0)         not null,
   localization_code    VARCHAR2(5 CHAR)     not null,
   localization_desc    VARCHAR2(200 CHAR)   not null,
   localization_desc_ens VARCHAR2(200 CHAR)   not null,
   lng_id               NUMBER(22,0),
   contry_id            NUMBER(22,0),
   is_default           INTEGER,
   constraint PK_T_LOCALIZATIONS primary key (localization_id)
         using index tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01;

comment on column u_dw_references.t_localizations.localization_id is
'Identificator of Supported References Languages';

comment on column u_dw_references.t_localizations.localization_code is
'Code of Supported References Languages';

comment on column u_dw_references.t_localizations.localization_desc is
'Name of Supported References Languages';

comment on column u_dw_references.t_localizations.localization_desc_ens is
'Endonym Name of  Supported References Languages';

comment on column u_dw_references.t_localizations.lng_id is
'Disabled - FK for Language_Id - Post Mapped by Load PKG';

comment on column u_dw_references.t_localizations.contry_id is
'Disabled - FK for Country_Id - Post Mapped by Load PKG';

comment on column u_dw_references.t_localizations.is_default is
'Default Language for all Application and Members on DataBase';

alter table u_dw_references.t_localizations
   add constraint CHK_T_LOCALIZATIONS_IS_DEFAULT check (is_default is null or (is_default in (1,0)));
