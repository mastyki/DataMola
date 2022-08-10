/*==============================================================*/
/* Table: SA_PRODUCTS                                           */
/*==============================================================*/
CREATE TABLE SA_PRODUCTS_DATA (
    PRODUCT_NAME        VARCHAR2(40 BYTE),
    PRODUCT_DESC        VARCHAR2(40 BYTE),
    CATEGORY_ID         NUMBER(*, 0),
    CATEGORY_NAME       VARCHAR2(40 BYTE),
    CATEGORY_DESC       VARCHAR2(40 BYTE),
    SUBCATEGORY_ID      NUMBER(*, 0),
    SUBCATEGORY_NAME    VARCHAR2(40 BYTE),
    SUBCATEGORY_DESC    VARCHAR2(40 BYTE),
    FEATURE_ID          NUMBER(*, 0),
    FEATURE_NAME        VARCHAR2(40 BYTE),
    FEATURE_DESC        VARCHAR2(40 BYTE),
    COST_DOLLAR_AMOUNT  NUMBER (5,2),
    INSERT_DT           DATE
)
TABLESPACE TS_SA_PRODUCTS_DATA_01;

/*==============================================================*/
/* Table: SA_RESTAURANTS_DATA                                   */
/*==============================================================*/

CREATE TABLE SA_RESTAURANTS_DATA (
    PHONE              VARCHAR2(40 BYTE),
    POSTAL_CODE        NUMBER(10,0),
    ADDRESS            VARCHAR2(40 BYTE),
    INSERT_DT          DATE
)
TABLESPACE TS_SA_RESTAURANTS_DATA_01;

/*==============================================================*/
/* Table: SA_COUPONS_DATA                                       */
/*==============================================================*/

CREATE TABLE SA_COUPONS_DATA (
    COUPON_NAME                  VARCHAR2(40),
    COUPON_DESC                  VARCHAR2(40),
    MEDIA_TYPE_ID                NUMBER(*,0),
    MEDIA_TYPE                   VARCHAR2(40),
    DISCOUNT_PERCENTAGE_AMOUNT   NUMBER(4,2),
    VALID_FROM                   DATE,
    VALID_TO                     DATE,
    INSERT_DT                    DATE
)
TABLESPACE TS_SA_COUPONS_DATA_01;

/*==============================================================*/
/* Table: SA_GEO_DATA                                           */
/*==============================================================*/

CREATE TABLE  SA_GEO_DATA (
   COUNTRY_NAME         CHAR(40),
   REGION_NAME          CHAR(40),
   CITY_NAME            CHAR(40),
   INSERT_DT            DATE
)
TABLESPACE TS_SA_GEO_DATA_01;



/*==============================================================*/
/* Table: SA_PERIODS_DATA                                       */
/*==============================================================*/

CREATE TABLE SA_PERIODS_DATA
(
    PERIOD_NAME VARCHAR2(20),
    PERIOD_DESC VARCHAR2(40),
    BEGIN_DT    DATE DEFAULT TO_DATE('01/01/1990', 'DD/MM/YYYY'),
    END_DT      DATE DEFAULT TO_DATE('31/12/9999', 'DD/MM/YYYY'),
    INSERT_DT   DATE
)
TABLESPACE TS_SA_PERIODS_DATA_01;
