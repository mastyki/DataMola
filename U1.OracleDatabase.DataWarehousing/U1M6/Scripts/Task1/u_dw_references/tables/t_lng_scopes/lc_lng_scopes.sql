ALTER TABLE u_dw_references.lc_lng_scopes
   DROP CONSTRAINT fk_loc2lng_scopes;

ALTER TABLE u_dw_references.lc_lng_scopes
   DROP CONSTRAINT fk_t_lng_scopes2lc_lng_scopes;

DROP TABLE u_dw_references.lc_lng_scopes CASCADE CONSTRAINTS;

--==============================================================
-- Table: lc_lng_scopes
--==============================================================
CREATE TABLE u_dw_references.lc_lng_scopes
(
   lng_scope_id   NUMBER ( 22, 0 ) NOT NULL
 , lng_scope_code VARCHAR2 ( 1 CHAR ) NOT NULL
 , lng_scope_desc VARCHAR2 ( 200 CHAR ) NOT NULL
 , localization_id NUMBER ( 22, 0 ) NOT NULL
 , CONSTRAINT pk_lc_lng_scopes PRIMARY KEY
      ( lng_scope_id, localization_id )
      USING INDEX TABLESPACE ts_references_idx_01
)
TABLESPACE ts_references_data_01;

COMMENT ON COLUMN u_dw_references.lc_lng_scopes.lng_scope_id IS
'Identificator of Language Scopes - ISO 639-3';

COMMENT ON COLUMN u_dw_references.lc_lng_scopes.lng_scope_code IS
'Code of Language Scopes - ISO 639-3';

COMMENT ON COLUMN u_dw_references.lc_lng_scopes.lng_scope_desc IS
'Description of Language Scopes - ISO 639-3';

COMMENT ON COLUMN u_dw_references.lc_lng_scopes.localization_id IS
'Identificator of Supported References Languages';

ALTER TABLE u_dw_references.lc_lng_scopes
   ADD CONSTRAINT fk_loc2lng_scopes FOREIGN KEY (localization_id)
      REFERENCES u_dw_references.t_localizations (localization_id)
      ON DELETE CASCADE;

ALTER TABLE u_dw_references.lc_lng_scopes
   ADD CONSTRAINT fk_t_lng_scopes2lc_lng_scopes FOREIGN KEY (lng_scope_id)
      REFERENCES u_dw_references.t_lng_scopes (lng_scope_id)
      ON DELETE CASCADE;