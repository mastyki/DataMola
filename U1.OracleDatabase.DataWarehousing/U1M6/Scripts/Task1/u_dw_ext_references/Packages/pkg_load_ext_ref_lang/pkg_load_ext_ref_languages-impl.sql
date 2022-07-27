CREATE OR REPLACE PACKAGE BODY pkg_load_ext_ref_languages
-- Package Reload Data From External Sources to DataBase
--
AS
   -- Extract Data from external source = External Table
   -- Load All Languages from ISO 693 - 3
   PROCEDURE load_cls_languages
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_languages_iso693';

      --Extract data
      INSERT INTO cls_languages_iso693 ( lng_3c_code
                                       , lng_2b_code
                                       , lng_2t_code
                                       , lng_1c_code
                                       , lng_scope
                                       , lng_type
                                       , lng_desc )
         SELECT lng_3c_code
              , lng_2b_code
              , lng_2t_code
              , lng_1c_code
              , lng_scope
              , lng_type
              , lng_desc
           FROM t_ext_languages_iso693;

      --Commit Data
      COMMIT;
   END load_cls_languages;

   /*****/
   -- Load All Languages Scopes from ISO 693 - 3
   PROCEDURE load_ref_lng_scopes
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_references.w_lng_scopes lng
            WHERE lng.lng_scope_code NOT IN (     SELECT DISTINCT UPPER ( lng_scope ) FROM cls_languages_iso693);

      --Merge Source data
      MERGE INTO u_dw_references.w_lng_scopes lng
           USING (  SELECT DISTINCT UPPER ( lng_scope ) AS lng_scope
                      FROM cls_languages_iso693
                  ORDER BY lng_scope) cls
              ON ( lng.lng_scope_code = cls.lng_scope )
      WHEN NOT MATCHED THEN
         INSERT            ( lng_scope_id
                           , lng_scope_code )
             VALUES ( u_dw_references.sq_lng_scopes_t_id.NEXTVAL
                    , cls.lng_scope );

      --Merge Source Localizable Data
      MERGE INTO u_dw_references.vl_lng_scopes lng
           USING (SELECT src.lng_scope_id
                       , src.lng_scope_code
                       , CASE
                            WHEN lng_scope_code = 'I' THEN 'Individual'
                            WHEN lng_scope_code = 'M' THEN 'Macrolanguage'
                            WHEN lng_scope_code = 'S' THEN 'Special'
                            ELSE 'Error: Not Defined'
                         END
                            AS lng_scope_desc
                       , 1 AS localization_id
                    FROM u_dw_references.w_lng_scopes src) cls
              ON ( lng.lng_scope_id = cls.lng_scope_id
              AND lng.localization_id = cls.localization_id )
      WHEN NOT MATCHED THEN
         INSERT            ( lng_scope_id
                           , lng_scope_code
                           , lng_scope_desc
                           , localization_id )
             VALUES ( cls.lng_scope_id
                    , cls.lng_scope_code
                    , cls.lng_scope_desc
                    , cls.localization_id )
      WHEN MATCHED THEN
         UPDATE SET lng.lng_scope_code = cls.lng_scope_code
                  , lng.lng_scope_desc = cls.lng_scope_desc;

      --Commit Resulst
      COMMIT;
   END load_ref_lng_scopes;

   /*****/
   -- Load All Languages types from ISO 693 - 3
   PROCEDURE load_ref_lng_types
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_references.w_lng_types lng
            WHERE lng.lng_type_code NOT IN (     SELECT DISTINCT UPPER ( lng_type ) FROM cls_languages_iso693);

      --Merge Source data
      MERGE INTO u_dw_references.w_lng_types lng
           USING (  SELECT DISTINCT UPPER ( lng_type ) AS lng_type
                      FROM cls_languages_iso693
                  ORDER BY lng_type) cls
              ON ( lng.lng_type_code = cls.lng_type )
      WHEN NOT MATCHED THEN
         INSERT            ( lng_type_id
                           , lng_type_code )
             VALUES ( u_dw_references.sq_lng_types_t_id.NEXTVAL
                    , cls.lng_type );

      --Merge Source Localizable Data
      MERGE INTO u_dw_references.vl_lng_types lng
           USING (SELECT src.lng_type_id
                       , src.lng_type_code
                       , CASE
                            -- A(ncient), C(onstructed),
                            -- E(xtinct), H(istorical), L(iving), S(pecial)
                         WHEN lng_type_code = 'A' THEN 'Ancient'
                            WHEN lng_type_code = 'C' THEN 'Constructed'
                            WHEN lng_type_code = 'E' THEN 'Extinct'
                            WHEN lng_type_code = 'H' THEN 'Historical'
                            WHEN lng_type_code = 'L' THEN 'Living'
                            WHEN lng_type_code = 'S' THEN 'Special'
                            ELSE 'Error: Not Defined'
                         END
                            AS lng_type_desc
                       , 1 AS localization_id
                    FROM u_dw_references.w_lng_types src) cls
              ON ( lng.lng_type_id = cls.lng_type_id
              AND lng.localization_id = cls.localization_id )
      WHEN NOT MATCHED THEN
         INSERT            ( lng_type_id
                           , lng_type_code
                           , lng_type_desc
                           , localization_id )
             VALUES ( cls.lng_type_id
                    , cls.lng_type_code
                    , cls.lng_type_desc
                    , cls.localization_id )
      WHEN MATCHED THEN
         UPDATE SET lng.lng_type_code = cls.lng_type_code
                  , lng.lng_type_desc = cls.lng_type_desc;

      --Commit Resulst
      COMMIT;
   END load_ref_lng_types;

   /*****/
   -- Load All Languages from ISO 693 - 3
   PROCEDURE load_ref_lanuages
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_references.w_languages lng
            WHERE lng.lng_3c_code NOT IN (     SELECT DISTINCT lng_3c_code FROM cls_languages_iso693);

      --Merge New Values
      MERGE INTO u_dw_references.w_languages lng
           USING (SELECT cls.lng_3c_code
                       , cls.lng_2b_code
                       , cls.lng_2t_code
                       , cls.lng_1c_code
                       , NVL ( scp.lng_scope_id, -99 ) AS lng_scope_id
                       , NVL ( typ.lng_type_id, -99 ) AS lng_type_id
                       , cls.lng_desc
                    FROM cls_languages_iso693 cls
                       , u_dw_references.w_lng_scopes scp
                       , u_dw_references.w_lng_types typ
                   WHERE scp.lng_scope_code(+) = cls.lng_scope
                     AND typ.lng_type_code(+) = cls.lng_type) cls
              ON ( lng.lng_3c_code = cls.lng_3c_code )
      WHEN MATCHED THEN
         UPDATE SET lng.lng_2b_code = cls.lng_2b_code
                  , lng.lng_2t_code = cls.lng_2t_code
                  , lng.lng_1c_code = cls.lng_1c_code
                  , lng.lng_scope_id = cls.lng_scope_id
                  , lng.lng_type_id = cls.lng_type_id
                  , lng.lng_desc = cls.lng_desc
      WHEN NOT MATCHED THEN
         INSERT            ( lng_id
                           , lng_3c_code
                           , lng_2b_code
                           , lng_2t_code
                           , lng_1c_code
                           , lng_scope_id
                           , lng_type_id
                           , lng_desc )
             VALUES ( u_dw_references.sq_languages_t_id.NEXTVAL
                    , cls.lng_3c_code
                    , cls.lng_2b_code
                    , cls.lng_2t_code
                    , cls.lng_1c_code
                    , cls.lng_scope_id
                    , cls.lng_type_id
                    , cls.lng_desc );

      -- Commit Current Results
      COMMIT;
   END load_ref_lanuages;

   -- Load Macrolanguages Links to Indiviual Languages from ISO 693 - 3
   PROCEDURE load_cls_links_macro2indiv
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_LNG_MACRO2IND_ISO693';

      --Extract data
      INSERT INTO cls_lng_macro2ind_iso693 ( macro_lng_code
                                           , indiv_lng_code )
         SELECT macro_lng_code
              , indiv_lng_code
           FROM t_ext_lng_macro2ind_iso693;

      --Commit Data
      COMMIT;
   END load_cls_links_macro2indiv;

   -- Load References Macrolanguages Links to Indiviual from ISO 693 - 3
   PROCEDURE load_ref_lng_links_macro
   AS
   BEGIN
      DELETE FROM u_dw_references.w_lng_links lnk
            WHERE ( lnk.parent_lng_id, lnk.child_lng_id, lnk.link_type_id ) NOT IN
                     (SELECT NVL ( m_lng.lng_id, -99 ) AS m_lng_id
                           , NVL ( i_lng.lng_id, -99 ) AS i_lng_id
                           , 1 AS link_type_id
                        FROM cls_lng_macro2ind_iso693 cls
                           , u_dw_references.w_languages m_lng
                           , u_dw_references.w_languages i_lng
                       WHERE m_lng.lng_3c_code(+) = cls.macro_lng_code
                         AND m_lng.lng_scope_id(+) = 2
                         AND i_lng.lng_3c_code(+) = cls.indiv_lng_code
                         AND i_lng.lng_scope_id(+) = 1);

      MERGE INTO u_dw_references.w_lng_links lnk
           USING (SELECT NVL ( m_lng.lng_id, -99 ) AS m_lng_id
                       , NVL ( i_lng.lng_id, -99 ) AS i_lng_id
                       , 1 AS link_type_id
                    FROM cls_lng_macro2ind_iso693 cls
                       , u_dw_references.w_languages m_lng
                       , u_dw_references.w_languages i_lng
                   WHERE m_lng.lng_3c_code = cls.macro_lng_code
                     AND m_lng.lng_scope_id = 2
                     AND i_lng.lng_3c_code = cls.indiv_lng_code
                     AND i_lng.lng_scope_id = 1) src
              ON ( lnk.parent_lng_id = src.m_lng_id
              AND lnk.child_lng_id = src.i_lng_id
              AND lnk.link_type_id = 1 )
      WHEN NOT MATCHED THEN
         INSERT            ( lnk.parent_lng_id
                           , lnk.child_lng_id
                           , lnk.link_type_id )
             VALUES ( src.m_lng_id
                    , src.i_lng_id
                    , src.link_type_id );

      COMMIT;
   END;
END;
/