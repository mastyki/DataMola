--==============================================================
-- Initial Rows: t_localizations
--==============================================================
INSERT INTO t_localizations ( localization_id
                            , localization_code
                            , localization_desc
                            , localization_desc_ens
                            , lng_id
                            , contry_id
                            , is_default )
     VALUES ( -1
            , 'n.a.'
            , 'Not Available'
            , 'Not Available'
            , NULL
            , NULL
            , NULL );

INSERT INTO t_localizations ( localization_id
                            , localization_code
                            , localization_desc
                            , localization_desc_ens
                            , lng_id
                            , contry_id
                            , is_default )
     VALUES ( -2
            , 'n.d.'
            , 'Not Defined'
            , 'Not Defined'
            , NULL
            , NULL
            , NULL );

INSERT INTO t_localizations ( localization_id
                            , localization_code
                            , localization_desc
                            , localization_desc_ens
                            , lng_id
                            , contry_id
                            , is_default )
     VALUES ( 1
            , 'en-US'
            , 'English'
            , 'English'
            , NULL
            , NULL
            , 1 );

INSERT INTO t_localizations ( localization_id
                            , localization_code
                            , localization_desc
                            , localization_desc_ens
                            , lng_id
                            , contry_id
                            , is_default )
     VALUES ( 2
            , 'ru-RU'
            , 'Russian'
            , 'Русский'
            , NULL
            , NULL
            , NULL );

INSERT INTO t_localizations ( localization_id
                            , localization_code
                            , localization_desc
                            , localization_desc_ens
                            , lng_id
                            , contry_id
                            , is_default )
     VALUES ( 3
            , 'be-BY'
            , 'Belarussian'
            , 'Беларускi'
            , NULL
            , NULL
            , NULL );

COMMIT;