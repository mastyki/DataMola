alter session set current_schema = DW_CL;
GRANT SELECT ON U_SA_LAYER.SA_SALES TO DW_CL;

CREATE OR REPLACE PACKAGE body pkg_etl_sales_cl
AS
    PROCEDURE load_CLEAN_SALES
    AS
        CURSOR c_v
            IS
            SELECT DISTINCT sale_id,
                            sale_dt,
                            product_name,
                            feature_name,
                            cost_dollar_amount,
                            coupon_name,
                            restaurant_code,
                            src_file_id
            FROM U_SA_LAYER.SA_SALES;
    BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.CL_SALES';
        FOR i IN c_v
            LOOP
                IF (i.sale_id is NULL OR
                    i.sale_dt is NULL OR
                    i.product_name is NULL OR
                    i.cost_dollar_amount is NULL OR
                    i.restaurant_code is NULL
                    )
                THEN
                    INSERT INTO DW_CL.CL_SALES_BAD(sale_id,
                                                   sale_dt,
                                                   product_name,
                                                   feature_name,
                                                   cost_dollar_amount,
                                                   coupon_name,
                                                   restaurant_code,
                                                   src_file_id)
                    VALUES (i.sale_id,
                            i.sale_dt,
                            i.product_name,
                            i.feature_name,
                            i.cost_dollar_amount,
                            i.coupon_name,
                            i.restaurant_code,
                            'NULL SALE CREDENTIALS');
                ELSIF i.SRC_FILE_ID is NULL
                THEN
                    INSERT INTO DW_CL.CL_SALES_BAD(sale_id,
                                                   sale_dt,
                                                   product_name,
                                                   feature_name,
                                                   cost_dollar_amount,
                                                   coupon_name,
                                                   restaurant_code,
                                                   src_file_id)
                    VALUES (i.sale_id,
                            i.sale_dt,
                            i.product_name,
                            i.feature_name,
                            i.cost_dollar_amount,
                            i.coupon_name,
                            i.restaurant_code,
                            'NULL SRC CREDENTIALS');
                ELSIF (i.cost_dollar_amount <= 0)
                THEN
                    INSERT INTO DW_CL.CL_SALES_BAD(sale_id,
                                                   sale_dt,
                                                   product_name,
                                                   feature_name,
                                                   cost_dollar_amount,
                                                   coupon_name,
                                                   restaurant_code,
                                                   src_file_id)
                    VALUES (i.sale_id,
                            i.sale_dt,
                            i.product_name,
                            i.feature_name,
                            i.cost_dollar_amount,
                            i.coupon_name,
                            i.restaurant_code,
                            'INCORRECT cost_dollar_amount value ');
                ELSIF (i.sale_dt < to_date('01/01/2000', 'DD/MM/YYYY') or i.sale_dt > current_date)
                THEN
                    INSERT INTO DW_CL.CL_SALES_BAD(sale_id,
                                                   sale_dt,
                                                   product_name,
                                                   feature_name,
                                                   cost_dollar_amount,
                                                   coupon_name,
                                                   restaurant_code,
                                                   src_file_id)
                    VALUES (i.sale_id,
                            i.sale_dt,
                            i.product_name,
                            i.feature_name,
                            i.cost_dollar_amount,
                            i.coupon_name,
                            i.restaurant_code,
                            'INCORRECT date value ');
                ELSE

                    INSERT INTO DW_CL.CL_SALES (sale_id,
                                                sale_dt,
                                                product_name,
                                                feature_name,
                                                cost_dollar_amount,
                                                coupon_name,
                                                restaurant_code,
                                                src_file_id)
                    VALUES (i.sale_id,
                            i.sale_dt,
                            i.product_name,
                            NVL(i.feature_name, '-98'),
                            i.cost_dollar_amount,
                            NVL(i.coupon_name, '-98'),
                            i.restaurant_code,
                            i.src_file_id);
                END IF;
                EXIT WHEN c_v%NOTFOUND;
            END LOOP;
        COMMIT;
    END load_CLEAN_SALES;
END pkg_etl_sales_cl;

