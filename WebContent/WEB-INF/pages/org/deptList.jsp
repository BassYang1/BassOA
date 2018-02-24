<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<%
	String pageTitle = (String) request.getAttribute("pageTitle");

	if (pageTitle == "" || pageTitle == "") {
		request.setAttribute("pageTitle", "部门列表");
	}
%>
<%@ include file="../shared/_header.jsp"%>
<link href="${pageContext.request.contextPath }/content/css/table.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/content/framework/css/bootstrap-pager.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath }/content/framework/js/bootstrap-pager.js"></script>
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
						<li class="active">部门列表</li>
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
							<div class="SimpleTable">
								<div class="title">
									<i class="fa fa-table"></i> <span class="fF lighter">部门列表</span>
								</div>
								<table class="table umar-t my-table" id="simpleTable">
									<thead>
										<tr>
											<th></th>
											<th>部门名</th>
											<th>父部门</th>
											<th>部门领导</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${depts }" var="d" varStatus="status" >
										<tr>
											<th>${status.index + 1 }</th>
											<th>${d.name }</th>
											<th>${d.parentName }</th>
											<th>${d.leaderName }</th>
											<th>
												<span class="table-icon bg-delete"> 
													<i class="fa fa-trash"></i>
												</span> 
												<span class="table-icon bg-edit"> 
													<i class="fa fa-edit"></i>
												</span>
											</th>
										</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<div id="page-container-static-normal"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../shared/_footer.jsp"%>
	<script type="text/javascript">
		$("#page-container-static-normal").page({
			count : 3,
			theme : "normal",
			pageSize : 1,
			pageNum : 2
		});
		$("#page-container-static-normal").on("pageChanged",
				function(e, pg) {
					console.log(pg);
					//$(this).data("page").refresh(params);
					location.href = "${pageContext.request.contextPath }/org/dept/list.do?pgnum=" + pg.pageNum + "&pgsize=" + pg.pageSize;
				});
	</script>
</body>
</html>
