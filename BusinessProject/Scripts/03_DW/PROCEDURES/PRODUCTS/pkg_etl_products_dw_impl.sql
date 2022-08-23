alter session set current_schema = DW_DATA;
GRANT SELECT ON dw_cl.cl_products TO DW_DATA;
GRANT SELECT ON u_sa_layer.sa_mtd_files TO DW_DATA;
GRANT SELECT ON DW_DATA.DW_SALES TO U_DM;
SELECT * FROM DW_SALES ORDER BY SALE_DT DESC
CREATE OR
REPLACE
PACKAGE
body
pkg_etl_products_dw
AS
PROCEDURE
load_PRODUCTS_DW
AS
BEGIN
    MERGE INTO DW_DATA.DW_PRODUCTS A
    USING (SELECT product_id,
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
                  src_file_id
           FROM dw_cl.cl_products) B
    ON (a.product_name = b.product_name and a.feature_id = b.feature_id)
    WHEN MATCHED THEN
        UPDATE
        SET a.product_src_id   = b.product_id,
            a.product_desc     = b.product_desc,
            a.category_id      = b.category_id,
            a.category_name    = b.category_name,
            a.category_desc    = b.category_desc,
            a.subcategory_id   = b.subcategory_id,
            a.subcategory_name = b.subcategory_name,
            a.subcategory_desc = b.subcategory_desc,
            a.feature_name     = b.feature_name,
            a.feature_desc     = b.feature_desc,
            a.update_dt        = (select insert_dt from u_sa_layer.sa_mtd_files where file_id = b.src_file_id),
            a.src_file_id      = b.src_file_id

    WHEN NOT MATCHED THEN
        INSERT (a.product_src_id,
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
                a.src_file_id,
                a.insert_dt,
                a.update_dt)
        VALUES (b.product_id,
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
                b.src_file_id,
                (select insert_dt from u_sa_layer.sa_mtd_files where file_id =b.src_file_id),
                (select insert_dt from u_sa_layer.sa_mtd_files where file_id =b.src_file_id));
    COMMIT;
END load_PRODUCTS_DW;
END pkg_etl_products_dw;

