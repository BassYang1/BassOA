<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<%
	String pageTitle = (String) request.getAttribute("pageTitle");

	if (pageTitle == "" || pageTitle == "") {
		request.setAttribute("pageTitle", "用户信息");
	}
%>
<%@ include file="../shared/_header.jsp"%>

<body>
	<!--引入头部-->
	<div id="topNav" class="topNav">
		<%@ include file="../shared/_topbar.jsp"%>
	</div>

	<!--中间内容-->
	<div class="main-container">
		<!--引入左侧导航-->
		<div class="sidebar" id="sidebar">
			<%@ include file="../shared/_menubar.jsp"%>
		</div>

		<!--主体内容-->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="contentTop">
					<ul class="topNavTitle">
						<li><i class="nav-icon fa fa-home"></i> <a href="#"><span>Home</span></a>
						</li>
						<li class="active">Dashboard</li>
					</ul>
					<div class="nav-search">
						<form class="form-search">
							<span class="nav-search-inner"> 
								<i class="search_icon fa fa-search"></i> 
								<input placeholder="搜索..." />
							</span>
						</form>
					</div>
				</div>
			</div>
			<div class="page-content">
				<div class="container">
					<div class="row">
						<div class="col-xs-12">
							<div class="title">
								<i class="fa fa-file-text-o"></i> <span class="fF lighter">个人信息</span>
							</div>
							<div class="module umar-t" style="margin-top: 0px !important">
								<div class="container">
									<div class="row">
										<div class="form-horizontal">
											<div class="col-xs-1"></div>
											<div class="col-xs-8">
												<div class="form-group">
													<label class="col-sm-2 control-label">用户姓名 : </label>
													<div class="col-sm-4">
														<p class="form-control-static">${user.name }</p>
													</div>
													<label class="col-sm-2 control-label">邮箱 : </label>
													<div class="col-sm-4">
														<p class="form-control-static">${user.email }</p>
													</div>
												</div>
											</div>
											<div class="col-xs-3">											
												<div class="form-group">
													<img alt="${user.name }" src="${pageContext.request.contextPath }/content/images/myphoto.jpg" width=150 height=150 />
												</div>
											</div>
											<div class="form-actions">
												<div class="col-xs-12">
													<div class="btnBox">
														<a role="button" class="btn btn-primary btn-edit">修改</a>
														<a role="button" class="btn btn-primary btn-upload">上传图像</a>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../shared/_footer.jsp"%>
</body>
</html>
