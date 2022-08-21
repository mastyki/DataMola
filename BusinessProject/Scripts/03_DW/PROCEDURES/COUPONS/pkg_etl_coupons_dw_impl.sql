GRANT SELECT ON dw_cl.cl_coupons TO DW_DATA;
alter session set current_schema = DW_DATA;

CREATE OR
    REPLACE
    PACKAGE
    body
    pkg_etl_coupons_dw
AS
    PROCEDURE
        load_COUPONS_DW
    AS
    BEGIN
        MERGE INTO DW_DATA.DW_COUPONS A
        USING (SELECT COUPON_ID,
                      COUPON_NAME,
                      COUPON_DESC,
                      MEDIA_TYPE_ID,
                      MEDIA_TYPE,
                      DISCOUNT_PERCENTAGE,
                      VALID_FROM,
                      VALID_TO,
                      SRC_FILE_ID
               FROM dw_cl.cl_coupons) B
        ON (A.COUPON_NAME = B.COUPON_NAME AND A.VALID_FROM = B.VALID_FROM AND A.VALID_TO = B.VALID_TO)
        WHEN NOT MATCHED THEN
            INSERT (A.COUPON_SRC_ID,
                    A.COUPON_NAME,
                    A.COUPON_DESC,
                    A.MEDIA_TYPE_ID,
                    A.MEDIA_TYPE,
                    A.DISCOUNT_PERCENTAGE,
                    A.VALID_FROM,
                    A.VALID_TO,
                    A.SRC_FILE_ID,
                    A.INSERT_DT)
            VALUES (B.COUPON_ID,
                    B.COUPON_NAME,
                    B.COUPON_DESC,
                    B.MEDIA_TYPE_ID,
                    B.MEDIA_TYPE,
                    B.DISCOUNT_PERCENTAGE,
                    B.VALID_FROM,
                    B.VALID_TO,
                    B.SRC_FILE_ID,
                    (SELECT insert_dt FROM u_sa_layer.sa_mtd_files WHERE file_id = b.src_file_id));
        COMMIT;
    END load_coupons_DW;
END pkg_etl_coupons_dw;
