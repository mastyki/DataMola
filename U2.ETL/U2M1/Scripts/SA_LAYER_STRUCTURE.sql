/*==============================================================*/
/* Table: SA_PRODUCTS                                           */
/*==============================================================*/
CREATE TABLE SA_PRODUCTS_DATA (
    PRODUCT_NAME      VARCHAR2(40 BYTE) NOT NULL,
    PRODUCT_DESC      VARCHAR2(40 BYTE),
    CATEGORY_ID       NUMBER(*, 0),
    CATEGORY_NAME     VARCHAR2(40 BYTE),
    CATEGORY_DESC     VARCHAR2(40 BYTE),
    SUBCATEGORY_ID    NUMBER(*, 0),
    SUBCATEGORY_NAME  VARCHAR2(40 BYTE),
    SUBCATEGORY_DESC  VARCHAR2(40 BYTE),
    FEATURE_ID        NUMBER(*, 0),
    FEATURE_NAME      VARCHAR2(40 BYTE),
    FEATURE_DESC      VARCHAR2(40 BYTE),
    INSERT_DT         DATE NOT NULL
)
TABLESPACE TS_SA_PRODUCTS_DATA_01;

/*==============================================================*/
/* Table: SA_RESTAURANTS_DATA                                   */
/*==============================================================*/

CREATE TABLE SA_RESTAURANTS_DATA (
    PHONE              VARCHAR2(40 BYTE) NOT NULL,
    POSTAL_CODE        NUMBER(10,0) NOT NULL,
    ADDRESS            VARCHAR2(40 BYTE) NOT NULL,
    INSERT_DT          DATE NOT NULL
)
TABLESPACE TS_SA_RESTAURANTS_DATA_01;

/*==============================================================*/
/* Table: SA_COUPONS_DATA                                       */
/*==============================================================*/

CREATE TABLE SA_COUPONS_DATA (
    COUPON_NAME                  VARCHAR2(40) NOT NULL,
    COUPON_DESC                  VARCHAR2(40),
    MEDIA_TYPE_ID                NUMBER(*,0) NOT NULL,
    MEDIA_TYPE                   VARCHAR2(40) NOT NULL,
    DISCOUNT_PERCENTAGE_AMOUNT   NUMBER(4,2) NOT NULL,
    VALID_FROM                   DATE NOT NULL ,
    VALID_TO                     DATE NOT NULL,
    INSERT_DT                    DATE NOT NULL
)
TABLESPACE TS_SA_COUPONS_DATA_01;

/*==============================================================*/
/* Table: SA_GEO_DATA                                           */
/*==============================================================*/

CREATE TABLE SA_GEO_DATA (
   COUNTRY_ID           NUMBER(22,0) NOT NULL,
   COUNTRY_NAME         CHAR(20) NOT NULL,
   COUNTRY_CODE         NUMBER(10) NOT NULL,
   COUNTRY_DESC         VARCHAR2(150) NOT NULL,
   REGIO_ID             NUMBER(22,0) NOT NULL,
   REGIO_CODE           NUMBER(10) NOT NULL,
   REGIO_NAME           CHAR(20) NOT NULL,
   REGIO_DESC           VARCHAR2(150) NOT NULL,
   CITY_ID              NUMBER(22,0) NOT NULL,
   CITY_CODE            NUMBER(10) NOT NULL,
   CITY_NAME            CHAR(25) NOT NULL,
   CITY_DESC            VARCHAR2(150) NOT NULL,
   INSERT_DT            DATE NOT NULL
)
TABLESPACE TS_SA_GEO_DATA_01;


/*==============================================================*/
/* Table: SA_PERIODS_DATA                                       */
/*==============================================================*/

CREATE TABLE SA_PERIODS_DATA
(
    PERIOD_NAME VARCHAR2(20),
    PERIOD_DESC VARCHAR2(40),
    BEGIN_DT    DATE DEFAULT TO_DATE('01/01/1990', 'DD/MM/YYYY') NOT NULL,
    END_DT      DATE DEFAULT TO_DATE('31/12/9999', 'DD/MM/YYYY') NOT NULL,
    INSERT_DT   DATE                                             NOT NULL
)
TABLESPACE TS_SA_PERIODS_DATA_01;
