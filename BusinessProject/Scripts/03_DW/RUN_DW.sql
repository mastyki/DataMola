alter session set current_schema = DW_DATA;
BEGIN
    PKG_ETL_COUPONS_DW.LOAD_COUPONS_DW();
    PKG_ETL_GEO_DW.LOAD_GEO_DW();
    PKG_ETL_PRODUCTS_DW.LOAD_PRODUCTS_DW();
    PKG_ETL_SALES_DW.LOAD_SALES_DW();
END;



SELECT COUNT(*) FROM DW_SALES ORDER BY SALE_ID