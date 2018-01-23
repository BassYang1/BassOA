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
		$("#email, #captcha, #password, #cfmPassword").focus(function(){
			$(".text-error").text("");
		});
		
		//提交请求
		$(".btn-submit").click(doSubmit);
		
		function doSubmit() {
			var isValid = true;
			var _btn = new MyButton(doSubmit);
			_btn.off();
			$(".text-error").text("");
			
			var email = $.trim($("#email").val());
			var captcha = $.trim($("#captcha").val());
			var password = $.trim($("#password").val());
			var cfmPassword = $.trim($("#cfmPassword").val());
			
			if(email == "" || !com.checkEmail(email)){
				$(".email-msg").text("<spring:message code="Email.password.email"/>");
				isValid = false;
			}

			if (captcha == "") {
				$(".captcha-msg").text("<spring:message code="NotEmpty.password.captcha"/>");
				isValid = false;
			}

			if (password == "") {
				$(".password-msg").text("<spring:message code="NotEmpty.password.password"/>");
				isValid = false;
			}

			if (cfmPassword == "") {
				$(".cfmPassword-msg").text("<spring:message code="NotEmpty.password.cfmPassword"/>");
				isValid = false;
			}

			if (cfmPassword != password) {
				$(".cfmPassword-msg").text("确认密码不一致");
				isValid = false;
			}
			
			if(isValid == false){
				_btn.on();
				return;
			}
			
			$("#frmPwd").submit();
		}
	
		//发送验证码
		$(".btn-captcha").click(doSend);
		
		function doSend() {
			var _btn = new MyButton(doSend);
			_btn.off();
			com.clearMsg(".text-error");
			
			var email = $.trim($("#email").val());
			
			if(email == "" || !com.checkEmail(email)){
				$(".email-msg").text("<spring:message code="Email.password.email"/>");
				_btn.on();
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
				
				_btn.on();
			};
			
			//请求失败回调
			var error = function(p1, p2, p3){				
				$(".form-msg").text(p3);
				_btn.on();
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
					<form:form id="frmPwd" method="POST" commandName="password" action="${pageContext.request.contextPath }/user/forgetPwd.do">						
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
							<div><form:label path="password">新密码</form:label></div>
							<div>
								<form:password  path="password" class="form-control" placeholder="请输入用户密码" />								
								<div class="text-error password-msg"><form:errors path="password" /></div>
							</div>
						</div>
						<div class="form-group">							
							<div><form:label path="cfmPassword">确认密码</form:label></div>
							<div>								
								<form:password  path="cfmPassword" class="form-control" placeholder="请输入确认密码" />
								<div class="text-error cfmPassword-msg"><form:errors path="cfmPassword" /></div>
							</div>
						</div>
						<div class="form-group">
							<input type="button" class="btn btn-primary btn-block btn-submit" value="提交 >>" />
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>