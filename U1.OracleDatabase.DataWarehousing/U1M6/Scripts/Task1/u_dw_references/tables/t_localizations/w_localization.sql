drop view w_localizations;

--==============================================================
-- View: w_localizations                                        
--==============================================================
create or replace view w_localizations as
SELECT localization_id
     , localization_code
     , localization_desc
     , localization_desc_ens
     , lng_id
     , contry_id
     , is_default
  FROM t_localizations;

comment on column w_localizations.localization_id is
'Identificator of Supported References Languages';

comment on column w_localizations.localization_code is
'Code of Supported References Languages';

comment on column w_localizations.localization_desc is
'Name of Supported References Languages';

comment on column w_localizations.localization_desc_ens is
'Endonym Name of  Supported References Languages';

comment on column w_localizations.lng_id is
'Disabled - FK for Language_Id - Post Mapped by Load PKG';

comment on column w_localizations.contry_id is
'Disabled - FK for Country_Id - Post Mapped by Load PKG';

comment on column w_localizations.is_default is
'Default Language for all Application and Members on DataBase';

grant SELECT on w_localizations to PUBLIC;
