GRANT SELECT ON DW_CL.cl_sales TO DW_DATA;
alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_etl_sales_dw
AS
  PROCEDURE LOAD_SALES_DW
   AS
     BEGIN
      DECLARE
       TYPE CURSOR_NUMBER IS TABLE OF number;
       TYPE CURSOR_VARCHAR IS TABLE OF varchar2(40);
       TYPE CURSOR_DATE IS TABLE OF date;
       TYPE CURSOR_FLOAT IS TABLE OF float;
       TYPE BIG_CURSOR IS REF CURSOR ;
       ALL_INF BIG_CURSOR;
       sale_id CURSOR_NUMBER;
       dt_id CURSOR_DATE;
       period_id CURSOR_NUMBER;
       restaurant_id CURSOR_NUMBER;
       coupon_id CURSOR_NUMBER;
       product_id CURSOR_NUMBER;
       geo_id CURSOR_NUMBER;
 BEGIN
    OPEN ALL_INF FOR
        SELECT
                sales.sale_id
              , pr.product_id
              , cp.coupon_id
              , rs.restaurant_id
              , pd.period_id
              , pd.insert_dt
              , geo.geo_id
           FROM (SELECT DISTINCT *
                           FROM DW_CL.cl_sales) source_cl
                     LEFT JOIN
                        DW_DATA.dim_products pr
                     ON (source_cl.product_name=pr.product_name)
                     LEFT JOIN
                        DW_DATA.dim_coupons_scd cp
                     ON (source_cl.coupon_name=cp.coupon_name)
                     LEFT JOIN
                        DW_DATA.dim_restaurants rs
                     ON (source_cl.insert_dt= rs.insert_dt)
                     LEFT JOIN
                        DW_DATA.dim_periods_scd pd
                     ON (source_cl.period_name=pd.period_name)
                     LEFT JOIN
                        DW_DATA.dim_geo geo
                     ON (source_cl.city_name =geo.city_name and source_cl.region_name =geo.region_name)
                     LEFT JOIN
                        DW_DATA.fct_sales sales
                     ON (pr.product_id=sales.product_id AND cp.coupon_id=sales.coupon_id AND
                         rs.restaurant_id=sales.restaurant_id AND pd.period_id= sales.period_id)
    WHERE rs.restaurant_id IS NOT NULL ;

    FETCH ALL_INF
    BULK COLLECT INTO
                sale_id
              , product_id
              , coupon_id
              , restaurant_id
              , period_id
              , dt_id
              , geo_id;

    CLOSE ALL_INF;

    FOR i IN sale_id.FIRST .. sale_id.LAST LOOP
       IF ( sale_id ( i ) IS NULL ) THEN
          INSERT INTO dw_data.fct_sales (
                sale_id
              , product_id
              , coupon_id
              , restaurant_id
              , period_id
              , dt_id
              , geo_id)
               VALUES ( SEQ_FCT_SALES.NEXTVAL
              , product_id(i)
              , coupon_id(i)
              , restaurant_id(i)
              , period_id(i)
              , dt_id(i)
              , geo_id(i));
          COMMIT;
       END IF;
    END LOOP;
 END;
   END LOAD_SALES_DW;
END pkg_etl_sales_dw;

    begin
PKG_ETL_SALES_DW.LOAD_SALES_DW();
end;

    /*
     FOR i IN sale_id.FIRST .. sale_id.LAST LOOP
       IF ( sale_id ( i ) IS NULL ) THEN
          INSERT INTO dw_data.fct_sales (
                sale_id
              , product_id
              , coupon_id
              , restaurant_id
              , period_id
              , dt_id
              , geo_id)
               VALUES ( SEQ_FCT_SALES.NEXTVAL
              , product_id(i)
              , coupon_id(i)
              , restaurant_id(i)
              , period_id(i)
              , dt_id(i)
              , geo_id(i));
          COMMIT;
       END IF;
    END LOOP;
     */
     SELECT
                sales.sale_id
              , pr.product_id
              , cp.coupon_id
              , rs.restaurant_id
              , pd.period_id
              , pd.insert_dt
              , geo.geo_id
           FROM (SELECT DISTINCT *
                           FROM DW_CL.cl_sales) source_cl
                     LEFT JOIN
                        DW_DATA.dim_products pr
                     ON (source_cl.product_name=pr.product_name)
                     LEFT JOIN
                        DW_DATA.dim_coupons_scd cp
                     ON (source_cl.coupon_name=cp.coupon_name)
                     RIGHT JOIN
                        DW_DATA.dim_restaurants rs
                     ON (source_cl.insert_dt=rs.INSERT_DT)
                     LEFT JOIN
                        DW_DATA.dim_periods_scd pd
                     ON (source_cl.period_name=pd.period_name)
                     LEFT JOIN
                        DW_DATA.dim_geo geo
                     ON (source_cl.city_name =geo.city_name and source_cl.region_name =geo.region_name)
                     LEFT JOIN
                        DW_DATA.fct_sales sales
                     ON (pr.product_id=sales.product_id AND cp.coupon_id=sales.coupon_id AND
                         rs.restaurant_id=sales.restaurant_id AND pd.period_id= sales.period_id)
where rs.RESTAURANT_ID is not null
select  *from  DIM_RESTAURANTS LEFT JOIN  DW_CL.CL_SALES ON (DIM_RESTAURANTS.POSTAL_CODE= DW_CL.CL_SALES.POSTAL_CODE)


        select * from( SELECT DISTINCT *
                           FROM DW_CL.cl_sales) source_cl
                     LEFT JOIN
                        DW_DATA.dim_products pr
                     ON (source_cl.product_name=pr.product_name)
                     LEFT JOIN
                        DW_DATA.dim_coupons_scd cp
                     ON (source_cl.coupon_name=cp.coupon_name)
                     LEFT OUTER JOIN
                        DW_DATA.dim_restaurants rs
                     ON (source_cl.insert_dt=rs.INSERT_DT)
                     LEFT JOIN
                        DW_DATA.dim_periods_scd pd
                     ON (source_cl.period_name=pd.period_name)
                     LEFT JOIN
                        DW_DATA.dim_geo geo
                     ON (source_cl.city_name =geo.city_name and source_cl.region_name =geo.region_name)
                     LEFT JOIN
                        DW_DATA.fct_sales sales
                     ON (pr.product_id=sales.product_id AND cp.coupon_id=sales.coupon_id AND
                         rs.restaurant_id=sales.restaurant_id AND pd.period_id= sales.period_id)
SELECT DISTINCT *
                           FROM DW_CL.cl_sales;
SELECT DISTINCT *
                           FROM DIM_RESTAURANTS