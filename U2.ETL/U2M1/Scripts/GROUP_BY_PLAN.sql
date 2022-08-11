SELECT
PRODUCT_NAME, COUNTRY_NAME, COUNT(*) AS QUANTITY, SUM(COST_DOLLAR_AMOUNT) AS TOATAL_SALE_DOLLAR_AMOUNT
FROM TRANSACTIONS
GROUP BY PRODUCT_NAME, COUNTRY_NAME
ORDER BY TOATAL_SALE_DOLLAR_AMOUNT DESC;