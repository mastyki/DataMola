--DROP TABLESPACE ts_dw_data_01 INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
--DROP USER dw_data CASCADE;

CREATE TABLESPACE ts_dw_data_01
DATAFILE '/oracle/u02/oradata/EMastykinadb/db_ts_dw_data_01.dat'
SIZE 200M
AUTOEXTEND ON NEXT 100M
SEGMENT SPACE MANAGEMENT AUTO;

CREATE USER dw_data
IDENTIFIED BY "%PWD%"
DEFAULT TABLESPACE ts_dw_data_01;

GRANT CONNECT,RESOURCE TO dw_data;

/*==============================================================*/
/* Table: dim_products                                          */
/*==============================================================*/
CREATE TABLE dw_data.dim_products (
    product_id      NUMBER(*, 0) NOT NULL,
    product_name    VARCHAR2(40 BYTE) NOT NULL,
    product_desc    VARCHAR2(40 BYTE) NOT NULL,
    category_id     NUMBER(*, 0) NOT NULL,
    category_name   VARCHAR2(40 BYTE) NOT NULL,
    category_desc VARCHAR2(40 BYTE) NOT NULL,
    subcategory_id  NUMBER(*, 0) NOT NULL,
    subcategory_name VARCHAR2(40 BYTE) NOT NULL,
    subcategory_desc VARCHAR2(40 BYTE) NOT NULL,
    feature_id  NUMBER(*, 0) NOT NULL,
    feature_name VARCHAR2(40 BYTE) NOT NULL,
    feature_desc VARCHAR2(40 BYTE) NOT NULL,
    cost_dollar_amount NUMBER(*, 2) NOT NULL,
    insert_dt DATE NOT NULL,
    update_dt DATE,
    CONSTRAINT PK_PRODUCTS PRIMARY KEY ( product_id ) ENABLE
);

--DROP SEQUENCE SEQ_DIM_PRODUCTS;
CREATE SEQUENCE dw_data.SEQ_DIM_PRODUCTS
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

/*==============================================================*/
/* Table: dim_coupons                                           */
/*==============================================================*/

CREATE TABLE dw_data.dim_coupons_scd (
    coupon_id NUMBER(*, 0) NOT NULL,
    coupon_name VARCHAR2(40 BYTE) NOT NULL,
    coupon_desc VARCHAR2(40) NOT NULL,
    media_type_id NUMBER(*,0) NOT NULL,
    media_type VARCHAR2(40) NOT NULL,
    discount_percentage_amount NUMBER(4,2) NOT NULL,
    valid_from DATE DEFAULT TO_DATE('01/01/1990', 'DD/MM/YYYY') NOT NULL,
    valid_to DATE DEFAULT TO_DATE('31/12/9999', 'DD/MM/YYYY') NOT NULL,
    is_active VARCHAR2(1) NOT NULL,
    insert_dt DATE NOT NULL,
    CONSTRAINT PK_COUPONS PRIMARY KEY (COUPON_ID) ENABLE
);

--DROP SEQUENCE SEQ_DIM_COUPONS;
CREATE SEQUENCE SEQ_DIM_COUPONS
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

/*==============================================================*/
/* Table: dim_restaurants                                       */
/*==============================================================*/

CREATE TABLE dw_data.dim_restaurants (
    restaurant_id NUMBER(*, 0) NOT NULL,
    phone         VARCHAR2(40 BYTE) NOT NULL,
    postal_code   NUMBER(*, 0) NOT NULL,
    address       VARCHAR2(40 BYTE) NOT NULL,
    insert_dt     DATE NOT NULL,
    update_dt     DATE,
    CONSTRAINT    UI_PHONE UNIQUE (phone),
    CONSTRAINT    UI_POSTAL_CODE UNIQUE (postal_code),
    CONSTRAINT    UI_ADDRESS UNIQUE (address),
    CONSTRAINT    PK_RESTAURANTS PRIMARY KEY ( restaurant_id ) ENABLE
);

--DROP SEQUENCE SEQ_DIM_RESTAURANTS;
CREATE SEQUENCE SEQ_DIM_RESTAURANTS
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

/*==============================================================*/
/* Table: dim_periods_scd                                       */
/*==============================================================*/

CREATE TABLE dw_data.dim_periods_scd(
    PERIOD_ID   NUMBER(*, 0) NOT NULL,
    PERIOD_NAME VARCHAR2(20) NOT NULL,
    PERIOD_DESC VARCHAR2(40) NOT NULL,
    VALID_FROM  DATE DEFAULT TO_DATE('01/01/1990', 'DD/MM/YYYY') NOT NULL,
    VALID_TO    DATE DEFAULT TO_DATE('31/12/9999', 'DD/MM/YYYY') NOT NULL,
    IS_ACTIVE   CHAR(1 BYTE) DEFAULT ('N') NOT NULL CHECK ( IS_ACTIVE IN('N','Y') ),
    INSERT_DT   DATE NOT NULL,
    CONSTRAINT  UI_PERIOD_NAME UNIQUE (PERIOD_NAME),
    CONSTRAINT  PK_PERIODS PRIMARY KEY ( PERIOD_ID ) ENABLE
)

/*==============================================================*/
/* Table: dim-geo                                               */
/*==============================================================*/

CREATE TABLE dw_data.dim_geo (
    GEO_ID              NUMBER(*, 0) NOT NULL,
    COUNTRY_NAME        VARCHAR2(40 BYTE) NOT NULL,
    REGION_NAME         VARCHAR2(40 BYTE) NOT NULL,
    CITY_NAME           VARCHAR2(40 BYTE) NOT NULL,
    INSERT_DT           DATE NOT NULL,
    UPDATE_DT           DATE,
    CONSTRAINT  PK_GEO PRIMARY KEY ( GEO_ID ) ENABLE
);


/*==============================================================*/
/* Table: ST_FCT_SALES_DD                                       */
/*==============================================================*/
CREATE TABLE  dw_data.FCT_SALES (
    SALE_ID NUMBER NOT NULL,
    DT_ID DATE NOT NULL,
    PERIOD_ID NUMBER NOT NULL,
    RESTAURANT_ID NUMBER NOT NULL,
    COUPON_ID NUMBER NOT NULL,
    PRODUCT_ID NUMBER NOT NULL,
    GEO_ID NUMBER NOT NULL,
    CONSTRAINT PK_SALES PRIMARY KEY(SALE_ID) enable,
    CONSTRAINT FK_SALES_PERIODS FOREIGN KEY (PERIOD_ID) REFERENCES dw_data.dim_periods_scd (PERIOD_ID),
    CONSTRAINT FK_SALES_RESTAURANTS FOREIGN KEY (RESTAURANT_ID) REFERENCES dw_data.dim_restaurants (RESTAURANT_ID),
    CONSTRAINT FK_SALES_COUPONS FOREIGN KEY (COUPON_ID) REFERENCES dw_data.dim_coupons_scd (COUPON_ID),
    CONSTRAINT FK_SALES_PRODUCTS FOREIGN KEY (PRODUCT_ID) REFERENCES dw_data.dim_products (PRODUCT_ID),
    CONSTRAINT FK_SALES_GEO FOREIGN KEY (GEO_ID) REFERENCES dw_data.dim_geo (GEO_ID)
)
PARTITION BY RANGE (dt_id)
subpartition by hash(RESTAURANT_ID) subpartitions 4
(
    PARTITION archive_until_2021 VALUES LESS THAN(to_date('01.01.2021','DD.MM.YYYY'))
    (
    subpartition archive_sub_1,
    subpartition archive_sub_2,
    subpartition archive_sub_3,
    subpartition archive_sub_4
    ),
PARTITION q1_2021 VALUES LESS THAN(to_date('01.04.2021','DD.MM.YYYY'))
    (
    subpartition q1_2021_sub_1,
    subpartition q1_2021_sub_2,
    subpartition q1_2021_sub_3,
    subpartition q1_2021_sub_4
    ),
PARTITION q2_2021 VALUES LESS THAN(to_date('01.07.2021','DD.MM.YYYY'))
    (
    subpartition q2_2021_sub_1,
    subpartition q2_2021_sub_2,
    subpartition q2_2021_sub_3,
    subpartition q2_2021_sub_4
    ),
PARTITION q3_2021 VALUES LESS THAN(to_date('01.10.2021','DD.MM.YYYY'))
    (
    subpartition q3_2021_sub_1,
    subpartition q3_2021_sub_2,
    subpartition q3_2021_sub_3,
    subpartition q3_2021_sub_4
    ),
PARTITION q4_2021 VALUES LESS THAN(to_date('01.01.2022','DD.MM.YYYY'))
    (
    subpartition q4_2021_sub_1,
    subpartition q4_2021_sub_2,
    subpartition q4_2021_sub_3,
    subpartition q4_2021_sub_4
    ),
PARTITION q1_2022 VALUES LESS THAN(to_date('01.04.2022','DD.MM.YYYY'))
    (
    subpartition q1_2022_sub_1,
    subpartition q1_2022_sub_2,
    subpartition q1_2022_sub_3,
    subpartition q1_2022_sub_4
    ),
PARTITION q2_2022 VALUES LESS THAN(to_date('01.07.2022','DD.MM.YYYY'))
    (
    subpartition q2_2022_sub_1,
    subpartition q2_2022_sub_2,
    subpartition q2_2022_sub_3,
    subpartition q2_2022_sub_4
    ),
PARTITION q3_2022 VALUES LESS THAN(to_date('01.10.2022','DD.MM.YYYY'))
    (
    subpartition q3_2022_sub_1,
    subpartition q3_2022_sub_2,
    subpartition q3_2022_sub_3,
    subpartition q3_2022_sub_4
    ),
PARTITION q4_2022 VALUES LESS THAN(to_date('01.01.2023','DD.MM.YYYY'))
    (
    subpartition q4_2022_sub_1,
    subpartition q4_2022_sub_2,
    subpartition q4_2022_sub_3,
    subpartition q4_2022_sub_4
    )
);




