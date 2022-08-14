select * from emastykina.SA_PERIODS_DATA;
select * from DW_CL.CL_PERIODS;
SELECT * FROM SA_COUPONS.SA_COUPONS_DATA;
GRANT SELECT ON emastykina.SA_PERIODS_DATA TO DW_CL;
alter session set current_schema = DW_CL;

CREATE OR REPLACE PACKAGE BODY pkg_etl_periods_cl
AS PROCEDURE load_CLEAN_PERIODS
   AS
      CURSOR c_v
      IS
         SELECT DISTINCT period_name
                       , period_desc
                       , begin_dt
                       , end_dt
                       , insert_dt
           FROM EMASTYKINA.SA_PERIODS_DATA
           WHERE period_name IS NOT NULL
           AND period_desc IS NOT NULL
           AND begin_dt IS NOT NULL
           AND end_dt IS NOT NULL
           AND insert_dt IS NOT NULL
           AND begin_dt < end_dt;
           active_status char (1);
   BEGIN
             EXECUTE IMMEDIATE 'TRUNCATE TABLE  DW_CL.CL_PERIODS';
             FOR i IN c_v LOOP
             IF current_date < i.end_dt THEN  active_status := 'Y';
             ELSE  active_status := 'N';
             END IF;
             INSERT INTO DW_CL.CL_PERIODS(
                         period_name
                       , period_desc
                       , valid_from
                       , valid_to
                       , is_active
                       , insert_dt)
                  VALUES (
                         i.period_name
                       , i.period_desc
                       , i.begin_dt
                       , i.end_dt
                       , active_status
                       , i.insert_dt);
             EXIT WHEN c_v%NOTFOUND;
          END LOOP;

          COMMIT;
   END load_CLEAN_PERIODS;
END pkg_etl_periods_cl;