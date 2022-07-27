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