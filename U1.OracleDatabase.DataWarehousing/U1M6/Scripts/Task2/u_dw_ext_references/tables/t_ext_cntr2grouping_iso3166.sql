drop table u_dw_ext_references.t_ext_cntr2grouping_iso3166 cascade constraints;

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

/*comment on table u_dw_ext_references.t_ext_cntr2grouping_iso3166 is
'External table for loading - Countries';
*/
