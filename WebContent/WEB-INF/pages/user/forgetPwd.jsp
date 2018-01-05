<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	
<!DOCTYPE html>
<html>
<%@ include file="../shared/_header.jsp"%>
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

</style>
<script>
	$(function() {
		$("#userName, #password").focus(function(){
			$(".userName-msg, .password-msg, .form-msg").text("");
		});
		
		$(".btn-submit").click(
			function() {
				var doSubmit = true;
	
				if ($.trim($("#userName").val()) == "") {
					$(".userName-msg").text("<spring:message code="NotEmpty.user.userName"/>");
					doSubmit = false;
				}

				if ($.trim($("#password").val()) == "") {
					$(".password-msg").text("<spring:message code="NotEmpty.user.password"/>");
					doSubmit = false;
				}
				
				if(doSubmit == false){
					$(".form-msg").text("<spring:message code="user.login.validation.error"/>");
				}
				
				$("#rememberme").val($("#rememberme").is(":checked") ? true : false);
				
				return doSubmit;
			}
		);
	});
</script>
<body>
	<div class="main-container">
		<div class="container">
			<div class="panel-box login-form">
				<div class="panel-box-title login-form-title">
					<i class="glyphicon glyphicon-user"></i>&nbsp;忘记密码
				</div>
				<div class="panel-box-content">
					<form:form id="frmUserLogin" method="POST" commandName="captcha" action="${pageContext.request.contextPath }/user/checkCaptcha.do?${pageContext.request.queryString }">						
						<div class="text-error form-msg">${message}</div>
						<div class="form-group">
							<input type="text" class="form-control" id="email" name="email"
								placeholder="请输入用户邮箱" />
								<div class="text-error userName-msg"><form:errors path="userName" /></div>
						</div>
						<div class="form-group">
							<input type="password" class="form-control" id="captcha" name="captcha"
								placeholder="请输入验证码" />
								<div class="text-error password-msg"><form:errors path="password" /></div>
						</div>
						<div class="form-group">
							<button class="btn btn-primary btn-block btn-submit">确认 >></button>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>