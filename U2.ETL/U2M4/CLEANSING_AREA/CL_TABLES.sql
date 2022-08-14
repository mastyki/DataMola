/*==============================================================*/
/* Table: CL_PRODUCTS                                           */
/*==============================================================*/

CREATE TABLE DW_CL.CL_PRODUCTS(
    PRODUCT_NAME        VARCHAR2(40 BYTE) NOT NULL,
    PRODUCT_DESC        VARCHAR2(40 BYTE) NOT NULL,
    CATEGORY_ID         NUMBER(*, 0) NOT NULL,
    CATEGORY_NAME       VARCHAR2(40 BYTE) NOT NULL,
    CATEGORY_DESC       VARCHAR2(40 BYTE) NOT NULL,
    SUBCATEGORY_ID      NUMBER(*, 0) NOT NULL,
    SUBCATEGORY_NAME    VARCHAR2(40 BYTE) NOT NULL,
    SUBCATEGORY_DESC    VARCHAR2(40 BYTE) NOT NULL,
    FEATURE_ID          NUMBER(*, 0) NOT NULL,
    FEATURE_NAME        VARCHAR2(40 BYTE) NOT NULL,
    FEATURE_DESC        VARCHAR2(40 BYTE) NOT NULL,
    COST_DOLLAR_AMOUNT  NUMBER(5,2) NOT NULL,
    INSERT_DT           DATE NOT NULL,
    UPDATE_DT           DATE
)
TABLESPACE TS_DW_CL;


/*==============================================================*/
/* Table: CL_RESTAURANTS                                        */
/*==============================================================*/
CREATE TABLE DW_CL.CL_RESTAURANTS (
    PHONE               VARCHAR2(40 BYTE) NOT NULL,
    POSTAL_CODE         NUMBER(10,0) NOT NULL,
    ADDRESS             VARCHAR2(40 BYTE) NOT NULL,
    INSERT_DT           DATE NOT NULL,
    UPDATE_DT           DATE
)
TABLESPACE TS_DW_CL;


/*==============================================================*/
/* Table: CL_RESTAURANTS                                        */
/*==============================================================*/
CREATE TABLE DW_CL.CL_GEO (
    COUNTRY_NAME        VARCHAR2(40 BYTE) NOT NULL,
    REGION_NAME         VARCHAR2(40 BYTE) NOT NULL,
    CITY_NAME           VARCHAR2(40 BYTE) NOT NULL,
    INSERT_DT           DATE NOT NULL,
    UPDATE_DT           DATE
)
TABLESPACE TS_DW_CL;


/*==============================================================*/
/* Table: CL_COUPONS                                            */
/*==============================================================*/

CREATE TABLE  DW_CL.CL_COUPONS (
    COUPON_NAME                  VARCHAR2(40) NOT NULL,
    COUPON_DESC                  VARCHAR2(40) NOT NULL,
    MEDIA_TYPE_ID                NUMBER(*,0) NOT NULL,
    MEDIA_TYPE                   VARCHAR2(40) NOT NULL,
    DISCOUNT_PERCENTAGE_AMOUNT   NUMBER(4,2) NOT NULL,
    VALID_FROM                   DATE DEFAULT TO_DATE('01/01/1990', 'DD/MM/YYYY') NOT NULL,
    VALID_TO                     DATE DEFAULT TO_DATE('31/12/9999', 'DD/MM/YYYY') NOT NULL,
    IS_ACTIVE                    CHAR(1 BYTE) DEFAULT ('N') NOT NULL CHECK ( IS_ACTIVE IN('N','Y') ),
    INSERT_DT                    DATE NOT NULL
)
TABLESPACE TS_DW_CL;


/*==============================================================*/
/* Table: CL_PERIODS                                            */
/*==============================================================*/

CREATE TABLE DW_CL.CL_PERIODS(
    PERIOD_NAME VARCHAR2(20) NOT NULL,
    PERIOD_DESC VARCHAR2(40) NOT NULL,
    VALID_FROM  DATE DEFAULT TO_DATE('01/01/1990', 'DD/MM/YYYY') NOT NULL,
    VALID_TO    DATE DEFAULT TO_DATE('31/12/9999', 'DD/MM/YYYY') NOT NULL,
    IS_ACTIVE   CHAR(1 BYTE) DEFAULT ('N') NOT NULL CHECK ( IS_ACTIVE IN('N','Y') ),
    INSERT_DT   DATE NOT NULL
)
TABLESPACE TS_DW_CL;


/*==============================================================*/
/* Table: CL_SALES                                          */
/*==============================================================*/

CREATE TABLE DW_CL.CL_SALES(
    PRODUCT_NAME       VARCHAR2(40 BYTE) NOT NULL,
    PRODUCT_DESC       VARCHAR2(40 BYTE) NOT NULL,
    CATEGORY_ID        NUMBER(*, 0) NOT NULL,
    CATEGORY_NAME      VARCHAR2(40 BYTE) NOT NULL,
    CATEGORY_DESC      VARCHAR2(40 BYTE) NOT NULL,
    SUBCATEGORY_ID     NUMBER(*, 0) NOT NULL,
    SUBCATEGORY_NAME   VARCHAR2(40 BYTE) NOT NULL,
    SUBCATEGORY_DESC   VARCHAR2(40 BYTE) NOT NULL,
    FEATURE_ID         NUMBER(*, 0) NOT NULL,
    FEATURE_NAME       VARCHAR2(40 BYTE) NOT NULL,
    FEATURE_DESC       VARCHAR2(40 BYTE) NOT NULL,
    COST_DOLLAR_AMOUNT NUMBER(5,3) NOT NULL,
    PHONE              VARCHAR2(40 BYTE) NOT NULL,
    POSTAL_CODE        NUMBER(10,0) NOT NULL,
    ADDRESS            VARCHAR2(40 BYTE)  NOT NULL,
    COUNTRY_NAME       CHAR(40) NOT NULL,
    REGION_NAME        CHAR(40) NOT NULL,
    CITY_NAME          CHAR(40) NOT NULL,
    COUPON_NAME                  VARCHAR2(40) NOT NULL,
    COUPON_DESC                  VARCHAR2(40) NOT NULL,
    MEDIA_TYPE_ID                NUMBER(*,0)  NOT NULL,
    MEDIA_TYPE                   VARCHAR2(40) NOT NULL,
    DISCOUNT_PERCENTAGE_AMOUNT   NUMBER(4,2) NOT NULL,
    COUPON_VALID_FROM            DATE DEFAULT TO_DATE('01/01/1990', 'DD/MM/YYYY') NOT NULL,
    COUPON_VALID_TO              DATE DEFAULT TO_DATE('31/12/9999', 'DD/MM/YYYY') NOT NULL,
    COUPON_IS_ACTIVE             CHAR(1 BYTE) DEFAULT ('N') NOT NULL CHECK ( COUPON_IS_ACTIVE IN('N','Y') ),
    PERIOD_NAME VARCHAR2(20) NOT NULL,
    PERIOD_DESC VARCHAR2(40) NOT NULL,
    VALID_FROM  DATE DEFAULT TO_DATE('01/01/1990', 'DD/MM/YYYY') NOT NULL,
    VALID_TO    DATE DEFAULT TO_DATE('31/12/9999', 'DD/MM/YYYY') NOT NULL,
    IS_ACTIVE   CHAR(1 BYTE) DEFAULT ('N') NOT NULL CHECK ( IS_ACTIVE IN('N','Y') ),
    INSERT_DT   DATE  NOT NULL
)
TABLESPACE TS_DW_CL;


