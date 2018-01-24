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
							<div class="module umar-t">
								<div class="container">
									<div class="row">
										<div class="form-horizontal">
											<div class="col-xs-2"></div>
											<div class="col-xs-8">
												<div class="form-group">
													<label class="col-sm-2 control-label">用户姓名</label>
													<div class="col-sm-10">
														<p class="form-control-static">${user.name }</p>
													</div>
												</div>
											</div>
											<div class="col-xs-2"></div>
											<div class="form-actions">
												<div class="col-xs-12">
													<div class="btnBox">
														<div class="form-btn formDel">取消</div>
														<div class="form-btn formPreview">预览</div>
														<div class="form-btn formSave">保存</div>
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
