ALTER TABLE u_dw_references.t_languages
   DROP CONSTRAINT fk_t_lng_scopes2t_languages;

ALTER TABLE u_dw_references.t_languages
   DROP CONSTRAINT fk_t_lng_types2t_languages;

ALTER TABLE u_dw_references.t_lng_links
   DROP CONSTRAINT fk_t_languages2t_lng_links_c;

ALTER TABLE u_dw_references.t_lng_links
   DROP CONSTRAINT fk_t_languages2t_lng_links_p;

DROP INDEX u_dw_references.idx_lng_3c_code;

DROP TABLE u_dw_references.t_languages CASCADE CONSTRAINTS;

--==============================================================
-- Table: t_languages
--==============================================================
CREATE TABLE u_dw_references.t_languages
(
   lng_id         NUMBER ( 22, 0 ) NOT NULL
 , lng_3c_code    VARCHAR2 ( 3 CHAR ) NOT NULL
 , lng_2b_code    VARCHAR2 ( 3 CHAR )
 , lng_2t_code    VARCHAR2 ( 3 CHAR )
 , lng_1c_code    VARCHAR2 ( 2 CHAR )
 , lng_scope_id   NUMBER ( 22, 0 ) NOT NULL
 , lng_type_id    NUMBER ( 22, 0 )
 , lng_desc       VARCHAR2 ( 200 CHAR ) NOT NULL
 , CONSTRAINT pk_t_languages PRIMARY KEY ( lng_id ) USING INDEX TABLESPACE ts_references_idx_01
)
TABLESPACE ts_references_data_01
PARTITION BY LIST (lng_scope_id)
   ( PARTITION p_individual
        VALUES (1)
        NOCOMPRESS
   , PARTITION p_macrolanguage
        VALUES (2)
        NOCOMPRESS
   , PARTITION p_special
        VALUES (3)
        NOCOMPRESS
   , PARTITION p_others
        VALUES (DEFAULT)
        NOCOMPRESS );

COMMENT ON TABLE u_dw_references.t_languages IS
'Using Standarts: ISO 639-3 
Codes for the representation of names of languages. ISO 639-3 attempts to provide as complete an enumeration of languages as possible, including living, extinct, ancient, and constructed languages, whether major or minor, written or unwritten.';

COMMENT ON COLUMN u_dw_references.t_languages.lng_id IS
'Identifier of the Language';

COMMENT ON COLUMN u_dw_references.t_languages.lng_3c_code IS
'ISO 639-3 identifier';

COMMENT ON COLUMN u_dw_references.t_languages.lng_2b_code IS
'ISO 639-2 identifier of the bibliographic applications';

COMMENT ON COLUMN u_dw_references.t_languages.lng_2t_code IS
'ISO 639-2 identifier of the terminology applications code ';

COMMENT ON COLUMN u_dw_references.t_languages.lng_1c_code IS
'ISO 639-1 identifier - common standart';

COMMENT ON COLUMN u_dw_references.t_languages.lng_scope_id IS
'Identifier of the language scope';

COMMENT ON COLUMN u_dw_references.t_languages.lng_desc IS
'Name of Language';

--==============================================================
-- Index: idx_lng_3c_code
--==============================================================
CREATE UNIQUE INDEX u_dw_references.idx_lng_3c_code
   ON u_dw_references.t_languages ( lng_3c_code ASC
                                  , lng_scope_id ASC )
   LOCAL
   TABLESPACE ts_references_idx_01;

ALTER TABLE u_dw_references.t_languages
   ADD CONSTRAINT fk_t_lng_scopes2t_languages FOREIGN KEY (lng_scope_id)
      REFERENCES u_dw_references.t_lng_scopes (lng_scope_id);

ALTER TABLE u_dw_references.t_languages
   ADD CONSTRAINT fk_t_lng_types2t_languages FOREIGN KEY (lng_type_id)
      REFERENCES u_dw_references.t_lng_types (lng_type_id);