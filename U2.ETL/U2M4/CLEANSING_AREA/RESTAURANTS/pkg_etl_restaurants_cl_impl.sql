alter session set current_schema = SA_RESTAURANTS;
select * from DW_CL.CL_RESTAURANTS;
SELECT * FROM SA_RESTAURANTS.SA_RESTAURANTS_DATA;
GRANT SELECT ON SA_RESTAURANTS.SA_RESTAURANTS_DATA TO DW_CL;
alter session set current_schema = DW_CL;

CREATE OR REPLACE PACKAGE body pkg_etl_restaurants_cl
AS
   PROCEDURE load_CLEAN_RESTAURANTS
   AS
      CURSOR c_v
      IS
         SELECT DISTINCT PHONE
                       , POSTAL_CODE
                       , ADDRESS
                       , INSERT_DT
                       , UPDATE_DT
           FROM SA_RESTAURANTS.SA_RESTAURANTS_DATA
           WHERE PHONE IS NOT NULL
           AND POSTAL_CODE IS NOT NULL
           AND ADDRESS IS NOT NULL
           AND INSERT_DT IS NOT NULL;
   BEGIN
       EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.CL_RESTAURANTS';
       FOR i IN c_v LOOP
         INSERT INTO DW_CL.CL_RESTAURANTS(
                         PHONE
                       , POSTAL_CODE
                       , ADDRESS
                       , INSERT_DT
                       , UPDATE_DT)
              VALUES (   i.PHONE
                       , i.POSTAL_CODE
                       , i.ADDRESS
                       , i.INSERT_DT
                       , i.UPDATE_DT);

         EXIT WHEN c_v%NOTFOUND;
      END LOOP;

      COMMIT;
    END load_CLEAN_RESTAURANTS;
END pkg_etl_RESTAURANTS_cl;

