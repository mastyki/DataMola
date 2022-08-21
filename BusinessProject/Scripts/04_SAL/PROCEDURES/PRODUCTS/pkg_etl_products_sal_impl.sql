GRANT SELECT ON DW_DATA.DW_PRODUCTS TO U_DM;
alter session set current_schema = U_DM;

CREATE OR
    REPLACE
    PACKAGE
    body
    PKG_ETL_PRODUCTS_SAL
AS
    PROCEDURE
        LOAD_PRODUCTS_SAL
    AS
    BEGIN
        DECLARE
            TYPE CURSOR_INT IS TABLE OF integer;
            TYPE CURSOR_VARCHAR40 IS TABLE OF varchar2(40);
            TYPE CURSOR_DATE IS TABLE OF date;
            TYPE BIG_CURSOR IS REF CURSOR ;
            ALL_INF          BIG_CURSOR;
            PRODUCT_ID       CURSOR_INT;
            PRODUCT_SRC_ID   CURSOR_INT;
            PRODUCT_NAME     CURSOR_VARCHAR40;
            PRODUCT_DESC     CURSOR_VARCHAR40;
            CATEGORY_ID      CURSOR_INT;
            CATEGORY_NAME    CURSOR_VARCHAR40;
            CATEGORY_DESC    CURSOR_VARCHAR40;
            SUBCATEGORY_ID   CURSOR_INT;
            SUBCATEGORY_NAME CURSOR_VARCHAR40;
            SUBCATEGORY_DESC CURSOR_VARCHAR40;
            FEATURE_ID       CURSOR_INT;
            FEATURE_NAME     CURSOR_VARCHAR40;
            FEATURE_DESC     CURSOR_VARCHAR40;
            INSERT_DT        CURSOR_DATE;
            UPDATE_DT        CURSOR_DATE;
        BEGIN
            OPEN ALL_INF FOR
                SELECT PRODUCTS.PRODUCT_ID,
                       SOURCE_PRODUCTS.PRODUCT_ID,
                       SOURCE_PRODUCTS.PRODUCT_NAME,
                       SOURCE_PRODUCTS.PRODUCT_DESC,
                       SOURCE_PRODUCTS.CATEGORY_ID,
                       SOURCE_PRODUCTS.CATEGORY_NAME,
                       SOURCE_PRODUCTS.CATEGORY_DESC,
                       SOURCE_PRODUCTS.SUBCATEGORY_ID,
                       SOURCE_PRODUCTS.SUBCATEGORY_NAME,
                       SOURCE_PRODUCTS.SUBCATEGORY_DESC,
                       SOURCE_PRODUCTS.FEATURE_ID,
                       SOURCE_PRODUCTS.FEATURE_NAME,
                       SOURCE_PRODUCTS.FEATURE_DESC,
                       SOURCE_PRODUCTS.INSERT_DT,
                       SOURCE_PRODUCTS.UPDATE_DT
                FROM (SELECT * FROM DW_DATA.DW_PRODUCTS) SOURCE_PRODUCTS

                         LEFT JOIN
                     DIM_PRODUCTS PRODUCTS
                     ON (PRODUCTS.PRODUCT_ID = SOURCE_PRODUCTS.PRODUCT_ID);

            FETCH ALL_INF
                BULK COLLECT INTO
                PRODUCT_ID,
                PRODUCT_SRC_ID,
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
                INSERT_DT,
                UPDATE_DT;

            CLOSE ALL_INF;

            FOR i IN PRODUCT_ID.FIRST .. PRODUCT_ID.LAST
                LOOP
                    IF (PRODUCT_ID(i) IS NULL) THEN
                        INSERT INTO DIM_PRODUCTS (PRODUCT_ID,
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
                                                  INSERT_DT,
                                                  UPDATE_DT)
                        VALUES (PRODUCT_SRC_ID(i),
                                PRODUCT_NAME(i),
                                PRODUCT_DESC(i),
                                CATEGORY_ID(i),
                                CATEGORY_NAME(i),
                                CATEGORY_DESC(i),
                                SUBCATEGORY_ID(i),
                                SUBCATEGORY_NAME(i),
                                SUBCATEGORY_DESC(i),
                                FEATURE_ID(i),
                                FEATURE_NAME(i),
                                FEATURE_DESC(i),
                                INSERT_DT(i),
                                UPDATE_DT(i));

                    ELSE
                        UPDATE DIM_PRODUCTS
                        SET PRODUCT_NAME     = PRODUCT_NAME(i),
                            PRODUCT_DESC     = PRODUCT_DESC(i),
                            CATEGORY_ID      = CATEGORY_ID(i),
                            CATEGORY_NAME    = CATEGORY_NAME(i),
                            CATEGORY_DESC    = CATEGORY_DESC(i),
                            SUBCATEGORY_ID   = SUBCATEGORY_ID(i),
                            SUBCATEGORY_NAME = SUBCATEGORY_NAME(i),
                            SUBCATEGORY_DESC = SUBCATEGORY_DESC(i),
                            FEATURE_ID       = FEATURE_ID(i),
                            FEATURE_NAME     = FEATURE_NAME(i),
                            FEATURE_DESC     = FEATURE_DESC(i),
                            UPDATE_DT        = INSERT_DT(i)
                            WHERE DIM_PRODUCTS.PRODUCT_ID = PRODUCT_ID(i);
                    END IF;
                    COMMIT;
                END LOOP;
        END;
    END LOAD_PRODUCTS_SAL;
END pkg_etl_products_sal;

