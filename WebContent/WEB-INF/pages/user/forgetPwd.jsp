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
			
			var error = function(p1, p2, p3){				
				$(".form-msg").text(p3);
			};
			
			com.post("${pageContext.request.contextPath }/user/sendCaptcha4Pwd.do", {email: email}, false, success, error);
			
			/* $.post("${pageContext.request.contextPath }/user/sendCaptcha4Pwd.do", {email: email}).then(
				function(res){
					com.onButton(".btn-captcha", doSend);
					
					if(rest = null || res == ""){
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
				}, 
				function(p1, p2, p3){
					com.onButton(".btn-captcha", doSend);
					
					$(".form-msg").text(p3);
				}
			); */
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
					<form:form id="frmUserLogin" method="POST" commandName="captcha" action="${pageContext.request.contextPath }/user/checkCaptcha.do?${pageContext.request.queryString }">						
						<div class="text-error form-msg">${message}</div>
						<div class="form-group">				
							<div><label>邮箱</label></div>
							<div>
							<input type="email" class="form-control" id="email" name="email"
								placeholder="请输入用户邮箱" />
								<div class="text-error email-msg"><form:errors path="email" /></div>
							</div>
						</div>
						<div class="form-group">							
							<div><label>验证码</label></div>
							<div>
							<input type="text" class="form-control" style="width:40%; display:inline;" id="captcha" name="captcha"
								placeholder="请输入验证码" />
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