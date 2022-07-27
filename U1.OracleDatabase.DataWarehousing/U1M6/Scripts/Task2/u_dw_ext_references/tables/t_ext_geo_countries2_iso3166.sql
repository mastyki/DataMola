--drop table u_dw_ext_references.t_ext_geo_countries2_iso3166 cascade constraints;

--==============================================================
-- Table: t_ext_geo_countries2_iso3166                          
--==============================================================
 alter session set current_schema=u_dw_references;
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


Select * from u_dw_ext_references.t_ext_geo_countries2_iso3166