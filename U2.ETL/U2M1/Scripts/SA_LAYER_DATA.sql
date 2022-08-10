/*==============================================================*/
/* Table: SA_DIM_PRODUCTS                                       */
/*==============================================================*/
CREATE SEQUENCE feature_seq START WITH 1;
CREATE TABLE TMP_FEATURES(
    FEATURE_ID        NUMBER(*, 0) DEFAULT feature_seq.nextval NOT NULL,
    CATEGORY_ID       NUMBER(*, 0) NOT NULL,
    SUBCATEGORY_ID    NUMBER(*, 0) NOT NULL,
    FEATURE_NAME      VARCHAR2(40 BYTE) NOT NULL
);

INSERT INTO TMP_FEATURES (CATEGORY_ID, SUBCATEGORY_ID, FEATURE_NAME) VALUES (1,1,'SPICY');
INSERT INTO TMP_FEATURES (CATEGORY_ID, SUBCATEGORY_ID, FEATURE_NAME) VALUES (1,2,'SPICY');
INSERT INTO TMP_FEATURES (CATEGORY_ID, SUBCATEGORY_ID, FEATURE_NAME) VALUES (1,3,'SPICY');
INSERT INTO TMP_FEATURES (CATEGORY_ID, SUBCATEGORY_ID, FEATURE_NAME) VALUES (1,4,'SPICY');
INSERT INTO TMP_FEATURES (CATEGORY_ID, SUBCATEGORY_ID, FEATURE_NAME) VALUES (1,1,'ORIGINAL');
INSERT INTO TMP_FEATURES (CATEGORY_ID, SUBCATEGORY_ID, FEATURE_NAME) VALUES (1,2,'ORIGINAL');
INSERT INTO TMP_FEATURES (CATEGORY_ID, SUBCATEGORY_ID, FEATURE_NAME) VALUES (1,3,'ORIGINAL');
INSERT INTO TMP_FEATURES (CATEGORY_ID, SUBCATEGORY_ID, FEATURE_NAME) VALUES (1,4,'ORIGINAL');
INSERT INTO TMP_FEATURES (CATEGORY_ID, SUBCATEGORY_ID, FEATURE_NAME) VALUES (1,5,'CHOCOLATE');
INSERT INTO TMP_FEATURES (CATEGORY_ID, SUBCATEGORY_ID, FEATURE_NAME) VALUES (1,5,'CARAMEL');
INSERT INTO TMP_FEATURES (CATEGORY_ID, SUBCATEGORY_ID, FEATURE_NAME) VALUES (1,5,'STRAWBERRY');
INSERT INTO TMP_FEATURES (CATEGORY_ID, SUBCATEGORY_ID, FEATURE_NAME) VALUES (2,1,'WITH ICE');
INSERT INTO TMP_FEATURES (CATEGORY_ID, SUBCATEGORY_ID, FEATURE_NAME) VALUES (2,1,'WITHOUT ICE');
INSERT INTO TMP_FEATURES (CATEGORY_ID, SUBCATEGORY_ID, FEATURE_NAME) VALUES (2,2,'WITH SUGAR');
INSERT INTO TMP_FEATURES (CATEGORY_ID, SUBCATEGORY_ID, FEATURE_NAME) VALUES (2,2,'WITHOUT SUGAR');

SELECT * FROM TMP_PRODUCTS P
LEFT JOIN TMP_FEATURES TF on P.CATEGORY_ID = TF.CATEGORY_ID and P.SUBCATEGORY_ID = TF.SUBCATEGORY_ID;

INSERT INTO SA_PRODUCTS_DATA(PRODUCT_NAME, PRODUCT_DESC, CATEGORY_ID, CATEGORY_NAME, CATEGORY_DESC, SUBCATEGORY_ID,
                             SUBCATEGORY_NAME, SUBCATEGORY_DESC, INSERT_DT, FEATURE_ID, FEATURE_NAME)
(SELECT P.PRODUCT_NAME, P.PRODUCT_DESC, P.CATEGORY_ID, P.CATEGORY_NAME, P.CATEGORY_DESC, P.SUBCATEGORY_ID,
                             P.SUBCATEGORY_NAME, P.SUBCATEGORY_DESC, P.INSERT_DT, F.FEATURE_ID, F.FEATURE_NAME FROM TMP_PRODUCTS P
LEFT JOIN TMP_FEATURES F on P.CATEGORY_ID = F.CATEGORY_ID and P.SUBCATEGORY_ID = F.SUBCATEGORY_ID);
UPDATE SA_PRODUCTS_DATA
SET FEATURE_DESC = (FEATURE_NAME|| ' ' || SA_PRODUCTS_DATA.PRODUCT_NAME);
COMMIT;
SELECT * FROM SA_PRODUCTS_DATA;

SELECT COUNT(*) FROM SA_PRODUCTS_DATA;

/*==============================================================*/
/* Table: SA_RESTAURANTS_DATA                                   */
/*==============================================================*/

INSERT INTO SA_RESTAURANTS_DATA(PHONE, POSTAL_CODE, ADDRESS, INSERT_DT)
SELECT '+'|| TO_CHAR(TRUNC(dbms_random.value(10000000000, 99999999999))),
       TRUNC(dbms_random.value(1000000000, 9999999999)),
       'STREET '||
       dbms_random.STRING('U', TRUNC(dbms_random.value(2, 15))) || ' ' ||
       TO_CHAR(TRUNC(dbms_random.value(1,100))),
       TO_DATE(
               TRUNC(
                       DBMS_RANDOM.VALUE(TO_CHAR(DATE '2015-01-01', 'J')
                           , TO_CHAR(DATE '2022-01-01', 'J')
                           )
                   ), 'J'
           )
FROM DUAL
CONNECT BY LEVEL <= 150;
COMMIT;

SELECT count(*) FROM SA_RESTAURANTS_DATA;


/*==============================================================*/
/* Table: SA_COUPONS_DATA                                       */
/*==============================================================*/

INSERT INTO SA_COUPONS_DATA(COUPON_NAME,DISCOUNT_PERCENTAGE_AMOUNT,VALID_FROM,INSERT_DT, MEDIA_TYPE_ID, MEDIA_TYPE)
WITH
CTE_COUPON_NAME AS(
    SELECT 'COUPON ' || TO_CHAR(TRUNC(dbms_random.value(1, 10)*10000)) AS NAME
           ,TRUNC(dbms_random.value(1, 20)) AS DISCONT
           ,TO_CHAR(TRUNC(dbms_random.value(1, 5))) AS  MEDIA_ID
           ,TO_DATE(
               TRUNC(
                       DBMS_RANDOM.VALUE(TO_CHAR(DATE '2015-01-01', 'J')
                           , TO_CHAR(DATE '2022-01-01', 'J')
                           )
                   ), 'J'
           )AS INSERTION_DT
           ,TO_DATE(
               TRUNC(
                       DBMS_RANDOM.VALUE(TO_CHAR(DATE '2015-01-01', 'J')
                           , TO_CHAR(DATE '2022-01-01', 'J')
                           )
                   ), 'J'
           )AS VALID_FROM_DT
    FROM DUAL
    CONNECT BY LEVEL <= 1000
),
CTE_MEDIA_TYPE AS (
    SELECT 1 AS ID, 'ONLINE' AS TYPE FROM DUAL UNION ALL
    SELECT 2 AS ID, 'OUTDOOR' AS TYPE FROM DUAL UNION ALL
    SELECT 3 AS ID, 'MOBILE' AS TYPE FROM DUAL UNION ALL
    SELECT 4 AS ID, 'PRINT' AS TYPE FROM DUAL
)
SELECT NAME, DISCONT, VALID_FROM_DT, INSERTION_DT, MEDIA_ID,TYPE  FROM CTE_COUPON_NAME
    INNER JOIN  CTE_MEDIA_TYPE ON MEDIA_ID=CTE_MEDIA_TYPE.ID;

UPDATE SA_COUPONS_DATA
SET VALID_TO = ADD_MONTHS(VALID_FROM,3);
COMMIT;

UPDATE SA_COUPONS_DATA
SET COUPON_DESC = COUPON_NAME || ' ' || MEDIA_TYPE || ' ' || VALID_FROM || ' - ' || VALID_TO;

COMMIT;
SELECT COUNT(*) FROM SA_COUPONS_DATA


/*==============================================================*/
/* Table: SA_GEO_DATA                                           */
/*==============================================================*/


UPDATE SA_GEO_DATA
SET INSERT_DT = TO_DATE(
               TRUNC(
                       DBMS_RANDOM.VALUE(TO_CHAR(DATE '2015-01-01', 'J')
                           , TO_CHAR(DATE '2022-01-01', 'J')
                           )
                   ), 'J'
           );
COMMIT;

/*==============================================================*/
/* Table: SA_PERIODS_DATA                                       */
/*==============================================================*/

INSERT INTO SA_PERIODS_DATA (PERIOD_NAME,BEGIN_DT, INSERT_DT)
SELECT 'PERIOD ' || TO_CHAR(ROWNUM),
       TO_DATE(
               TRUNC(
                       DBMS_RANDOM.VALUE(TO_CHAR(DATE '2015-01-01', 'J')
                           , TO_CHAR(DATE '2022-01-01', 'J')
                           )
                   ), 'J'
           ),
       TO_DATE(
               TRUNC(
                       DBMS_RANDOM.VALUE(TO_CHAR(DATE '2015-01-01', 'J')
                           , TO_CHAR(DATE '2022-01-01', 'J')
                           )
                   ), 'J'
           )
FROM DUAL
CONNECT BY LEVEL <= 100;

UPDATE SA_PERIODS_DATA
SET END_DT = ADD_MONTHS(BEGIN_DT,12),
    PERIOD_DESC = PERIOD_NAME || ' DESC';
COMMIT;
