ALTER SESSION  SET CURRENT_SCHEMA = U_DM;
CREATE OR REPLACE PACKAGE pkg_etl_fct_sales_sal
AS
    PROCEDURE load_FCT_SALES_SAL;
END pkg_etl_fct_sales_sal;