GRANT SELECT ON DW_DATA.DW_COUPONS TO U_DM;
alter session set current_schema = U_DM;
SELECT COUPON_SURR_ID,
       COUPON_ID,
       COUPON_NAME,
       COUPON_DESC,
       MEDIA_TYPE_ID,
       MEDIA_TYPE,
       DISCOUNT_PERCENTAGE,
       VALID_FROM,
       VALID_TO,
       INSERT_DT
FROM DIM_COUPONS_SCD;
CREATE OR
    REPLACE
    PACKAGE
    body
    PKG_ETL_COUPONS_SAL
AS
    PROCEDURE
        LOAD_COUPONS_SAL
    AS
    BEGIN
        DECLARE
            TYPE CURSOR_INT IS TABLE OF integer;
            TYPE CURSOR_VARCHAR40 IS TABLE OF varchar2(40);
            TYPE CURSOR_VARCHAR20 IS TABLE OF varchar2(20);
            TYPE CURSOR_DATE IS TABLE OF date;
            TYPE CURSOR_FLOAT IS TABLE OF float;
            TYPE BIG_CURSOR IS REF CURSOR ;
            ALL_INF         BIG_CURSOR;
        COUPON_SURR_ID CURSOR_INT;
       COUPON_ID CURSOR_INT;
       COUPON_SRC_ID CURSOR_INT;
       COUPON_NAME CURSOR_VARCHAR20 ;
       COUPON_DESC CURSOR_VARCHAR40;
       MEDIA_TYPE_ID CURSOR_INT;
       MEDIA_TYPE CURSOR_VARCHAR40;
       DISCOUNT_PERCENTAGE CURSOR_FLOAT;
       VALID_FROM CURSOR_DATE;
       VALID_TO CURSOR_DATE;
       INSERT_DT CURSOR_DATE;
        BEGIN
            OPEN ALL_INF FOR
                SELECT COUPONS.COUPON_SURR_ID,
                       COUPONS.COUPON_ID,
                       SOURCE_COUPONS.COUPON_ID,
                       SOURCE_COUPONS.COUPON_NAME,
                       SOURCE_COUPONS.COUPON_DESC,
                      SOURCE_COUPONS.MEDIA_TYPE_ID,
                       SOURCE_COUPONS.MEDIA_TYPE,
                       SOURCE_COUPONS.DISCOUNT_PERCENTAGE,
                       SOURCE_COUPONS.VALID_FROM,
                       SOURCE_COUPONS.VALID_TO,
                       SOURCE_COUPONS.INSERT_DT
                FROM (SELECT * FROM DW_DATA.DW_COUPONS) SOURCE_COUPONS

                         LEFT JOIN
                     DIM_COUPONS_SCD COUPONS
                     ON (COUPONS.COUPON_ID = SOURCE_COUPONS.COUPON_ID AND
                         COUPONS.VALID_FROM= SOURCE_COUPONS.VALID_FROM AND
                         COUPONS.VALID_TO = SOURCE_COUPONS.VALID_TO );

            FETCH ALL_INF
                BULK COLLECT INTO
               COUPON_SURR_ID,
       COUPON_ID,
       COUPON_SRC_ID,
       COUPON_NAME,
       COUPON_DESC,
       MEDIA_TYPE_ID,
       MEDIA_TYPE,
       DISCOUNT_PERCENTAGE,
       VALID_FROM,
       VALID_TO,
       INSERT_DT;

            CLOSE ALL_INF;

            FOR i IN COUPON_SURR_ID.FIRST .. COUPON_SURR_ID.LAST
                LOOP
                    IF (COUPON_SURR_ID(i) IS NULL) THEN
                        INSERT INTO DIM_COUPONS_SCD ( COUPON_SURR_ID,
       COUPON_ID,
       COUPON_NAME,
       COUPON_DESC,
       MEDIA_TYPE_ID,
       MEDIA_TYPE,
       DISCOUNT_PERCENTAGE,
       VALID_FROM,
       VALID_TO,
       INSERT_DT)
                        VALUES ( SEQ_COUPONS.nextval,
       COUPON_SRC_ID(i),
       COUPON_NAME(i),
       COUPON_DESC(i),
       MEDIA_TYPE_ID(i),
       MEDIA_TYPE(i),
       DISCOUNT_PERCENTAGE(i),
       VALID_FROM(i),
       VALID_TO(i),
       INSERT_DT(i));


                    END IF;
                    COMMIT;
                END LOOP;
        END;
    END LOAD_COUPONS_SAL;
END pkg_etl_COUPONS_sal;

