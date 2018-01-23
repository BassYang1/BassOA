<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	
<!DOCTYPE html>
<html>
<%
	String pageTitle = (String)request.getAttribute("pageTitle");

	if(pageTitle == "" || pageTitle == ""){
		request.setAttribute("pageTitle", "重置密码");
	}
%>

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
		$(".btn-captcha").click(doSend);
		
		$("#email, #captcha").focus(function(){
			$(".text-error").text("");
		});
		
		$(".btn-submit").click(
			function() {
				$(".text-error").text("");
				
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
		
		//发送验证码
		function doSend() {
			com.clearMsg(".text-error");
			
			var email = $.trim($("#email").val());
			
			if(email == "" || !com.checkEmail(email)){
				$(".email-msg").text("<spring:message code="Email.captcha.email"/>");
				return;
			}
			
			//请求成功回调
			var success = function(res) {				
				if(res == null || res == ""){
					var msg = "<spring:message code="captcha.send.again" />";
					var sec = 60;
					$(".captcha-success").html(msg.replace(/\\$\d?\\$/i, sec));
					$(".btn-captcha").hide();
					$(".captcha-success").show();
					
					var timer = window.setInterval(function(){
						$(".captcha-success").html(msg.replace(/\\$\d?\\$/i, --sec));
						
						if(sec <= 0){
							if(timer != null){
								$(".btn-captcha").show();
								$(".captcha-success").hide();
								window.clearInterval(timer);
							}
						}
					}, 1000);
				}
				else{
					$(".form-msg").text(res);
				}
			};
			
			//请求失败回调
			var error = function(p1, p2, p3){				
				$(".form-msg").text(p3);
			};
			
			com.post("${pageContext.request.contextPath }/user/sendCaptcha4Pwd.do", {email: email}, false, success, error);
		}
	});
</script>
<body>
	<div class="main-container">
		<div class="container">
			<div class="panel-box login-form">
				<div class="panel-box-title login-form-title">
					<i class="glyphicon glyphicon-lock"></i>&nbsp;重置密码
				</div>
				<div class="panel-box-content">
					<form:form id="frmPwd" method="POST" commandName="password" action="${pageContext.request.contextPath }/user/resetPwd.do">						
						<div class="text-error form-msg">${error}</div>
						<div class="form-group">				
							<div><form:label path="password">新密码</form:label></div>
							<div>
								<form:password  path="password" class="form-control" placeholder="请输入用户密码" />								
								<div class="text-error password-msg"><form:errors path="password" /></div>
							</div>
						</div>
						<div class="form-group">							
							<div><form:label path="checkPassword">确认密码</form:label></div>
							<div>								
								<form:password  path="checkPassword" class="form-control" placeholder="请输入确认密码" />
								<div class="text-error checkPassword-msg"><form:errors path="checkPassword" /></div>
							</div>
						</div>
						<div class="form-group">
							<button class="btn btn-primary btn-block btn-submit">重置 >></button>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>