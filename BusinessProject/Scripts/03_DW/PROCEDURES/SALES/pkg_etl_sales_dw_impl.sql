GRANT SELECT ON DW_CL.cl_sales TO DW_DATA;
alter session set current_schema = DW_DATA;

CREATE OR
    REPLACE
    PACKAGE
    body
    pkg_etl_sales_dw
AS
    PROCEDURE
        LOAD_SALES_DW
    AS
    BEGIN
        DECLARE
            TYPE CURSOR_INT IS TABLE OF integer;
            TYPE CURSOR_VARCHAR40 IS TABLE OF varchar2(40);
            TYPE CURSOR_VARCHAR20 IS TABLE OF varchar2(20);
            TYPE CURSOR_VARCHAR10 IS TABLE OF varchar2(10);
            TYPE CURSOR_VARCHAR6 IS TABLE OF varchar2(6);
            TYPE CURSOR_DATE IS TABLE OF date;
            TYPE CURSOR_FLOAT IS TABLE OF float;
            TYPE BIG_CURSOR IS REF CURSOR ;
            ALL_INF         BIG_CURSOR;
            SALE_ID         CURSOR_INT;
            SALE_SRC_ID     CURSOR_INT;
            SALE_DT         CURSOR_DATE;
            PRODUCT_ID      CURSOR_INT;
            PRODUCT_NAME    CURSOR_VARCHAR40;
            PRODUCT_FEATURE CURSOR_VARCHAR40;
            COUPON_ID       CURSOR_INT;
            COUPON_NAME     CURSOR_VARCHAR20;
            GEO_ID          CURSOR_INT;
            RESTAURANT_CODE CURSOR_VARCHAR10;
            COST            CURSOR_FLOAT;
            SRC_FILE_ID     CURSOR_VARCHAR6;
        BEGIN
            OPEN ALL_INF FOR
                SELECT SALES.sale_id
                     , SOURCE_SALES.SALE_ID
                     , SOURCE_SALES.SALE_DT
                     , PRODUCT.product_id
                     , SOURCE_SALES.PRODUCT_NAME
                     , SOURCE_SALES.FEATURE_NAME
                     , COUPON.coupon_id
                     , SOURCE_SALES.COUPON_NAME
                     , GEO.geo_id
                     , SOURCE_SALES.RESTAURANT_CODE
                     , SOURCE_SALES.COST_DOLLAR_AMOUNT
                     , SOURCE_SALES.SRC_FILE_ID
                FROM (SELECT * FROM DW_CL.cl_sales) SOURCE_SALES
                         INNER JOIN
                     DW_DATA.DW_PRODUCTS PRODUCT
                     ON (SOURCE_SALES.product_name = PRODUCT.product_name AND
                         SOURCE_SALES.FEATURE_NAME = PRODUCT.FEATURE_NAME)
                         INNER JOIN
                     DW_DATA.DW_COUPONS COUPON
                     ON (SOURCE_SALES.coupon_name = COUPON.coupon_name
                         AND SOURCE_SALES.SALE_DT BETWEEN COUPON.VALID_FROM AND COUPON.VALID_TO)
                         INNER JOIN
                     DW_DATA.DW_GEO geo
                     ON (SOURCE_SALES.RESTAURANT_CODE = geo.RESTAURANT_CODE)
                         LEFT JOIN
                     DW_DATA.DW_SALES sales
                     ON (PRODUCT.PRODUCT_ID = sales.PRODUCT_ID AND COUPON.COUPON_ID = SALES.COUPON_ID AND
                         GEO.GEO_ID = sales.GEO_ID AND SOURCE_SALES.SALE_DT = SALES.SALE_DT);

            FETCH ALL_INF
                BULK COLLECT INTO
                sale_id
                , sale_src_id
                , sale_dt
                , product_id
                , product_name
                , product_feature
                , coupon_id
                , coupon_name
                , geo_id
                , restaurant_code
                , cost
                , src_file_id;
            CLOSE ALL_INF;

            FOR i IN sale_id.FIRST .. sale_id.LAST
                LOOP
                    IF (sale_id(i) IS NULL) THEN
                        INSERT INTO dw_data.DW_SALES ( sale_src_id
                                                     , sale_dt
                                                     , product_id
                                                     , product_name
                                                     , feature_name
                                                     , coupon_id
                                                     , coupon_name
                                                     , geo_id
                                                     , restaurant_code
                                                     , cost_dollar_amount
                                                     , src_file_id
                                                     , insert_dt
                                                     , update_dt)
                        VALUES ( sale_src_id(i)
                               , sale_dt(i)
                               , product_id(i)
                               , product_name(i)
                               , product_feature(i)
                               , coupon_id(i)
                               , coupon_name(i)
                               , geo_id(i)
                               , restaurant_code(i)
                               , cost(i)
                               , src_file_id(i)
                               , (select insert_dt from u_sa_layer.sa_mtd_files where file_id = src_file_id(i))
                               , (select insert_dt from u_sa_layer.sa_mtd_files where file_id = src_file_id(i)));

                    ELSE
                        UPDATE DW_DATA.DW_SALES
                        SET sale_src_id        = sale_src_id(i)
                          , sale_dt            =sale_dt(i)
                          , product_id         = product_id(i)
                          , product_name       = product_name(i)
                          , feature_name       = product_feature(i)
                          , coupon_id          =coupon_id(i)
                          , coupon_name        = coupon_name(i)
                          , geo_id             = geo_id(i)
                          , restaurant_code    =restaurant_code(i)
                          , cost_dollar_amount = cost(i)
                          , src_file_id        = src_file_id(i)
                          , update_dt          =(select insert_dt
                                                 from u_sa_layer.sa_mtd_files
                                                 where file_id = src_file_id(i));
                    END IF;
                    COMMIT;
                END LOOP;
        END;
    END LOAD_SALES_DW;
END pkg_etl_sales_dw;

