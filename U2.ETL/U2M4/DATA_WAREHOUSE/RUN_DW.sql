alter session set current_schema = DW_DATA;
BEGIN
    pkg_etl_coupons_dw.LOAD_COUPONS_DW();
    PKG_ETL_GEO_DW.LOAD_GEO_DW();
    PKG_ETL_PERIODS_DW.LOAD_PERIODS_DW();
    PKG_ETL_PRODUCTS_DW.LOAD_PRODUCTS_DW();
    PKG_ETL_RESTAURANTS_DW.LOAD_RESTAURANTS_DW();
    PKG_ETL_SALES_DW.LOAD_SALES_DW();
END;

truncate table DW_DATA.DIM_COUPONS_SCD;
truncate table DW_DATA.DIM_geo;
truncate table DW_DATA.DIM_PERIODS_SCD;
truncate table DW_DATA.DIM_PRODUCTS;
truncate table DW_DATA.DIM_RESTAURANTS;
truncate table DW_DATA.FCT_SALES;
select * from FCT_SALES;
select * from DIM_RESTAURANTS