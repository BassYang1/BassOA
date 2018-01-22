<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	
<!DOCTYPE html>
<html>
<%
	String pageTitle = (String)request.getAttribute("pageTitle");

	if(pageTitle == "" || pageTitle == ""){
		request.setAttribute("pageTitle", "邮箱验证");
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
		$("#email, #captcha").focus(function(){
			$(".text-error").text("");
		});
		
		//提交请求
		$(".btn-submit").click(
			function() {
				$(".text-error").text("");
				
				var doSubmit = true;captcha
				var email = $.trim($("#email").val());
				var captcha = $.trim($("#captcha").val());
				
				if(email == "" || !com.checkEmail(email)){
					$(".email-msg").text("<spring:message code="Email.captcha.email"/>");
					doSubmit = false;
				}

				if (captcha == "") {
					$(".captcha-msg").text("<spring:message code="NotEmpty.captcha.captcha"/>");
					doSubmit = false;
				}
								
				return doSubmit;
			}
		);
		
		//发送验证码
		$(".btn-captcha").click(doSend);
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
					<i class="glyphicon glyphicon-lock"></i>&nbsp;忘记密码
				</div>
				<div class="panel-box-content">
					<form:form id="frmCaptcha" method="POST" commandName="captcha" action="${pageContext.request.contextPath }/user/forgetPwd.do">						
						<div class="text-error form-msg">${error}</div>
						<div class="form-group">				
							<div><form:label path="email">邮箱</form:label></div>
							<div>
								<form:input path="email" type="email" class="form-control" placeholder="请输入用户邮箱" />								
								<div class="text-error email-msg"><form:errors path="email" /></div>
							</div>
						</div>
						<div class="form-group">							
							<div><form:label path="captcha">验证码</form:label></div>
							<div>
								<form:input path="captcha" class="form-control" style="width:40%; display:inline;" placeholder="请输入验证码" />
								<a class="btn btn-link btn-captcha">发送验证码</a>
								<span class="captcha-success"></span>
								<div class="text-error captcha-msg"><form:errors path="captcha" /></div>
							</div>
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