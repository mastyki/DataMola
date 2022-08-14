alter session set current_schema = SA_RESTAURANTS;
select * from dw_cl.cl_restaurants;
SELECT * FROM SA_RESTAURANTS.SA_RESTAURANTS_DATA;
GRANT SELECT ON dw_cl.cl_restaurants TO DW_DATA;
alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_etl_restaurants_dw
AS
   PROCEDURE load_RESTAURANTS_DW
   AS
       BEGIN
           MERGE INTO DW_DATA.dim_restaurants A
           USING (
               SELECT phone, postal_code, address, insert_dt, update_dt
               FROM dw_cl.cl_restaurants
           ) B
           ON ( a.postal_code = b.postal_code)
           WHEN MATCHED THEN UPDATE SET a.address = b.address, a.phone = b.phone, a.update_dt = b.insert_dt
           WHEN NOT MATCHED THEN INSERT (a.restaurant_id, a.phone, a.postal_code, a.address, a.insert_dt, a.update_dt)
                                 VALUES ( dw_data.SEQ_DIM_RESTAURANTS.NEXTVAL, b.phone, b.postal_code, b.address, b.insert_dt, b.update_dt);
           COMMIT;
    END load_RESTAURANTS_DW;
END pkg_etl_restaurants_dw;

