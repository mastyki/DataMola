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
alter session set current_schema = u_dw_references;
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

alter session set current_schema = u_dw_references;
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
