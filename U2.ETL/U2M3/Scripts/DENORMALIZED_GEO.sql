
CREATE TABLE DENORMALIZED_GEO_TABLE
AS
    SELECT geo.country_geo_id
     , cnt.country_id
     , cnt.region_desc AS country_name
     , prt.part_desc
     , reg.region_desc
  FROM (  SELECT country_geo_id
               , SUM ( region ) AS region_geo_id
               , SUM ( contenet ) AS contenet_geo_id
            FROM (    SELECT CONNECT_BY_ROOT ( child_geo_id ) AS country_geo_id
                           , parent_geo_id
                           , link_type_id
                           , DECODE ( link_type_id, 2, parent_geo_id ) AS contenet
                           , DECODE ( link_type_id, 3, parent_geo_id ) AS region
                        FROM u_dw_references.w_geo_object_links
                  CONNECT BY PRIOR parent_geo_id = child_geo_id
                  START WITH child_geo_id IN (SELECT DISTINCT geo_id
                                                FROM u_dw_references.cu_countries))
        GROUP BY country_geo_id) geo
       LEFT JOIN u_dw_references.cu_countries cnt
          ON ( geo.country_geo_id = cnt.geo_id )
       LEFT JOIN u_dw_references.cu_geo_regions reg
          ON ( geo.region_geo_id = reg.geo_id )
                 LEFT JOIN u_dw_references.cu_geo_parts prt
          ON ( geo.contenet_geo_id = prt.geo_id );


SELECT * FROM DENORMALIZED_GEO_TABLE;