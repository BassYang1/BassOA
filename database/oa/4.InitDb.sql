USE MissionskyOA
GO

/**************************************************************
--�û���ɫ
--**************************************************************/
/*
SET IDENTITY_INSERT Role ON

INSERT INTO Role (Id, Name, ApprovedDays, CreatedTime, Abbreviation, IsInitRole, CreateUser, Status) 
	SELECT N'1', N'�ܾ���', N'1', N'2015-12-05 00:00:00.0000000', N'CEO', N'1', null, N'1' 
	WHERE NOT EXISTS (SELECT 1 FROM Role WHERE Name=N'�ܾ���')

INSERT INTO Role (Id, Name, ApprovedDays, CreatedTime, Abbreviation, IsInitRole, CreateUser, Status)  
	SELECT N'2', N'���ܾ���', N'1', N'2015-12-05 00:00:00.0000000', N'CFO', N'1', null, N'1' 
	WHERE NOT EXISTS (SELECT 1 FROM Role WHERE Name=N'���ܾ���')

INSERT INTO Role (Id, Name, ApprovedDays, CreatedTime, Abbreviation, IsInitRole, CreateUser, Status)  
	SELECT N'3', N'�ܼ�', N'1', N'2015-12-05 00:00:00.0000000', N'CTO', N'1', null, N'1' 
	WHERE NOT EXISTS (SELECT 1 FROM Role WHERE Name=N'�ܼ�')

INSERT INTO Role (Id, Name, ApprovedDays, CreatedTime, Abbreviation, IsInitRole, CreateUser, Status)  
	SELECT N'4', N'��Ŀ����', N'1', N'2015-12-05 00:00:00.0000000', N'PM', N'1', null, N'1' 
	WHERE NOT EXISTS (SELECT 1 FROM Role WHERE Name=N'��Ŀ����')

INSERT INTO Role (Id, Name, ApprovedDays, CreatedTime, Abbreviation, IsInitRole, CreateUser, Status)  
	SELECT N'5', N'����ʦ', N'1', N'2015-12-05 00:00:00.0000000', N'ENG', N'1', null, N'1' 
	WHERE NOT EXISTS (SELECT 1 FROM Role WHERE Name=N'����ʦ')

INSERT INTO Role (Id, Name, ApprovedDays, CreatedTime, Abbreviation, IsInitRole, CreateUser, Status)  
	SELECT N'6', N'����רԱ', N'1', N'2015-12-05 00:00:00.0000000', N'PD', N'1', null, N'1' 
	WHERE NOT EXISTS (SELECT 1 FROM Role WHERE Name=N'����רԱ')

INSERT INTO Role (Id, Name, ApprovedDays, CreatedTime, Abbreviation, IsInitRole, CreateUser, Status)  
	SELECT N'7', N'COO/CFO', N'1', N'2015-12-05 00:00:00.0000000', N'COO/CFO', N'1', null, N'1' 
	WHERE NOT EXISTS (SELECT 1 FROM Role WHERE Name=N'COO/CFO')

INSERT INTO Role (Id, Name, ApprovedDays, CreatedTime, Abbreviation, IsInitRole, CreateUser, Status)  
	SELECT N'8', N'CEO', N'1', N'2015-12-05 00:00:00.0000000', N'CEO', N'1', null, N'1' 
	WHERE NOT EXISTS (SELECT 1 FROM Role WHERE Name=N'CEO')

INSERT INTO Role (Id, Name, ApprovedDays, CreatedTime, Abbreviation, IsInitRole, CreateUser, Status)  
	SELECT N'9', N'�ʲ�����Ա', N'1', N'2015-12-05 00:00:00.0000000', N'ADMIN', N'1', null, N'1' 
	WHERE NOT EXISTS (SELECT 1 FROM Role WHERE Name=N'�ʲ�����Ա')

SET IDENTITY_INSERT Role OFF
GO
*/

/**************************************************************
--�û�/��ɫ
--**************************************************************/
INSERT INTO [User] (No ,ChineseName ,EnglishName ,QQID ,Email ,Phone ,Password ,Gender ,DirectlySupervisorId ,DeptId ,ProjectId ,Position ,Token ,Status ,Available ,TodayStatus ,JoinDate ,ExpirationTime ,CreatedTime)
	SELECT 
		NULL ,N'ϵͳ����Ա' ,'System Admin' ,NULL ,'admin@missionsky.com' ,NULL ,NULL ,NULL ,NULL ,
		(SELECT TOP 1 Id FROM Department WHERE Name LIKE N'%����%') AS DeptId ,
		0 ,N'ϵͳ����Ա' ,NULL ,0 ,1 ,1 ,GETDATE() ,NULL ,GETDATE()
	WHERE NOT EXISTS (SELECT 1 FROM [User] WHERE ChineseName=N'ϵͳ����Ա')
GO

INSERT INTO [User] (No ,ChineseName ,EnglishName ,QQID ,Email ,Phone ,Password ,Gender ,DirectlySupervisorId ,DeptId ,ProjectId ,Position ,Token ,Status ,Available ,TodayStatus ,JoinDate ,ExpirationTime ,CreatedTime)
	SELECT 
		NULL ,N'�ʲ�����Ա' ,'Assets Manager' ,NULL ,'assets.manager@missionsky.com' ,NULL ,NULL ,1 ,0 ,
		(SELECT TOP 1 Id FROM Department WHERE Name = N'IT��') AS DeptId ,
		0 ,N'�ʲ�����Ա' ,NULL ,0 ,1 ,1 ,GETDATE() ,NULL ,GETDATE()
	WHERE NOT EXISTS (SELECT 1 FROM [User] WHERE ChineseName=N'�ʲ�����Ա')
GO

UPDATE [User] SET AuthNotify = N'LeaveApprove:1;OvertimeApprove:1;ExpenseApprove:1;Notice:1;WorkTask:1;' WHERE LEN(ISNULL(AuthNotify, N'')) <= 0;
GO

UPDATE [User] SET Password = N'E1-0A-DC-39-49-BA-59-AB-BE-56-E0-57-F2-0F-88-3E' WHERE ISNULL(Password, '') = '';
GO

UPDATE [User] SET Email = LOWER(REPLACE(EnglishName,' ', '.')) + '@missionsky.com' WHERE ISNULL(EMAIL, '') = '';
GO

INSERT INTO UserRole(UserId, RoleId)
SELECT U.Id, R.Id FROM [USER] U, Role R
	WHERE ChineseName=N'ϵͳ����Ա' AND R.Name = N'����רԱ' 
		AND NOT EXISTS(SELECT 1 FROM UserRole WHERE UserId = U.Id AND RoleId = R.Id)
GO

INSERT INTO UserRole(UserId, RoleId)
SELECT U.Id, R.Id FROM [USER] U, Role R
	WHERE ChineseName=N'�ʲ�����Ա' AND R.Name = N'����רԱ' 
		AND NOT EXISTS(SELECT 1 FROM UserRole WHERE UserId = U.Id AND RoleId = R.Id)
GO

/**************************************************************
--�ʲ�����
--**************************************************************/

SET IDENTITY_INSERT AssetAttribute ON 

INSERT AssetAttribute (Id, Name, Description, DataType, Sort) 
	SELECT 1, N'���', NULL, 0, 1 
	WHERE NOT EXISTS (SELECT 1 FROM AssetAttribute WHERE Name=N'���')

INSERT AssetAttribute (Id, Name, Description, DataType, Sort) 
	SELECT 2, N'����', NULL, 2, 2 
	WHERE NOT EXISTS (SELECT 1 FROM AssetAttribute WHERE Name=N'����')

INSERT AssetAttribute (Id, Name, Description, DataType, Sort) 
	SELECT 3, N'���(RMB)', NULL, 1, 3 
	WHERE NOT EXISTS (SELECT 1 FROM AssetAttribute WHERE Name=N'���(RMB)')

INSERT AssetAttribute (Id, Name, Description, DataType, Sort) 
	SELECT 4, N'���(HKD)', NULL, 1, 4 
	WHERE NOT EXISTS (SELECT 1 FROM AssetAttribute WHERE Name=N'���(HKD)')

INSERT AssetAttribute (Id, Name, Description, DataType, Sort) 
	SELECT 5, N'��ϸ����', NULL, 2, 5 
	WHERE NOT EXISTS (SELECT 1 FROM AssetAttribute WHERE Name=N'��ϸ����')

INSERT AssetAttribute (Id, Name, Description, DataType, Sort) 
	SELECT 6, N'�ɹ�����', NULL, 3, 6 
	WHERE NOT EXISTS (SELECT 1 FROM AssetAttribute WHERE Name=N'�ɹ�����')

INSERT AssetAttribute (Id, Name, Description, DataType, Sort) 
	SELECT 7, N'�ɹ���', NULL, 2, 7 
	WHERE NOT EXISTS (SELECT 1 FROM AssetAttribute WHERE Name=N'�ɹ���')

INSERT AssetAttribute (Id, Name, Description, DataType, Sort) 
	SELECT 8, N'��������', NULL, 2, 8 
	WHERE NOT EXISTS (SELECT 1 FROM AssetAttribute WHERE Name=N'��������')

INSERT AssetAttribute (Id, Name, Description, DataType, Sort) 
	SELECT 9, N'�۾�', NULL, 2, 9 
	WHERE NOT EXISTS (SELECT 1 FROM AssetAttribute WHERE Name=N'�۾�')

INSERT AssetAttribute (Id, Name, Description, DataType, Sort) 
	SELECT 10, N'ʹ����', NULL, 2, 10 
	WHERE NOT EXISTS (SELECT 1 FROM AssetAttribute WHERE Name=N'ʹ����')

INSERT AssetAttribute (Id, Name, Description, DataType, Sort) 
	SELECT 11, N'��ŵص�', NULL, 2, 11 
	WHERE NOT EXISTS (SELECT 1 FROM AssetAttribute WHERE Name=N'��ŵص�')

INSERT AssetAttribute (Id, Name, Description, DataType, Sort) 
	SELECT 12, N'��ע', NULL, 2, 12 
	WHERE NOT EXISTS (SELECT 1 FROM AssetAttribute WHERE Name=N'��ע')

SET IDENTITY_INSERT AssetAttribute OFF
GO

SET IDENTITY_INSERT AssetType ON 

INSERT AssetType (Id, Name, Sort) 
	SELECT 1, N'����', 1 
	WHERE NOT EXISTS (SELECT 1 FROM AssetType WHERE Name=N'����')

INSERT AssetType (Id, Name, Sort) 
	SELECT 2, N'��ʾ��', 2 
	WHERE NOT EXISTS (SELECT 1 FROM AssetType WHERE Name=N'��ʾ��')

INSERT AssetType (Id, Name, Sort) 
	SELECT 3, N'MACMINI����', 3 
	WHERE NOT EXISTS (SELECT 1 FROM AssetType WHERE Name=N'MACMINI����')

INSERT AssetType (Id, Name, Sort) 
	SELECT 4, N'�ʼǱ�����', 4 
	WHERE NOT EXISTS (SELECT 1 FROM AssetType WHERE Name=N'�ʼǱ�����')

INSERT AssetType (Id, Name, Sort) 
	SELECT 5, N'ƽ�����', 5 
	WHERE NOT EXISTS (SELECT 1 FROM AssetType WHERE Name=N'ƽ�����')

INSERT AssetType (Id, Name, Sort) 
	SELECT 6, N'�ֻ�', 6 
	WHERE NOT EXISTS (SELECT 1 FROM AssetType WHERE Name=N'�ֻ�')

INSERT AssetType (Id, Name, Sort) 
	SELECT 7, N'���ݴ�', 7 
	WHERE NOT EXISTS (SELECT 1 FROM AssetType WHERE Name=N'���ݴ�')

INSERT AssetType (Id, Name, Sort) 
	SELECT 8, N'�����̶��ʲ�', 8 
	WHERE NOT EXISTS (SELECT 1 FROM AssetType WHERE Name=N'�����̶��ʲ�')

INSERT AssetType (Id, Name, Sort) 
	SELECT 9, N'�����׺�Ʒ', 9 
	WHERE NOT EXISTS (SELECT 1 FROM AssetType WHERE Name=N'�����׺�Ʒ')

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
--����
--**************************************************************/

INSERT INTO ScheduledTask([Name], Interval, Unit, Status, [Desc], TaskClass)
	SELECT N'����Ա����ǰ״̬', 10, 2, 2, N'ͳ��Ա���Ƿ��ڹ�˾�ϰ࣬����������', 'MissionskyOA.Services.Task.SummaryTodayStatus'
	WHERE NOT EXISTS (SELECT 1 FROM ScheduledTask WHERE Name = N'����Ա����ǰ״̬')

INSERT INTO ScheduledTask([Name], Interval, Unit, Status, [Desc], TaskClass)
	SELECT N'֪ͨ�û��黹ͼ��', 1, 4, 2, N'����û�����ͼ��δ�黹����ÿ������һ��', 'MissionskyOA.Services.Task.NotifyReturnBook'
	WHERE NOT EXISTS (SELECT 1 FROM ScheduledTask WHERE Name = N'֪ͨ�û��黹ͼ��')

INSERT INTO ScheduledTask([Name], Interval, Unit, Status, [Desc], TaskClass)
	SELECT N'֪ͨ���鿪ʼ����', 30, 1, 1, N'��ǰ5������ʾ�û����鿪ʼ�����', 'MissionskyOA.Services.Task.NotifyMeeting'
	WHERE NOT EXISTS (SELECT 1 FROM ScheduledTask WHERE Name = N'֪ͨ���鿪ʼ����')
GO

/**************************************************************
--�ֵ�����
--**************************************************************/

INSERT INTO DataDict(Type, Value, Text)
	SELECT N'�����ʽ', 'PDF', 'PDF'
	WHERE NOT EXISTS (SELECT 1 FROM DataDict WHERE Type = N'�����ʽ' AND Value = 'PDF')

INSERT INTO DataDict(Type, Value, Text)
	SELECT N'�����ʽ', 'Word', 'Word'
	WHERE NOT EXISTS (SELECT 1 FROM DataDict WHERE Type = N'�����ʽ' AND Value = 'Word')
	
INSERT INTO DataDict(Type, Value, Text)
	SELECT N'�����ʽ', 'Excel', 'Excel'
	WHERE NOT EXISTS (SELECT 1 FROM DataDict WHERE Type = N'�����ʽ' AND Value = 'Excel')
GO

INSERT INTO DataDict(Type, Value, Text)
	SELECT N'�����������', 'Integer', 'Integer'
	WHERE NOT EXISTS (SELECT 1 FROM DataDict WHERE Type = N'�����������' AND Value = 'Integer')
	
INSERT INTO DataDict(Type, Value, Text)
	SELECT N'�����������', 'Float', 'Float'
	WHERE NOT EXISTS (SELECT 1 FROM DataDict WHERE Type = N'�����������' AND Value = 'Float')
	
INSERT INTO DataDict(Type, Value, Text)
	SELECT N'�����������', 'Boolean', 'Boolean'
	WHERE NOT EXISTS (SELECT 1 FROM DataDict WHERE Type = N'�����������' AND Value = 'Boolean')
	
INSERT INTO DataDict(Type, Value, Text)
	SELECT N'�����������', 'DateTime', 'DateTime'
	WHERE NOT EXISTS (SELECT 1 FROM DataDict WHERE Type = N'�����������' AND Value = 'DateTime')
	
INSERT INTO DataDict(Type, Value, Text)
	SELECT N'�����������', 'Date', 'Date'
	WHERE NOT EXISTS (SELECT 1 FROM DataDict WHERE Type = N'�����������' AND Value = 'Date')
	
INSERT INTO DataDict(Type, Value, Text)
	SELECT N'�����������', 'String', 'String'
	WHERE NOT EXISTS (SELECT 1 FROM DataDict WHERE Type = N'�����������' AND Value = 'String')
	
INSERT INTO DataDict(Type, Value, Text)
	SELECT N'�����������', 'DropdownList', 'DropdownList'
	WHERE NOT EXISTS (SELECT 1 FROM DataDict WHERE Type = N'�����������' AND Value = 'DropdownList')
GO


/**************************************************************
--����
--**************************************************************/

SET IDENTITY_INSERT Report ON
GO

INSERT Report (Id, Name, [Desc], CreatedTime, IsOpen, No) 
SELECT 1, N'Ա����ټӰ��¼', N'ͳ��Ա����ټӰ��¼', GETDATE(), 1, N'' 
	WHERE NOT EXISTS(SELECT 1 FROM Report WHERE Name = N'Ա����ټӰ��¼')
	
INSERT Report (Id, Name, [Desc], CreatedTime, IsOpen, No) 
SELECT 2, N'�ʲ�������', N'�ʲ�������', GETDATE(), 1, N'' 
	WHERE NOT EXISTS(SELECT 1 FROM Report WHERE Name = N'�ʲ�������')
	
INSERT Report (Id, Name, [Desc], CreatedTime, IsOpen, No)  
SELECT 3, N'��ٺͼӰ���ܱ�', N'��ٺͼӰ���ܱ�', GETDATE(), 1, N''
	WHERE NOT EXISTS(SELECT 1 FROM Report WHERE Name = N'��ٺͼӰ���ܱ�')
	
INSERT Report (Id, Name, [Desc], CreatedTime, IsOpen, No)  
SELECT 4, N'Ա�������ʻ���', N'Ա�������ʻ���', GETDATE(), 1, N''
	WHERE NOT EXISTS(SELECT 1 FROM Report WHERE Name = N'Ա�������ʻ���')
	
INSERT Report (Id, Name, [Desc], CreatedTime, IsOpen, No)  
SELECT 5, N'�������뵥', N'�������뵥', GETDATE(), 0, N'MS_EX_ORDER_REPORT'
	WHERE NOT EXISTS(SELECT 1 FROM Report WHERE Name = N'�������뵥')
	
INSERT Report (Id, Name, [Desc], CreatedTime, IsOpen, No)  
SELECT 6, N'ͳ��Ա�����������¼', N'ͳ��Ա�����������¼', GETDATE(), 1, N''
	WHERE NOT EXISTS(SELECT 1 FROM Report WHERE Name = N'ͳ��Ա�����������¼')

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
SELECT 1, 1, N'StartDate', N'��ʼʱ��', N'Date', 0, NULL, GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportParameter WHERE ReportId = 1 AND Name = N'StartDate')

INSERT ReportParameter (Id, ReportId, Name, [Desc], Type, Nullable, DataSource, CreatedTime) 
SELECT 2, 1, N'EndDate', N'����ʱ��', N'Date', 0, NULL, GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportParameter WHERE ReportId = 1 AND Name = N'EndDate')

INSERT ReportParameter (Id, ReportId, Name, [Desc], Type, Nullable, DataSource, CreatedTime) 
SELECT 3, 2, N'DateType', N'�ʲ�����', N'DropdownList', 0, N'AssetType', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportParameter WHERE ReportId = 2 AND Name = N'DateType')

INSERT ReportParameter (Id, ReportId, Name, [Desc], Type, Nullable, DataSource, CreatedTime) 
SELECT 4, 2, N'InventoryID', N'�ʲ��̵�', N'DropdownList', 0, N'AssetInventory', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportParameter WHERE ReportId = 2 AND Name = N'InventoryID')

INSERT ReportParameter (Id, ReportId, Name, [Desc], Type, Nullable, DataSource, CreatedTime) 
SELECT 5, 3, N'StartDate', N'��ʼʱ��', N'Date', 0, NULL, GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportParameter WHERE ReportId = 3 AND Name = N'StartDate')

INSERT ReportParameter (Id, ReportId, Name, [Desc], Type, Nullable, DataSource, CreatedTime) 
SELECT 6, 3, N'EndDate', N'����ʱ��', N'Date', 0, NULL, GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportParameter WHERE ReportId = 3 AND Name = N'EndDate')

INSERT ReportParameter (Id, ReportId, Name, [Desc], Type, Nullable, DataSource, CreatedTime) 
SELECT 7, 3, N'ProjectName', N'��Ŀ��', N'DropdownList', 1, N'Project', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportParameter WHERE ReportId = 3 AND Name = N'ProjectName')

INSERT ReportParameter (Id, ReportId, Name, [Desc], Type, Nullable, DataSource, CreatedTime) 
SELECT 8, 4, N'StartDate', N'��ʼʱ��', N'Date', 0, NULL, GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportParameter WHERE ReportId = 4 AND Name = N'StartDate')

INSERT ReportParameter (Id, ReportId, Name, [Desc], Type, Nullable, DataSource, CreatedTime) 
SELECT 9, 4, N'EndDate', N'����ʱ��', N'Date', 0, NULL, GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportParameter WHERE ReportId = 4 AND Name = N'EndDate')

INSERT ReportParameter (Id, ReportId, Name, [Desc], Type, Nullable, DataSource, CreatedTime) 
SELECT 10, 5, N'RequestID', N'������Id', N'Integer', 0, NULL, GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportParameter WHERE ReportId = 5 AND Name = N'RequestID')

INSERT ReportParameter (Id, ReportId, Name, [Desc], Type, Nullable, DataSource, CreatedTime) 
SELECT 11, 6, N'StartDate', N'��ʼʱ��', N'Date', 0, NULL, GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportParameter WHERE ReportId = 6 AND Name = N'StartDate')

INSERT ReportParameter (Id, ReportId, Name, [Desc], Type, Nullable, DataSource, CreatedTime) 
SELECT 12, 6, N'EndDate', N'����ʱ��', N'Date', 0, NULL, GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportParameter WHERE ReportId = 6 AND Name = N'EndDate')

INSERT ReportParameter (Id, ReportId, Name, [Desc], Type, Nullable, DataSource, CreatedTime) 
SELECT 13, 6, N'UserID', N'Ա��Id', N'DropdownList', 0, N'User', GETDATE()
	WHERE NOT EXISTS(SELECT 1 FROM ReportParameter WHERE ReportId = 6 AND Name = N'UserID')


SET IDENTITY_INSERT ReportParameter OFF
GO


