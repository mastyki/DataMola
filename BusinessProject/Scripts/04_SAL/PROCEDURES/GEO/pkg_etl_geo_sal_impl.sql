GRANT SELECT ON DW_DATA.DW_GEO TO U_DM;
alter session set current_schema = U_DM;

CREATE OR
    REPLACE
    PACKAGE
    body
    PKG_ETL_GEO_SAL
AS
    PROCEDURE
        LOAD_GEO_SAL
    AS
    BEGIN
        DECLARE
            TYPE CURSOR_INT IS TABLE OF integer;
            TYPE CURSOR_VARCHAR40 IS TABLE OF varchar2(40);
            TYPE CURSOR_VARCHAR10 IS TABLE OF varchar2(10);
            TYPE CURSOR_DATE IS TABLE OF date;
            TYPE BIG_CURSOR IS REF CURSOR ;
            ALL_INF         BIG_CURSOR;
            GEO_ID          CURSOR_INT;
            GEO_SRC_ID      CURSOR_INT;
            COUNTRY_NAME    CURSOR_VARCHAR40;
            REGION_NAME     CURSOR_VARCHAR40;
            CITY_NAME       CURSOR_VARCHAR40;
            ADDRESS         CURSOR_VARCHAR40;
            RESTAURANT_CODE CURSOR_VARCHAR10;
            INSERT_DT       CURSOR_DATE;
            UPDATE_DT       CURSOR_DATE;
        BEGIN
            OPEN ALL_INF FOR
                SELECT GEO.GEO_ID,
                       SOURCE_GEO.GEO_ID,
                       SOURCE_GEO.COUNTRY_NAME,
                       SOURCE_GEO.REGION_NAME,
                       SOURCE_GEO.CITY_NAME,
                       SOURCE_GEO.ADDRESS,
                       SOURCE_GEO.RESTAURANT_CODE,
                       SOURCE_GEO.INSERT_DT,
                       SOURCE_GEO.UPDATE_DT
                FROM (SELECT * FROM DW_DATA.DW_GEO) SOURCE_GEO

                         LEFT JOIN
                     DIM_GEO GEO
                     ON (GEO.GEO_ID = SOURCE_GEO.GEO_ID);

            FETCH ALL_INF
                BULK COLLECT INTO
                GEO_ID,
                GEO_SRC_ID,
                COUNTRY_NAME,
                REGION_NAME,
                CITY_NAME,
                ADDRESS,
                RESTAURANT_CODE,
                INSERT_DT,
                UPDATE_DT;

            CLOSE ALL_INF;

            FOR i IN GEO_ID.FIRST .. GEO_ID.LAST
                LOOP
                    IF (GEO_ID(i) IS NULL) THEN
                        INSERT INTO DIM_GEO (GEO_ID,
                                             COUNTRY_NAME,
                                             REGION_NAME,
                                             CITY_NAME,
                                             ADDRESS,
                                             RESTAURANT_CODE,
                                             INSERT_DT,
                                             UPDATE_DT)
                        VALUES (GEO_SRC_ID(i),
                                COUNTRY_NAME(i),
                                REGION_NAME(i),
                                CITY_NAME(i),
                                ADDRESS(i),
                                RESTAURANT_CODE(i),
                                INSERT_DT(i),
                                UPDATE_DT(i));

                    ELSE
                        UPDATE DIM_GEO
                        SET COUNTRY_NAME    = COUNTRY_NAME(i),
                            REGION_NAME     = REGION_NAME(i),
                            CITY_NAME       = CITY_NAME(i),
                            ADDRESS         =ADDRESS(i),
                            RESTAURANT_CODE = RESTAURANT_CODE(i),
                            UPDATE_DT       = INSERT_DT(i)
                        WHERE DIM_GEO.GEO_ID = GEO_ID(i);
                    END IF;
                    COMMIT;
                END LOOP;
        END;
    END LOAD_GEO_SAL;
END pkg_etl_GEO_sal;

