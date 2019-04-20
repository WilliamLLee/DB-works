CREATE TABLE Store(
	Store_ID  int Not null,
	Store_address varchar(256) Not null,
	Store_openDate datetime Not null,
	Store_teleNO varchar(25) Not null,
	primary key(Store_ID)
);

CREATE TABLE Employee(
	Employee_ID  int  Not null,
	Store_ID int Not null,
	Employee_name varchar(20) Not null,
	Employee_address varchar(256) null,
	Employee_age int null ,
	Employee_teleNO varchar(25) Not null,
	Employee_salary int Not null,
	Employee_IDNO varchar(25) Not null,
	Employee_SocialSecurity varchar(25) Not null,
	Employee_enterDate  datetime Not null,
	Employee_position  varchar(40) Not null,
	primary key(Employee_ID), 
	foreign key(Store_ID) references Store(Store_ID)
);


CREATE TABLE Supplier(
	Supplier_ID  int Not null,
	Supplier_name varchar(20) Not null,
	Supplier_address varchar(256)  Not null,
	Supplier_teleNO varchar(25) Not null,
	Supplier_business varchar(1024) null,
	primary key(Supplier_ID) 
);

CREATE TABLE VIP(
	VIP_ID  int Not null,
	VIP_level int Not null,
	VIP_consumption int null ,
	VIP_teleNO varchar(25) Not null,
	VIP_validity datetime null,
	VIP_datetime datetime Not null,
	primary key(VIP_ID) 
);

CREATE TABLE Manufacture(
	Manf_ID   int Not null,
	Manf_name varchar(50) Not null,
	Manf_address varchar(256) Not null,
	Manf_teleNO varchar(25) Not null,
	primary key(Manf_ID) 
);

CREATE TABLE Commodity(
	Cmd_ID  int Not null,
	Manf_ID int Not null,
	Cmd_saleprice int  Not null,
	Cmd_buyprice int Not null,
	Cmd_name varchar(25) Not null,
	Cmd_proDate datetime Not null,
	Cmd_leftNum int,
	Cmd_shelflife datetime Not null,
	primary key(Cmd_ID),
	foreign key(Manf_ID) references Manufacture(Manf_ID)
);

CREATE TABLE FreshCommodity(
	FCmd_ID int Not null,
	FCmd_temp int Not null,
	primary key(FCmd_ID),
	foreign key(FCmd_ID) references Commodity(Cmd_ID)
);

CREATE TABLE DiscountCommodity(
	DisCmd_ID int Not null,
	DisCmd_disc int Not null,
	DisCmd_discstart datetime Not null,
	DisCmd_discend datetime Not null,
	primary key(DisCmd_ID),
	foreign key(DisCmd_ID) references Commodity(Cmd_ID)
);

CREATE TABLE LimitCommodity(
	LimitCmd_ID int Not null,
	LimitCmd_num int Not null,
	LimitCmd_start datetime Not null,
	LimitCmd_end datetime Not null,
	primary key(LimitCmd_ID),
	foreign key(LimitCmd_ID) references Commodity(Cmd_ID)
);

CREATE TABLE Supply(
	Store_ID int Not null,
	Supplier_ID int Not null,
	Cmd_ID int Not null,
	Supply_time datetime Not null,
	Supply_num int Not null,
	primary key(Store_ID,Supplier_ID,Cmd_ID),
	foreign key(Store_ID) references Store(Store_ID),
	foreign key(Supplier_ID) references Supplier(Supplier_ID),
	foreign key(Cmd_ID) references Commodity(Cmd_ID)
);


CREATE TABLE Register(
	Store_ID int Not null,
	VIP_ID int Not null,
	primary key(Store_ID,VIP_ID),
	foreign key(Store_ID) references Store(Store_ID),
	foreign key(VIP_ID) references VIP(VIP_ID)
);

CREATE TABLE Sale(
	VIP_ID int Not null,
	Cmd_ID int Not null,
	Sale_orderID int Not null,
	Sale_time datetime Not null,
	Sale_num int Not null,
	Sale_price int Not null,
	Sale_returnTime datetime null,
	sale_returnprice int null ,
	primary key(VIP_ID,Cmd_ID),
	foreign key(VIP_ID) references VIP(VIP_ID),
	foreign key(Cmd_ID) references Commodity(Cmd_ID)
);