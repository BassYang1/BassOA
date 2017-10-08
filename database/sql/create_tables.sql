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