/*==============================================================*/
/* Table: ST_DIM_PRODUCT_DD                                     */
/*==============================================================*/

CREATE TABLE ST_DIM_PRODUCTS (
    product_id      NUMBER(*, 0) NOT NULL,
    product_name    VARCHAR2(40 BYTE) NOT NULL,
    product_desc    VARCHAR2(40 BYTE) NOT NULL,
    category_id     NUMBER(*, 0),
    category_name   VARCHAR2(40 BYTE),
    category_description VARCHAR2(40 BYTE),
    subcategory_id  NUMBER(*, 0),
    subcategory_name VARCHAR2(40 BYTE),
    subcategory_description VARCHAR2(40 BYTE),
    feature_id  NUMBER(*, 0),
    feature_name VARCHAR2(40 BYTE),
    feature_description VARCHAR2(40 BYTE),
    cost_dollar_amount NUMBER(*, 2) NOT NULL,
    packaging_type VARCHAR2(40 BYTE),
    insert_dt DATE NOT NULL,
    update_dt DATE NOT NULL,
    CONSTRAINT PK_PRODUCT PRIMARY KEY ( product_id ) ENABLE
);

/*==============================================================*/
/* Table: ST_DIM_RESTAURANTS                                    */
/*==============================================================*/

CREATE TABLE ST_DIM_RESTAURANTS (
    restaurant_id NUMBER(*, 0) NOT NULL,
    phone         VARCHAR2(40 BYTE) NOT NULL,
    postal_code   NUMBER(*, 0) NOT NULL,
    address       VARCHAR2(20 BYTE) NOT NULL,
    city          VARCHAR2(20 BYTE) NOT NULL,
    country       VARCHAR2(20 BYTE) NOT NULL,
    region        VARCHAR2(20 BYTE) NOT NULL,
    CONSTRAINT PK_RESTAURANT PRIMARY KEY ( restaurant_id ) ENABLE
);

/*==============================================================*/
/* Table: ST_DIM_COUPONS_SCD                                    */
/*==============================================================*/

CREATE TABLE ST_DIM_COUPONS_SCD (
    coupon_id NUMBER(*, 0) NOT NULL,
    coupon_desc VARCHAR2(40),
    media_type VARCHAR2(40),
    discount_percentage_amount NUMBER(4,2),
    valid_from DATE DEFAULT TO_DATE('01/01/1990', 'DD/MM/YYYY') NOT NULL ,
    valid_to DATE DEFAULT TO_DATE('31/12/9999', 'DD/MM/YYYY') NOT NULL,
    is_active VARCHAR2(1) NOT NULL ,
    insert_dt DATE NOT NULL,
    update_dt DATE NOT NULL,
    CONSTRAINT PK_COUPON PRIMARY KEY (COUPON_ID) ENABLE
);

/*==============================================================*/
/* Table: DIM_GEO_LOCATIONS                                               */
/*==============================================================*/

CREATE TABLE ST_DIM_GEO (
   GEO_ID               NUMBER(22) NOT NULL,
   COUNTRY_ID           NUMBER(22,0) NOT NULL,
   COUNTRY_NAME         CHAR(20) NOT NULL,
   COUNTRY_CODE         NUMBER(10) NOT NULL,
   COUNTRY_CODE_A2      CHAR(2) NOT NULL,
   COUNTRY_CODE_A3      CHAR(3) NOT NULL,
   COUNTRY_DESC         VARCHAR2(150) NOT NULL,
   REGIO_ID             NUMBER(22,0) NOT NULL,
   REGIO_CODE           NUMBER(10) NOT NULL,
   REGIO_NAME           CHAR(20) NOT NULL,
   REGIO_DESC           VARCHAR2(150) NOT NULL,
   CITY_ID              NUMBER(22,0) NOT NULL,
   CITY_CODE            NUMBER(10) NOT NULL,
   CITY_NAME            CHAR(25) NOT NULL,
   CITY_DESC            VARCHAR2(150) NOT NULL,
   INSERT_DT            DATE NOT NULL,
   UPDATE_DT            DATE NOT NULL,
   CONSTRAINT PK_GEO PRIMARY KEY (GEO_ID) ENABLE
);

/*==============================================================*/
/* Table: DIM_TIME                                              */
/*==============================================================*/

CREATE TABLE ST_DIM_TIME (
   TIME_ID              DATE NOT NULL,
   DAY_NAME             VARCHAR(40),
   DAY_NUM_WEEK_ISO     NUMBER(1),
   DAY_NUM_MONTH_ISO    NUMBER(2),
   DAY_NUM_QUARTER_ISO  NUMBER(2),
   DAY_NUM_YEAR_ISO     NUMBER(3),
   WEEK_ID_ISO          NUMBER,
   WEEK_NUM_ISO         NUMBER(2),
   WEEK_DAYS_CNT_ISO    NUMBER(2),
   WEEK_BEGIN_DT_ISO    DATE,
   WEEK_END_DT_ISO      DATE,
   MONTH_ID_ISO         NUMBER,
   MONTH_NAME_ISO       VARCHAR(40),
   MONTH_NUM_ISO        NUMBER(2),
   MONTH_DAYS_CNT_ISO   NUMBER(2),
   MONTH_BEGIN_DT_ISO   DATE,
   MONTH_END_DT_ISO     DATE,
   QUARTER_ID_ISO       NUMBER,
   QUARTER_NUM_ISO      NUMBER(1),
   QUARTER_DAYS_CNT_ISO NUMBER(3),
   QUARTER_BEGIN_DT_ISO DATE,
   QUARTER_END_DT_ISO   DATE,
   YEAR_ID_ISO          NUMBER,
   YEAR_NUM_ISO         NUMBER(4),
   YEAR_DAYS_CNT_ISO    NUMBER(3),
   YEAR_BEGIN_DT_ISO    DATE,
   YEAR_END_DT_ISO      DATE,
   DAY_NUM_WEEK_FIN     NUMBER(1),
   DAY_NUM_MONTH_FIN    NUMBER(2),
   DAY_NUM_QUARTER_FIN  NUMBER(2),
   DAY_NUM_YEAR_FIN     NUMBER(3),
   WEEK_ID_FIN          NUMBER,
   WEEK_NUM_FIN         NUMBER(2),
   WEEK_DAYS_CNT_FIN    NUMBER(2),
   WEEK_BEGIN_DT_FIN    DATE,
   WEEK_END_DT_FIN      DATE,
   MONTH_ID_FIN         NUMBER,
   MONTH_NAME_FIN       VARCHAR(40),
   MONTH_NUM_FIN        NUMBER(2),
   MONTH_DAYS_CNT_FIN   NUMBER(2),
   MONTH_BEGIN_DT_FIN   DATE,
   MONTH_END_DT_FIN     DATE,
   QUARTER_ID_FIN       NUMBER,
   QUARTER_NUM_FIN      NUMBER(1),
   QUARTER_DAYS_CNT_FIN NUMBER(3),
   QUARTER_BEGIN_DT_FIN DATE,
   QUARTER_END_DT_FIN   DATE,
   YEAR_ID_FIN          NUMBER,
   YEAR_NUM_FIN         NUMBER(4),
   YEAR_DAYS_CNT_FIN    NUMBER(3),
   YEAR_BEGIN_DT_FIN    DATE,
   YEAR_END_DT_FIN      DATE,
   CONSTRAINT PK_TIME PRIMARY KEY (TIME_ID) ENABLE
);

/*==============================================================*/
/* Table: ST_DIM_PERIODS                                      */
/*==============================================================*/

CREATE TABLE ST_DIM_PERIODS (
    PERIOD_ID NUMBER NOT NULL,
    PERIOD_NAME VARCHAR2(40),
    PERIOD_DESC VARCHAR2(40),
    BEGIN_DT DATE DEFAULT TO_DATE('01/01/1990', 'DD/MM/YYYY') NOT NULL ,
    END_DT DATE DEFAULT TO_DATE('31/12/9999', 'DD/MM/YYYY') NOT NULL,
    IS_ACTIVE VARCHAR2(4) NOT NULL ,
    INSERT_DT DATE NOT NULL,
    UPDATE_DT DATE NOT NULL,
    CONSTRAINT PK_PERIOD PRIMARY KEY (PERIOD_ID) ENABLE
);

/*==============================================================*/
/* Table: ST_FCT_SALES_DD                                       */
/*==============================================================*/


CREATE TABLE  ST_FCT_SALES_DD (
    SALE_ID NUMBER NOT NULL,
    TIME_ID DATE NOT NULL,
    PERIOD_ID NUMBER NOT NULL,
    RESTAURANT_ID NUMBER NOT NULL,
    COUPON_ID NUMBER NOT NULL,
    PRODUCT_ID NUMBER NOT NULL,
    GEO_ID NUMBER NOT NULL,
    TAX_DOLLAR_AMOUNT NUMBER(5,2),
    TAX_PERCENTAGE_AMOUNT NUMBER(4,2),
    GROSS_PROFIT_DOLLAR_AMOUNT NUMBER(5,2),
    CONSTRAINT PK_SALES PRIMARY KEY(SALE_ID),
    CONSTRAINT FK_SALES_PERIODS FOREIGN KEY (PERIOD_ID) REFERENCES ST_DIM_PERIODS (PERIOD_ID),
    CONSTRAINT FK_SALES_TIME FOREIGN KEY (TIME_ID) REFERENCES ST_DIM_TIME (TIME_ID),
    CONSTRAINT FK_SALES_RESTAURANTS FOREIGN KEY (RESTAURANT_ID) REFERENCES ST_DIM_RESTAURANTS (RESTAURANT_ID),
    CONSTRAINT FK_SALES_COUPONS FOREIGN KEY (COUPON_ID) REFERENCES ST_DIM_COUPONS_SCD (COUPON_ID),
    CONSTRAINT FK_SALES_PRODUCTS FOREIGN KEY (PRODUCT_ID) REFERENCES ST_DIM_PRODUCTS (PRODUCT_ID),
    CONSTRAINT FK_SALES_GEO FOREIGN KEY (GEO_ID) REFERENCES ST_DIM_GEO (GEO_ID)
)
PARTITION BY RANGE (TIME_ID) INTERVAL (NUMTOYMINTERVAL(1,'MONTH'))
SUBPARTITION BY HASH (RESTAURANT_ID) SUBPARTITIONS 4
(
    PARTITION P0 VALUES LESS THAN (TO_DATE('1-1-2020','DD-MM-YYYY')),
    PARTITION P1 VALUES LESS THAN (TO_DATE('1-1-2021','DD-MM-YYYY')),
    PARTITION P2 VALUES LESS THAN (TO_DATE('1-1-2022','DD-MM-YYYY'))
);