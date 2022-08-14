alter session set current_schema = SA_RESTAURANTS;
select * from DW_CL.CL_PRODUCTS;
SELECT * FROM SA_RESTAURANTS.SA_RESTAURANTS_DATA;
GRANT SELECT ON EMASTYKINA.SA_PRODUCTS_DATA TO DW_CL;
alter session set current_schema = DW_CL;

CREATE OR REPLACE PACKAGE body pkg_etl_products_cl
AS
   PROCEDURE load_CLEAN_PRODUCTS
   AS
      CURSOR c_v
      IS
         SELECT DISTINCT product_name,
                         product_desc,
                         category_id,
                         category_name,
                         category_desc,
                         subcategory_id,
                         subcategory_name,
                         subcategory_desc,
                         feature_id,
                         feature_name,
                         feature_desc,
                         insert_dt,
                         update_dt,
                         cost_dollar_amount
           FROM EMASTYKINA.SA_PRODUCTS_DATA
           WHERE product_name IS NOT NULL
           AND product_desc IS NOT NULL
           AND category_id IS NOT NULL
           AND category_name IS NOT NULL
           AND category_desc IS NOT NULL
           AND subcategory_id IS NOT NULL
           AND subcategory_name IS NOT NULL
           AND subcategory_desc IS NOT NULL
           AND feature_id IS NOT NULL
           AND feature_name IS NOT NULL
           AND feature_desc IS NOT NULL
           AND insert_dt IS NOT NULL
           AND cost_dollar_amount IS NOT NULL;
   BEGIN
       EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.CL_PRODUCTS';
       FOR i IN c_v LOOP
         INSERT INTO DW_CL.CL_PRODUCTS(
                         product_name,
                         product_desc,
                         category_id,
                         category_name,
                         category_desc,
                         subcategory_id,
                         subcategory_name,
                         subcategory_desc,
                         feature_id,
                         feature_name,
                         feature_desc,
                         insert_dt,
                         cost_dollar_amount,
                         update_dt)
              VALUES (    i.product_name,
                          i.product_desc,
                          i.category_id,
                          i.category_name,
                          i.category_desc,
                          i.subcategory_id,
                          i.subcategory_name,
                          i.subcategory_desc,
                          i.feature_id,
                          i.feature_name,
                          i.feature_desc,
                          i.insert_dt,
                          i.cost_dollar_amount,
                          i.update_dt);

         EXIT WHEN c_v%NOTFOUND;
      END LOOP;

      COMMIT;
    END load_CLEAN_PRODUCTS;
END pkg_etl_products_cl;

