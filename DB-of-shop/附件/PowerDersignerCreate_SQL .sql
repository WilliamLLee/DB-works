/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     2019/4/2 0:52:51                             */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Commodity') and o.name = 'FK_COMMODIT_PRODUCE_MANUFACT')
alter table Commodity
   drop constraint FK_COMMODIT_PRODUCE_MANUFACT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DiscountCommodity') and o.name = 'FK_DISCOUNT_INHERITAN_COMMODIT')
alter table DiscountCommodity
   drop constraint FK_DISCOUNT_INHERITAN_COMMODIT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Employee') and o.name = 'FK_EMPLOYEE_WORKON_STORE')
alter table Employee
   drop constraint FK_EMPLOYEE_WORKON_STORE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('FreshCommodity') and o.name = 'FK_FRESHCOM_INHERITAN_COMMODIT')
alter table FreshCommodity
   drop constraint FK_FRESHCOM_INHERITAN_COMMODIT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('LimitCommodity') and o.name = 'FK_LIMITCOM_INHERITAN_COMMODIT')
alter table LimitCommodity
   drop constraint FK_LIMITCOM_INHERITAN_COMMODIT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Register') and o.name = 'FK_REGISTER_REGISTER_VIP')
alter table Register
   drop constraint FK_REGISTER_REGISTER_VIP
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Register') and o.name = 'FK_REGISTER_REGISTER2_STORE')
alter table Register
   drop constraint FK_REGISTER_REGISTER2_STORE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Sale') and o.name = 'FK_SALE_SALE_VIP')
alter table Sale
   drop constraint FK_SALE_SALE_VIP
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Sale') and o.name = 'FK_SALE_SALE2_COMMODIT')
alter table Sale
   drop constraint FK_SALE_SALE2_COMMODIT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Supply') and o.name = 'FK_SUPPLY_SUPPLY_STORE')
alter table Supply
   drop constraint FK_SUPPLY_SUPPLY_STORE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Supply') and o.name = 'FK_SUPPLY_SUPPLY2_SUPPLIER')
alter table Supply
   drop constraint FK_SUPPLY_SUPPLY2_SUPPLIER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Supply') and o.name = 'FK_SUPPLY_SUPPLY3_COMMODIT')
alter table Supply
   drop constraint FK_SUPPLY_SUPPLY3_COMMODIT
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Commodity')
            and   name  = 'Produce_FK'
            and   indid > 0
            and   indid < 255)
   drop index Commodity.Produce_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Commodity')
            and   type = 'U')
   drop table Commodity
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DiscountCommodity')
            and   type = 'U')
   drop table DiscountCommodity
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Employee')
            and   name  = 'Workon_FK'
            and   indid > 0
            and   indid < 255)
   drop index Employee.Workon_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Employee')
            and   type = 'U')
   drop table Employee
go

if exists (select 1
            from  sysobjects
           where  id = object_id('FreshCommodity')
            and   type = 'U')
   drop table FreshCommodity
go

if exists (select 1
            from  sysobjects
           where  id = object_id('LimitCommodity')
            and   type = 'U')
   drop table LimitCommodity
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Manufacture')
            and   type = 'U')
   drop table Manufacture
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Register')
            and   name  = 'Register2_FK'
            and   indid > 0
            and   indid < 255)
   drop index Register.Register2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Register')
            and   name  = 'Register_FK'
            and   indid > 0
            and   indid < 255)
   drop index Register.Register_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Register')
            and   type = 'U')
   drop table Register
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Sale')
            and   name  = 'Sale2_FK'
            and   indid > 0
            and   indid < 255)
   drop index Sale.Sale2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Sale')
            and   name  = 'Sale_FK'
            and   indid > 0
            and   indid < 255)
   drop index Sale.Sale_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Sale')
            and   type = 'U')
   drop table Sale
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Store')
            and   type = 'U')
   drop table Store
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Supplier')
            and   type = 'U')
   drop table Supplier
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Supply')
            and   name  = 'Supply3_FK'
            and   indid > 0
            and   indid < 255)
   drop index Supply.Supply3_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Supply')
            and   name  = 'Supply2_FK'
            and   indid > 0
            and   indid < 255)
   drop index Supply.Supply2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Supply')
            and   name  = 'Supply_FK'
            and   indid > 0
            and   indid < 255)
   drop index Supply.Supply_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Supply')
            and   type = 'U')
   drop table Supply
go

if exists (select 1
            from  sysobjects
           where  id = object_id('VIP')
            and   type = 'U')
   drop table VIP
go

/*==============================================================*/
/* Table: Commodity                                             */
/*==============================================================*/
create table Commodity (
   Commodity_ID         int                  not null,
   Manf_ID              int                  not null,
   Cmd_name             varchar              not null,
   Cmd_saleprice        int                  not null,
   Cmd_buyprice         int                  not null,
   Cmd_proDate          datetime             not null,
   Cmd_leftNum          int                  not null,
   Cmd_shelflife        datetime             not null,
   constraint PK_COMMODITY primary key nonclustered (Commodity_ID)
)
go

/*==============================================================*/
/* Index: Produce_FK                                            */
/*==============================================================*/
create index Produce_FK on Commodity (
Manf_ID ASC
)
go

/*==============================================================*/
/* Table: DiscountCommodity                                     */
/*==============================================================*/
create table DiscountCommodity (
   Commodity_ID         int                  not null,
   DisCmd_disc          int                  not null,
   DisCmd_discStart     datetime             not null,
   DisCmd_DiscEnd       datetime             not null,
   constraint PK_DISCOUNTCOMMODITY primary key (Commodity_ID)
)
go

/*==============================================================*/
/* Table: Employee                                              */
/*==============================================================*/
create table Employee (
   Attribute_6          int                  not null,
   Store_ID             int                  not null,
   Employee_name        varchar              not null,
   Employee_address     varchar              null,
   Employee_age         int                  null,
   Employee_salary      int                  not null,
   Employee_IDNO        varchar              not null,
   Employee_SocialSecurity varchar              not null,
   Employee_enterDate   datetime             not null,
   Employee_position    varchar              not null,
   Employee_teleNO      varchar              not null,
   constraint PK_EMPLOYEE primary key nonclustered (Attribute_6)
)
go

/*==============================================================*/
/* Index: Workon_FK                                             */
/*==============================================================*/
create index Workon_FK on Employee (
Store_ID ASC
)
go

/*==============================================================*/
/* Table: FreshCommodity                                        */
/*==============================================================*/
create table FreshCommodity (
   Commodity_ID         int                  not null,
   FCmd_temp            int                  not null,
   constraint PK_FRESHCOMMODITY primary key (Commodity_ID)
)
go

/*==============================================================*/
/* Table: LimitCommodity                                        */
/*==============================================================*/
create table LimitCommodity (
   Commodity_ID         int                  not null,
   LimitCmd_num         int                  not null,
   LimitCmd_start       datetime             not null,
   LimitCmd_end         datetime             not null,
   constraint PK_LIMITCOMMODITY primary key (Commodity_ID)
)
go

/*==============================================================*/
/* Table: Manufacture                                           */
/*==============================================================*/
create table Manufacture (
   Manf_ID              int                  not null,
   Manf_address         varchar              not null,
   Manf_teleNO          varchar              not null,
   Manf_name            varchar              not null,
   constraint PK_MANUFACTURE primary key nonclustered (Manf_ID)
)
go

/*==============================================================*/
/* Table: Register                                              */
/*==============================================================*/
create table Register (
   VIP_ID               int                  not null,
   Store_ID             int                  not null,
   constraint PK_REGISTER primary key (VIP_ID, Store_ID)
)
go

/*==============================================================*/
/* Index: Register_FK                                           */
/*==============================================================*/
create index Register_FK on Register (
VIP_ID ASC
)
go

/*==============================================================*/
/* Index: Register2_FK                                          */
/*==============================================================*/
create index Register2_FK on Register (
Store_ID ASC
)
go

/*==============================================================*/
/* Table: Sale                                                  */
/*==============================================================*/
create table Sale (
   VIP_ID               int                  not null,
   Commodity_ID         int                  not null,
   Sale_orderID         int                  not null,
   Sale_time            datetime             not null,
   Sale_num             int                  not null,
   Sale_price           int                  not null,
   Sale_returnTime      datetime             null,
   Sale_returnPrice     int                  null,
   constraint PK_SALE primary key (VIP_ID, Commodity_ID)
)
go

/*==============================================================*/
/* Index: Sale_FK                                               */
/*==============================================================*/
create index Sale_FK on Sale (
VIP_ID ASC
)
go

/*==============================================================*/
/* Index: Sale2_FK                                              */
/*==============================================================*/
create index Sale2_FK on Sale (
Commodity_ID ASC
)
go

/*==============================================================*/
/* Table: Store                                                 */
/*==============================================================*/
create table Store (
   Store_ID             int                  not null,
   Store_address        varchar              not null,
   Store_openDate       Datetime             not null,
   Store_teleNO         varchar              not null,
   constraint PK_STORE primary key nonclustered (Store_ID)
)
go

/*==============================================================*/
/* Table: Supplier                                              */
/*==============================================================*/
create table Supplier (
   Supplier_ID          int                  not null,
   Supplier_address     varchar              not null,
   Supplier_teleNO      varchar              not null,
   Supplier_name        varchar              not null,
   Supplier_business    varchar              null,
   constraint PK_SUPPLIER primary key nonclustered (Supplier_ID)
)
go

/*==============================================================*/
/* Table: Supply                                                */
/*==============================================================*/
create table Supply (
   Store_ID             int                  not null,
   Supplier_ID          int                  not null,
   Commodity_ID         int                  not null,
   Supply_time          datetime             not null,
   Supply_num           int                  not null,
   constraint PK_SUPPLY primary key (Store_ID, Supplier_ID, Commodity_ID)
)
go

/*==============================================================*/
/* Index: Supply_FK                                             */
/*==============================================================*/
create index Supply_FK on Supply (
Store_ID ASC
)
go

/*==============================================================*/
/* Index: Supply2_FK                                            */
/*==============================================================*/
create index Supply2_FK on Supply (
Supplier_ID ASC
)
go

/*==============================================================*/
/* Index: Supply3_FK                                            */
/*==============================================================*/
create index Supply3_FK on Supply (
Commodity_ID ASC
)
go

/*==============================================================*/
/* Table: VIP                                                   */
/*==============================================================*/
create table VIP (
   VIP_ID               int                  not null,
   VIP_teleNO           varchar              not null,
   VIP_level            int                  not null,
   VIP_consumption      int                  null,
   "VIP_ validity"      datetime             null,
   VIP_datetime         datetime             not null,
   constraint PK_VIP primary key nonclustered (VIP_ID)
)
go

alter table Commodity
   add constraint FK_COMMODIT_PRODUCE_MANUFACT foreign key (Manf_ID)
      references Manufacture (Manf_ID)
go

alter table DiscountCommodity
   add constraint FK_DISCOUNT_INHERITAN_COMMODIT foreign key (Commodity_ID)
      references Commodity (Commodity_ID)
go

alter table Employee
   add constraint FK_EMPLOYEE_WORKON_STORE foreign key (Store_ID)
      references Store (Store_ID)
go

alter table FreshCommodity
   add constraint FK_FRESHCOM_INHERITAN_COMMODIT foreign key (Commodity_ID)
      references Commodity (Commodity_ID)
go

alter table LimitCommodity
   add constraint FK_LIMITCOM_INHERITAN_COMMODIT foreign key (Commodity_ID)
      references Commodity (Commodity_ID)
go

alter table Register
   add constraint FK_REGISTER_REGISTER_VIP foreign key (VIP_ID)
      references VIP (VIP_ID)
go

alter table Register
   add constraint FK_REGISTER_REGISTER2_STORE foreign key (Store_ID)
      references Store (Store_ID)
go

alter table Sale
   add constraint FK_SALE_SALE_VIP foreign key (VIP_ID)
      references VIP (VIP_ID)
go

alter table Sale
   add constraint FK_SALE_SALE2_COMMODIT foreign key (Commodity_ID)
      references Commodity (Commodity_ID)
go

alter table Supply
   add constraint FK_SUPPLY_SUPPLY_STORE foreign key (Store_ID)
      references Store (Store_ID)
go

alter table Supply
   add constraint FK_SUPPLY_SUPPLY2_SUPPLIER foreign key (Supplier_ID)
      references Supplier (Supplier_ID)
go

alter table Supply
   add constraint FK_SUPPLY_SUPPLY3_COMMODIT foreign key (Commodity_ID)
      references Commodity (Commodity_ID)
go

