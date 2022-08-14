alter session set current_schema = SA_RESTAURANTS;
select * from DW_CL.CL_GEO;
SELECT * FROM  EMASTYKINA.SA_GEO_DATA;
GRANT SELECT ON EMASTYKINA.SA_GEO_DATA TO DW_CL;
alter session set current_schema = DW_CL;

CREATE OR REPLACE PACKAGE body pkg_etl_geo_cl
AS
   PROCEDURE load_CLEAN_GEO
   AS
      CURSOR c_v
      IS
         SELECT DISTINCT country_name,
                         region_name,
                         city_name,
                         insert_dt,
                         update_dt
           FROM EMASTYKINA.SA_GEO_DATA
           WHERE country_name IS NOT NULL
           AND region_name IS NOT NULL
           AND city_name IS NOT NULL
           AND insert_dt IS NOT NULL;
   BEGIN
       EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.CL_GEO';
       FOR i IN c_v LOOP
         INSERT INTO DW_CL.CL_GEO(
                         country_name,
                         region_name,
                         city_name,
                         insert_dt,
                         update_dt)
              VALUES (   i.country_name,
                         i.region_name,
                         i.city_name,
                         i.insert_dt,
                         i.update_dt);

         EXIT WHEN c_v%NOTFOUND;
      END LOOP;

      COMMIT;
    END load_CLEAN_GEO;
END pkg_etl_geo_cl;
