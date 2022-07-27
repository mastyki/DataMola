--Create Directory with path to External References files storage
/*==============================================================*/
/* Directories: ext_references                                  */
/*==============================================================*/
CREATE OR REPLACE DIRECTORY ext_references
AS
  '/mnt/ext_references/';

GRANT READ ON DIRECTORY ext_references TO u_dw_ext_references;
GRANT WRITE ON DIRECTORY ext_references TO u_dw_ext_references;