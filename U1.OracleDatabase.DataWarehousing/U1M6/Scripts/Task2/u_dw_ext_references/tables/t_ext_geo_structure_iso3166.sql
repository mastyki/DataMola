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

