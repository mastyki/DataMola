alter session set current_schema = DW_CL;
GRANT SELECT ON U_SA_LAYER.SA_COUPONS TO DW_CL;

CREATE OR REPLACE PACKAGE body pkg_etl_coupons_cl
AS
    PROCEDURE load_CLEAN_COUPONS
    AS
        CURSOR c_v
            IS
            SELECT DISTINCT coupon_id,
                            coupon_name,
                            coupon_desc,
                            media_type_id,
                            media_type,
                            discount_percentage,
                            valid_from,
                            valid_to,
                            src_file_id
            FROM U_SA_LAYER.SA_COUPONS;
    BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.CL_COUPONS';
        FOR i IN c_v
            LOOP
                IF (i.coupon_id is NULL OR
                    i.coupon_name is NULL OR
                    i.coupon_desc is NULL OR
                    i.media_type_id is NULL OR
                    i.media_type is NULL OR
                    i.discount_percentage is NULL OR
                    i.valid_from is NULL OR
                    i.valid_to is NULL
                    )
                THEN
                    INSERT INTO DW_CL.CL_COUPONS_BAD(coupon_id,
                                                     coupon_name,
                                                     coupon_desc,
                                                     media_type_id,
                                                     media_type,
                                                     discount_percentage,
                                                     valid_from,
                                                     valid_to,
                                                     src_file_id,
                                                     bad_comment)
                    VALUES (i.coupon_id,
                            i.coupon_name,
                            i.coupon_desc,
                            i.media_type_id,
                            i.media_type,
                            i.discount_percentage,
                            i.valid_from,
                            i.valid_to,
                            i.SRC_FILE_ID,
                            'NULL COUPON CREDENTIALS');
                ELSIF i.SRC_FILE_ID is NULL
                THEN
                    INSERT INTO DW_CL.CL_COUPONS_BAD(coupon_id,
                                                     coupon_name,
                                                     coupon_desc,
                                                     media_type_id,
                                                     media_type,
                                                     discount_percentage,
                                                     valid_from,
                                                     valid_to,
                                                     src_file_id,
                                                     bad_comment)
                    VALUES (i.coupon_id,
                            i.coupon_name,
                            i.coupon_desc,
                            i.media_type_id,
                            i.media_type,
                            i.discount_percentage,
                            i.valid_from,
                            i.valid_to,
                            i.SRC_FILE_ID,
                            'NULL SRC CREDENTIALS');
                    ELSIF (i.valid_from < to_date('01/01/2000','DD/MM/YYYY') or i.valid_to >  to_date('01/01/2100','DD/MM/YYYY'))
                THEN
                    INSERT INTO DW_CL.CL_COUPONS_BAD(coupon_id,
                                                     coupon_name,
                                                     coupon_desc,
                                                     media_type_id,
                                                     media_type,
                                                     discount_percentage,
                                                     valid_from,
                                                     valid_to,
                                                     src_file_id,
                                                     bad_comment)
                    VALUES (i.coupon_id,
                            i.coupon_name,
                            i.coupon_desc,
                            i.media_type_id,
                            i.media_type,
                            i.discount_percentage,
                            i.valid_from,
                            i.valid_to,
                            i.SRC_FILE_ID,
                            'INCORRECT VALID PERIOD');
                ELSE

                    INSERT INTO DW_CL.CL_COUPONS(   coupon_id,
                                                     coupon_name,
                                                     coupon_desc,
                                                     media_type_id,
                                                     media_type,
                                                     discount_percentage,
                                                     valid_from,
                                                     valid_to,
                                                     src_file_id)
                    VALUES (i.coupon_id,
                            i.coupon_name,
                            i.coupon_desc,
                            i.media_type_id,
                            i.media_type,
                            i.discount_percentage,
                            i.valid_from,
                            i.valid_to,
                            i.SRC_FILE_ID);
                END IF;
                EXIT WHEN c_v%NOTFOUND;
            END LOOP;
        COMMIT;
    END load_CLEAN_COUPONS;
END pkg_etl_coupons_cl;



