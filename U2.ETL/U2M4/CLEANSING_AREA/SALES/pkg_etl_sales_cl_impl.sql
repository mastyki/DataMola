alter session set current_schema = SA_RESTAURANTS;
select * from DW_CL.CL_SALES;
SELECT * FROM SA_RESTAURANTS.SA_RESTAURANTS_DATA;
GRANT SELECT ON EMASTYKINA.TRANSACTIONS TO DW_CL;
alter session set current_schema = DW_CL;

CREATE OR REPLACE PACKAGE body pkg_etl_sales_cl
AS
   PROCEDURE load_CLEAN_SALES
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
                         cost_dollar_amount,
                         phone,
                         postal_code,
                         address,
                         coupon_name,
                         coupon_desc,
                         media_type_id,
                         media_type,
                         discount_percentage_amount,
                         valid_from,
                         valid_to,
                         country_name,
                         region_name,
                         city_name,
                         period_name,
                         period_desc,
                         begin_dt,
                         end_dt,
                         insert_dt
           FROM EMASTYKINA.TRANSACTIONS
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
           AND cost_dollar_amount IS NOT NULL
           AND PHONE IS NOT NULL
           AND POSTAL_CODE IS NOT NULL
           AND ADDRESS IS NOT NULL
           AND coupon_name IS NOT NULL
           AND coupon_desc IS NOT NULL
           AND media_type_id IS NOT NULL
           AND media_type IS NOT NULL
           AND discount_percentage_amount IS NOT NULL
           AND valid_from IS NOT NULL
           AND valid_to IS NOT NULL
           AND valid_from < valid_to
           AND discount_percentage_amount <= 100
           AND country_name IS NOT NULL
           AND region_name IS NOT NULL
           AND city_name IS NOT NULL
           AND period_name IS NOT NULL
           AND period_desc IS NOT NULL
           AND begin_dt IS NOT NULL
           AND end_dt IS NOT NULL
           AND insert_dt IS NOT NULL
           AND begin_dt < end_dt
           AND insert_dt IS NOT NULL;
           active_status char (1);
           coupon_active_status char (1);
   BEGIN
       EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.CL_SALES';
       FOR i IN c_v LOOP
         IF current_date < i.end_dt THEN  active_status := 'Y';
         END IF;
          IF current_date < i.VALID_TO THEN coupon_active_status := 'Y';
         END IF;
         INSERT INTO DW_CL.CL_SALES(
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
                         cost_dollar_amount,
                         phone,
                         postal_code,
                         address,
                         coupon_name,
                         coupon_desc,
                         media_type_id,
                         media_type,
                         discount_percentage_amount,
                         coupon_valid_from,
                         coupon_valid_to,
                         coupon_is_active,
                         country_name,
                         region_name,
                         city_name,
                         period_name,
                         period_desc,
                         valid_from,
                         valid_to,
                         is_active,
                         insert_dt)
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
                          i.cost_dollar_amount,
                          i.PHONE,
                          i.POSTAL_CODE,
                          i.ADDRESS,
                          i.coupon_name,
                          i.coupon_desc,
                          i.media_type_id,
                          i.media_type,
                          i.discount_percentage_amount,
                          i.valid_from,
                          i.valid_to,
                          coupon_active_status,
                          i.country_name,
                          i.region_name,
                          i.city_name,
                          i.period_name,
                          i.period_desc,
                          i.valid_from,
                          i.valid_to,
                          active_status,
                          i.insert_dt);

         EXIT WHEN c_v%NOTFOUND;
      END LOOP;
      COMMIT;
    END load_CLEAN_SALES;
END pkg_etl_sales_cl;

