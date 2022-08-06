
alter table "DW.TIME"
   drop constraint "FK_DW.TIME_REFERENCE_DW.T_DAY";

alter table "DW.TIME"
   drop constraint "FK_DW.TIME_REFERENCE_DW.T_WEE";

alter table "DW.TIME"
   drop constraint "FK_DW.TIME_REFERENCE_DW.T_YEA";

alter table "DW.TIME"
   drop constraint "FK_DW.TIME_REFERENCE_DW.T_MON";

alter table "DW.TIME"
   drop constraint "FK_DW.TIME_REFERENCE_DW.T.QUA";

drop table "DW.T.QUARTERS" cascade constraints;

drop table "DW.TIME" cascade constraints;

drop table "DW.T_DAYS" cascade constraints;

drop table "DW.T_MONTH" cascade constraints;

drop table "DW.T_WEEKS" cascade constraints;

drop table "DW.T_YEARS" cascade constraints;

/*==============================================================*/
/* Table: "DW.TIME"                                             */
/*==============================================================*/

create table "DW.TIME" (
   TIME_ID              DATE                  not null,
   DAY_ID               NUMBER(22,0),
   WEEK_ID              NUMBER(22,0),
   YEAR_ID              NUMBER(22,0),
   MONTH_ID             NUMBER(22,0),
   QUARTER_ID           NUMBER(22,0),
   constraint "PK_DW.TIME" primary key (TIME_ID)
);

/*==============================================================*/
/* Table: "DW.T_DAYS"                                           */
/*==============================================================*/

create table "DW.T_DAYS" (
   DAY_ID               NUMBER(22,0)          not null,
   DAY_NAME             VARCHAR(30),
   DAY_NUMBER_WEEK      NUMBER(1),
   DAY_NUMBER_MONTH     NUMBER(2),
   DAY_NUMBER_YEAR      NUMBER(3),
   constraint "PK_DW.T_DAYS" primary key (DAY_ID)
);

/*==============================================================*/
/* Table: "DW.T_WEEKS"                                          */
/*==============================================================*/
create table "DW.T_WEEKS" (
   WEEK_ID              NUMBER(22,0)          not null,
   WEEK_NUMBER          NUMBER(2),
   WEEK_END_DT          DATE,
   constraint "PK_DW.T_WEEKS" primary key (WEEK_ID)
);

/*==============================================================*/
/* Table: "DW.T_MONTH"                                          */
/*==============================================================*/
create table "DW.T_MONTH" (
   MONTH_ID             NUMBER(22,0)          not null,
   MONTH_NUMBER         NUMBER(2),
   MONTH_NAME           VARCHAR(30),
   MONTH_DAYS_CNT       NUMBER(3),
   constraint "PK_DW.T_MONTH" primary key (MONTH_ID)
);

/*==============================================================*/
/* Table: "DW.T.QUARTERS"                                       */
/*==============================================================*/
create table "DW.T.QUARTERS" (
   QUARTER_ID           NUMBER(22,0)          not null,
   QUARTER_NUMBER       NUMBER(1)             not null,
   QUARTER_DAYS_CNT     NUMBER(3),
   QUARTER_BEGIN_DT     DATE,
   QUARTER_END_DT       DATE,
   constraint "PK_DW.T.QUARTERS" primary key (QUARTER_ID)
);



/*==============================================================*/
/* Table: "DW.T_YEARS"                                          */
/*==============================================================*/
create table "DW.T_YEARS" (
   YEAR_ID              NUMBER(22,0)          not null,
   YEAR_CALENDAR        NUMBER(4),
   YEAR_DAYS_CNT        NUMBER(3),
   constraint "PK_DW.T_YEARS" primary key (YEAR_ID)
);


alter table "DW.TIME"
   add constraint "FK_DW.TIME_REFERENCE_DW.T_DAY" foreign key (DAY_ID)
      references "DW.T_DAYS" (DAY_ID);

alter table "DW.TIME"
   add constraint "FK_DW.TIME_REFERENCE_DW.T_WEE" foreign key (WEEK_ID)
      references "DW.T_WEEKS" (WEEK_ID);

alter table "DW.TIME"
   add constraint "FK_DW.TIME_REFERENCE_DW.T_YEA" foreign key (YEAR_ID)
      references "DW.T_YEARS" (YEAR_ID);

alter table "DW.TIME"
   add constraint "FK_DW.TIME_REFERENCE_DW.T_MON" foreign key (MONTH_ID)
      references "DW.T_MONTH" (MONTH_ID);

alter table "DW.TIME"
   add constraint "FK_DW.TIME_REFERENCE_DW.T.QUA" foreign key (QUARTER_ID)
      references "DW.T.QUARTERS" (QUARTER_ID);