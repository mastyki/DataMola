ALTER SESSION SET CURRENT_SCHEMA = DW_CL;
CREATE OR REPLACE PACKAGE pkg_etl_periods_cl
AS
   PROCEDURE load_CLEAN_PERIODS;
END pkg_etl_periods_cl;