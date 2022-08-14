GRANT SELECT ON dw_cl.cl_coupons TO DW_DATA;
alter session set current_schema = DW_DATA;
select * from DW_DATA.dim_coupons_scd;
CREATE OR REPLACE PACKAGE body pkg_etl_coupons_dw
AS
   PROCEDURE load_COUPONS_DW
   AS
       BEGIN
           MERGE INTO DW_DATA.dim_coupons_scd A
           USING (
               SELECT    coupon_name
                       , coupon_desc
                       , media_type_id
                       , media_type
                       , discount_percentage_amount
                       , valid_from
                       , valid_to
                       , is_active
                       , insert_dt
               FROM dw_cl.cl_coupons
           ) B
           ON ( a.coupon_name = b.coupon_name)
           WHEN MATCHED THEN UPDATE SET a.discount_percentage_amount = b.discount_percentage_amount
           WHEN NOT MATCHED THEN
               INSERT (   a.coupon_id
                       ,  a.coupon_name
                       ,  a.coupon_desc
                       ,  a.media_type_id
                       ,  a.media_type
                       ,  a.discount_percentage_amount
                       ,  a.valid_from
                       ,  a.valid_to
                       ,  a.is_active
                       ,  a.insert_dt
                   )
                VALUES ( DW_DATA.SEQ_DIM_COUPONS.NEXTVAL,
                          b.coupon_name
                       ,  b.coupon_desc
                       ,  b.media_type_id
                       ,  b.media_type
                       ,  b.discount_percentage_amount
                       ,  b.valid_from
                       ,  b.valid_to
                       ,  b.is_active
                       ,  b.insert_dt);
           COMMIT;
    END load_coupons_DW;
END pkg_etl_coupons_dw;

