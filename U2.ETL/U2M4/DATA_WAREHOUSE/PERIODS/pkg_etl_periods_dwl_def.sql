ALTER SESSION  SET CURRENT_SCHEMA = DW_DATA;
CREATE OR REPLACE PACKAGE pkg_etl_periods_dw
AS
    PROCEDURE load_periods_DW;
END pkg_etl_periods_dw;