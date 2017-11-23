USE oa
GO

--用户表
--SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='oa' AND TABLE_NAME='userinfo'
CREATE TABLE IF NOT EXISTS tbUser(
	userId INT PRIMARY KEY auto_increment,
	userName VARCHAR(20) UNIQUE,
	password VARCHAR(20),
	loginedDate DATETIME,
	createdDate DATETIME
)engine=innodb DEFAULT charset=utf8 auto_increment=1;
INSERT INTO tbUser(userName, password, createdDate) VALUES('admin', '', now());

--日常用药量
CREATE TABLE IF NOT EXISTS tbDailyDose(
	seqNumber INT PRIMARY KEY auto_increment,
	drugName VARCHAR(50),
	dose VARCHAR(100),
	unit VARCHAR(100),
	drugTime DATETIME
)engine=innodb DEFAULT charset=utf8 auto_increment=1;

--INSERT INTO tbDailyDose(drugName, dose, unit, drugTime) VALUES('huafalin', '1,3/4', 'pian', sysdate());