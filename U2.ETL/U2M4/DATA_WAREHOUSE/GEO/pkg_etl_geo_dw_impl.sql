GRANT SELECT ON dw_cl.cl_geo TO DW_DATA;
alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_etl_geo_dw
AS
   PROCEDURE load_GEO_DW
   AS
       BEGIN
           MERGE INTO DW_DATA.dim_geo A
           USING (
               SELECT country_name, region_name, city_name, insert_dt, update_dt
               FROM dw_cl.cl_geo
           ) B
           ON ( a.city_name = b.city_name and a.region_name = b.region_name and a.country_name = b.country_name)
           WHEN NOT MATCHED THEN INSERT (a.geo_id, a.country_name, a.region_name, a.city_name,  a.insert_dt, a.update_dt)
                                 VALUES ( dw_data.SEQ_DIM_GEO.NEXTVAL, b.country_name, b.region_name, b.city_name,  b.insert_dt, b.update_dt);
           COMMIT;
    END load_GEO_DW;
END pkg_etl_geo_dw;

