ALTER SESSION SET CURRENT_SCHEMA = U_DM;

--DROP TABLE DW_PRODUCTS
--DROP TABLE DW_COUPONS;
--DROP TABLE DW_GEO;
--DROP TABLE DW_SALES;


/*==============================================================*/
/* Table: DIM_PRODUCTS                                           */
/*==============================================================*/

CREATE TABLE DIM_PRODUCTS
(
    PRODUCT_ID       INTEGER           NOT NULL,
    PRODUCT_NAME     VARCHAR2(40 BYTE) NOT NULL,
    PRODUCT_DESC     VARCHAR2(40 BYTE) NOT NULL,
    CATEGORY_ID      INTEGER           NOT NULL,
    CATEGORY_NAME    VARCHAR2(40 BYTE) NOT NULL,
    CATEGORY_DESC    VARCHAR2(40 BYTE) NOT NULL,
    SUBCATEGORY_ID   INTEGER           NOT NULL,
    SUBCATEGORY_NAME VARCHAR2(40 BYTE) NOT NULL,
    SUBCATEGORY_DESC VARCHAR2(40 BYTE) NOT NULL,
    FEATURE_ID       INTEGER           NOT NULL,
    FEATURE_NAME     VARCHAR2(40 BYTE) NOT NULL,
    FEATURE_DESC     VARCHAR2(40 BYTE) NOT NULL,
    INSERT_DT        DATE              NOT NULL,
    UPDATE_DT        DATE              NOT NULL,
    CONSTRAINT PK_PRODUCTS PRIMARY KEY (PRODUCT_ID) ENABLE
);


/*==============================================================*/
/* Table: DIM_COUPONS_SCD                                       */
/*==============================================================*/
CREATE TABLE DIM_COUPONS_SCD
(
    COUPON_SURR_ID      INTEGER DEFAULT SEQ_COUPONS.nextval NOT NULL,
    COUPON_ID           INTEGER                             NOT NULL,
    COUPON_NAME         VARCHAR2(20)                        NOT NULL,
    COUPON_DESC         VARCHAR2(40)                        NOT NULL,
    MEDIA_TYPE_ID       INTEGER                             NOT NULL,
    MEDIA_TYPE          VARCHAR2(40)                        NOT NULL,
    DISCOUNT_PERCENTAGE NUMBER(4, 2)                        NOT NULL,
    VALID_FROM          DATE                                NOT NULL,
    VALID_TO            DATE                                NOT NULL,
    INSERT_DT           DATE                                NOT NULL,
    CONSTRAINT PK_COUPONS PRIMARY KEY (COUPON_ID, VALID_FROM, VALID_TO) ENABLE,
    CONSTRAINT UI_COUPON_SURR_ID UNIQUE (COUPON_SURR_ID) ENABLE
);



/*==============================================================*/
/* Table: DIM_GEO                                                */
/*==============================================================*/

CREATE TABLE DIM_GEO
(
    GEO_ID          INTEGER           NOT NULL,
    COUNTRY_NAME    VARCHAR2(40)      NOT NULL,
    REGION_NAME     VARCHAR2(40)      NOT NULL,
    CITY_NAME       VARCHAR2(40)      NOT NULL,
    ADDRESS         VARCHAR2(40 BYTE) NOT NULL,
    RESTAURANT_CODE VARCHAR2(10)      NOT NULL,
    INSERT_DT       DATE              NOT NULL,
    UPDATE_DT       DATE              NOT NULL,
    CONSTRAINT PK_GEO PRIMARY KEY (GEO_ID) ENABLE
);


CREATE TABLE DIM_TIME
AS
    (SELECT t_days.time_id                     time_id,
            t_days.day_name                    day_name,
            t_days.day_number_in_week          day_number_in_week_iso,
            t_days.day_number_in_month         day_number_in_month_iso,
            t_days.day_number_in_year          day_number_in_year_iso,
            t_weeks.week_id                    week_id,
            t_weeks.week_beg_date              week_beg_date,
            t_weeks.week_ending_date           week_ending_date,
            t_months.month_id                  month_id_iso,
            t_months.calendar_month_number     calendar_month_number_iso,
            t_months.days_in_cal_month         days_in_cal_month_iso,
            t_months.beg_of_cal_month          beg_of_cal_month_iso,
            t_months.end_of_cal_month          end_of_cal_month_iso,
            t_months.calendar_month_name       calendar_month_name_iso,
            m.month_id                         month_id_fin,
            m.calendar_month_number            calendar_month_number_fin,
            m.days_in_cal_month                days_in_cal_month_fin,
            m.beg_of_cal_month                 beg_of_cal_month_fin,
            m.end_of_cal_month                 end_of_cal_month_fin,
            m.calendar_month_name              calendar_month_name_fin,
            t_quarters.quarter_id              quarter_id_iso,
            t_quarters.days_in_cal_quarter     days_in_cal_quarter_iso,
            t_quarters.beg_of_cal_quarter      beg_of_cal_quarter_iso,
            t_quarters.end_of_cal_quarter      end_of_cal_quarter_iso,
            t_quarters.calendar_quarter_number calendar_quarter_number_iso,
            q.quarter_id                       quarter_id_fin,
            q.days_in_cal_quarter              days_in_cal_quarter_fin,
            q.beg_of_cal_quarter               beg_of_cal_quarter_fin,
            q.end_of_cal_quarter               end_of_cal_quarter_fin,
            q.calendar_quarter_number          calendar_quarter_number_fin,
            t_years.year_id                    year_id_iso,
            t_years.calendar_year              calendar_year_iso,
            t_years.days_in_cal_year           days_in_cal_year_iso,
            t_years.beg_of_cal_year            beg_of_cal_year_iso,
            t_years.end_of_cal_year            end_of_cal_year_iso,
            y.year_id                          year_id_fin,
            y.calendar_year                    calendar_year_fin,
            y.days_in_cal_year                 days_in_cal_year_fin,
            y.beg_of_cal_year                  beg_of_cal_year_fin,
            y.end_of_cal_year                  end_of_cal_year_fin
     FROM t_days
              INNER JOIN t_weeks ON t_days.time_id BETWEEN week_beg_date AND week_ending_date
              INNER JOIN t_months ON t_days.time_id BETWEEN beg_of_cal_month AND end_of_cal_month
         AND type = 'iso'
              INNER JOIN t_months m ON t_days.time_id BETWEEN m.beg_of_cal_month AND m.end_of_cal_month
         AND m.type = 'fin'
              INNER JOIN t_quarters
                         ON t_days.time_id BETWEEN t_quarters.beg_of_cal_quarter AND t_quarters.end_of_cal_quarter
                             AND t_quarters.type = 'iso'
              INNER JOIN t_quarters q ON t_days.time_id BETWEEN q.beg_of_cal_quarter AND q.end_of_cal_quarter
         AND q.type = 'fin'
              INNER JOIN t_years ON t_days.time_id BETWEEN t_years.beg_of_cal_year AND t_years.end_of_cal_year
         AND t_years.type = 'iso'
              INNER JOIN t_years y ON t_days.time_id BETWEEN y.beg_of_cal_year AND y.end_of_cal_year
         AND y.type = 'fin');


ALTER TABLE DIM_TIME
    ADD CONSTRAINT PK_TIME
        PRIMARY KEY (TIME_ID);


/*==============================================================*/
/* Table: FCT_SALES_DD                                          */
/*==============================================================*/

CREATE TABLE FCT_SALES_DD
(
    SALE_ID                    INTEGER NOT NULL,
    TIME_ID                    DATE    NOT NULL,
    PRODUCT_ID                 INTEGER NOT NULL,
    GEO_ID                     INTEGER NOT NULL,
    COUPON_ID                  INTEGER NOT NULL,
    COST_DOLLAR_AMOUNT         FLOAT   NOT NULL,
    GROSS_PROFIT_DOLLAR_AMOUNT FLOAT   NOT NULL,
    INSERT_DT                  DATE    NOT NULL,
    UPDATE_DT                  DATE    NOT NULL,
    CONSTRAINT FK_TIME FOREIGN KEY (TIME_ID) REFERENCES DIM_TIME (TIME_ID),
    CONSTRAINT FK_PRODUCT FOREIGN KEY (PRODUCT_ID) REFERENCES DIM_PRODUCTS (PRODUCT_ID),
    CONSTRAINT FK_GEO FOREIGN KEY (GEO_ID) REFERENCES DIM_GEO (GEO_ID),
    CONSTRAINT FK_COUPONS FOREIGN KEY (COUPON_ID) REFERENCES DIM_COUPONS_SCD (COUPON_SURR_ID) ENABLE,
    CONSTRAINT PK_SALES PRIMARY KEY (SALE_ID) ENABLE
);

