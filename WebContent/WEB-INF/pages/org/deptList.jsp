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
								<table class="table umar-t" id="simpleTable">
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
							<div id="grid-pager"
								class="ui-jqgrid-pager ui-state-default ui-corner-bottom"
								dir="ltr" style="width: 756px;">
								<div id="pg_grid-pager" class="ui-pager-control" role="group">
									<table class="ui-pg-table ui-common-table ui-pager-table ">
										<tbody>
											<tr>
												<td id="grid-pager_left" align="left"></td>
												<td id="grid-pager_center" align="center"
													style="white-space: pre; width: 204px;"><table
														class="ui-pg-table ui-common-table ui-paging-pager">
														<tbody>
															<tr>
																<td id="first_grid-pager"
																	class="ui-pg-button ui-corner-all ui-state-disabled"
																	title="First Page" style="cursor: default;"><span
																	class="ui-icon fa fa-angle-double-left"></span></td>
																<td id="prev_grid-pager"
																	class="ui-pg-button ui-corner-all ui-state-disabled"
																	title="Previous Page" style="cursor: default;"><span
																	class="ui-icon fa fa-angle-left"></span></td>
																<td class="ui-pg-button ui-state-disabled"
																	style="cursor: default;"><span
																	class="ui-separator"></span></td>
																<td id="input_grid-pager" dir="ltr">Page <input
																	class="ui-pg-input ui-corner-all" type="text" size="2"
																	maxlength="7" value="0" role="textbox"> of <span
																	id="sp_1_grid-pager">2</span></td>
																<td class="ui-pg-button ui-state-disabled"><span
																	class="ui-separator"></span></td>
																<td id="next_grid-pager"
																	class="ui-pg-button ui-corner-all" title="Next Page"
																	style="cursor: default;"><span
																	class="ui-icon fa fa-angle-right"></span></td>
																<td id="last_grid-pager"
																	class="ui-pg-button ui-corner-all" title="Last Page"
																	style="cursor: default;"><span
																	class="ui-icon fa fa-angle-double-right"></span></td>
																<td dir="ltr"><select
																	class="ui-pg-selbox ui-widget-content ui-corner-all"
																	role="listbox" title="Records per Page"><option
																			role="option" value="10" selected="selected">10</option>
																		<option role="option" value="20">20</option>
																		<option role="option" value="30">30</option></select></td>
															</tr>
														</tbody>
													</table></td>
												<td id="grid-pager_right" align="right"><div dir="ltr"
														style="text-align: right" class="ui-paging-info">View
														1 - 10 of 15</div></td>
											</tr>
										</tbody>
									</table>
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
