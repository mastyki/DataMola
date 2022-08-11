-- GEO_REF (contain a geolocation link to the Denormalized table)

CREATE TABLE GEO_REF
AS SELECT
            LPAD ( ' '
                , 2 * LEVEL
                , ' ' )
                || child_geo_id
                     AS cid
                   , parent_geo_id AS pid
                   , link_type_id
                   , DECODE ( LEVEL,  1, 'ROOT',  2, 'BRANCH',  'LEAF' ) AS id_type
                   , DECODE ( ( SELECT COUNT ( * )
                               FROM u_dw_references.t_geo_object_links a
                                    WHERE a.parent_geo_id = b.child_geo_id )
                            , 0, NULL
                            , ( SELECT COUNT ( * )
                                    FROM u_dw_references.t_geo_object_links a
                                    WHERE a.parent_geo_id = b.child_geo_id ) )
                     AS lev_count
                    , SYS_CONNECT_BY_PATH ( parent_geo_id
                 , ':' )
                     AS PATH
             FROM u_dw_references.t_geo_object_links b
       CONNECT BY PRIOR child_geo_id = parent_geo_id
ORDER SIBLINGS BY child_geo_id

