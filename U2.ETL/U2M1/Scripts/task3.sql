SELECT COUNT(*),PRODUCT_CATEGORY
FROM DIM_PRODUCTS
GROUP BY PRODUCT_CATEGORY
ORDER BY PRODUCT_CATEGORY;

SELECT COUNT(*), PROCUREMENT_DOLLAR_AMOUNT
FROM DIM_PRODUCTS
GROUP BY PROCUREMENT_DOLLAR_AMOUNT
ORDER BY PROCUREMENT_DOLLAR_AMOUNT DESC
FETCH FIRST 10 ROWS ONLY;

-- adhoc view on coupons data

SELECT MEDIA_TYPE, IS_ACTIVE, COUNT(*)
FROM DIM_COUPONS_SCD
GROUP BY MEDIA_TYPE, IS_ACTIVE;

-- merging

CREATE TABLE MG_PRODUCTS(
    ID NUMBER,
    CATEGORY VARCHAR2(40BYTE),
    PRICE NUMBER(5,2)
);

INSERT INTO MG_PRODUCTS
SELECT ROWNUM,PRODUCT_CATEGORY, TRUNC(DBMS_RANDOM.VALUE(1, 20),2)
from DIM_PRODUCTS;

SELECT * FROM MG_PRODUCTS;

MERGE INTO DIM_PRODUCTS P
    USING (SELECT ID, CATEGORY, PRICE FROM MG_PRODUCTS group by ID,CATEGORY, PRICE ) MG
    ON (MG.ID = P.PRODUCT_ID)
WHEN MATCHED THEN
    UPDATE SET P.COST_DOLLAR_AMOUNT = MG.PRICE
WHEN NOT MATCHED THEN
    INSERT (PRODUCT_ID, PRODUCT_CATEGORY, COST_DOLLAR_AMOUNT)
    VALUES (MG.ID, MG.CATEGORY, MG.PRICE);

SELECT * FROM DIM_PRODUCTS;
COMMIT;




SELECT * FROM DIM_PRODUCTS;

