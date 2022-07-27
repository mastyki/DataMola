drop table u_dw_references.t_geo_types cascade constraints;

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
