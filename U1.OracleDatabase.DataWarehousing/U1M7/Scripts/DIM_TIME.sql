--DROP TABLE DIM_TIME;
--DROP INDEX IDX_DIM_TIME;

/*==============================================================*/
/* Table: DIM_TIME                                              */
/*==============================================================*/
CREATE TABLE DIM_TIME (
   TIME_ID              DATE               NOT NULL,
   YEAR_CALENDAR        NUMBER(4)          NOT NULL,
   YEAR_DAYS_CNT        NUMBER(3)          NOT NULL,
   QUARTER_NUMBER       NUMBER(1)          NOT NULL,
   QUARTER_DAYS_CNT     NUMBER(3)          NOT NULL,
   QUARTER_BEGIN_DT     DATE               NOT NULL,
   QUARTER_END_DT       DATE               NOT NULL,
   MONTH_NUMBER         NUMBER(2)           NOT NULL,
   MONTH_NAME           VARCHAR(30)         NOT NULL,
   MONTH_DAYS_CNT       NUMBER(3)           NOT NULL,
   WEEK_NUMBER          NUMBER(2)           NOT NULL,
   WEEK_END_DT          DATE                NOT NULL,
   DAY_NAME             VARCHAR(30)         NOT NULL,
   DAY_NUMBER_WEEK      NUMBER(1)           NOT NULL,
   DAY_NUMBER_MONTH     NUMBER(2)           NOT NULL,
   DAY_NUMBER_YEAR      NUMBER(3)           NOT NULL,
   CONSTRAINT PK_DIM_TIME PRIMARY KEY (TIME_ID)
);
CREATE INDEX IDX_DIM_TIME ON DIM_TIME(TIME_ID DESC);


INSERT INTO DIM_TIME
SELECT

    TRUNC( sd + rn ), -- time_id
    TO_CHAR( sd + rn, 'YYYY' ), -- year_calendar
    ( TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
    - TRUNC( sd + rn, 'YEAR' ) ) + 1, -- year days_cnt

    TO_CHAR( sd + rn, 'Q' ), --quarter_number
        ( ( CASE
          WHEN TO_CHAR( sd + rn, 'Q' ) = 1 THEN
            TO_DATE( '03/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
          WHEN TO_CHAR( sd + rn, 'Q' ) = 2 THEN
            TO_DATE( '06/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
          WHEN TO_CHAR( sd + rn, 'Q' ) = 3 THEN
            TO_DATE( '09/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
          WHEN TO_CHAR( sd + rn, 'Q' ) = 4 THEN
            TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
        END ) - TRUNC( sd + rn, 'Q' ) + 1 ), --  quarter_days_cnt

    TRUNC( sd + rn, 'Q' ), -- quarter begin_dt

        ( CASE
          WHEN TO_CHAR( sd + rn, 'Q' ) = 1 THEN
            TO_DATE( '03/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
          WHEN TO_CHAR( sd + rn, 'Q' ) = 2 THEN
            TO_DATE( '06/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
          WHEN TO_CHAR( sd + rn, 'Q' ) = 3 THEN
            TO_DATE( '09/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
          WHEN TO_CHAR( sd + rn, 'Q' ) = 4 THEN
            TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
        END ), -- quarter_end_dt


        TO_CHAR( sd + rn, 'MM' ), --month_number
        TO_CHAR( sd + rn, 'FMMonth' ), -- month_name
        TO_CHAR( LAST_DAY( sd + rn ), 'DD' ), -- month_days_cnt

        TO_CHAR( sd + rn, 'W' ), -- week_number
            ( CASE
                  WHEN TO_CHAR( sd + rn, 'D' ) IN ( 1, 2, 3, 4, 5, 6 ) THEN
                    NEXT_DAY( sd + rn, 'СУББОТА' )
                  ELSE
                    ( sd + rn )
                END ), -- week_end_date

        TO_CHAR( sd + rn, 'fmDay' ), -- day_name
        TO_CHAR( sd + rn, 'D' ), -- day_number_week
        TO_CHAR( sd + rn, 'DD' ), -- day_number_month
        TO_CHAR( sd + rn, 'DDD' ) -- day_number_year

    FROM
  (
    SELECT
      TO_DATE( '12/31/2021', 'MM/DD/YYYY' ) sd,
      rownum rn
    FROM dual
      CONNECT BY level <= 1000
  );



SELECT * FROM DIM_TIME ORDER BY TIME_ID;