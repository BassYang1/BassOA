USE MissionskyOA
GO

/**************************************************************
--用户角色
--**************************************************************/
/*
SET IDENTITY_INSERT Role ON

INSERT INTO Role (Id, Name, ApprovedDays, CreatedTime, Abbreviation, IsInitRole, CreateUser, Status) 
	SELECT N'1', N'总经理', N'1', N'2015-12-05 00:00:00.0000000', N'CEO', N'1', null, N'1' 
	WHERE NOT EXISTS (SELECT 1 FROM Role WHERE Name=N'总经理')

INSERT INTO Role (Id, Name, ApprovedDays, CreatedTime, Abbreviation, IsInitRole, CreateUser, Status)  
	SELECT N'2', N'副总经理', N'1', N'2015-12-05 00:00:00.0000000', N'CFO', N'1', null, N'1' 
	WHERE NOT EXISTS (SELECT 1 FROM Role WHERE Name=N'副总经理')

INSERT INTO Role (Id, Name, ApprovedDays, CreatedTime, Abbreviation, IsInitRole, CreateUser, Status)  
	SELECT N'3', N'总监', N'1', N'2015-12-05 00:00:00.0000000', N'CTO', N'1', null, N'1' 
	WHERE NOT EXISTS (SELECT 1 FROM Role WHERE Name=N'总监')

INSERT INTO Role (Id, Name, ApprovedDays, CreatedTime, Abbreviation, IsInitRole, CreateUser, Status)  
	SELECT N'4', N'项目经理', N'1', N'2015-12-05 00:00:00.0000000', N'PM', N'1', null, N'1' 
	WHERE NOT EXISTS (SELECT 1 FROM Role WHERE Name=N'项目经理')

INSERT INTO Role (Id, Name, ApprovedDays, CreatedTime, Abbreviation, IsInitRole, CreateUser, Status)  
	SELECT N'5', N'工程师', N'1', N'2015-12-05 00:00:00.0000000', N'ENG', N'1', null, N'1' 
	WHERE NOT EXISTS (SELECT 1 FROM Role WHERE Name=N'工程师')

INSERT INTO Role (Id, Name, ApprovedDays, CreatedTime, Abbreviation, IsInitRole, CreateUser, Status)  
	SELECT N'6', N'行政专员', N'1', N'2015-12-05 00:00:00.0000000', N'PD', N'1', null, N'1' 
	WHERE NOT EXISTS (SELECT 1 FROM Role WHERE Name=N'行政专员')

INSERT INTO Role (Id, Name, ApprovedDays, CreatedTime, Abbreviation, IsInitRole, CreateUser, Status)  
	SELECT N'7', N'COO/CFO', N'1', N'2015-12-05 00:00:00.0000000', N'COO/CFO', N'1', null, N'1' 
	WHERE NOT EXISTS (SELECT 1 FROM Role WHERE Name=N'COO/CFO')

INSERT INTO Role (Id, Name, ApprovedDays, CreatedTime, Abbreviation, IsInitRole, CreateUser, Status)  
	SELECT N'8', N'CEO', N'1', N'2015-12-05 00:00:00.0000000', N'CEO', N'1', null, N'1' 
	WHERE NOT EXISTS (SELECT 1 FROM Role WHERE Name=N'CEO')

INSERT INTO Role (Id, Name, ApprovedDays, CreatedTime, Abbreviation, IsInitRole, CreateUser, Status)  
	SELECT N'9', N'资产管理员', N'1', N'2015-12-05 00:00:00.0000000', N'ADMIN', N'1', null, N'1' 
	WHERE NOT EXISTS (SELECT 1 FROM Role WHERE Name=N'资产管理员')

SET IDENTITY_INSERT Role OFF
GO
*/

/**************************************************************
--用户/角色
--**************************************************************/
INSERT INTO [User] (No ,ChineseName ,EnglishName ,QQID ,Email ,Phone ,Password ,Gender ,DirectlySupervisorId ,DeptId ,ProjectId ,Position ,Token ,Status ,Available ,TodayStatus ,JoinDate ,ExpirationTime ,CreatedTime)
	SELECT 
		NULL ,N'系统管理员' ,'System Admin' ,NULL ,'admin@missionsky.com' ,NULL ,NULL ,NULL ,NULL ,
		(SELECT TOP 1 Id FROM Department WHERE Name LIKE N'%行政%') AS DeptId ,
		0 ,N'系统管理员' ,NULL ,0 ,1 ,1 ,GETDATE() ,NULL ,GETDATE()
	WHERE NOT EXISTS (SELECT 1 FROM [User] WHERE ChineseName=N'系统管理员')
GO

INSERT INTO [User] (No ,ChineseName ,EnglishName ,QQID ,Email ,Phone ,Password ,Gender ,DirectlySupervisorId ,DeptId ,ProjectId ,Position ,Token ,Status ,Available ,TodayStatus ,JoinDate ,ExpirationTime ,CreatedTime)
	SELECT 
		NULL ,N'资产管理员' ,'Assets Manager' ,NULL ,'assets.manager@missionsky.com' ,NULL ,NULL ,1 ,0 ,
		(SELECT TOP 1 Id FROM Department WHERE Name = N'IT部') AS DeptId ,
		0 ,N'资产管理员' ,NULL ,0 ,1 ,1 ,GETDATE() ,NULL ,GETDATE()
	WHERE NOT EXISTS (SELECT 1 FROM [User] WHERE ChineseName=N'资产管理员')
GO

UPDATE [User] SET AuthNotify = N'LeaveApprove:1;OvertimeApprove:1;ExpenseApprove:1;Notice:1;WorkTask:1;' WHERE LEN(ISNULL(AuthNotify, N'')) <= 0;
GO

UPDATE [User] SET Password = N'E1-0A-DC-39-49-BA-59-AB-BE-56-E0-57-F2-0F-88-3E' WHERE ISNULL(Password, '') = '';
GO

UPDATE [User] SET Email = LOWER(REPLACE(EnglishName,' ', '.')) + '@missionsky.com' WHERE ISNULL(EMAIL, '') = '';
GO

INSERT INTO UserRole(UserId, RoleId)
SELECT U.Id, R.Id FROM [USER] U, Role R
	WHERE ChineseName=N'系统管理员' AND R.Name = N'行政专员' 
		AND NOT EXISTS(SELECT 1 FROM UserRole WHERE UserId = U.Id AND RoleId = R.Id)
GO

INSERT INTO UserRole(UserId, RoleId)
SELECT U.Id, R.Id FROM [USER] U, Role R
	WHERE ChineseName=N'资产管理员' AND R.Name = N'行政专员' 
		AND NOT EXISTS(SELECT 1 FROM UserRole WHERE UserId = U.Id AND RoleId = R.Id)
GO

/**************************************************************
--资产管理
--**************************************************************/

SET IDENTITY_INSERT AssetAttribute ON 

INSERT AssetAttribute (Id, Name, Description, DataType, Sort) 
	SELECT 1, N'编号', NULL, 0, 1 
	WHERE NOT EXISTS (SELECT 1 FROM AssetAttribute WHERE Name=N'编号')

INSERT AssetAttribute (Id, Name, Description, DataType, Sort) 
	SELECT 2, N'名称', NULL, 2, 2 
	WHERE NOT EXISTS (SELECT 1 FROM AssetAttribute WHERE Name=N'名称')

INSERT AssetAttribute (Id, Name, Description, DataType, Sort) 
	SELECT 3, N'金额(RMB)', NULL, 1, 3 
	WHERE NOT EXISTS (SELECT 1 FROM AssetAttribute WHERE Name=N'金额(RMB)')

INSERT AssetAttribute (Id, Name, Description, DataType, Sort) 
	SELECT 4, N'金额(HKD)', NULL, 1, 4 
	WHERE NOT EXISTS (SELECT 1 FROM AssetAttribute WHERE Name=N'金额(HKD)')

INSERT AssetAttribute (Id, Name, Description, DataType, Sort) 
	SELECT 5, N'详细配置', NULL, 2, 5 
	WHERE NOT EXISTS (SELECT 1 FROM AssetAttribute WHERE Name=N'详细配置')

INSERT AssetAttribute (Id, Name, Description, DataType, Sort) 
	SELECT 6, N'采购日期', NULL, 3, 6 
	WHERE NOT EXISTS (SELECT 1 FROM AssetAttribute WHERE Name=N'采购日期')

INSERT AssetAttribute (Id, Name, Description, DataType, Sort) 
	SELECT 7, N'采购人', NULL, 2, 7 
	WHERE NOT EXISTS (SELECT 1 FROM AssetAttribute WHERE Name=N'采购人')

INSERT AssetAttribute (Id, Name, Description, DataType, Sort) 
	SELECT 8, N'入账区域', NULL, 2, 8 
	WHERE NOT EXISTS (SELECT 1 FROM AssetAttribute WHERE Name=N'入账区域')

INSERT AssetAttribute (Id, Name, Description, DataType, Sort) 
	SELECT 9, N'折旧', NULL, 2, 9 
	WHERE NOT EXISTS (SELECT 1 FROM AssetAttribute WHERE Name=N'折旧')

INSERT AssetAttribute (Id, Name, Description, DataType, Sort) 
	SELECT 10, N'使用人', NULL, 2, 10 
	WHERE NOT EXISTS (SELECT 1 FROM AssetAttribute WHERE Name=N'使用人')

INSERT AssetAttribute (Id, Name, Description, DataType, Sort) 
	SELECT 11, N'存放地点', NULL, 2, 11 
	WHERE NOT EXISTS (SELECT 1 FROM AssetAttribute WHERE Name=N'存放地点')

INSERT AssetAttribute (Id, Name, Description, DataType, Sort) 
	SELECT 12, N'备注', NULL, 2, 12 
	WHERE NOT EXISTS (SELECT 1 FROM AssetAttribute WHERE Name=N'备注')

SET IDENTITY_INSERT AssetAttribute OFF
GO

SET IDENTITY_INSERT AssetType ON 

INSERT AssetType (Id, Name, Sort) 
	SELECT 1, N'主机', 1 
	WHERE NOT EXISTS (SELECT 1 FROM AssetType WHERE Name=N'主机')

INSERT AssetType (Id, Name, Sort) 
	SELECT 2, N'显示器', 2 
	WHERE NOT EXISTS (SELECT 1 FROM AssetType WHERE Name=N'显示器')

INSERT AssetType (Id, Name, Sort) 
	SELECT 3, N'MACMINI电脑', 3 
	WHERE NOT EXISTS (SELECT 1 FROM AssetType WHERE Name=N'MACMINI电脑')

INSERT AssetType (Id, Name, Sort) 
	SELECT 4, N'笔记本电脑', 4 
	WHERE NOT EXISTS (SELECT 1 FROM AssetType WHERE Name=N'笔记本电脑')

INSERT AssetType (Id, Name, Sort) 
	SELECT 5, N'平板电脑', 5 
	WHERE NOT EXISTS (SELECT 1 FROM AssetType WHERE Name=N'平板电脑')

INSERT AssetType (Id, Name, Sort) 
	SELECT 6, N'手机', 6 
	WHERE NOT EXISTS (SELECT 1 FROM AssetType WHERE Name=N'手机')

INSERT AssetType (Id, Name, Sort) 
	SELECT 7, N'午休床', 7 
	WHERE NOT EXISTS (SELECT 1 FROM AssetType WHERE Name=N'午休床')

INSERT AssetType (Id, Name, Sort) 
	SELECT 8, N'其他固定资产', 8 
	WHERE NOT EXISTS (SELECT 1 FROM AssetType WHERE Name=N'其他固定资产')

INSERT AssetType (Id, Name, Sort) 
	SELECT 9, N'其他易耗品', 9 
	WHERE NOT EXISTS (SELECT 1 FROM AssetType WHERE Name=N'其他易耗品')

SET IDENTITY_INSERT AssetType OFF
GO

INSERT INTO AssetTypeAttribute(TypeId, AttributeId) 
	SELECT 1, A.Id FROM AssetAttribute A 
	WHERE NOT EXISTS (SELECT 1 FROM AssetTypeAttribute WHERE TypeId = 1 AND AttributeId = A.Id)

INSERT INTO AssetTypeAttribute(TypeId, AttributeId) 
	SELECT 2, A.Id FROM AssetAttribute  A 
	WHERE NOT EXISTS (SELECT 1 FROM AssetTypeAttribute WHERE TypeId = 2 AND AttributeId = A.Id)

INSERT INTO AssetTypeAttribute(TypeId, AttributeId) 
	SELECT 3, A.Id FROM AssetAttribute A 
	WHERE NOT EXISTS (SELECT 1 FROM AssetTypeAttribute WHERE TypeId = 3 AND AttributeId = A.Id)

INSERT INTO AssetTypeAttribute(TypeId, AttributeId) 
	SELECT 4, A.Id FROM AssetAttribute A 
	WHERE NOT EXISTS (SELECT 1 FROM AssetTypeAttribute WHERE TypeId = 4 AND AttributeId = A.Id)

INSERT INTO AssetTypeAttribute(TypeId, AttributeId) 
	SELECT 5, A.Id FROM AssetAttribute A 
	WHERE NOT EXISTS (SELECT 1 FROM AssetTypeAttribute WHERE TypeId = 5 AND AttributeId = A.Id)

INSERT INTO AssetTypeAttribute(TypeId, AttributeId) 
	SELECT 6, A.Id FROM AssetAttribute A 
	WHERE NOT EXISTS (SELECT 1 FROM AssetTypeAttribute WHERE TypeId = 6 AND AttributeId = A.Id)

INSERT INTO AssetTypeAttribute(TypeId, AttributeId) 
	SELECT 7, A.Id FROM AssetAttribute A 
	WHERE NOT EXISTS (SELECT 1 FROM AssetTypeAttribute WHERE TypeId = 7 AND AttributeId = A.Id)

INSERT INTO AssetTypeAttribute(TypeId, AttributeId) 
	SELECT 8, A.Id FROM AssetAttribute A 
	WHERE NOT EXISTS (SELECT 1 FROM AssetTypeAttribute WHERE TypeId = 8 AND AttributeId = A.Id)

INSERT INTO AssetTypeAttribute(TypeId, AttributeId) 
	SELECT 9, A.Id FROM AssetAttribute A 
	WHERE NOT EXISTS (SELECT 1 FROM AssetTypeAttribute WHERE TypeId = 9 AND AttributeId = A.Id)
GO


/**************************************************************
--任务
--**************************************************************/

INSERT INTO ScheduledTask([Name], Interval, Unit, Status, [Desc], TaskClass)
	SELECT N'更新员工当前状态', 10, 2, 2, N'统计员工是否在公司上班，还是请假外出', 'MissionskyOA.Services.Task.SummaryTodayStatus'
	WHERE NOT EXISTS (SELECT 1 FROM ScheduledTask WHERE Name = N'更新员工当前状态')

INSERT INTO ScheduledTask([Name], Interval, Unit, Status, [Desc], TaskClass)
	SELECT N'通知用户归还图书', 1, 4, 2, N'如果用户到期图书未归还，则每日提醒一次', 'MissionskyOA.Services.Task.NotifyReturnBook'
	WHERE NOT EXISTS (SELECT 1 FROM ScheduledTask WHERE Name = N'通知用户归还图书')

INSERT INTO ScheduledTask([Name], Interval, Unit, Status, [Desc], TaskClass)
	SELECT N'通知会议开始结束', 30, 1, 1, N'提前5分钟提示用户会议开始或结束', 'MissionskyOA.Services.Task.NotifyMeeting'
	WHERE NOT EXISTS (SELECT 1 FROM ScheduledTask WHERE Name = N'通知会议开始结束')
GO

/**************************************************************
--字典数据
--**************************************************************/

INSERT INTO DataDict(Type, Value, Text)
	SELECT N'报表格式', 'PDF', 'PDF'
	WHERE NOT EXISTS (SELECT 1 FROM DataDict WHERE Type = N'报表格式' AND Value = 'PDF')

INSERT INTO DataDict(Type, Value, Text)
	SELECT N'报表格式', 'Word', 'Word'
	WHERE NOT EXISTS (SELECT 1 FROM DataDict WHERE Type = N'报表格式' AND Value = 'Word')
	
INSERT INTO DataDict(Type, Value, Text)
	SELECT N'报表格式', 'Excel', 'Excel'
	WHERE NOT EXISTS (SELECT 1 FROM DataDict WHERE Type = N'报表格式' AND Value = 'Excel')
GO

INSERT INTO DataDict(Type, Value, Text)
	SELECT N'报表参数类型', 'Integer', 'Integer'
	WHERE NOT EXISTS (SELECT 1 FROM DataDict WHERE Type = N'报表参数类型' AND Value = 'Integer')
	
INSERT INTO DataDict(Type, Value, Text)
	SELECT N'报表参数类型', 'Float', 'Float'
	WHERE NOT EXISTS (SELECT 1 FROM DataDict WHERE Type = N'报表参数类型' AND Value = 'Float')
	
INSERT INTO DataDict(Type, Value, Text)
	SELECT N'报表参数类型', 'Boolean', 'Boolean'
	WHERE NOT EXISTS (SELECT 1 FROM DataDict WHERE Type = N'报表参数类型' AND Value = 'Boolean')
	
INSERT INTO DataDict(Type, Value, Text)
	SELECT N'报表参数类型', 'DateTime', 'DateTime'
	WHERE NOT EXISTS (SELECT 1 FROM DataDict WHERE Type = N'报表参数类型' AND Value = 'DateTime')
	
INSERT INTO DataDict(Type, Value, Text)
	SELECT N'报表参数类型', 'Date', 'Date'
	WHERE NOT EXISTS (SELECT 1 FROM DataDict WHERE Type = N'报表参数类型' AND Value = 'Date')
	
INSERT INTO DataDict(Type, Value, Text)
	SELECT N'报表参数类型', 'String', 'String'
	WHERE NOT EXISTS (SELECT 1 FROM DataDict WHERE Type = N'报表参数类型' AND Value = 'String')
	
INSERT INTO DataDict(Type, Value, Text)
	SELECT N'报表参数类型', 'DropdownList', 'DropdownList'
	WHERE NOT EXISTS (SELECT 1 FROM DataDict WHERE Type = N'报表参数类型' AND Value = 'DropdownList')
GO


/**************************************************************
--报表
--**************************************************************/

SET IDENTITY_INSERT Report ON
GO

INSERT Report (Id, Name, [Desc], CreatedTime, IsOpen, No) 
SELECT 1, N'员工请假加班记录', N'统计员工请假加班记录', GETDATE(), 1, N'' 
	WHERE NOT EXISTS(SELECT 1 FROM Report WHERE Name = N'员工请假加班记录')
	
INSERT Report (Id, Name, [Desc], CreatedTime, IsOpen, No) 
SELECT 2, N'资产管理报表', N'资产管理报表', GETDATE(), 1, N'' 
	WHERE NOT EXISTS(SELECT 1 FROM Report WHERE Name = N'资产管理报表')
	
INSERT Report (Id, Name, [Desc], CreatedTime, IsOpen, No)  
SELECT 3, N'请假和加班汇总表', N'请假和加班汇总表', GETDATE(), 1, N''
	WHERE NOT EXISTS(SELECT 1 FROM Report WHERE Name = N'请假和加班汇总表')
	
INSERT Report (Id, Name, [Desc], CreatedTime, IsOpen, No)  
SELECT 4, N'员工出勤率汇总', N'员工出勤率汇总', GETDATE(), 1, N''
	WHERE NOT EXISTS(SELECT 1 FROM Report WHERE Name = N'员工出勤率汇总')
	
INSERT Report (Id, Name, [Desc], CreatedTime, IsOpen, No)  
SELECT 5, N'报销申请单', N'报销申请单', GETDATE(), 0, N'MS_EX_ORDER_REPORT'
	WHERE NOT EXISTS(SELECT 1 FROM Report WHERE Name = N'报销申请单')
	
INSERT Report (Id, Name, [Desc], CreatedTime, IsOpen, No)  
SELECT 6, N'统计员工个人申请记录', N'统计员工个人申请记录', GETDATE(), 1, N''
	WHERE NOT EXISTS(SELECT 1 FROM Report WHERE Name = N'统计员工个人申请记录')

SET IDENTITY_INSERT Report OFF
GO

SET IDENTITY_INSERT ReportConfig ON 
GO

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime)   
SELECT 1, 1, N'DefaultFormat', N'PDF', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 1 AND Config = N'DefaultFormat')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 2, 1, N'ServiceUrl', N'http://oa-server/ReportServer', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 1 AND Config = N'ServiceUrl')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 3, 1, N'ReportPath', N'/MissionskyOA/MissionskyOA_SummaryReportByPerson', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 1 AND Config = N'ReportPath')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 4, 1, N'UserName', N'oa', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 1 AND Config = N'UserName')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 5, 1, N'Password', N'Ms123456!', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 1 AND Config = N'Password')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 6, 1, N'Domain', N'oa-server', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 1 AND Config = N'Domain')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 7, 2, N'DefaultFormat', N'Word', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 2 AND Config = N'DefaultFormat')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 8, 2, N'ServiceUrl', N'http://oa-server/ReportServer', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 2 AND Config = N'ServiceUrl')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 9, 2, N'ReportPath', N'/MissionskyOA/AssetInventoryReport', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 2 AND Config = N'ServiceUrl')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 10, 2, N'UserName', N'oa', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 2 AND Config = N'UserName')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 11, 2, N'UserName', N'Ms123456!', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 2 AND Config = N'UserName')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 12, 2, N'Domain', N'oa-server', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 2 AND Config = N'Domain')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 13, 3, N'DefaultFormat', N'Excel', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 3 AND Config = N'DefaultFormat')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 14, 3, N'ServiceUrl', N'http://oa-server/ReportServer', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 3 AND Config = N'ServiceUrl')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 15, 3, N'ReportPath', N'/MissionskyOA/MissionskyOA_SummaryReportByProject', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 3 AND Config = N'ReportPath')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 16, 3, N'ReportPath', N'oa', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 3 AND Config = N'ReportPath')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 17, 3, N'Password', N'Ms123456!', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 3 AND Config = N'Password')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 18, 3, N'Password', N'oa-server', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 3 AND Config = N'Password')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 19, 4, N'DefaultFormat', N'PDF', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 4 AND Config = N'DefaultFormat')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 20, 4, N'ServiceUrl', N'http://oa-server/ReportServer', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 4 AND Config = N'ServiceUrl')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 21, 4, N'ReportPath', N'/MissionskyOA/MissionskyOA_ResourceReport', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 4 AND Config = N'ReportPath')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 22, 4, N'UserName', N'oa', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 4 AND Config = N'UserName')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 23, 4, N'Password', N'Ms123456!', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 4 AND Config = N'Password')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 24, 4, N'Domain', N'oa-server', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 4 AND Config = N'Domain')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 25, 5, N'DefaultFormat', N'PDF', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 5 AND Config = N'DefaultFormat')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 26, 5, N'ServiceUrl', N'http://oa-server/ReportServer', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 5 AND Config = N'ServiceUrl')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 27, 5, N'ReportPath', N'/MissionskyOA/MissionskyOA_ExpenseReimbursementReport', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 5 AND Config = N'ReportPath')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 28, 5, N'UserName', N'oa', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 5 AND Config = N'UserName')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 29, 5, N'Password', N'Ms123456!', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 5 AND Config = N'Password')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 30, 5, N'Domain', N'oa-server', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 5 AND Config = N'Domain')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 31, 6, N'DefaultFormat', N'PDF', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 6 AND Config = N'DefaultFormat')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 32, 6, N'ServiceUrl', N'http://oa-server/ReportServer', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 6 AND Config = N'ServiceUrl')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 33, 6, N'ReportPath', N'/MissionskyOA/MissionskyOA_SummaryReportforSinglePerson', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 6 AND Config = N'ReportPath')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 34, 6, N'UserName', N'oa', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 6 AND Config = N'UserName')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 35, 6, N'Password', N'Ms123456!', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 6 AND Config = N'Password')

INSERT ReportConfig (Id, ReportId, Config, [Value], CreatedTime) 
SELECT 36, 6, N'Domain', N'oa-server', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportConfig WHERE ReportId = 6 AND Config = N'Domain')

SET IDENTITY_INSERT ReportConfig OFF
GO
	
UPDATE ReportConfig SET [Value] = N'https://missionsky-demo.missionsky.com/ReportServer' WHERE Config=N'ServiceUrl' AND [Value]=N'http://oa-server/ReportServer';
GO

UPDATE ReportConfig SET [Value] = N'missionsky' WHERE Config=N'UserName' AND [Value]=N'oa';
GO

UPDATE ReportConfig SET [Value] = N'missionsky' WHERE Config=N'Password' AND [Value]=N'Ms123456!';
GO

UPDATE ReportConfig SET [Value] = N'missionsky-demo' WHERE Config=N'Domain' AND [Value]=N'oa-server';
GO

SET IDENTITY_INSERT ReportParameter ON 
GO

INSERT ReportParameter (Id, ReportId, Name, [Desc], Type, Nullable, DataSource, CreatedTime) 
SELECT 1, 1, N'StartDate', N'开始时间', N'Date', 0, NULL, GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportParameter WHERE ReportId = 1 AND Name = N'StartDate')

INSERT ReportParameter (Id, ReportId, Name, [Desc], Type, Nullable, DataSource, CreatedTime) 
SELECT 2, 1, N'EndDate', N'结束时间', N'Date', 0, NULL, GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportParameter WHERE ReportId = 1 AND Name = N'EndDate')

INSERT ReportParameter (Id, ReportId, Name, [Desc], Type, Nullable, DataSource, CreatedTime) 
SELECT 3, 2, N'DateType', N'资产类型', N'DropdownList', 0, N'AssetType', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportParameter WHERE ReportId = 2 AND Name = N'DateType')

INSERT ReportParameter (Id, ReportId, Name, [Desc], Type, Nullable, DataSource, CreatedTime) 
SELECT 4, 2, N'InventoryID', N'资产盘点', N'DropdownList', 0, N'AssetInventory', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportParameter WHERE ReportId = 2 AND Name = N'InventoryID')

INSERT ReportParameter (Id, ReportId, Name, [Desc], Type, Nullable, DataSource, CreatedTime) 
SELECT 5, 3, N'StartDate', N'开始时间', N'Date', 0, NULL, GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportParameter WHERE ReportId = 3 AND Name = N'StartDate')

INSERT ReportParameter (Id, ReportId, Name, [Desc], Type, Nullable, DataSource, CreatedTime) 
SELECT 6, 3, N'EndDate', N'结束时间', N'Date', 0, NULL, GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportParameter WHERE ReportId = 3 AND Name = N'EndDate')

INSERT ReportParameter (Id, ReportId, Name, [Desc], Type, Nullable, DataSource, CreatedTime) 
SELECT 7, 3, N'ProjectName', N'项目组', N'DropdownList', 1, N'Project', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportParameter WHERE ReportId = 3 AND Name = N'ProjectName')

INSERT ReportParameter (Id, ReportId, Name, [Desc], Type, Nullable, DataSource, CreatedTime) 
SELECT 8, 4, N'StartDate', N'开始时间', N'Date', 0, NULL, GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportParameter WHERE ReportId = 4 AND Name = N'StartDate')

INSERT ReportParameter (Id, ReportId, Name, [Desc], Type, Nullable, DataSource, CreatedTime) 
SELECT 9, 4, N'EndDate', N'结束时间', N'Date', 0, NULL, GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportParameter WHERE ReportId = 4 AND Name = N'EndDate')

INSERT ReportParameter (Id, ReportId, Name, [Desc], Type, Nullable, DataSource, CreatedTime) 
SELECT 10, 5, N'RequestID', N'报销单Id', N'Integer', 0, NULL, GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportParameter WHERE ReportId = 5 AND Name = N'RequestID')

INSERT ReportParameter (Id, ReportId, Name, [Desc], Type, Nullable, DataSource, CreatedTime) 
SELECT 11, 6, N'StartDate', N'开始时间', N'Date', 0, NULL, GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportParameter WHERE ReportId = 6 AND Name = N'StartDate')

INSERT ReportParameter (Id, ReportId, Name, [Desc], Type, Nullable, DataSource, CreatedTime) 
SELECT 12, 6, N'EndDate', N'结束时间', N'Date', 0, NULL, GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportParameter WHERE ReportId = 6 AND Name = N'EndDate')

INSERT ReportParameter (Id, ReportId, Name, [Desc], Type, Nullable, DataSource, CreatedTime) 
SELECT 13, 6, N'UserID', N'员工Id', N'DropdownList', 0, N'User', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportParameter WHERE ReportId = 6 AND Name = N'UserID')


SET IDENTITY_INSERT ReportParameter OFF
GO


