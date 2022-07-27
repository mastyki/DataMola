--drop view u_dw_references.cu_languages;

--==============================================================
-- View: cu_languages
--==============================================================
CREATE OR REPLACE VIEW u_dw_references.cu_languages
AS
   SELECT lng_id
        , lng_3c_code
        , lng_2b_code
        , lng_2t_code
        , lng_1c_code
        , lng_scope_id
        , lng_type_id
        , lng_desc
     FROM t_languages lng
    WHERE lng.lng_scope_id = 1 --Individuals
      AND lng.lng_type_id = 5 --Living
   WITH READ ONLY;

COMMENT ON COLUMN u_dw_references.cu_languages.lng_id IS
'Identifier of the Language';

COMMENT ON COLUMN u_dw_references.cu_languages.lng_3c_code IS
'ISO 639-3 identifier';

COMMENT ON COLUMN u_dw_references.cu_languages.lng_2b_code IS
'ISO 639-2 identifier of the bibliographic applications';

COMMENT ON COLUMN u_dw_references.cu_languages.lng_2t_code IS
'ISO 639-2 identifier of the terminology applications code ';

COMMENT ON COLUMN u_dw_references.cu_languages.lng_1c_code IS
'ISO 639-1 identifier - common standart';

COMMENT ON COLUMN u_dw_references.cu_languages.lng_scope_id IS
'Identifier of the language scope';

COMMENT ON COLUMN u_dw_references.cu_languages.lng_desc IS
'Name of Language';

GRANT DELETE,INSERT,UPDATE,SELECT ON u_dw_references.cu_languages TO u_dw_ext_references;