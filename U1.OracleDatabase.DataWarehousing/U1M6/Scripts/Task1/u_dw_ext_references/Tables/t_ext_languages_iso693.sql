--drop table u_dw_ext_references.t_ext_languages_iso693 cascade constraints;

--==============================================================
-- Table: t_ext_languages_iso693
--==============================================================
CREATE TABLE u_dw_ext_references.t_ext_languages_iso693
(
   lng_3c_code    VARCHAR2 ( 3 CHAR )
 , lng_2b_code    VARCHAR2 ( 3 CHAR )
 , lng_2t_code    VARCHAR2 ( 3 CHAR )
 , lng_1c_code    VARCHAR2 ( 2 CHAR )
 , lng_scope      VARCHAR2 ( 2 CHAR )
 , lng_type       VARCHAR2 ( 1 CHAR )
 , lng_desc       VARCHAR2 ( 200 CHAR )
)
ORGANIZATION EXTERNAL
                      (
    TYPE oracle_loader
    DEFAULT DIRECTORY ext_references
    ACCESS PARAMETERS (RECORDS DELIMITED BY NEWLINE NOBADFILE NODISCARDFILE NOLOGFILE FIELDS TERMINATED BY ';' MISSING FIELD VALUES ARE NULL( lng_3c_code CHAR( 3 ) , lng_2b_code CHAR( 3 ) , lng_2t_code CHAR( 3 ) , lng_1c_code CHAR( 2 ) , lng_scope CHAR( 1 ) , lng_type CHAR( 1 ) , lng_desc CHAR( 150 ) ) )
    LOCATION ('iso-639-3.tab')
)
REJECT LIMIT UNLIMITED;