<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="frm"%>

<!DOCTYPE html>
<html>
<head>
<c:set var="pagename" scope="page" value="日常用药" />
<%@ include file="../../shared/_header.jsp"%>
<body>
	<!--引入头部-->
	<div id="topNav" class="topNav">
		<%@ include file="../../shared/_topbar.jsp"%>
	</div>

	<!--中间内容-->
	<div class="main-container">
		<!--引入左侧导航-->
		<div class="sidebar" id="sidebar">
			<%@ include file="../../shared/_menubar.jsp"%>
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
						<!-- <form class="form-search">
							<span class="nav-search-inner"> <i
								class="search_icon fa fa-search"></i> <input placeholder="搜索..." />
							</span>
						</form> -->
					</div>

				</div>
			</div>
			<div class="page-content">
				<div class="container">
					<div class="btn-toolbar btn-nav" role="toolbar" aria-label="">
						<div class="btn-group" role="group" aria-label="">
							<button type="button" class="btn btn-default">添加</button>
							<button type="button" class="btn btn-default">修改</button>
							<button type="button" class="btn btn-default">删除</button>
							<button type="button" class="btn btn-default">导出</button>
						</div>
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary active"> 
								<input type="checkbox" autocomplete="off" checked>天
							</label>														
							<button type="button" class="btn btn-default dropdown-toggle"
								data-toggle="dropdown" aria-haspopup="true"
								aria-expanded="false">
								<span class="caret"></span> <span class="sr-only">选择日</span>
							</button>
							<ul class="dropdown-menu">
								<li><a href="#">01</a></li>
								<li><a href="#">02</a></li>
								<li><a href="#">03</a></li>
								<li role="separator" class="divider"></li>
								<li><input type="text" name="month" id="txtMonth"
									placeholder="日" /></li>
							</ul> 
							<label class="btn btn-primary"> <input type="checkbox"
								autocomplete="off">月
							</label>							
							<button type="button" class="btn btn-default dropdown-toggle"
								data-toggle="dropdown" aria-haspopup="true"
								aria-expanded="false">
								<span class="caret"></span> <span class="sr-only">选择月</span>
							</button>
							<ul class="dropdown-menu">
								<li><a href="#">01</a></li>
								<li><a href="#">02</a></li>
								<li><a href="#">03</a></li>
								<li role="separator" class="divider"></li>
								<li><input type="text" name="month" id="txtMonth"
									placeholder="月份" /></li>
							</ul>
							<label class="btn btn-primary"> <input type="checkbox"
								autocomplete="off">年
							</label>
							<button type="button" class="btn btn-default dropdown-toggle"
								data-toggle="dropdown" aria-haspopup="true"
								aria-expanded="false">
								<span class="caret"></span> <span class="sr-only">选择年</span>
							</button>
							<ul class="dropdown-menu">
								<li><a href="#">2017</a></li>
								<li><a href="#">2016</a></li>
								<li><a href="#">2015</a></li>
								<li role="separator" class="divider"></li>
								<li><input type="text" name="year" id="txtYear"
									placeholder="年份" /></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="js/app.js"></script>
	<script>
		$(function() {
			setTimeout(function() {
				sidebarHeight();//控制侧导航的高度
			}, 0);
		})
	</script>
</body>
</html>
