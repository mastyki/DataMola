GRANT SELECT ON dw_cl.cl_geo TO DW_DATA;
alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_etl_geo_dw
AS
    PROCEDURE load_GEO_DW
    AS
    BEGIN
        MERGE INTO DW_DATA.DW_GEO A
        USING (SELECT GEO_ID,
                      COUNTRY_NAME,
                      REGION_NAME,
                      CITY_NAME,
                      ADDRESS,
                      RESTAURANT_CODE,
                      SRC_FILE_ID
               FROM dw_cl.cl_geo) B
        ON (A.RESTAURANT_CODE = B.RESTAURANT_CODE)
        WHEN MATCHED THEN
            UPDATE
            SET A.GEO_SRC_ID   = b.GEO_ID,
                a.COUNTRY_NAME = b.COUNTRY_NAME,
                a.REGION_NAME  = b.REGION_NAME,
                a.CITY_NAME    = b.CITY_NAME,
                a.ADDRESS      = b.ADDRESS,
                a.UPDATE_DT    = (SELECT insert_dt FROM u_sa_layer.sa_mtd_files
                                                   WHERE file_id = b.src_file_id),
                a.SRC_FILE_ID  = b.SRC_FILE_ID
        WHEN NOT MATCHED THEN
            INSERT (A.GEO_SRC_ID,
                    A.COUNTRY_NAME,
                    A.REGION_NAME,
                    A.CITY_NAME,
                    A.ADDRESS,
                    A.RESTAURANT_CODE,
                    A.SRC_FILE_ID,
                    A.INSERT_DT,
                    A.UPDATE_DT)
            VALUES (B.GEO_ID,
                    B.COUNTRY_NAME,
                    B.REGION_NAME,
                    B.CITY_NAME,
                    B.ADDRESS,
                    B.RESTAURANT_CODE,
                    B.SRC_FILE_ID,
                    (SELECT insert_dt FROM u_sa_layer.sa_mtd_files
                                      WHERE file_id = b.src_file_id),
                    (SELECT insert_dt FROM u_sa_layer.sa_mtd_files
                                      WHERE file_id = b.src_file_id));
        COMMIT;
    END load_GEO_DW;
END pkg_etl_geo_dw;
