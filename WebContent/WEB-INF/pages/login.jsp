<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户登录</title>
<link rel="stylesheet" type="text/css"
	href="../content/framework/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="../content/framework/css/font-awesome.css" />
<link rel="stylesheet" type="text/css" href="../content/css/base.css" />
<link rel="stylesheet" type="text/css" href="../content/css/app.css" />
<script src="../content/js/jquery-2.1.4.min.js"></script>
<script src="../content/framework/js/bootstrap.min.js"></script>
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
</head>
<body>
	<div class="main-container">
		<div class="container">
			<div class="panel-box login-form">
				<div class="panel-box-title login-form-title">
					<i class="glyphicon glyphicon-user"></i>&nbsp;用户登录
				</div>
				<div class="panel-box-content">
					<div class="form-group">
						<input type="text" class="form-control" id="userName"
							placeholder="请输入用户名" />
					</div>
					<div class="form-group">
						<input type="password" class="form-control" id="password"
							placeholder="请输入用户密码" />
					</div>
					<div class="form-group checkbox">
						<label>
							<input type="checkbox" id="cbRemember" />记住我
						</label> 
					</div>
					<div class="form-group">
						<button class="btn btn-primary btn-block">登录 >> </button>
						<span><a href="#"
							class="pull-right">忘记密码?</a></span>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>