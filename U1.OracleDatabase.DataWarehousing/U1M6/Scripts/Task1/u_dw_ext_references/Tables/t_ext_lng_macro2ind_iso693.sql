--drop table u_dw_ext_references.t_ext_lng_macro2ind_iso693 cascade constraints;

--==============================================================
-- Table: t_ext_lng_macro2ind_iso693                            
--==============================================================
create table u_dw_ext_references.t_ext_lng_macro2ind_iso693 
(
   MACRO_LNG_CODE       VARCHAR2(3 CHAR),
   INDIV_LNG_CODE       VARCHAR2(3 CHAR)
)
organization external (
    type oracle_loader
    default directory ext_references
    access parameters (RECORDS DELIMITED BY 0x'0D0A' NOBADFILE NODISCARDFILE NOLOGFILE FIELDS TERMINATED BY ';' MISSING FIELD VALUES ARE NULL ( MACRO_LNG_CODE CHAR( 3 ) , INDIV_LNG_CODE CHAR( 3 ) ) )
    location ('iso-639-3-Macro.tab')
)
reject limit unlimited;


