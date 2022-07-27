create table U_DW_REFERENCES."DW.T_DAYS" 
(
   DAY_ID               NUMBER               not null,
   DAY_NUMBER_IN_WEEK   NUMBER,
   DAY_NUMBER_IN_MONTH  NUMBER,
   DAY_NUMBER_IN_YEAR   NUMBER,
   constraint "PK_DW.T_DAYS" primary key (DAY_ID)
);
