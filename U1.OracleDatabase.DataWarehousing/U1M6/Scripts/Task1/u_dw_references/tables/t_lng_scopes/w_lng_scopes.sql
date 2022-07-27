DROP VIEW u_dw_references.w_lng_scopes;

--==============================================================
-- View: w_lng_scopes
--==============================================================
CREATE OR REPLACE VIEW u_dw_references.w_lng_scopes
AS
   SELECT lng_scope_id
        , lng_scope_code
     FROM t_lng_scopes;

COMMENT ON COLUMN u_dw_references.w_lng_scopes.lng_scope_id IS
'Idemtificator of Language Scopes - ISO 639-3';

COMMENT ON COLUMN u_dw_references.w_lng_scopes.lng_scope_code IS
'Code of Languages Scopes - ISO 639-3';

GRANT DELETE,INSERT,UPDATE,SELECT ON u_dw_references.w_lng_scopes TO u_dw_ext_references;