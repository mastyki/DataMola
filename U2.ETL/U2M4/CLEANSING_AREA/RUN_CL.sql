alter session set current_schema = DW_CL;
BEGIN
    pkg_etl_coupons_cl.load_CLEAN_COUPONS;
    pkg_etl_products_cl.load_CLEAN_PRODUCTS;
    pkg_etl_periods_cl.load_CLEAN_PERIODS;
    pkg_etl_restaurants_cl.load_CLEAN_RESTAURANTS;
    pkg_etl_geo_cl.load_CLEAN_GEO;
    pkg_etl_sales_cl.load_CLEAN_SALES;
END;

SELECT * FROM DW_DATA.FCT_SALES order by SALE_ID