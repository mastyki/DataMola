-- DAILY REPORT ON ALL SUBCATEGORIES IN ALL COUNTRIES
SELECT DISTINCT
    INSERT_DT AS TRANSACTION_DT,
    DECODE(GROUPING(PRODUCT_NAME),1, 'ALL PRODUCTS', PRODUCT_NAME) AS PRODUCT_NAME,
    DECODE(GROUPING(COUNTRY_NAME),1, 'ALL COUNTRIES', COUNTRY_NAME) AS COUNTRY_NAME,
    SUM(COST_DOLLAR_AMOUNT- TRANSACTIONS.COST_DOLLAR_AMOUNT*TRANSACTIONS.DISCOUNT_PERCENTAGE_AMOUNT/100) AS DAILY_PROFIT
FROM TRANSACTIONS
GROUP BY INSERT_DT, CUBE(PRODUCT_NAME, COUNTRY_NAME)
HAVING grouping_id (PRODUCT_NAME) = 1  AND grouping_id (COUNTRY_NAME) = 1
ORDER BY  TRANSACTION_DT DESC, DAILY_PROFIT DESC;


-- MONTHLY REPORT ON ALL PRODUCTS IN ALL COUNTRIES
SELECT DISTINCT
    TO_CHAR(INSERT_DT,'YY-MM') AS MONTH,
    DECODE(GROUPING(PRODUCT_NAME),1, 'ALL PRODUCTS', PRODUCT_NAME) AS PRODUCT_NAME,
    DECODE(GROUPING(COUNTRY_NAME),1, 'ALL COUNTRIES', COUNTRY_NAME) AS COUNTRY_NAME,
    SUM(COST_DOLLAR_AMOUNT-TRANSACTIONS.COST_DOLLAR_AMOUNT*TRANSACTIONS.DISCOUNT_PERCENTAGE_AMOUNT/100) AS MONTH_PROFIT
FROM TRANSACTIONS
GROUP BY TO_CHAR(INSERT_DT,'YY-MM') , CUBE(PRODUCT_NAME, COUNTRY_NAME)
HAVING grouping_id (PRODUCT_NAME) = 1  AND grouping_id (COUNTRY_NAME) = 1
ORDER BY  MONTH DESC;

--ROLLUP BY TIME
SELECT
       DECODE ( GROUPING_ID ( TRUNC ( INSERT_DT
                                      , 'Year' )
                              , TRUNC ( INSERT_DT
                                      , 'Q' )
                              , TRUNC ( INSERT_DT
                                      , 'Month' )
                              , TRUNC ( INSERT_DT
                                      , 'DD' ) )
                , 7, 'Total for year'
                , 15, 'GRANT TOTAL'
                , TRUNC ( INSERT_DT
                        , 'Year' ) )
            AS YEAR
       , DECODE ( GROUPING_ID ( TRUNC ( INSERT_DT
                                      , 'Year' )
                              , TRUNC ( INSERT_DT
                                      , 'Q' )
                              , TRUNC ( INSERT_DT
                                      , 'Month' )
                              , TRUNC ( INSERT_DT
                                      , 'DD' ) )
                , 3, 'Total for quarter'
                , TRUNC (INSERT_DT
                        , 'Q' ) )
            AS QUARTER
       , DECODE ( GROUPING_ID ( TRUNC ( INSERT_DT
                                      , 'Year' )
                              , TRUNC ( INSERT_DT
                                      , 'Q' )
                              , TRUNC ( INSERT_DT
                                      , 'Month' )
                              , TRUNC ( INSERT_DT
                                      , 'DD' ) )
                , 1, 'Total for month'
                , TRUNC ( INSERT_DT
                        , 'Month' ) )
            AS MONTH
       , DECODE ( GROUPING_ID ( TRUNC ( INSERT_DT
                                      , 'Year' )
                              , TRUNC ( INSERT_DT
                                      , 'Q' )
                              , TRUNC ( INSERT_DT
                                      , 'Month' )
                              , TRUNC ( INSERT_DT
                                      , 'DD' ) )
                , 15, ''
                , TRUNC ( INSERT_DT
                        , 'DD' ) )
            AS DAY
       ,SUM(COST_DOLLAR_AMOUNT-TRANSACTIONS.COST_DOLLAR_AMOUNT*TRANSACTIONS.DISCOUNT_PERCENTAGE_AMOUNT/100)
            AS DAILY_PROFIT
    FROM TRANSACTIONS
    GROUP BY ROLLUP ( TRUNC ( INSERT_DT
                        , 'Year' ), TRUNC ( INSERT_DT
                                          , 'Q' ), TRUNC (INSERT_DT
                                                         , 'Month' ), TRUNC ( INSERT_DT
                                                                            , 'DD' ) )
    ORDER BY DAILY_PROFIT DESC;






