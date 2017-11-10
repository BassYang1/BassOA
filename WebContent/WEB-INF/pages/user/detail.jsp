<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
	
<!DOCTYPE html>
<html>
<c:set var="pagename" scope="page" value="用户详细"/>
<%@ include file="../shared/_header.jsp"%>
<style>
.login-form {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 280px;
	height: 260px;
	margin-left: -140px;
	margin-top: -130px;
}

.login-form .login-form-title {
	
}

.login-control {
	
}
</style>
<body>
	<div class="main-container">
		<div class="container">
			用户详细
		</div>
		<div>用户Id: ${user.userId}</div>
		<div>用户名: ${user.userName}</div>
		<div>用户Token: ${user.userToken}</div>
	</div>
</body>
</html>