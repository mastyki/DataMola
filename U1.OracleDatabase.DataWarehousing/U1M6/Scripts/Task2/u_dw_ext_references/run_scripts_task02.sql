BEGIN
   --Transport Countries
   pkg_load_ext_ref_geography.load_cls_languages_alpha3;
   pkg_load_ext_ref_geography.load_cls_languages_alpha2;
   pkg_load_ext_ref_geography.load_ref_geo_countries;
END;

BEGIN
   --Cleansing
   pkg_load_ext_ref_geography.load_cls_geo_structure;
   pkg_load_ext_ref_geography.load_cls_geo_structure2cntr;
   pkg_load_ext_ref_geography.load_cls_countries_grouping;
   pkg_load_ext_ref_geography.load_cls_countries2groups;
   --Transport References
   pkg_load_ext_ref_geography.load_ref_geo_systems;
   pkg_load_ext_ref_geography.load_ref_geo_parts;
   pkg_load_ext_ref_geography.load_ref_geo_regions;
   pkg_load_ext_ref_geography.load_ref_cntr_group_systems;
   pkg_load_ext_ref_geography.load_ref_cntr_groups;
   pkg_load_ext_ref_geography.load_ref_cntr_sub_groups;   
   --Transport Links
   pkg_load_ext_ref_geography.load_lnk_geo_structure;
   pkg_load_ext_ref_geography.load_lnk_geo_countries;
   pkg_load_ext_ref_geography.load_lnk_cntr_grouping;
   pkg_load_ext_ref_geography.load_lnk_cntr2groups;
END;





