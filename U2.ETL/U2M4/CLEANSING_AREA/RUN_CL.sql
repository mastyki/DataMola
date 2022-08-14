BEGIN
    pkg_etl_coupon_cl.load_CLEAN_COUPON_DATA;
    pkg_etl_product_cl.load_CLEAN_PRODUCT_DATA;
    pkg_etl_period_cl.load_CLEAN_PERIOD_DATA;
    pkg_etl_restaurant_cl.load_CLEAN_RESTAURANT_DATA;
END;