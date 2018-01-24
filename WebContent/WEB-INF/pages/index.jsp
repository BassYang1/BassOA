<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<%
	String pageTitle = (String)request.getAttribute("pageTitle");

	if(pageTitle == "" || pageTitle == ""){
		request.setAttribute("pageTitle", "首页");
	}
%>
<%@ include file="shared/_header.jsp" %>

<body>
	<!--引入头部-->
	<div id="topNav" class="topNav">
		<%@ include file="shared/_topbar.jsp"%>
	</div>

	<!--中间内容-->
	<div class="main-container">
		<!--引入左侧导航-->
		<div class="sidebar" id="sidebar">
			<%@ include file="shared/_menubar.jsp"%>
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
							<span class="nav-search-inner"> <i
								class="search_icon fa fa-search"></i> <input placeholder="搜索..." />
							</span>
						</form>
					</div>

				</div>
			</div>
			<div class="page-content">
				<div class="container">
					<div class="row">
						<div class="col-xs-12">
							<div class="alert alert-success umar-t">
								<i class="fa fa-check"></i> <span>Demo</span> <i
									class="close-icon fa fa-close pull-right"></i>
							</div>
							<div class="row">
								<div class="col-xs-6">
									<div class="panel-box">
										<div class="panel-box-title"></div>
										<div class="panel-box-content">
											<p></p>
											<ul>
												<li></li>

											</ul>
										</div>
									</div>
									<div class="panel-box umar-t">
										<div class="panel-box-title"></div>
										<div class="panel-box-content">
											<ul>
												<li><i class="fa fa-close"></i> <span class="umar-l"><a></a></span>
												</li>
												<li><i class="fa fa-close"></i> <span class="umar-l"><a></a></span>
												</li>
											</ul>
										</div>
									</div>
								</div>
								<div class="col-xs-6">
									<div class="panel-box">
										<div class="panel-box-title">用户登录</div>
										<div class="panel-box-content">
											<ul>
												<li class="panel-box-veision"><span></span> <span
													class="pull-right umar-r fgrey"></span></li>
												<li class="panel-box-veision umar-t"><span></span> <span
													class="pull-right umar-r fgrey"></span></li>

											</ul>
										</div>
									</div>
								</div>
							</div>
							<div id="footer" class="footer">
								<span class="footerText pull-right"></span> <span
									class="footerText pull-right"></span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="shared/_footer.jsp" %>
	<%-- <jsp:include page="shared/_footer.jsp" />   --%>
</body>
</html>
