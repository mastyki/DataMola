ALTER SESSION SET CURRENT_SCHEMA = DW_DATA;

--DROP TABLE DW_PRODUCTS
--DROP TABLE DW_COUPONS;
--DROP TABLE DW_GEO;
--DROP TABLE DW_SALES;


/*==============================================================*/
/* Table: DW_PRODUCTS                                           */
/*==============================================================*/

CREATE TABLE DW_PRODUCTS
(
    PRODUCT_ID       INTEGER DEFAULT SEQ_PRODUCTS.nextval NOT NULL,
    PRODUCT_SRC_ID   INTEGER                              NOT NULL,
    PRODUCT_NAME     VARCHAR2(40 BYTE)                    NOT NULL,
    PRODUCT_DESC     VARCHAR2(40 BYTE)                    NOT NULL,
    CATEGORY_ID      INTEGER                              NOT NULL,
    CATEGORY_NAME    VARCHAR2(40 BYTE)                    NOT NULL,
    CATEGORY_DESC    VARCHAR2(40 BYTE)                    NOT NULL,
    SUBCATEGORY_ID   INTEGER                              NOT NULL,
    SUBCATEGORY_NAME VARCHAR2(40 BYTE)                    NOT NULL,
    SUBCATEGORY_DESC VARCHAR2(40 BYTE)                    NOT NULL,
    FEATURE_ID       INTEGER                              NOT NULL,
    FEATURE_NAME     VARCHAR2(40 BYTE)                    NOT NULL,
    FEATURE_DESC     VARCHAR2(40 BYTE)                    NOT NULL,
    SRC_FILE_ID      VARCHAR2(6 BYTE)                     NOT NULL,
    INSERT_DT        DATE                                 NOT NULL,
    UPDATE_DT        DATE                                 NOT NULL,
    CONSTRAINT PK_PRODUCTS PRIMARY KEY (PRODUCT_ID) ENABLE
)
    TABLESPACE TS_DW_DATA_01;

/*==============================================================*/
/* Table: DW_COUPONS                                            */
/*==============================================================*/

CREATE TABLE DW_COUPONS
(
    COUPON_ID           INTEGER DEFAULT SEQ_COUPONS.nextval NOT NULL,
    COUPON_SRC_ID       INTEGER                             NOT NULL,
    COUPON_NAME         VARCHAR2(20)                        NOT NULL,
    COUPON_DESC         VARCHAR2(40)                        NOT NULL,
    MEDIA_TYPE_ID       INTEGER                             NOT NULL,
    MEDIA_TYPE          VARCHAR2(40)                        NOT NULL,
    DISCOUNT_PERCENTAGE NUMBER(4, 2)                        NOT NULL,
    VALID_FROM          DATE                                NOT NULL,
    VALID_TO            DATE                                NOT NULL,
    SRC_FILE_ID         VARCHAR2(6 BYTE)                    NOT NULL,
    INSERT_DT           DATE                                NOT NULL,
    CONSTRAINT PK_COUPONS PRIMARY KEY (COUPON_ID) ENABLE
)
    TABLESPACE TS_DW_DATA_01;

/*==============================================================*/
/* Table: DW_GEO                                                */
/*==============================================================*/

CREATE TABLE DW_GEO
(
    GEO_ID          INTEGER DEFAULT SEQ_GEO.nextval NOT NULL,
    GEO_SRC_ID      INTEGER                         NOT NULL,
    COUNTRY_NAME    VARCHAR2(40)                    NOT NULL,
    REGION_NAME     VARCHAR2(40)                    NOT NULL,
    CITY_NAME       VARCHAR2(40)                    NOT NULL,
    ADDRESS         VARCHAR2(40 BYTE)               NOT NULL,
    RESTAURANT_CODE VARCHAR2(10)                    NOT NULL,
    SRC_FILE_ID     VARCHAR2(6 BYTE)                NOT NULL,
    INSERT_DT       DATE                            NOT NULL,
    UPDATE_DT       DATE                            NOT NULL,
    CONSTRAINT PK_GEO PRIMARY KEY (GEO_ID) ENABLE
)
    TABLESPACE TS_DW_DATA_01;


/*==============================================================*/
/* Table: DW_SALES                                              */
/*==============================================================*/

CREATE TABLE DW_SALES
(
    SALE_ID            INTEGER DEFAULT SEQ_SALES.nextval NOT NULL,
    SALE_SRC_ID        INTEGER                           NOT NULL,
    SALE_DT            DATE                              NOT NULL,
    PRODUCT_ID         INTEGER                           NOT NULL,
    PRODUCT_NAME       VARCHAR2(40 BYTE)                 NOT NULL,
    FEATURE_NAME       VARCHAR2(40 BYTE)                 NOT NULL,
    COST_DOLLAR_AMOUNT FLOAT                             NOT NULL,
    COUPON_ID          INTEGER                           NOT NULL,
    COUPON_NAME        VARCHAR2(20)                      NOT NULL,
    GEO_ID             INTEGER                           NOT NULL,
    RESTAURANT_CODE    VARCHAR2(10)                      NOT NULL,
    SRC_FILE_ID        VARCHAR2(6 BYTE)                  NOT NULL,
    INSERT_DT          DATE                              NOT NULL,
    UPDATE_DT          DATE                              NOT NULL,
    CONSTRAINT PK_SALES PRIMARY KEY (SALE_ID) ENABLE
)
    TABLESPACE TS_DW_DATA_01;





