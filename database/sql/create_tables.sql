USE oa
GO

--用户表
--SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='oa' AND TABLE_NAME='userinfo'
CREATE TABLE IF NOT EXISTS tbUser(
	userId INT PRIMARY KEY auto_increment,
	userName VARCHAR(20) UNIQUE,
	password VARCHAR(20) NOT NULL,
	loginCount INT DEFAULT(0),	--登录次数
	loginDate DATETIME,	--登录时间
	expiredDate DATETIME,	--token过期时间
	token VARCHAR(200),	--userName+GUID+加密
	series VARCHAR(200),	--登录密文, userName+密码+token过期时间+Salt+加密
	createdDate DATETIME
)engine=innodb DEFAULT charset=utf8 auto_increment=1;

INSERT INTO tbUser(userName, password, createdDate) VALUES('admin', 'admin', now());

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