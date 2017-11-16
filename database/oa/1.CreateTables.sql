USE MASTER
GO

--DROP DATABASE MissionskyOA
IF NOT EXISTS (SELECT 1 FROM MASTER.dbo.sysdatabases WHERE name='MissionskyOA')
	CREATE DATABASE MissionskyOA
GO

USE MissionskyOA
GO

/**************************************************************
--ϵͳ��־ Log
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'Log' AND  xtype='U') 
BEGIN
CREATE TABLE Log(
	Id INT IDENTITY(1,1) NOT NULL,
	Date DATETIME NULL,
	Thread NVARCHAR(255) NULL,
	Level NVARCHAR(50) NULL,
	Logger NVARCHAR(255) NULL,
	Message NVARCHAR(4000) NULL,
	Exception NVARCHAR(2000) NULL
	)
END
GO

--������� PK_Log
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'PK_Log' AND  xtype='PK')
	AND NOT EXISTS (SELECT 1 FROM SysObjects WHERE parent_obj = OBJECT_ID(N'Log') AND  xtype='PK')
	ALTER TABLE Log ADD CONSTRAINT PK_Log PRIMARY KEY (Id)
GO

/**************************************************************
--�û� User
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'User' AND  xtype='U') 
BEGIN
CREATE TABLE [User](
	Id INT IDENTITY(1,1) NOT NULL,
	No NVARCHAR(30) NULL,
	ChineseName NVARCHAR(50) NULL,
	EnglishName NVARCHAR(50) NULL,
	QQID NVARCHAR(50) NULL,
	Email NVARCHAR(50) NULL,
	Phone NVARCHAR(50) NULL,
	Password NVARCHAR(255) NULL,
	Gender INT NULL,
	DirectlySupervisorId INT NULL,
	DeptId INT NULL,
	ProjectId INT NULL,
	Position NVARCHAR(30) NULL,
	Token NVARCHAR(255) NULL,
	Status INT NULL,
	Available BIT NOT NULL DEFAULT(1),
	TodayStatus INT NOT NULL DEFAULT(1),
	JoinDate DATE NULL,
	ServerYear INT NULL,
	ServerYearType INT NULL,
	ExpirationTime DATETIME2(7) NULL,
	AuthNotify NVARCHAR(500),
	CreatedTime DATETIME2(7) NULL
	)
END
GO


IF NOT EXISTS (SELECT 1 FROM SysColumns WHERE name = N'ServerYear' AND  id=OBJECT_ID(N'User')) 
	ALTER TABLE [User] ADD ServerYear INT NULL

IF NOT EXISTS (SELECT 1 FROM SysColumns WHERE name = N'ServerYearType' AND  id=OBJECT_ID(N'User')) 
	ALTER TABLE [User] ADD ServerYearType INT NULL

/*
	--ɾ�����
	ALTER TABLE UserRole DROP CONSTRAINT FK_UserRole_User;
	ALTER TABLE Asset DROP CONSTRAINT FK_Asset_User;
	ALTER TABLE Avatar DROP CONSTRAINT FK_Avatar_User;
	ALTER TABLE ExpenseMember DROP CONSTRAINT FK_ExpenseMember_User;
	ALTER TABLE MeetingParticipant DROP CONSTRAINT FK_MeetingParticipant_User;
	ALTER TABLE [Order] DROP CONSTRAINT FK_Order_User;
	ALTER TABLE WorkflowProcess DROP CONSTRAINT FK_WorkflowProcess_User;
	ALTER TABLE Feedback DROP CONSTRAINT FK_Feedback_User;
*/

--������� PK_Users
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'PK_Users' AND  xtype='PK')
	AND NOT EXISTS (SELECT 1 FROM SysObjects WHERE parent_obj = OBJECT_ID(N'User') AND  xtype='PK')
	ALTER TABLE [User] ADD CONSTRAINT PK_Users PRIMARY KEY (Id)
GO

/*
--������ FK_User_Department
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_User_Department' AND  xtype='F')
BEGIN
	ALTER TABLE [User] WITH CHECK ADD CONSTRAINT FK_User_Department FOREIGN KEY(DeptId)
	REFERENCES Department (Id)
END
GO
*/

/**************************************************************
--������ɫ Role
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'Role' AND  xtype='U') 
BEGIN
CREATE TABLE Role(
	Id INT IDENTITY(1,1) NOT NULL,
	Name NVARCHAR(50) NOT NULL,
	ApprovedDays INT NULL,
	CreatedTime DATETIME2(7) NULL,
	Abbreviation NVARCHAR(50) NULL,
	IsInitRole INT NULL,
	CreateUser NVARCHAR(255) NULL,
	Status INT NULL
	)
END
GO

--������� PK_Role
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'PK_Role' AND  xtype='PK')
	AND NOT EXISTS (SELECT 1 FROM SysObjects WHERE parent_obj = OBJECT_ID(N'Role') AND  xtype='PK')
	ALTER TABLE Role ADD CONSTRAINT PK_Role PRIMARY KEY (Id)
GO

/**************************************************************
--�û���ɫ UserRole
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'UserRole' AND  xtype='U') 
BEGIN
CREATE TABLE UserRole(
	Id INT IDENTITY(1,1) NOT NULL,
	UserId INT NOT NULL,
	RoleId INT NOT NULL
	)
END
GO

--������� PK_UserRole
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'PK_UserRole' AND  xtype='PK')
	AND NOT EXISTS (SELECT 1 FROM SysObjects WHERE parent_obj = OBJECT_ID(N'UserRole') AND  xtype='PK')
	ALTER TABLE UserRole ADD CONSTRAINT PK_UserRole PRIMARY KEY (Id)
GO

--������ FK_UserRole_User
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_UserRole_User' AND  xtype='F')
BEGIN
	ALTER TABLE UserRole  WITH CHECK ADD  CONSTRAINT FK_UserRole_User FOREIGN KEY(UserId)
	REFERENCES [User] (Id)
END
GO

--������ FK_UserRole_Role
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_UserRole_Role' AND  xtype='F')
BEGIN
	ALTER TABLE UserRole  WITH CHECK ADD  CONSTRAINT FK_UserRole_Role FOREIGN KEY(RoleId)
	REFERENCES Role (Id)
END
GO

/**************************************************************
--���� Department
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'Department' AND  xtype='U') 
BEGIN
CREATE TABLE Department(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	No NVARCHAR(30) NOT NULL,
	Name NVARCHAR(30) NOT NULL,
	CreateUserName NVARCHAR(30) NULL,
	DepartmentHead INT NULL,
	Status INT NULL,
	CreatedDate DATETIME NULL DEFAULT (GETDATE()),
	)
END
GO

/*
	--ɾ�����
	ALTER TABLE [User] DROP CONSTRAINT FK_User_Department;
	ALTER TABLE ExpenseMain DROP CONSTRAINT FK_ExpenseMain_Department;
*/

/**************************************************************
--��Ŀ Project
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'Project' AND  xtype='U') 
BEGIN
CREATE TABLE Project(
	Id INT IDENTITY(1,1) NOT NULL,
	Name NVARCHAR(50) NULL,
	CreatedTime DATETIME2(7) NULL,
	ProjectNo NVARCHAR(100) NULL,
	ProjectManager INT NULL,
	ProjectBegin DATETIME NULL,
	ProjectEnd DATETIME NULL,
	CreateUserName NVARCHAR(255) NULL,
	Status INT NULL
	)
END
GO

--������� PK_Project
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'PK_Project' AND  xtype='PK')
	AND NOT EXISTS (SELECT 1 FROM SysObjects WHERE parent_obj = OBJECT_ID(N'Project') AND  xtype='PK')
	ALTER TABLE Project ADD CONSTRAINT PK_Project PRIMARY KEY (Id)
GO

/**************************************************************
--��ǩ AcceptProxy
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'AcceptProxy' AND  xtype='U') 
BEGIN
CREATE TABLE AcceptProxy(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Date DATE NOT NULL,
	Description NVARCHAR(200) NULL,
	FileName NVARCHAR(1000) NULL,
	Content VARBINARY(max) NULL,
	AcceptUserId INT NOT NULL,
	Status INT NOT NULL,
	Courier NVARCHAR(200) NULL,
	LeaveMessage NVARCHAR(200) NULL,
	CourierPhone NVARCHAR(50) NULL,
	CreateUserId INT NULL,
	LastModifyUserId INT NULL,
	LastModifyTime DATETIME2(7) NULL
	)
END
GO


/**************************************************************
--���� Announcement
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'Announcement' AND  xtype='U') 
BEGIN
CREATE TABLE Announcement(
	Id INT IDENTITY(1,1) NOT NULL,
	Type INT NOT NULL,
	Title NVARCHAR(255) NULL,
	Content NVARCHAR(max) NULL,
	ApplyUserId INT NOT NULL,
	EffectiveDays INT NULL,
	CreateUserId INT NULL,
	CreatedTime DATETIME2(7) NULL,
	Status INT NULL,
	AuditReason NVARCHAR(255) NULL,
	RefAssetInventoryId INT NULL
	)
END
GO

/**************************************************************
--�ʲ����� AssetType
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'AssetType' AND  xtype='U') 
BEGIN
CREATE TABLE AssetType(
	Id INT IDENTITY(1,1) NOT NULL,
	Name NVARCHAR(50) NOT NULL,
	Sort INT NULL
	)
END
GO

--������� PK_AssetType
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'PK_AssetType' AND  xtype='PK')
	AND NOT EXISTS (SELECT 1 FROM SysObjects WHERE parent_obj = OBJECT_ID(N'AssetType') AND  xtype='PK')
	ALTER TABLE AssetType ADD CONSTRAINT PK_AssetType PRIMARY KEY (Id)
GO

/**************************************************************
--�ʲ� Asset
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'Asset' AND  xtype='U') 
BEGIN
CREATE TABLE Asset(
	Id INT IDENTITY(1,1) NOT NULL,
	TypeId INT NOT NULL,
	UserId INT NOT NULL,
	Status INT NULL
	)
END
GO

--������� PK_Asset_1
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'PK_Asset_1' AND  xtype='PK')
	AND NOT EXISTS (SELECT 1 FROM SysObjects WHERE parent_obj = OBJECT_ID(N'Asset') AND  xtype='PK')
	ALTER TABLE Asset ADD CONSTRAINT PK_Asset_1 PRIMARY KEY (Id)
GO

--������ FK_Asset_AssetType
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_Asset_AssetType' AND  xtype='F')
BEGIN
	ALTER TABLE Asset  WITH CHECK ADD  CONSTRAINT FK_Asset_AssetType FOREIGN KEY(TypeId) 
	REFERENCES AssetType (Id)
END
GO

--������ FK_Asset_User
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_Asset_User' AND  xtype='F')
BEGIN
	ALTER TABLE Asset  WITH CHECK ADD  CONSTRAINT FK_Asset_User FOREIGN KEY(UserId) 
	REFERENCES [User] (Id)
END
GO

/**************************************************************
--�ʲ� AssetAttribute
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'AssetAttribute' AND  xtype='U') 
BEGIN
CREATE TABLE dbo.AssetAttribute(
	Id INT IDENTITY(1,1) NOT NULL,
	Name NVARCHAR(50) NOT NULL,
	Description NVARCHAR(255) NULL,
	DataType INT NULL,
	Sort INT NULL
	)
END
GO

--������� PK_AssetAttribute
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'PK_AssetAttribute' AND  xtype='PK')
	AND NOT EXISTS (SELECT 1 FROM SysObjects WHERE parent_obj = OBJECT_ID(N'AssetAttribute') AND  xtype='PK')
	ALTER TABLE AssetAttribute ADD CONSTRAINT PK_AssetAttribute PRIMARY KEY (Id)
GO

/**************************************************************
--�ʲ� AssetInfo
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'AssetInfo' AND  xtype='U') 
BEGIN
CREATE TABLE AssetInfo(
	Id INT IDENTITY(1,1) NOT NULL,
	AssetId INT NOT NULL,
	AttributeId INT NOT NULL,
	AttributeValue NVARCHAR(255) NULL
	)
END
GO

--������� PK_Asset
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'PK_Asset' AND  xtype='PK')
	AND NOT EXISTS (SELECT 1 FROM SysObjects WHERE parent_obj = OBJECT_ID(N'AssetInfo') AND  xtype='PK')
	ALTER TABLE AssetInfo ADD CONSTRAINT PK_Asset PRIMARY KEY (Id)
GO

--������ FK_AssetInfo_Asset1
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_AssetInfo_Asset1' AND  xtype='F')
BEGIN
	ALTER TABLE AssetInfo  WITH CHECK ADD  CONSTRAINT FK_AssetInfo_Asset1 FOREIGN KEY(AssetId) 
	REFERENCES Asset (Id)
END
GO

--������ FK_AssetInfo_AssetAttribute
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_AssetInfo_AssetAttribute' AND  xtype='F')
	ALTER TABLE AssetInfo  WITH CHECK ADD  CONSTRAINT FK_AssetInfo_AssetAttribute FOREIGN KEY(AttributeId) 
	REFERENCES AssetAttribute (Id)
GO

/**************************************************************
--�ʲ� AssetInventory
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'AssetInventory' AND  xtype='U') 
BEGIN
CREATE TABLE AssetInventory(
	Id INT IDENTITY(1,1) NOT NULL,
	Title NVARCHAR(255) NOT NULL,
	Description NVARCHAR(2000) NULL,
	Status INT NULL,
	CreatedTime DATETIME2(7) NOT NULL
	)
END
GO

--������� PK_AssetInventory
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'PK_AssetInventory' AND  xtype='PK')
	AND NOT EXISTS (SELECT 1 FROM SysObjects WHERE parent_obj = OBJECT_ID(N'AssetInventory') AND  xtype='PK')
	ALTER TABLE AssetInventory ADD CONSTRAINT PK_AssetInventory PRIMARY KEY (Id)
GO

/**************************************************************
--�ʲ� AssetInventoryRecord
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'AssetInventoryRecord' AND  xtype='U') 
BEGIN
CREATE TABLE AssetInventoryRecord(
	Id INT IDENTITY(1,1) NOT NULL,
	InventoryId INT NOT NULL,
	UserId INT NOT NULL,
	AssetId INT NULL,
	ScanCode NVARCHAR(50) NULL
	)
END
GO

--������� PK_AssetInventoryRecord
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'PK_AssetInventoryRecord' AND  xtype='PK')
	AND NOT EXISTS (SELECT 1 FROM SysObjects WHERE parent_obj = OBJECT_ID(N'AssetInventoryRecord') AND  xtype='PK')
	ALTER TABLE AssetInventoryRecord ADD CONSTRAINT PK_AssetInventoryRecord PRIMARY KEY (Id)
GO

--������ FK_AssetInventoryRecord_AssetInventory
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_AssetInventoryRecord_AssetInventory' AND  xtype='F')
BEGIN
	ALTER TABLE AssetInventoryRecord  WITH CHECK ADD  CONSTRAINT FK_AssetInventoryRecord_AssetInventory FOREIGN KEY(InventoryId)
	REFERENCES AssetInventory (Id)
END
GO

/**************************************************************
--�ʲ� AssetTransaction
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'AssetTransaction' AND  xtype='U') 
BEGIN
CREATE TABLE AssetTransaction(
	Id INT IDENTITY(1,1) NOT NULL,
	AssetId INT NOT NULL,
	BusinessType INT NULL,
	OutUserId INT NOT NULL,
	OutUserIsConfirm BIT NULL,
	InUserId INT NOT NULL,
	InUserIsConfirm BIT NULL,
	Description NVARCHAR(255) NULL,
	CreatedTime DATETIME2(7) NULL,
	Status INT NULL
	)
END
GO

--������� PK_AssetUserChangeHitstory
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'PK_AssetUserChangeHitstory' AND  xtype='PK')
	AND NOT EXISTS (SELECT 1 FROM SysObjects WHERE parent_obj = OBJECT_ID(N'AssetTransaction') AND  xtype='PK')
	ALTER TABLE AssetTransaction ADD CONSTRAINT PK_AssetUserChangeHitstory PRIMARY KEY (Id)
GO

--������ FK_AssetTransaction_Asset
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_AssetTransaction_Asset' AND  xtype='F')
BEGIN
	ALTER TABLE AssetTransaction  WITH CHECK ADD  CONSTRAINT FK_AssetTransaction_Asset FOREIGN KEY(AssetId)
	REFERENCES Asset (Id)
END
GO

/**************************************************************
--�ʲ� AssetTypeAttribute
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'AssetTypeAttribute' AND  xtype='U') 
BEGIN
CREATE TABLE AssetTypeAttribute(
	Id INT IDENTITY(1,1) NOT NULL,
	TypeId INT NOT NULL,
	AttributeId INT NOT NULL
	)
END
GO

--������� PK_AssetTypeAttribute
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'PK_AssetTypeAttribute' AND  xtype='PK')
	AND NOT EXISTS (SELECT 1 FROM SysObjects WHERE parent_obj = OBJECT_ID(N'AssetTypeAttribute') AND  xtype='PK')
	ALTER TABLE AssetTypeAttribute ADD CONSTRAINT PK_AssetTypeAttribute PRIMARY KEY (Id)
GO

--������ FK_AssetTypeAttribute_AssetAttribute
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_AssetTypeAttribute_AssetAttribute' AND  xtype='F')
BEGIN
	ALTER TABLE AssetTypeAttribute  WITH CHECK ADD  CONSTRAINT FK_AssetTypeAttribute_AssetAttribute FOREIGN KEY(AttributeId)
	REFERENCES AssetAttribute (Id)
END
GO

--������ FK_AssetTypeAttribute_AssetType
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_AssetTypeAttribute_AssetType' AND  xtype='F')
BEGIN
	ALTER TABLE AssetTypeAttribute  WITH CHECK ADD  CONSTRAINT FK_AssetTypeAttribute_AssetType FOREIGN KEY(TypeId)
	REFERENCES AssetType (Id)
END
GO

/**************************************************************
--���� Attachment
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'Attachment' AND  xtype='U') 
BEGIN
CREATE TABLE Attachment(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	EntityType NVARCHAR(30) NOT NULL,
	EntityId INT NOT NULL,
	Name NVARCHAR(50) NULL,
	[Desc] NVARCHAR(100) NULL,
	Content VARBINARY(max) NULL,
	CreatedTime DATETIME NOT NULL DEFAULT(GETDATE())
	)
END
GO

/**************************************************************
--���ڻ��� AttendanceSummary
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'AttendanceSummary' AND  xtype='U') 
BEGIN
CREATE TABLE AttendanceSummary(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	UserId INT NOT NULL,
	Type INT NOT NULL,
	Year INT NOT NULL,
	LastValue float NULL,
	BaseValue float NULL,
	RemainValue float NULL
	)
END
GO

/**************************************************************
--���ڻ��� AttendanceSummaryDetail
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'AttendanceSummaryDetail' AND  xtype='U') 
BEGIN
CREATE TABLE AttendanceSummaryDetail(
	UserId INT NULL,
	SumDate DATE NULL,
	WorkHours float NULL,
	OrderHours float NULL,
	FixedHC BIT NULL DEFAULT(0)
	)
END
GO

/**************************************************************
--�����־ AuditMessage
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'AuditMessage' AND  xtype='U') 
BEGIN
CREATE TABLE AuditMessage(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Type INT NOT NULL,
	Message NVARCHAR(100) NOT NULL,
	UserId INT NOT NULL,
	Status INT NULL DEFAULT(0),
	CreatedTime DATETIME NULL DEFAULT(GETDATE())
	)
END
GO

/**************************************************************
--�û�ͷ�� Avatar
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'Avatar' AND  xtype='U') 
BEGIN
CREATE TABLE Avatar(
	Id INT IDENTITY(1,1) NOT NULL,
	UserId INT NOT NULL,
	FileName NVARCHAR(1000) NULL,
	Content VARBINARY(max) NULL,
	CreatedTime DATETIME2(7) NULL
	)
END
GO

--������� PK_Avatar
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'PK_Avatar' AND  xtype='PK')
	AND NOT EXISTS (SELECT 1 FROM SysObjects WHERE parent_obj = OBJECT_ID(N'Avatar') AND  xtype='PK')
	ALTER TABLE Avatar ADD CONSTRAINT PK_Avatar PRIMARY KEY (Id)
GO

--������ FK_Avatar_User
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_Avatar_User' AND  xtype='F')
BEGIN
	ALTER TABLE Avatar  WITH CHECK ADD  CONSTRAINT FK_Avatar_User FOREIGN KEY(UserId)
	REFERENCES [User] (Id)
END
GO

/**************************************************************
--ͼ�� Book
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'Book' AND  xtype='U') 
BEGIN
CREATE TABLE Book(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Name NVARCHAR(50) NOT NULL,
	ISBN NVARCHAR(30) NOT NULL,
	Type NVARCHAR(30) NULL,
	[Desc] ntext NULL,
	Author NVARCHAR(30) NULL,
	Source INT NULL,
	Donor INT NULL,
	Status INT NULL,
	Reader INT NULL,
	BarCode NVARCHAR(100) NULL,
	CreatedDate DATETIME NOT NULL DEFAULT (GETDATE())
	)
END
GO

/**************************************************************
--ͼ�� BookBorrow
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'BookBorrow' AND  xtype='U') 
BEGIN
CREATE TABLE BookBorrow(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	UserId INT NOT NULL,
	BookId INT NOT NULL,
	Status INT NULL,
	BorrowDate DATETIME NOT NULL,
	ReturnDate DATETIME NOT NULL
	)
END
GO

/**************************************************************
--ͼ�� BookComment
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'BookComment' AND  xtype='U') 
BEGIN
CREATE TABLE BookComment(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	UserId INT NOT NULL,
	BookId INT NOT NULL,
	Comment ntext NULL,
	Rating INT NULL,
	CreatedDate DATETIME NOT NULL DEFAULT (GETDATE())
	)
END
GO

/**************************************************************
--�����ֵ� DataDict
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'DataDict' AND  xtype='U') 
BEGIN
CREATE TABLE DataDict(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Type NVARCHAR(30) NOT NULL,
	Value NVARCHAR(30) NOT NULL,
	Text NVARCHAR(30) NULL,
	Parent NVARCHAR(20) NULL
	)
END
GO

/**************************************************************
--���� ExpenseMain
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'ExpenseMain' AND  xtype='U') 
BEGIN
CREATE TABLE ExpenseMain(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	AuditId INT NOT NULL,
	DeptNo INT NOT NULL,
	ProjNo INT NOT NULL,
	Amount decimal(18, 2) NOT NULL,
	Reason NVARCHAR(200) NULL,
	CreatedTime DATETIME2(7) NULL,
	ApplyUserId INT NULL,
	PrintForm INT NULL DEFAULT ((0)),
	ConfirmForm BIT NULL DEFAULT ((0))
	)
END
GO

--������ FK_ExpenseMain_Department
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_ExpenseMain_Department' AND  xtype='F')
BEGIN
	ALTER TABLE ExpenseMain  WITH CHECK ADD CONSTRAINT FK_ExpenseMain_Department FOREIGN KEY(DeptNo)
	REFERENCES Department (Id)
END
GO

--������ FK_ExpenseMain_Project
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_ExpenseMain_Project' AND  xtype='F')
BEGIN
	ALTER TABLE ExpenseMain  WITH CHECK ADD CONSTRAINT FK_ExpenseMain_Project FOREIGN KEY(DeptNo)
	REFERENCES Project (Id)
END
GO

/**************************************************************
--���� ExpenseAuditHistory
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'ExpenseAuditHistory' AND  xtype='U') 
BEGIN
CREATE TABLE ExpenseAuditHistory(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	CurrentAudit INT NOT NULL,
	NextAudit INT NULL,
	ExpenseId INT NOT NULL,
	Status INT NULL,
	AuditMessage NVARCHAR(200) NULL,
	CreatedTime DATETIME2(7) NULL
	)
END
GO

--������ FK_ExpenseAuditHistory_ExpenseMain
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_ExpenseAuditHistory_ExpenseMain' AND  xtype='F')
BEGIN
	ALTER TABLE ExpenseAuditHistory  WITH CHECK ADD CONSTRAINT FK_ExpenseAuditHistory_ExpenseMain FOREIGN KEY(ExpenseId)
	REFERENCES ExpenseMain (Id)
END
GO

/**************************************************************
--���� ExpenseDetail
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'ExpenseDetail' AND  xtype='U') 
BEGIN
CREATE TABLE ExpenseDetail(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	MId INT NOT NULL,
	ODate DATETIME NOT NULL,
	EType INT NOT NULL,
	Remark NVARCHAR(200) NULL,
	PCount INT NOT NULL,
	Amount decimal(18, 2) NOT NULL
	)
END
GO

--������ FK_ExpenseDetail_ExpenseMain
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_ExpenseDetail_ExpenseMain' AND  xtype='F')
BEGIN
	ALTER TABLE ExpenseDetail  WITH CHECK ADD CONSTRAINT FK_ExpenseDetail_ExpenseMain FOREIGN KEY(MId)	
	REFERENCES ExpenseMain (Id)
END
GO

/**************************************************************
--���� ExpenseMember
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'ExpenseMember' AND  xtype='U') 
BEGIN
CREATE TABLE ExpenseMember(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	DId INT NOT NULL,
	MemberId INT NOT NULL
	)
END
GO

--������ FK_ExpenseMember_User
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_ExpenseMember_User' AND  xtype='F')
BEGIN
	ALTER TABLE ExpenseMember  WITH CHECK ADD CONSTRAINT FK_ExpenseMember_User FOREIGN KEY(MemberId)
	REFERENCES [User] (Id)
END
GO

--������ FK_ExpenseMember_ExpenseDetail
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_ExpenseMember_ExpenseDetail' AND  xtype='F')
BEGIN
	ALTER TABLE ExpenseMember  WITH CHECK ADD CONSTRAINT FK_ExpenseMember_ExpenseDetail FOREIGN KEY(MemberId)
	REFERENCES ExpenseDetail (Id)
END
GO

/**************************************************************
--������ MeetingRoom
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'MeetingRoom' AND  xtype='U') 
BEGIN
CREATE TABLE MeetingRoom(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	MeetingRoomName NVARCHAR(50) NULL,
	Capacity INT NOT NULL DEFAULT ((0)),
	Equipment NVARCHAR(200) NULL,
	Remark NVARCHAR(200) NULL,
	Status INT NULL,
	CreateUserName NVARCHAR(255) NULL,
	CreateDate DATETIME NULL
	)
END
GO

/**************************************************************
--���� MeetingCalendar
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'MeetingCalendar' AND  xtype='U') 
BEGIN
CREATE TABLE MeetingCalendar(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	MeetingRoomId INT NOT NULL,
	Title NVARCHAR(200) NULL,
	StartDate DATE NOT NULL,
	StartTime time(7) NULL,
	EndDate DATE NOT NULL,
	EndTime time(7) NULL,
	Host NVARCHAR(200) NULL,
	MeetingContext NVARCHAR(200) NULL,
	MeetingSummary NVARCHAR(200) NULL,
	Status INT NOT NULL,
	ApplyUserId INT NOT NULL,
	CreatedTime DATETIME2(7) NULL
	)
END
GO

--������ FK_MeetingCalendar_MeetingRoom
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_MeetingCalendar_MeetingRoom' AND  xtype='F')
BEGIN
	ALTER TABLE MeetingCalendar  WITH CHECK ADD CONSTRAINT FK_MeetingCalendar_MeetingRoom FOREIGN KEY(MeetingRoomId)
	REFERENCES MeetingRoom (Id)
END
GO

/**************************************************************
--���� MeetingParticipant
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'MeetingParticipant' AND  xtype='U') 
BEGIN
CREATE TABLE MeetingParticipant(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	MeetingCalendarId INT NOT NULL,
	UserId INT NOT NULL,
	IsOptional char(5) NOT NULL
	)
END
GO

--������ FK_MeetingParticipant_MeetingCalendar
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_MeetingParticipant_MeetingCalendar' AND  xtype='F')
BEGIN
	ALTER TABLE MeetingParticipant  WITH CHECK ADD CONSTRAINT FK_MeetingParticipant_MeetingCalendar FOREIGN KEY(MeetingCalendarId)
	REFERENCES MeetingCalendar (Id)
END
GO

--������ FK_MeetingParticipant_User
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_MeetingParticipant_User' AND  xtype='F')
BEGIN
	ALTER TABLE MeetingParticipant  WITH CHECK ADD CONSTRAINT FK_MeetingParticipant_User FOREIGN KEY(UserId)
	REFERENCES [User] (Id)
END
GO

/**************************************************************
--������Ϣ Notification
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'Notification' AND  xtype='U') 
BEGIN
CREATE TABLE Notification(
	Id INT IDENTITY(1,1) NOT NULL,
	BusinessType INT NULL,
	Title NVARCHAR(255) NULL,
	MessageContent NVARCHAR(max) NULL,
	Target NVARCHAR(255) NULL,
	MessageType INT NOT NULL,
	Scope INT NOT NULL,
	MessagePrams NVARCHAR(max) NULL,
	CreatedUserId INT NULL,
	CreatedTime DATETIME NOT NULL
	)
END
GO

--������� PK_NotificationList
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'PK_NotificationList' AND  xtype='PK') 
	AND NOT EXISTS (SELECT 1 FROM SysObjects WHERE parent_obj = OBJECT_ID(N'Notification') AND  xtype='PK')
	ALTER TABLE Notification ADD CONSTRAINT PK_NotificationList PRIMARY KEY (Id)
GO

/**************************************************************
--������Ϣ NotificationTargetUser
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'NotificationTargetUser' AND  xtype='U') 
BEGIN
CREATE TABLE NotificationTargetUser(
	Id INT IDENTITY(1,1) NOT NULL,
	NotificationId INT NOT NULL,
	TargetUserId INT NOT NULL
	)
END
GO

--������� PK_NotificationTargetUser
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'PK_NotificationTargetUser' AND  xtype='PK')
	AND NOT EXISTS (SELECT 1 FROM SysObjects WHERE parent_obj = OBJECT_ID(N'NotificationTargetUser') AND  xtype='PK')
	ALTER TABLE NotificationTargetUser ADD CONSTRAINT PK_NotificationTargetUser PRIMARY KEY (Id)
GO

--������ FK_NotificationTargetUser_Notification
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_NotificationTargetUser_Notification' AND  xtype='F')
BEGIN
	ALTER TABLE NotificationTargetUser  WITH CHECK ADD CONSTRAINT FK_NotificationTargetUser_Notification FOREIGN KEY(NotificationId)
	REFERENCES Notification (Id)
END
GO


/**************************************************************
--�������뵥 Order
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'Order' AND  xtype='U') 
BEGIN
CREATE TABLE [Order](
	Id INT IDENTITY(1,1) NOT NULL,
	Status INT NULL,
	OrderType INT NOT NULL,
	UserId INT NOT NULL,
	ApplyUserId INT NULL,
	RefOrderId INT NULL,
	WorkflowId INT NULL,
	NextStep INT NULL,
	NextAudit INT NULL,
	CreatedTime DATETIME2(7) NULL,
	OrderNo INT NOT NULL
	)
END
GO

--������� PK_Order
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'PK_Order' AND  xtype='PK')
	AND NOT EXISTS (SELECT 1 FROM SysObjects WHERE parent_obj = OBJECT_ID(N'Order') AND  xtype='PK')
	ALTER TABLE [Order] ADD CONSTRAINT PK_Order PRIMARY KEY (Id)
GO

--������ FK_Order_User
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_Order_User' AND  xtype='F')
BEGIN
	ALTER TABLE [Order]  WITH CHECK ADD  CONSTRAINT FK_Order_User FOREIGN KEY(UserId)
	REFERENCES [User] (Id)
END
GO

/**************************************************************
--�������뵥 OrderDet
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'OrderDet' AND  xtype='U') 
BEGIN
CREATE TABLE OrderDet(
	Id INT IDENTITY(1,1) NOT NULL,
	OrderId INT NOT NULL,
	StartDate DATE NOT NULL,
	StartTime time(7) NULL,
	EndDate DATE NOT NULL,
	EndTime time(7) NULL,
	IOHours float NULL,	
	InformLeader BIT, --�Ƿ��֪�쵼
	WorkTransfer BIT, --�Ƿ�������
	Recipient INT, --�ƽ���
	Description NVARCHAR(max) NULL,
	FileName NVARCHAR(max) NULL,
	FileContent VARBINARY(max) NULL,
	Audit NVARCHAR(50) NULL
	)
END
GO

--������� PK_OrderDet
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'PK_OrderDet' AND  xtype='PK')
	AND NOT EXISTS (SELECT 1 FROM SysObjects WHERE parent_obj = OBJECT_ID(N'OrderDet') AND  xtype='PK')
	ALTER TABLE OrderDet ADD CONSTRAINT PK_OrderDet PRIMARY KEY (Id)
GO

--������ FK_OrderDet_Order
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_OrderDet_Order' AND  xtype='F')
BEGIN
	ALTER TABLE OrderDet  WITH CHECK ADD  CONSTRAINT FK_OrderDet_Order FOREIGN KEY(OrderId)
	REFERENCES [Order] (Id)
END
GO

/**************************************************************
--���� Report
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'Report' AND  xtype='U') 
BEGIN
CREATE TABLE Report(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Name NVARCHAR(100) NOT NULL UNIQUE,
	[Desc] NVARCHAR(100) NULL,
	IsOpen BIT NOT NULL DEFAULT ((1)),
	No NVARCHAR(20) NOT NULL DEFAULT (''),
	CreatedTime DATETIME NOT NULL DEFAULT (GETDATE())
	)
END
GO

/**************************************************************
--���� ReportConfig
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'ReportConfig' AND  xtype='U') 
BEGIN
CREATE TABLE ReportConfig(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	ReportId INT NOT NULL,
	Config NVARCHAR(100) NOT NULL,
	Value NVARCHAR(100) NOT NULL,
	CreatedTime DATETIME NOT NULL DEFAULT (GETDATE())
	)
END
GO

--������ FK_Report_Config
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_Report_Config' AND  xtype='F')
BEGIN
	ALTER TABLE ReportConfig  WITH CHECK ADD  CONSTRAINT FK_Report_Config FOREIGN KEY(ReportId)
	REFERENCES Report (Id)
END
GO

/**************************************************************
--���� ReportParameter
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'ReportParameter' AND  xtype='U') 
BEGIN
CREATE TABLE ReportParameter(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	ReportId INT NOT NULL,
	Name NVARCHAR(30) NOT NULL,
	[Desc] NVARCHAR(50) NOT NULL,
	Type NVARCHAR(20) NOT NULL,
	Nullable BIT NULL,
	DataSource NVARCHAR(30) NULL,
	CreatedTime DATETIME NOT NULL DEFAULT (GETDATE())
	)
END
GO

--������ FK_Report_Parameter
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_Report_Parameter' AND  xtype='F')
BEGIN
	ALTER TABLE ReportParameter  WITH CHECK ADD  CONSTRAINT FK_Report_Parameter FOREIGN KEY(ReportId)
	REFERENCES Report (Id)
END
GO

/**************************************************************
--��ʱ���� ScheduledTask
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'ScheduledTask' AND  xtype='U') 
BEGIN
CREATE TABLE ScheduledTask(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Name NVARCHAR(50) NULL,
	Interval INT NOT NULL,
	Unit INT NOT NULL,
	Status INT NOT NULL,
	TaskClass NVARCHAR(100) NOT NULL,
	[Desc] NVARCHAR(100) NULL,
	LastExecTime DATETIME NULL,
	CreatedTime DATETIME NOT NULL DEFAULT (GETDATE())
	)
END
GO

/**************************************************************
--��ʱ���� ScheduledTaskHistory
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'ScheduledTaskHistory' AND  xtype='U') 
BEGIN
CREATE TABLE ScheduledTaskHistory(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	TaskId INT NOT NULL,
	Result BIT NOT NULL,
	[Desc] ntext NULL,
	CreatedTime DATETIME NOT NULL DEFAULT (GETDATE())
	)
END
GO

--������ FK_ScheduledTask_History
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_ScheduledTask_History' AND  xtype='F')
BEGIN
	ALTER TABLE ScheduledTaskHistory  WITH CHECK ADD  CONSTRAINT FK_ScheduledTask_History FOREIGN KEY(TaskId)
	REFERENCES ScheduledTask (Id)
END
GO

/**************************************************************
--������ Workflow
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'Workflow' AND  xtype='U') 
BEGIN
CREATE TABLE Workflow(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Name NVARCHAR(30) NOT NULL,
	[Desc] NVARCHAR(100) NULL,
	Type INT NOT NULL,
	Status BIT NOT NULL,
	CreatedTime DATETIME NOT NULL,
	Condition ntext NULL,
	ConditionDesc NVARCHAR(100) NULL DEFAULT (GETDATE())
	)
END
GO

/**************************************************************
--������ WorkflowStep
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'WorkflowStep' AND  xtype='U') 
BEGIN
CREATE TABLE WorkflowStep(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	FlowId INT NOT NULL,
	Name NVARCHAR(30) NOT NULL,
	Operator INT NOT NULL,
	OperatorType INT NOT NULL,
	MinTimes float NOT NULL DEFAULT ((0)),
	MaxTimes float NOT NULL,
	Type INT NULL,
	NextStep INT NULL,
	[Desc] NVARCHAR(100) NULL,
	CreatedTime DATETIME NOT NULL DEFAULT (GETDATE())
	)
END
GO

--������ FK_WorkflowStep_Workflow
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_WorkflowStep_Workflow' AND  xtype='F')
BEGIN	
	ALTER TABLE WorkflowStep  WITH CHECK ADD  CONSTRAINT FK_WorkflowStep_Workflow FOREIGN KEY(FlowId)
	REFERENCES Workflow (Id)
END
GO


/**************************************************************
--������ WorkflowProcess
--**************************************************************/

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'WorkflowProcess' AND  xtype='U') 
BEGIN
CREATE TABLE WorkflowProcess(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	FlowId INT NOT NULL,
	StepId INT NOT NULL,
	Operator INT NOT NULL,
	Operation INT NOT NULL,
	OperationDesc NVARCHAR(100) NULL,
	OrderNo INT NOT NULL,
	CreatedTime DATETIME NOT NULL DEFAULT (GETDATE())
	)
END
GO

--������ FK_WorkflowProcess_User
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_WorkflowProcess_User' AND  xtype='F')
BEGIN	
	ALTER TABLE WorkflowProcess  WITH CHECK ADD  CONSTRAINT FK_WorkflowProcess_User FOREIGN KEY(Operator)
	REFERENCES [User] (Id)
END
GO

/**************************************************************
--�������� WorkTask
--**************************************************************/

IF NOT EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'WorkTask') AND XType = N'U')
BEGIN
CREATE TABLE WorkTask(		
	Id INT IDENTITY(1, 1) PRIMARY KEY,
	Outline NVARCHAR(50) NOT NULL, --��������
	Type INT NOT NULL,
	Status INT NOT NULL,
	[Desc] NVARCHAR(150), --������ϸ˵��
	MeetingId INT,
	ProjectId INT,
	Sponsor INT NOT NULL, --������
	Supervisor INT, --�ල��
	Executor INT, --ִ����
	[Source] INT NOT NULL, --������Դ
	Priority INT NOT NULL, --���ȼ� 
	Workload INT NOT NULL, --������(Сʱ)
	Urgency INT, --������: ���е�
	Importance INT, --��Ҫ��: ���е�
	StartTime DATETIME,
	EndTime DATETIME,	--�����ֹʱ��
	CompleteTime DATETIME, --���ʱ��
	CloseTime DATETIME,
	CreatedTime DATETIME NOT NULL DEFAULT(GETDATE())
	)
END
GO

/**************************************************************
--�������� WorkTaskHistory
--**************************************************************/

IF NOT EXISTS(SELECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'WorkTaskHistory') AND XType = N'U')
BEGIN
CREATE TABLE WorkTaskHistory(
	Id INT IDENTITY(1, 1) PRIMARY KEY,
	TaskId INT NOT NULL,
	Operator INT NOT NULL, --������
	OperatorName NVARCHAR(30), --����������
	Status INT NOT NULL,  --����״̬
	Audit NVARCHAR(100), --����˵��
	CreatedTime DATETIME NOT NULL DEFAULT(GETDATE())
	)
END
GO

--������ FK_WorkTaskHistory_WorkTask
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_WorkTaskHistory_WorkTask' AND  xtype='F')
BEGIN	
	ALTER TABLE WorkTaskHistory  WITH CHECK ADD CONSTRAINT FK_WorkTaskHistory_WorkTask FOREIGN KEY(TaskId)
	REFERENCES WorkTask (Id)
END
GO

/**************************************************************
--�������� WorkTaskComment
--**************************************************************/

IF NOT EXISTS(SELECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'WorkTaskComment') AND XType = N'U')
BEGIN
CREATE TABLE WorkTaskComment(
	Id INT IDENTITY(1, 1) PRIMARY KEY,
	TaskId INT NOT NULL,
	UserId INT NOT NULL, --������
	Comment NVARCHAR(150) NOT NULL, --����
	CreatedTime DATETIME NOT NULL DEFAULT(GETDATE())
	)
END
GO

--������ FK_WorkTaskComment_WorkTask
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_WorkTaskComment_WorkTask' AND  xtype='F')
BEGIN	
	ALTER TABLE WorkTaskComment  WITH CHECK ADD CONSTRAINT FK_WorkTaskComment_WorkTask FOREIGN KEY(TaskId)
	REFERENCES WorkTask (Id)
END
GO

/**************************************************************
--���� Feedback
--**************************************************************/

IF NOT EXISTS(SELECT 1 FROM SYSOBJECTS WHERE Id = OBJECT_ID(N'Feedback') AND XType = N'U')
BEGIN
CREATE TABLE Feedback(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[Desc] NVARCHAR(100) NULL,
	ProblemType INT NOT NULL,
	Title NVARCHAR(50) NOT NULL,
	UserId INT NOT NULL,
	CreateTime DATE NOT NULL
	)
END
GO

--������ FK_Feedback_User
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE name = N'FK_Feedback_User' AND  xtype='F')
BEGIN	
	ALTER TABLE Feedback  WITH CHECK ADD CONSTRAINT FK_Feedback_User FOREIGN KEY(UserId)
	REFERENCES [User] (Id)
END
GO

/**************************************************************
--�����û� ImportedUser
--**************************************************************/


IF NOT EXISTS(SELECT 1 FROM SYSOBJECTS WHERE Id = OBJECT_ID(N'ImportedUser') AND XType = N'U')
BEGIN
CREATE TABLE ImportedUser(
	No NVARCHAR(30) NULL,
	ChineseName NVARCHAR(50) NULL,
	EnglishName NVARCHAR(50) NULL,
	Phone NVARCHAR(50) NULL,
	Email NVARCHAR(50) NULL,
	QQID NVARCHAR(50) NULL,
	Gender NVARCHAR(2) NULL,
	DirectlySupervisor NVARCHAR(50) NULL,
	UserDept NVARCHAR(30) NULL,
	Project NVARCHAR(30) NULL,
	UserRole NVARCHAR(30) NULL,
	Position NVARCHAR(30) NULL,
	JoinDate NVARCHAR(30) NULL,
	)
END
GO
