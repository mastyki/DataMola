alter session set current_schema = DW_CL;
GRANT SELECT ON U_SA_LAYER.SA_PRODUCTS TO DW_CL;

CREATE OR REPLACE PACKAGE body pkg_etl_products_cl
AS
    PROCEDURE load_CLEAN_PRODUCTS
    AS
        CURSOR c_v
            IS
            SELECT DISTINCT PRODUCT_ID,
                            PRODUCT_NAME,
                            PRODUCT_DESC,
                            CATEGORY_ID,
                            CATEGORY_NAME,
                            CATEGORY_DESC,
                            SUBCATEGORY_ID,
                            SUBCATEGORY_NAME,
                            SUBCATEGORY_DESC,
                            FEATURE_ID,
                            FEATURE_NAME,
                            FEATURE_DESC,
                            SRC_FILE_ID
            FROM U_SA_LAYER.SA_PRODUCTS;
    BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.CL_PRODUCTS';
        FOR i IN c_v
            LOOP
                IF (i.PRODUCT_ID is NULL OR
                    i.PRODUCT_NAME is NULL OR
                    i.PRODUCT_DESC is NULL
                    )
                THEN
                    INSERT INTO DW_CL.CL_PRODUCTS_BAD(PRODUCT_ID,
                                                      PRODUCT_NAME,
                                                      PRODUCT_DESC,
                                                      CATEGORY_ID,
                                                      CATEGORY_NAME,
                                                      CATEGORY_DESC,
                                                      SUBCATEGORY_ID,
                                                      SUBCATEGORY_NAME,
                                                      SUBCATEGORY_DESC,
                                                      FEATURE_ID,
                                                      FEATURE_NAME,
                                                      FEATURE_DESC,
                                                      SRC_FILE_ID,
                                                      BAD_COMMENT)
                    VALUES (i.PRODUCT_ID,
                            i.PRODUCT_NAME,
                            i.PRODUCT_DESC,
                            i.CATEGORY_ID,
                            i.CATEGORY_NAME,
                            i.CATEGORY_DESC,
                            i.SUBCATEGORY_ID,
                            i.SUBCATEGORY_NAME,
                            i.SUBCATEGORY_DESC,
                            i.FEATURE_ID,
                            i.FEATURE_NAME,
                            i.FEATURE_DESC,
                            i.SRC_FILE_ID,
                            'NULL PRODUCT CREDENTIALS');
                ELSIF i.SRC_FILE_ID is NULL
                THEN
                    INSERT INTO DW_CL.CL_PRODUCTS_BAD(PRODUCT_ID,
                                                      PRODUCT_NAME,
                                                      PRODUCT_DESC,
                                                      CATEGORY_ID,
                                                      CATEGORY_NAME,
                                                      CATEGORY_DESC,
                                                      SUBCATEGORY_ID,
                                                      SUBCATEGORY_NAME,
                                                      SUBCATEGORY_DESC,
                                                      FEATURE_ID,
                                                      FEATURE_NAME,
                                                      FEATURE_DESC,
                                                      SRC_FILE_ID,
                                                      BAD_COMMENT)
                    VALUES (i.PRODUCT_ID,
                            i.PRODUCT_NAME,
                            i.PRODUCT_DESC,
                            i.CATEGORY_ID,
                            i.CATEGORY_NAME,
                            i.CATEGORY_DESC,
                            i.SUBCATEGORY_ID,
                            i.SUBCATEGORY_NAME,
                            i.SUBCATEGORY_DESC,
                            i.FEATURE_ID,
                            i.FEATURE_NAME,
                            i.FEATURE_DESC,
                            i.SRC_FILE_ID,
                            'NULL SRC CREDENTIALS');
                ELSE

                    INSERT INTO DW_CL.CL_PRODUCTS(PRODUCT_ID,
                                                  PRODUCT_NAME,
                                                  PRODUCT_DESC,
                                                  CATEGORY_ID,
                                                  CATEGORY_NAME,
                                                  CATEGORY_DESC,
                                                  SUBCATEGORY_ID,
                                                  SUBCATEGORY_NAME,
                                                  SUBCATEGORY_DESC,
                                                  FEATURE_ID,
                                                  FEATURE_NAME,
                                                  FEATURE_DESC,
                                                  SRC_FILE_ID)
                    VALUES (i.PRODUCT_ID,
                            i.PRODUCT_NAME,
                            i.PRODUCT_DESC,
                            NVL(i.CATEGORY_ID, -98),
                            NVL(i.CATEGORY_NAME, '-98'),
                            NVL(i.CATEGORY_DESC, '-98'),
                            NVL(i.SUBCATEGORY_ID, -98),
                            NVL(i.SUBCATEGORY_NAME, '-98'),
                            NVL(i.SUBCATEGORY_DESC, '-98'),
                            NVL(i.FEATURE_ID, -98),
                            NVL(i.FEATURE_NAME, '-98'),
                            NVL(i.FEATURE_DESC, '-98'),
                            i.SRC_FILE_ID);
                END IF;
                EXIT WHEN c_v%NOTFOUND;
            END LOOP;
        COMMIT;
    END load_CLEAN_PRODUCTS;
END pkg_etl_products_cl;

