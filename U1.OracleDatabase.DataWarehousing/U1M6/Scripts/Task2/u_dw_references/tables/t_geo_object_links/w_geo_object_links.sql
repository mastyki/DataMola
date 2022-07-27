--drop view u_dw_references.w_geo_object_links;

--==============================================================
-- View: w_geo_object_links                                     
--==============================================================
create or replace view u_dw_references.w_geo_object_links as
SELECT parent_geo_id
     , child_geo_id
     , link_type_id
  FROM t_geo_object_links;

 comment on table u_dw_references.w_geo_object_links is
'Work View: T_GEO_OBJECT_LINKS';

comment on column u_dw_references.w_geo_object_links.parent_geo_id is
'Parent objects of Geo_IDs';

comment on column u_dw_references.w_geo_object_links.child_geo_id is
'Child objects of Geo_IDs';

comment on column u_dw_references.w_geo_object_links.link_type_id is
'Type of Links, between Geo_IDs';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_geo_object_links to u_dw_ext_references;
