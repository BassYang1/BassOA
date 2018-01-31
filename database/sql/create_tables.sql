USE oa
GO

CREATE TABLE IF NOT EXISTS tbModule(
	
)engine=innodb DEFAULT charset=utf8 auto_increment=1;

--用户表
CREATE TABLE IF NOT EXISTS tbUser(
	userId INT PRIMARY KEY auto_increment,
	userName VARCHAR(20) UNIQUE,
	password VARCHAR(100) NOT NULL,
	name VARCHAR(20) NOT NULL,
	email VARCHAR(50) NOT NULL,
	enabled TINYINT(1) DEFAULT TRUE,
	loginCount INT,	--登录次数
	loginDate DATETIME,	--登录时间
	expiredDate DATETIME,	--token过期时间
	token VARCHAR(200),	--userName+GUID+加密
	series VARCHAR(200),	--登录密文, userName+密码+token过期时间+Salt+加密
	createdDate DATETIME
)engine=innodb DEFAULT charset=utf8 auto_increment=1;

INSERT INTO tbUser(userName, password, name, email, createdDate) VALUES('admin', 'd82494f05d6917ba02f7aaa29689ccb444bb73f20380876cb05d1f37537b7892', 'AdminUser', '672836012@qq.com',now());

--机构(公司)表
CREATE TABLE IF NOT EXISTS tbOrganization(
	id INT PRIMARY KEY auto_increment,
	name VARCHAR(20) NOT NULL, --公司名称
	director VARCHAR(20), --负责人
	contact VARCHAR(20), --联系方式
	email VARCHAR(50), --邮箱
	url VARCHAR(100), --主页地址
	address VARCHAR(100), --公司地址
	intro TEXT, --公司简介
	createdDate DATETIME
)engine=innodb DEFAULT charset=utf8 auto_increment=1;

INSERT INTO tbOrganization(name, email, createdDate) VALUES("TestCompany", "test@test.com", NOW());

--部门表
CREATE TABLE IF NOT EXISTS tbDepartment(
	id INT PRIMARY KEY auto_increment,
	orgId INT NOT NULL,
	parentId INT,
	code VARCHAR(100) NOT NULL,
	name VARCHAR(20) NOT NULL,
	leader INT,
	createdDate DATETIME
)engine=innodb DEFAULT charset=utf8 auto_increment=1;

--日常用药量
CREATE TABLE IF NOT EXISTS tbDailyDose(
	seqNumber INT PRIMARY KEY auto_increment,
	userId INT,
	drugName VARCHAR(50),
	dose VARCHAR(100),
	unit VARCHAR(100),
	drugTime DATETIME
)engine=innodb DEFAULT charset=utf8 auto_increment=1;

--INSERT INTO tbDailyDose(drugName, userId, dose, unit, drugTime) VALUES('huafalin', 1, '1,3/4', 'pian', sysdate());
--INSERT INTO tbDailyDose(drugName, userId, dose, unit, drugTime) VALUES('huafalin', 1, '1,1/2', 'pian', sysdate());
--INSERT INTO tbDailyDose(drugName, userId, dose, unit, drugTime) VALUES('gankang', 1, '1', 'pian', sysdate());
--SELECT drugName FROM (SELECT drugName, MAX(drugTime) AS drugTime FROM tbDailyDose GROUP BY drugName) A ORDER BY drugTime DESC;