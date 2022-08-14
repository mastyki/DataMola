alter session set current_schema = SA_COUPONS;
select * from DW_CL.CL_COUPONS;
SELECT * FROM SA_COUPONS.SA_COUPONS_DATA;
GRANT SELECT ON SA_COUPONS.SA_COUPONS_DATA TO DW_CL;
alter session set current_schema = DW_CL;

CREATE OR REPLACE PACKAGE body pkg_etl_coupons_cl
AS
 PROCEDURE load_CLEAN_COUPONS
   AS
      CURSOR c_v
      IS
         SELECT DISTINCT coupon_name
                       ,coupon_desc
                       , media_type_id
                       , media_type
                       , discount_percentage_amount
                       , valid_from
                       , valid_to
                       , insert_dt
           FROM SA_COUPONS.SA_COUPONS_DATA
           WHERE coupon_name IS NOT NULL
           AND coupon_desc IS NOT NULL
           AND media_type_id IS NOT NULL
           AND media_type IS NOT NULL
           AND discount_percentage_amount IS NOT NULL
           AND valid_from IS NOT NULL
           AND valid_to IS NOT NULL
           AND INSERT_DT IS NOT NULL
           AND valid_from < valid_to
           AND discount_percentage_amount <= 100;
      active_status char (1);
   BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE  DW_CL.CL_COUPONS';
         FOR i IN c_v LOOP
         IF current_date < i.valid_to THEN  active_status := 'Y';
         ELSE  active_status := 'N';
         END IF;
         INSERT INTO DW_CL.CL_COUPONS(
                         coupon_name
                       , coupon_desc
                       , media_type_id
                       , media_type
                       , discount_percentage_amount
                       , valid_from
                       , valid_to
                       , is_active
                       , insert_dt)
              VALUES (   i.coupon_name
                       , i.coupon_desc
                       , i.media_type_id
                       , i.media_type
                       , i.discount_percentage_amount
                       , i.valid_from
                       , i.valid_to
                       , active_status
                       , i.insert_dt);
         EXIT WHEN c_v%NOTFOUND;
      END LOOP;

      COMMIT;
   END load_CLEAN_COUPONS;
END pkg_etl_coupons_cl;