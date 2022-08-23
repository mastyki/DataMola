GRANT SELECT ON DW_DATA.DW_SALES TO U_DM;
alter session set current_schema = U_DM;

CREATE OR
    REPLACE
    PACKAGE
    body
    pkg_etl_fct_sales_sal
AS
    PROCEDURE
        LOAD_FCT_SALES_SAL
    AS
    BEGIN
        DECLARE
            TYPE CURSOR_INT IS TABLE OF integer;
            TYPE CURSOR_DATE IS TABLE OF date;
            TYPE CURSOR_FLOAT IS TABLE OF float;
            TYPE BIG_CURSOR IS REF CURSOR ;
            ALL_INF            BIG_CURSOR;
            SALE_ID            CURSOR_INT;
            SALE_SRC_ID        CURSOR_INT;
            TIME_ID            CURSOR_DATE;
            PRODUCT_ID         CURSOR_INT;
            COUPON_ID          CURSOR_INT;
            GEO_ID             CURSOR_INT;
            COST_DOLLAR_AMOUNT CURSOR_FLOAT;
            INSERT_DT          CURSOR_DATE;
            UPDATE_DT          CURSOR_DATE;
        BEGIN
            OPEN ALL_INF FOR
                SELECT SALES.SALE_ID
                     , SOURCE_SALES.SALE_ID
                     , SOURCE_SALES.SALE_DT
                     , SOURCE_SALES.PRODUCT_ID
                     , COUPONS.COUPON_SURR_ID
                     , SOURCE_SALES.GEO_ID
                     , SOURCE_SALES.COST_DOLLAR_AMOUNT
                     , SOURCE_SALES.INSERT_DT
                     , SOURCE_SALES.UPDATE_DT
                FROM (SELECT * FROM DW_DATA.DW_SALES) SOURCE_SALES
                         LEFT JOIN
                     FCT_SALES_DD sales
                     ON (SOURCE_SALES.SALE_ID = SALES.SALE_ID)
                         INNER JOIN
                     DIM_COUPONS_SCD COUPONS
                     ON (SOURCE_SALES.COUPON_ID = COUPONS.COUPON_ID)
                WHERE SALE_DT BETWEEN COUPONS.VALID_FROM AND COUPONS.VALID_TO;

            FETCH ALL_INF
                BULK COLLECT INTO
                SALE_ID,
                SALE_SRC_ID,
                TIME_ID,
                PRODUCT_ID,
                COUPON_ID,
                GEO_ID,
                COST_DOLLAR_AMOUNT,
                INSERT_DT,
                UPDATE_DT;
            CLOSE ALL_INF;
            FOR i IN SALE_ID.FIRST .. SALE_ID.LAST
                LOOP
                    IF (sale_id(i) IS NULL) THEN
                        INSERT INTO FCT_SALES_DD ( SALE_ID
                                                 , TIME_ID
                                                 , PRODUCT_ID
                                                 , GEO_ID
                                                 , COUPON_ID
                                                 , COST_DOLLAR_AMOUNT
                                                 , GROSS_PROFIT_DOLLAR_AMOUNT
                                                 , INSERT_DT
                                                 , UPDATE_DT)
                        VALUES ( SALE_SRC_ID(i)
                               , TIME_ID(i)
                               , PRODUCT_ID(i)
                               , GEO_ID(i)
                               , COUPON_ID(i)
                               , COST_DOLLAR_AMOUNT(i)
                               , (COST_DOLLAR_AMOUNT(i) - COST_DOLLAR_AMOUNT(i) * (SELECT DISCOUNT_PERCENTAGE
                                                                                   FROM DIM_COUPONS_SCD
                                                                                   WHERE DIM_COUPONS_SCD.COUPON_ID =
                                                                                         COUPON_ID(i)) * .01)
                               , INSERT_DT(i)
                               , UPDATE_DT(i));

                    ELSE
                        UPDATE FCT_SALES_DD
                        SET TIME_ID                    = TIME_ID(i)
                          , PRODUCT_ID                 = PRODUCT_ID(i)
                          , GEO_ID                     = GEO_ID(i)
                          , COUPON_ID                  = COUPON_ID(i)
                          , COST_DOLLAR_AMOUNT         = COST_DOLLAR_AMOUNT(i)
                          , GROSS_PROFIT_DOLLAR_AMOUNT = (COST_DOLLAR_AMOUNT(i) -
                                                          COST_DOLLAR_AMOUNT(i) * (SELECT DISCOUNT_PERCENTAGE
                                                                                   FROM DIM_COUPONS_SCD
                                                                                   WHERE DIM_COUPONS_SCD.COUPON_ID =
                                                                                         COUPON_ID(i)) * .01)
                          , UPDATE_DT                  = INSERT_DT(i)
                        WHERE FCT_SALES_DD.SALE_ID = SALE_ID(i);
                    END IF;
                    COMMIT;
                END LOOP;
        END;
    END LOAD_FCT_SALES_SAL;
END pkg_etl_fct_sales_sal;

