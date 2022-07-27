--drop view u_dw_references.cu_lng_types;

--==============================================================
-- View: cu_lng_types                                           
--==============================================================
create or replace view u_dw_references.cu_lng_types as
SELECT src.lng_type_id
     , src.lng_type_code AS src_type_code
     , NVL ( lc.lng_type_code, '-' ) AS lng_type_code
     , NVL ( lc.lng_type_desc, 'Not Defined' ) AS lng_type_desc
     , NVL ( lc.localization_id, -99 ) AS localization_id
  FROM w_lng_types src
     , lc_lng_types lc
 WHERE lc.lng_type_id(+) = src.lng_type_id
   AND lc.localization_id(+) = pkg_session_params.get_user_localization_id
with read only;

comment on column u_dw_references.cu_lng_types.lng_type_id is
'Identificator of Language Types - ISO 639-3';

comment on column u_dw_references.cu_lng_types.src_type_code is
'Code of Language Types - ISO 639-3';
