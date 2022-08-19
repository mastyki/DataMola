ALTER SESSION SET CURRENT_SCHEMA = DW_CL;

--DROP TABLE CL_PRODUCTS;
--DROP TABLE CL_PRODUCTS_BAD;
--DROP TABLE CL_COUPONS;
--DROP TABLE CL_COUPONS_BAD;
--DROP TABLE CL_GEO;
--DROP TABLE CL_GEO_BAD;
--DROP TABLE CL_SALES;
--DROP TABLE CL_SALES_BAD;


/*==============================================================*/
/* Table: CL_PRODUCTS                                           */
/*==============================================================*/

CREATE TABLE CL_PRODUCTS (
    PRODUCT_ID              INTEGER             NOT NULL,
    PRODUCT_NAME            VARCHAR2(40 BYTE)   NOT NULL,
    PRODUCT_DESC            VARCHAR2(40 BYTE)   NOT NULL,
    CATEGORY_ID             INTEGER             NOT NULL,
    CATEGORY_NAME           VARCHAR2(40 BYTE)   NOT NULL,
    CATEGORY_DESC           VARCHAR2(40 BYTE)   NOT NULL,
    SUBCATEGORY_ID          INTEGER             NOT NULL,
    SUBCATEGORY_NAME        VARCHAR2(40 BYTE)   NOT NULL,
    SUBCATEGORY_DESC        VARCHAR2(40 BYTE)   NOT NULL,
    FEATURE_ID              INTEGER             NOT NULL,
    FEATURE_NAME            VARCHAR2(40 BYTE)   NOT NULL,
    FEATURE_DESC            VARCHAR2(40 BYTE)   NOT NULL,
    SRC_FILE_ID             VARCHAR2(6 BYTE)    NOT NULL
)
TABLESPACE TS_DW_CL;

/*==============================================================*/
/* Table: CL_PRODUCTS_BAD                                       */
/*==============================================================*/

CREATE TABLE CL_PRODUCTS_BAD (
    PRODUCT_ID              INTEGER,
    PRODUCT_NAME            VARCHAR2(40 BYTE),
    PRODUCT_DESC            VARCHAR2(40 BYTE),
    CATEGORY_ID             INTEGER,
    CATEGORY_NAME           VARCHAR2(40 BYTE),
    CATEGORY_DESC           VARCHAR2(40 BYTE),
    SUBCATEGORY_ID          INTEGER,
    SUBCATEGORY_NAME        VARCHAR2(40 BYTE),
    SUBCATEGORY_DESC        VARCHAR2(40 BYTE),
    FEATURE_ID              INTEGER,
    FEATURE_NAME            VARCHAR2(40 BYTE),
    FEATURE_DESC            VARCHAR2(40 BYTE),
    BAD_COMMENT             VARCHAR2(40 BYTE),
    SRC_FILE_ID             VARCHAR2(6 BYTE)
)
TABLESPACE TS_DW_CL;

/*==============================================================*/
/* Table: CL_COUPONS                                            */
/*==============================================================*/

CREATE TABLE CL_COUPONS  (
    COUPON_ID               INTEGER             NOT NULL,
    COUPON_NAME             VARCHAR2(20)        NOT NULL,
    COUPON_DESC             VARCHAR2(40)        NOT NULL,
    MEDIA_TYPE_ID           INTEGER             NOT NULL,
    MEDIA_TYPE              VARCHAR2(40)        NOT NULL,
    DISCOUNT_PERCENTAGE     NUMBER(4,2)         NOT NULL,
    VALID_FROM              DATE                NOT NULL,
    VALID_TO                DATE                NOT NULL,
    SRC_FILE_ID             VARCHAR2(6 BYTE)    NOT NULL
)
TABLESPACE TS_DW_CL;

/*==============================================================*/
/* Table: CL_COUPONS_BAD                                        */
/*==============================================================*/

CREATE TABLE CL_COUPONS_BAD (
    COUPON_ID               INTEGER,
    COUPON_NAME             VARCHAR2(20),
    COUPON_DESC             VARCHAR2(40),
    MEDIA_TYPE_ID           INTEGER,
    MEDIA_TYPE              VARCHAR2(40),
    DISCOUNT_PERCENTAGE     NUMBER(4,2),
    VALID_FROM              DATE,
    VALID_TO                DATE,
    BAD_COMMENT             VARCHAR2(40 BYTE),
    SRC_FILE_ID             VARCHAR2(6 BYTE)
)
TABLESPACE TS_DW_CL;

/*==============================================================*/
/* Table: CL_GEO                                                */
/*==============================================================*/

CREATE TABLE CL_GEO (
   GEO_ID               INTEGER                 NOT NULL,
   COUNTRY_NAME         VARCHAR2(40)            NOT NULL,
   REGION_NAME          VARCHAR2(40)            NOT NULL,
   CITY_NAME            VARCHAR2(40)            NOT NULL,
   ADDRESS              VARCHAR2(40 BYTE)       NOT NULL,
   RESTAURANT_CODE      VARCHAR2(10)            NOT NULL,
   SRC_FILE_ID          VARCHAR2(6 BYTE)        NOT NULL
)
TABLESPACE TS_DW_CL;


/*==============================================================*/
/* Table: CL_GEO_BAD                                            */
/*==============================================================*/

CREATE TABLE CL_GEO_BAD (
   GEO_ID               INTEGER,
   COUNTRY_NAME         VARCHAR2(40),
   REGION_NAME          VARCHAR2(40),
   CITY_NAME            VARCHAR2(40),
   ADDRESS              VARCHAR2(40 BYTE),
   RESTAURANT_CODE      VARCHAR2(10),
   BAD_COMMENT          VARCHAR2(40 BYTE),
   SRC_FILE_ID          VARCHAR2(6 BYTE)
)
TABLESPACE TS_DW_CL;

/*==============================================================*/
/* Table: CL_SALES                                              */
/*==============================================================*/

CREATE TABLE CL_SALES (
    SALE_ID                 INTEGER             NOT NULL,
    SALE_DT                 DATE                NOT NULL,
    PRODUCT_NAME            VARCHAR2(40 BYTE)   NOT NULL,
    FEATURE_NAME            VARCHAR2(40 BYTE)   NOT NULL,
    COST_DOLLAR_AMOUNT      FLOAT               NOT NULL,
    COUPON_NAME             VARCHAR2(20)        NOT NULL,
    RESTAURANT_CODE         VARCHAR2(10)        NOT NULL,
    SRC_FILE_ID             VARCHAR2(6 BYTE)    NOT NULL
)
TABLESPACE TS_DW_CL;

/*==============================================================*/
/* Table: CL_SALES_BAD                                          */
/*==============================================================*/

CREATE TABLE CL_SALES_BAD (
    SALE_ID                 INTEGER,
    SALE_DT                 DATE,
    PRODUCT_NAME            VARCHAR2(40 BYTE),
    FEATURE_NAME            VARCHAR2(40 BYTE),
    COST_DOLLAR_AMOUNT      FLOAT,
    COUPON_NAME             VARCHAR2(20),
    RESTAURANT_CODE         VARCHAR2(10),
    BAD_COMMENT             VARCHAR2(40 BYTE),
    SRC_FILE_ID             VARCHAR2(6 BYTE)
)
TABLESPACE TS_DW_CL;







