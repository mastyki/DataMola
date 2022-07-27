--DROP VIEW u_dw_references.w_lng_types;

--==============================================================
-- View: w_lng_types
--==============================================================
CREATE OR REPLACE VIEW u_dw_references.w_lng_types
AS
   SELECT t_lng_types.lng_type_id
        , t_lng_types.lng_type_code
     FROM t_lng_types;

COMMENT ON COLUMN u_dw_references.w_lng_types.lng_type_id IS
'Identificator of Language Types - ISO 639-3';

COMMENT ON COLUMN u_dw_references.w_lng_types.lng_type_code IS
'Code of Language Types - ISO 639-3';

GRANT DELETE,INSERT,UPDATE,SELECT ON u_dw_references.w_lng_types TO u_dw_ext_references;