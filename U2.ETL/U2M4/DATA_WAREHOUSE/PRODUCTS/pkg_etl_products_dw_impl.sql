GRANT SELECT ON dw_cl.cl_products TO DW_DATA;
alter session set current_schema = DW_DATA;
select * from  DW_DATA.dim_products;
CREATE OR REPLACE PACKAGE body pkg_etl_products_dw
AS
   PROCEDURE load_PRODUCTS_DW
   AS
       BEGIN
           MERGE INTO DW_DATA.dim_products A
           USING (
               SELECT    product_name,
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
                         update_dt
               FROM dw_cl.cl_products
           ) B
           ON ( a.product_name = b.product_name)
           WHEN MATCHED THEN UPDATE SET a.cost_dollar_amount=b.cost_dollar_amount, a.update_dt =  b.insert_dt
           WHEN NOT MATCHED THEN
               INSERT (   a.product_id,
                          a.product_name,
                          a.product_desc,
                          a.category_id,
                          a.category_name,
                          a.category_desc,
                          a.subcategory_id,
                          a.subcategory_name,
                          a.subcategory_desc,
                          a.feature_id,
                          a.feature_name,
                          a.feature_desc,
                          a.insert_dt,
                          a.cost_dollar_amount,
                          a.update_dt
                   )
                VALUES ( DW_DATA.SEQ_DIM_PRODUCTS.NEXTVAL,
                          b.product_name,
                          b.product_desc,
                          b.category_id,
                          b.category_name,
                          b.category_desc,
                          b.subcategory_id,
                          b.subcategory_name,
                          b.subcategory_desc,
                          b.feature_id,
                          b.feature_name,
                          b.feature_desc,
                          b.insert_dt,
                          b.cost_dollar_amount,
                          b.update_dt);
           COMMIT;
    END load_PRODUCTS_DW;
END pkg_etl_products_dw;

