<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	
<!DOCTYPE html>
<html>
<%
	String pageTitle = (String)request.getAttribute("pageTitle");

	if(pageTitle == "" || pageTitle == ""){
		request.setAttribute("pageTitle", "用户登录");
	}
%>
<%@ include file="shared/_header.jsp"%>
<style>
.login-form {    
	display: block;
    margin-right: auto;
    margin-left: auto;
    margin-top: 140px;
	width: 300px;
}

.login-form .login-form-title {
	
}

.login-control {
	
}

#rememberme {
	vertical-align:middle;
	margin-top:6px;
}
</style>
<script>
	$(function() {
		$("#userName, #password").focus(function(){
			$(".userName-msg, .password-msg, .form-msg").text("");
		});
		
		//登录
		$(".btn-submit").click(doSubmit);		
		function doSubmit () {
			var isValid = true;
			var _btn = new MyButton(doSubmit);
			_btn.off();

			if ($.trim($("#userName").val()) == "") {
				$(".userName-msg").text("<spring:message code="NotEmpty.user.userName"/>");
				isValid = false;
			}

			if ($.trim($("#password").val()) == "") {
				$(".password-msg").text("<spring:message code="NotEmpty.user.password"/>");
				isValid = false;
			}

			$("#rememberme").val($("#rememberme").is(":checked") ? true : false);
			
			if(isValid == false){
				$(".form-msg").text("<spring:message code="user.login.validation.error"/>");
				_btn.on();
				return;
			}		
			
			$("#frmUserLogin").submit();
		}
	});
</script>
<body>
	<div class="main-container">
		<div class="container">
			<div class="panel-box login-form">
				<div class="panel-box-title login-form-title">
					<i class="glyphicon glyphicon-user"></i>&nbsp;用户登录
				</div>
				<div class="panel-box-content">
					<form:form id="frmUserLogin" method="POST" commandName="user" action="${pageContext.request.contextPath }/user/login.do?${pageContext.request.queryString }">						
						<div class="text-error form-msg">${error}</div>
						<div class="form-group">	
							<div><label class="control-label">用户名</label></div>
							<div>
							<input type="text" class="form-control" id="userName" name="userName"
								placeholder="请输入用户名" />
								<div class="text-error userName-msg"><form:errors path="userName" /></div>
							</div>
						</div>
						<div class="form-group">
							<div><label>密码</label></div>
							<div>
							<input type="password" class="form-control" id="password" name="password"
								placeholder="请输入用户密码" />
								<div class="text-error password-msg"><form:errors path="password" /></div>
							</div>
						</div>
						<div class="form-group checkbox">
							<label><input type="checkbox" id="rememberme" name="rememberme" />记住我
							</label>
						</div>
						<div class="form-group">
							<input type="button" class="btn btn-primary btn-block btn-submit" value="登录 >>" />
							<span><a href="${pageContext.request.contextPath }/user/forgetPwd.do" class="pull-right">忘记密码?</a></span>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>