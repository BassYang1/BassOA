<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<%
	String pageTitle = (String) request.getAttribute("pageTitle");

	if (pageTitle == "" || pageTitle == "") {
		request.setAttribute("pageTitle", "机构信息");
	}
%>
<%@ include file="../shared/_header.jsp"%>

<body>
	<!--引入头部-->
	<%@ include file="../shared/_topbar.jsp"%>

	<!--中间内容-->
	<div class="main-container">
		<!--引入左侧导航-->
		<%@ include file="../shared/_menubar.jsp"%>

		<!--主体内容-->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="contentTop">
					<ul class="topNavTitle">
						<li><i class="nav-icon fa fa-home"></i> <a href="${pageContext.request.contextPath }/index.do"><span>首页</span></a>
						</li>
						<li class="active">机构信息</li>
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
								<i class="fa fa-file-text-o"></i> <span class="fF lighter">机构信息</span>
							</div>
							<div class="module umar-t" style="margin-top: 0px !important">
								<div class="container">
									<div class="row">
										<div class="form-horizontal">
											<div class="col-xs-12">
												<div class="form-group">
													<label class="col-sm-1 control-label">机构名称 : </label>
													<div class="col-sm-5">
														<p class="form-control-static">${org.name }</p>
													</div>
													<div class="col-xs-6">	
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-1 control-label">负责人 : </label>
													<div class="col-sm-2">
														<p class="form-control-static">${org.director }</p>
													</div>
													<label class="col-sm-1 control-label">联系方式 : </label>
													<div class="col-sm-2">
														<p class="form-control-static">${org.contact }</p>
													</div>
													<div class="col-xs-6">	
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-1 control-label">网址 : </label>
													<div class="col-sm-2">
														<p class="form-control-static">${org.url }</p>
													</div>
													<label class="col-sm-1 control-label">邮箱 : </label>
													<div class="col-sm-2">
														<p class="form-control-static">${org.email }</p>
													</div>
													<div class="col-xs-6">	
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-1 control-label">地址 : </label>
													<div class="col-sm-5">
														<p class="form-control-static">${org.address }</p>
													</div>
													<div class="col-xs-6">	
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-1 control-label">简介 : </label>
													<div class="col-sm-5">
														<p class="form-control-static">${org.intro }</p>
													</div>
													<div class="col-xs-6">	
													</div>
												</div>
											</div>
											<div class="form-actions">
												<div class="col-xs-6">
													<div class="btnBox">
														<div class="form-btn formEdit">
															<a href="${pageContext.request.contextPath }/org/edit.do">修改</a>
														</div>
													</div>
												</div>
												<div class="col-xs-6">	
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
