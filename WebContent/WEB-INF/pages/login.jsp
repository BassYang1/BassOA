<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
	
<!DOCTYPE html>
<html>
<c:set var="pagename" scope="page" value="用户登录"/>
<%@ include file="shared/_header.jsp"%>
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
			<div class="panel-box login-form">
				<div class="panel-box-title login-form-title">
					<i class="glyphicon glyphicon-user"></i>&nbsp;用户登录
				</div>
				<div class="panel-box-content">
					<div class="form-group">
						<div class="text-danger">
							<c:if test="${result != null && result.status == false }">
								${empty result.message ? "登录失败" : result.message }
							</c:if>
						</div>
					</div>
					<form:form method="POST" commandName="user" action="${pageContext.request.contextPath}/user/loginSubmit.do">
						<div>${error}</div>
						<div class="form-group">
							<input type="text" class="form-control" id="userName"
								placeholder="请输入用户名" />
								<form:errors path="userName" />
						</div>
						<div class="form-group">
							<input type="password" class="form-control" id="password"
								placeholder="请输入用户密码" />
								<form:errors path="password" />
						</div>
						<div class="form-group checkbox">
							<label> <input type="checkbox" id="cbRemember" />记住我
							</label>
						</div>
						<div class="form-group">
							<button class="btn btn-primary btn-block">登录 >></button>
							<span><a href="#" class="pull-right">忘记密码?</a></span>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>