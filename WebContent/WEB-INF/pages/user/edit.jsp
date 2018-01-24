<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<%
	String pageTitle = (String)request.getAttribute("pageTitle");

	if(pageTitle == "" || pageTitle == ""){
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
							<div class="title">
								<i class="fa fa-file-text-o"></i> <span class="fF lighter">个人信息</span>
							</div>
							<div class="module umar-t">
								<div class="container">
									<div class="row">
										<div class="col-xs-12">
											<form class="form-horizontal" role="form">
												<div class="form-group">
													<label class="col-xs-2 control-label">选择框：</label>
													<div class="col-xs-8">
														<select class="form-control">
															<option value=""></option>
															<option value="1">1</option>
														</select>
													</div>
												</div>
												<div class="form-group">
													<label class="col-xs-2 control-label">输入框：</label>
													<div class="col-xs-8">
														<input type="text" placeholder="请输入..."
															class="col-xs-12 form-control" />
													</div>
												</div>
												<div class="form-group">
													<label class="col-xs-2 control-label">单选框：</label>
													<div class="col-xs-8">
														<span class="radio"> <label> <input
																name="form-field-radio" type="radio" class="ace">
																<span class="lbl">选项一</span>
														</label>
														</span> <span class="radio"> <label> <input
																name="form-field-radio" type="radio" class="ace">
																<span class="lbl">选项二</span>
														</label>
														</span> <span class="radio"> <label> <input
																name="form-field-radio" type="radio" class="ace">
																<span class="lbl">选项三</span>
														</label>
														</span>
													</div>
												</div>
												<div class="form-group">
													<label class="col-xs-2 control-label">复选框：</label>
													<div class="col-xs-8">
														<span class="checkbox"> <label> <input
																name="form-field-checkbox" type="checkbox" class="ace">
																<span class="lbl">选项一</span>
														</label>
														</span> <span class="checkbox"> <label> <input
																name="form-field-checkbox" type="checkbox" class="ace">
																<span class="lbl">选项二</span>
														</label>
														</span> <span class="checkbox"> <label> <input
																name="form-field-checkbox" type="checkbox" class="ace">
																<span class="lbl">选项三</span>
														</label>
														</span>
													</div>
												</div>
												<div class="form-group">
													<label class="col-xs-2 control-label">描述框：</label>
													<div class="col-xs-8">
														<textarea class="col-xs-12 form-control"></textarea>
													</div>
												</div>
												<div class="form-group">
													<label class="col-xs-2 control-label">表格数据：</label>
													<div class="col-xs-8">
														<div class="tableBox">
															<div class="tableTitle">
																<table class="table">
																	<thead>
																		<tr>
																			<th>名称</th>
																			<th>序列</th>
																			<th>类型</th>
																			<th>别名</th>
																			<th>是否可见</th>
																		</tr>
																	</thead>
																</table>
															</div>
															<div class="tableBody">
																<table class="table">
																	<tbody>
																		<tr>
																			<td>1-A</td>
																			<td>2-A</td>
																			<td>3-A</td>
																			<td><input type="text" class="form-control" />
																			</td>
																			<td><label> <input type="checkbox"
																					class="ace" /> <span class="lbl"></span>
																			</label></td>
																		</tr>
																		<tr>
																			<td>1-B</td>
																			<td>2-B</td>
																			<td>3-B</td>
																			<td><input type="text" class="form-control" />
																			</td>
																			<td><label> <input type="checkbox"
																					class="ace" /> <span class="lbl"></span>
																			</label></td>
																		</tr>
																		<tr>
																			<td>1-C</td>
																			<td>2-C</td>
																			<td>3-C</td>
																			<td><input type="text" class="form-control" />
																			</td>
																			<td><label> <input type="checkbox"
																					class="ace" /> <span class="lbl"></span>
																			</label></td>
																		</tr>
																		<tr>
																			<td>1-A</td>
																			<td>2-A</td>
																			<td>3-A</td>
																			<td><input type="text" class="form-control" />
																			</td>
																			<td><label> <input type="checkbox"
																					class="ace" /> <span class="lbl"></span>
																			</label></td>
																		</tr>
																		<tr>
																			<td>1-D</td>
																			<td>2-D</td>
																			<td>3-D</td>
																			<td><input type="text" class="form-control" />
																			</td>
																			<td><label> <input type="checkbox"
																					class="ace" /> <span class="lbl"></span>
																			</label></td>
																		</tr>
																		<tr>
																			<td>1-E</td>
																			<td>2-E</td>
																			<td>3-E</td>
																			<td><input type="text" class="form-control" />
																			</td>
																			<td><label> <input type="checkbox"
																					class="ace" /> <span class="lbl"></span>
																			</label></td>
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
													</div>
												</div>
												<div class="form-actions">
													<div class="col-xs-12">
														<div class="btnBox">
															<div class="form-btn formDel">取消</div>
															<div class="form-btn formPreview">预览</div>
															<div class="form-btn formSave">保存</div>
														</div>
													</div>
												</div>
											</form>
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
