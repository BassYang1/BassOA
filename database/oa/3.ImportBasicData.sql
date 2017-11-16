USE MissionskyOA
GO

/*

--����Ȩ��
EXEC sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
EXEC sp_configure 'Ad Hoc Distributed Queries', 1;
GO
RECONFIGURE;
GO 
EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1
GO
EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1
GO

--��ѯExcel
INSERT INTO ImportedUser(No, ChineseName, EnglishName, Phone, Email, QQID, Gender, DirectlySupervisor, UserDept, Project, UserRole, Position, JoinDate)
SELECT ����, ������, Ӣ����, ��ϵ��ʽ, ����, QQ, �Ա�, �ϼ��쵼, ����, ��Ŀ��, ��ɫ, ְλ,��ְ����
 
FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
                       'Excel 8.0;Database=C:/User20171030.xlsx;', 
                       'SELECT * FROM [User$]')

--�ر�Ȩ��
EXEC sp_configure 'Ad Hoc Distributed Queries', 0;
GO
RECONFIGURE;
GO 
EXEC sp_configure 'show advanced options', 0;
GO
RECONFIGURE;
GO
EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 0
GO
EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 0
GO

*/

/**************************************************************
--�������� Department
--**************************************************************/


SET IDENTITY_INSERT Department ON
GO

INSERT INTO Department(Id, No, Name, CreateUserName, Status, CreatedDate)
SELECT ROW_NUMBER() OVER (ORDER BY D.UserDept DESC) , ROW_NUMBER() OVER (ORDER BY D.UserDept DESC), D.UserDept, N'Admin', 1, GETDATE()
FROM (SELECT DISTINCT UserDept FROM ImportedUser WHERE UserDept IS NOT NULL) AS D
WHERE NOT EXISTS(SELECT 1 FROM Department WHERE D.UserDept = Name)

SET IDENTITY_INSERT Department OFF
GO

/**************************************************************
--�������� Role
--**************************************************************/

SET IDENTITY_INSERT Role ON
GO

INSERT INTO Role(Id, Name, ApprovedDays, Abbreviation, IsInitRole, Status, CreateUser, CreatedTime)
SELECT ROW_NUMBER() OVER (ORDER BY R.UserRole DESC) , R.UserRole, NULL, NULL, 1, 1, N'Admin', GETDATE()
FROM (SELECT DISTINCT UserRole FROM ImportedUser WHERE UserRole IS NOT NULL) AS R
WHERE NOT EXISTS(SELECT 1 FROM Role WHERE R.UserRole = Name)

SET IDENTITY_INSERT Role OFF
GO

/**************************************************************
--�������� Project
--**************************************************************/

SET IDENTITY_INSERT Project ON
GO

INSERT INTO Project(Id, Name, CreateUserName, Status)
SELECT ROW_NUMBER() OVER (ORDER BY P.Project DESC), P.Project, N'Admin', 1
FROM (SELECT DISTINCT Project FROM ImportedUser WHERE Project IS NOT NULL) AS P
WHERE NOT EXISTS(SELECT 1 FROM Project WHERE P.Project = Name)

SET IDENTITY_INSERT Project OFF
GO


/**************************************************************
--�������� User
--**************************************************************/

SET IDENTITY_INSERT [User] ON
GO

INSERT INTO [User](Id, No, ChineseName, EnglishName, Phone, Email, QQID, Gender, Position, JoinDate, Status, Available, CreatedTime)
SELECT ROW_NUMBER() OVER (ORDER BY No), No, 
	ChineseName, EnglishName, Phone, Email, QQID, 
	(CASE WHEN ISNULL(Gender, N'��') = N'��' THEN 1 ELSE 0 END) AS Gender, 
	Position, JoinDate, 0 AS Status, 1 AS Available, GETDATE() AS CreatedTime
FROM ImportedUser U
WHERE NOT EXISTS(SELECT 1 FROM [User] WHERE U.EnglishName = EnglishName)

SET IDENTITY_INSERT [User] OFF
GO

/**************************************************************
--�û���ɫ UserRole
--**************************************************************/

INSERT INTO UserRole(UserId, RoleId)
SELECT U.Id, R.Id
FROM [User] U, ImportedUser U1, Role R
WHERE U.EnglishName = U1.EnglishName AND R.Name = U1.UserRole 
	AND NOT EXISTS(SELECT 1 FROM UserRole WHERE U.Id = UserId)

/**************************************************************
--�������� User
--**************************************************************/

--����ֱ���쵼
UPDATE U SET U.DirectlySupervisorId = U2.Id
FROM [User] U, ImportedUser U1, [User] U2
WHERE U.EnglishName = U1.EnglishName AND ISNULL(U1.DirectlySupervisor, '') = U2.EnglishName

--����Ա������
UPDATE U SET U.DeptId = D.Id
FROM [User] U, ImportedUser U1, Department D
WHERE U.EnglishName = U1.EnglishName AND ISNULL(U1.UserDept, '') = D.Name

--����Ա����Ŀ��
UPDATE U SET U.ProjectId = P.Id
FROM [User] U, ImportedUser U1, Project P
WHERE U.EnglishName = U1.EnglishName AND ISNULL(U1.Project, '') = P.Name
