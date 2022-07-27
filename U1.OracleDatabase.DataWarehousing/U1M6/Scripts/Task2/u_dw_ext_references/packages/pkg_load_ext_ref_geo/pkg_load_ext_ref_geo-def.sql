CREATE OR REPLACE PACKAGE pkg_load_ext_ref_geography
-- Package Reload Data From External Sources to DataBase - Geography objects
--
AS  
   -- Extract Data from external source = External Table
   -- Load All Countries from ISO 3166 Alpha 3
   PROCEDURE load_cls_languages_alpha3;
   
   -- Extract Data from external source = External Table
   -- Load All Countries from ISO 3166 Alpha 2
   PROCEDURE load_cls_languages_alpha2;
      
   -- Load All Countries from ISO 3166 to References
   PROCEDURE load_ref_geo_countries;
   
   -- Extract Data from external source = External Table
   -- Load All Geography objects from ISO 3166
   PROCEDURE load_cls_geo_structure;
      
   -- Extract Data from external source = External Table
   -- Load All Geography objects from ISO 3166
   PROCEDURE load_cls_geo_structure2cntr;
   
   -- Load Geography System from ISO 3166 to References
   PROCEDURE load_ref_geo_systems;
   
   -- Load Geography Continents from ISO 3166 to References
   PROCEDURE load_ref_geo_parts;
   
   -- Load Geography Regions from ISO 3166 to References
   PROCEDURE load_ref_geo_regions;

   -- Extract Data from external source = External Table
   -- Load All Geography objects - Groups from ISO 3166
   PROCEDURE load_cls_countries_grouping;

     -- Extract Data from external source = External Table
   -- Load All Geography objects - Groups Links to Countries from ISO 3166
   PROCEDURE load_cls_countries2groups;
   
    -- Load Countries Grouping System from ISO 3166 to References
   PROCEDURE load_ref_cntr_group_systems;
   
    -- Load Countries Groups from ISO 3166 to References
   PROCEDURE load_ref_cntr_groups;
   
    -- Load Countries Groups from ISO 3166 to References
   PROCEDURE load_ref_cntr_sub_groups;
   
    -- Load Countries links to Geography from ISO 3166 to References
   PROCEDURE load_lnk_geo_structure;
   
   -- Load Countries links to Geography Regions from ISO 3166 to References
   PROCEDURE load_lnk_geo_countries;
   
   -- Load Countries links to Grouping Systems from ISO 3166 to References
   PROCEDURE load_lnk_cntr_grouping;
   
   -- Load Countries links to Groups from ISO 3166 to References
   PROCEDURE load_lnk_cntr2groups;
   
END pkg_load_ext_ref_geography;
/