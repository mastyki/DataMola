ALTER SESSION SET CURRENT_SCHEMA = U_SA_LAYER;

--DROP TABLE SA_MTA_FILES;
--DROP TABLE SA_PRODUCTS;
--DROP TABLE SA_COUPONS;
--DROP TABLE SA_GEO;
--DROP TABLE SA_SALES;

/*==============================================================*/
/* Table: SA_MTD_FILES                                         */
/*==============================================================*/

CREATE TABLE SA_MTD_FILES (
    FILE_ID                 VARCHAR2(20 BYTE),
    FILE_NAME               VARCHAR2(20 BYTE),
    FILE_DESC               VARCHAR2(40 BYTE),
    INSERT_DT               DATE,
    STATUS_ID               NUMBER(1) DEFAULT 1
)
TABLESPACE TS_SA_METADATA_01;

/*==============================================================*/
/* Table: SA_PRODUCTS                                           */
/*==============================================================*/

CREATE TABLE SA_PRODUCTS (
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
    SRC_FILE_ID             VARCHAR2(6 BYTE)
)
TABLESPACE TS_SA_PRODUCTS_DATA_01;

/*==============================================================*/
/* Table: SA_COUPONS                                            */
/*==============================================================*/

CREATE TABLE SA_COUPONS  (
    COUPON_ID               INTEGER,
    COUPON_NAME             VARCHAR2(20),
    COUPON_DESC             VARCHAR2(40),
    MEDIA_TYPE_ID           INTEGER,
    MEDIA_TYPE              VARCHAR2(40),
    DISCOUNT_PERCENTAGE     NUMBER(4,2),
    VALID_FROM              DATE,
    VALID_TO                DATE,
    SRC_FILE_ID             VARCHAR2(6 BYTE)
)
TABLESPACE TS_SA_COUPONS_DATA_01;

/*==============================================================*/
/* Table: SA_GEO                                                */
/*==============================================================*/

CREATE TABLE SA_GEO (
   GEO_ID               INTEGER,
   COUNTRY_NAME         VARCHAR2(40),
   REGION_NAME          VARCHAR2(40),
   CITY_NAME            VARCHAR2(40),
   ADDRESS              VARCHAR2(40 BYTE),
   RESTAURANT_CODE      VARCHAR2(10),
   SRC_FILE_ID          VARCHAR2(6 BYTE)
)
TABLESPACE TS_SA_GEO_DATA_01;

/*==============================================================*/
/* Table: SA_SALES                                              */
/*==============================================================*/

CREATE TABLE SA_SALES (
    SALE_ID                 INTEGER,
    SALE_DT                 DATE,
    PRODUCT_NAME            VARCHAR2(40 BYTE),
    FEATURE_NAME            VARCHAR2(40 BYTE),
    COST_DOLLAR_AMOUNT      FLOAT,
    COUPON_NAME             VARCHAR2(20),
    RESTAURANT_CODE         VARCHAR2(10),
    SRC_FILE_ID             VARCHAR2(6 BYTE)
)
TABLESPACE TS_SA_SALES_DATA_01;
TRUNCATE TABLE SA_SALES;
SELECT COUNT(*) FROM SA_SALES ORDER BY SALE_DT DESC;
SELECT * FROM SA_COUPONS ORDER BY VALID_FROM DESC;

UPDATE SA_COUPONS SET COUPON_DESC = MEDIA_TYPE || ' COUPON ' || TO_CHAR(TRUNC(DISCOUNT_PERCENTAGE)) || '% DISCOUNT' ;


UPDATE SA_SALES SET SALE_DT =( SELECT VALID_FROM + TRUNC (COST_DOLLAR_AMOUNT) FROM SA_COUPONS WHERE SA_COUPONS.COUPON_NAME = SA_SALES.COUPON_NAME  ORDER BY COUPON_ID FETCH NEXT 1 ROWS ONLY );

SELECT * FROM SA_COUPONS;
COMMIT;

DECLARE DAYS NUMBER;
BEGIN
 FOR i IN 1 .. 300000
LOOP
    DAYS:= TRUNC(DBMS_RANDOM.VALUE(1,90));
UPDATE SA_SALES SET SALE_DT = SALE_DT+DAYS WHERE SALE_ID = I;


END LOOP;
END;
