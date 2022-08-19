alter session set current_schema = DW_CL;
GRANT SELECT ON U_SA_LAYER.SA_GEO TO DW_CL;

CREATE OR REPLACE PACKAGE body pkg_etl_geo_cl
AS
    PROCEDURE load_CLEAN_GEO
    AS
        CURSOR c_v
            IS
            SELECT DISTINCT geo_id,
                            country_name,
                            region_name,
                            city_name,
                            address,
                            restaurant_code,
                            src_file_id
            FROM U_SA_LAYER.SA_GEO;
    BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.CL_GEO';
        FOR i IN c_v
            LOOP
                IF (i.geo_id is NULL OR
                    i.country_name is NULL OR
                    i.region_name is NULL OR
                    i.city_name is NULL OR
                    i.address is NULL OR
                    i.restaurant_code is NULL
                    )
                THEN
                    INSERT INTO DW_CL.CL_GEO_BAD(geo_id,
                                                 country_name,
                                                 region_name,
                                                 city_name,
                                                 address,
                                                 restaurant_code,
                                                 src_file_id,
                                                 bad_comment)
                    VALUES (i.geo_id,
                            i.country_name,
                            i.region_name,
                            i.city_name,
                            i.address,
                            i.restaurant_code,
                            i.src_file_id,
                            'NULL GEO CREDENTIALS');
                ELSIF i.SRC_FILE_ID is NULL
                THEN
                    INSERT INTO DW_CL.CL_GEO_BAD(geo_id,
                                                 country_name,
                                                 region_name,
                                                 city_name,
                                                 address,
                                                 restaurant_code,
                                                 src_file_id,
                                                 bad_comment)
                    VALUES (i.geo_id,
                            i.country_name,
                            i.region_name,
                            i.city_name,
                            i.address,
                            i.restaurant_code,
                            i.src_file_id,
                            'NULL SRC CREDENTIALS');
                ELSE

                    INSERT INTO DW_CL.CL_GEO(geo_id,
                                                 country_name,
                                                 region_name,
                                                 city_name,
                                                 address,
                                                 restaurant_code,
                                                 src_file_id)
                    VALUES (i.geo_id,
                            i.country_name,
                            i.region_name,
                            i.city_name,
                            i.address,
                            i.restaurant_code,
                            i.src_file_id);
                END IF;
                EXIT WHEN c_v%NOTFOUND;
            END LOOP;
        COMMIT;
    END load_CLEAN_GEO;
END pkg_etl_geo_cl;

