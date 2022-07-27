alter table u_dw_references.t_lng_links
   drop constraint FK_T_LANGUAGES2T_LNG_LINKS_C;

alter table u_dw_references.t_lng_links
   drop constraint FK_T_LANGUAGES2T_LNG_LINKS_P;

drop table u_dw_references.t_lng_links cascade constraints;

--==============================================================
-- Table: t_lng_links                                           
--==============================================================
create table u_dw_references.t_lng_links 
(
   parent_lng_id        NUMBER(22,0)         not null,
   child_lng_id         NUMBER(22,0)         not null,
   link_type_id         NUMBER(3,0)          not null,
   constraint PK_T_LNG_LINKS primary key (parent_lng_id, child_lng_id, link_type_id)
         using index
       local
       tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01
 partition by list
 (link_type_id)
 (partition
         p_Macro2Individ
        values (1)
         nocompress);

comment on column u_dw_references.t_lng_links.parent_lng_id is
'Link: Paranet Object - Languages T_LANGUAGES';

comment on column u_dw_references.t_lng_links.child_lng_id is
'Link: Child Object - Languages T_LANGUAGES';

comment on column u_dw_references.t_lng_links.link_type_id is
'Link Type: 1 - Macrolanguages to Individual Languages';

alter table u_dw_references.t_lng_links
   add constraint FK_T_LANGUAGES2T_LNG_LINKS_C foreign key (child_lng_id)
      references u_dw_references.t_languages (lng_id);

alter table u_dw_references.t_lng_links
   add constraint FK_T_LANGUAGES2T_LNG_LINKS_P foreign key (parent_lng_id)
      references u_dw_references.t_languages (lng_id);
