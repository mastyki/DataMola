ALTER SESSION  SET CURRENT_SCHEMA = DW_DATA;
CREATE OR REPLACE PACKAGE pkg_etl_sales_dw
AS
    PROCEDURE load_SALES_DW;
END pkg_etl_sales_dw;