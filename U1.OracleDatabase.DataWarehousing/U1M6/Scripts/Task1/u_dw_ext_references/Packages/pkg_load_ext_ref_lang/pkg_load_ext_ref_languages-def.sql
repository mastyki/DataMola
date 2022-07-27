CREATE OR REPLACE PACKAGE pkg_load_ext_ref_languages
-- Package Reload Data From External Sources to DataBase
--
AS
   -- Extract Data from external source = External Table
   -- Load All Languages from ISO 693 - 3
   PROCEDURE load_cls_languages;

   -- Load All Languages Scopes from ISO 693 - 3
   PROCEDURE load_ref_lng_scopes;

   -- Load All Languages Types from ISO 693 - 3
   PROCEDURE load_ref_lng_types;

   -- Load All Languages from ISO 693 - 3
   PROCEDURE load_ref_lanuages;

   -- Load Macrolanguages Links to Indiviual Languages from ISO 693 - 3
   PROCEDURE load_cls_links_macro2indiv;
   
   -- Load References Macrolanguages Links to Indiviual from ISO 693 - 3
   PROCEDURE load_ref_lng_links_macro;
END;
/