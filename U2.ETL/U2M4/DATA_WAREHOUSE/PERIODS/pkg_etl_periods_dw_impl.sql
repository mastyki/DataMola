GRANT SELECT ON dw_cl.cl_periods TO DW_DATA;
alter session set current_schema = DW_DATA;
select * from  dw_cl.cl_periods;
CREATE OR REPLACE PACKAGE body pkg_etl_periods_dw
AS
   PROCEDURE load_periods_DW
   AS
       BEGIN
           MERGE INTO DW_DATA.dim_periods_scd A
           USING (
               SELECT   period_name
                       , period_desc
                       , valid_from
                       , valid_to
                       , is_active
                       , insert_dt
               FROM dw_cl.cl_periods
           ) B
           ON (        a.period_name = b.period_name and
                       a.period_desc = b.period_desc and
                       a.valid_from = b.valid_from and
                       a.valid_to = b.valid_to and
                       a.is_active = b.is_active and
                       a.valid_to = b.valid_to)
           WHEN NOT MATCHED THEN INSERT (
                         a.period_id
                       , a.period_name
                       , a.period_desc
                       , a.valid_from
                       , a.valid_to
                       , a.is_active
                       , a.insert_dt)
                                 VALUES (
                         DW_DATA.SEQ_DIM_PERIODS.NEXTVAL
                       , b.period_name
                       , b.period_desc
                       , b.valid_from
                       , b.valid_to
                       , b.is_active
                       , b.insert_dt);
           COMMIT;
    END load_periods_DW;
END pkg_etl_periods_dw;

