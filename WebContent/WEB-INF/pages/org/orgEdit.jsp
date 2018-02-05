<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<%
	String pageTitle = (String)request.getAttribute("pageTitle");

	if(pageTitle == "" || pageTitle == ""){
		request.setAttribute("pageTitle", "编辑机构信息");
	}
%>
<%@ include file="../shared/_header.jsp"%>

<script>
	$(function() {
		$("#name, #contact, #email").focus(function(){
			$(".name-msg, .contact-msg, .email-msg, .form-msg").text("");
		});
		
		//保存
		$(".formSave").click(doSubmit);
		
		function doSubmit () {
			var name = $.trim($("#name").val());
			var email = $.trim($("#email").val());
			
			var isValid = true;
			var _btn = new MyButton(doSubmit);
			_btn.off();
			$(".text-error").text("");

			if (name == "") {
				$(".name-msg").text("公司名称不能为空");
				isValid = false;
			}

			if(email == "" || !com.checkEmail(email)){
				$(".email-msg").text("无效的公司邮箱");
				isValid = false;
			}

			if(isValid == false){
				$(".form-msg").text("保存公司信息失败");
				_btn.on();
				return;
			}		
			
			$("#frmOrg").submit();
		}
	});
</script>
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
						<li><i class="nav-icon"></i> <a href="${pageContext.request.contextPath }/org/detail.do"><span>机构信息</span></a>
						</li>
						<li class="active">编辑</li>
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
								<i class="fa fa-file-text-o"></i> <span class="fF lighter">机构信息</span>
							</div>
							<div class="module umar-t">
								<div class="container">
									<div class="row">
										<div class="col-xs-12">
											<form:form id="frmOrg" commandName="org" method="POST" action="${pageContext.request.contextPath }/org/edit.do" class="form-horizontal" role="form">
												<div class="text-error form-msg">${error}</div>
												<div class="form-group">
													<form:label path="name" class="col-xs-1 control-label">机构名称 : </form:label>
													<div class="col-xs-5">
														<form:input type="hidden" path="id" />
														<form:input path="name" class="col-xs-12 form-control" placeholder="请输入机构名称" />
														<div class="text-error name-msg"><form:errors path="name" /></div>
													</div>
												</div>
												<div class="form-group">
													<form:label path="director" class="col-xs-1 control-label">负责人 : </form:label>
													<div class="col-xs-2">
														<form:input path="director" class="col-xs-12 form-control" placeholder="请输入负责人姓名" />
													</div>
													<form:label path="contact" class="col-xs-1 control-label">联系方式 : </form:label>
													<div class="col-xs-2">
														<form:input path="contact" class="col-xs-12 form-control" placeholder="请输入联系方式" />
														<div class="text-error contact-msg"><form:errors path="contact" /></div>
													</div>
													<div class="col-xs-6">	
													</div>
												</div>
												<div class="form-group">
													<form:label path="url" class="col-xs-1 control-label">网址 : </form:label>
													<div class="col-xs-2">
														<form:input path="url" type="url" class="col-xs-12 form-control" placeholder="请输入官网地址" />
													</div>
													<form:label path="email" class="col-xs-1 control-label">邮箱 : </form:label>
													<div class="col-xs-2">
														<form:input path="email" type="email" class="col-xs-12 form-control" placeholder="请输入机构邮箱" />
														<div class="text-error email-msg"><form:errors path="email" /></div>
													</div>
													<div class="col-xs-6">	
													</div>
												</div>
												<div class="form-group">
													<form:label path="address" class="col-xs-1 control-label">地址 : </form:label>
													<div class="col-xs-5">
														<form:input path="address" class="col-xs-12 form-control" placeholder="请输入地址" />
													</div>
													<div class="col-xs-6">	
													</div>
												</div>
												<div class="form-group">
													<form:label path="intro" class="col-xs-1 control-label">简介 : </form:label>
													<div class="col-xs-5">
														<form:textarea path="intro" class="col-xs-12 form-control" placeholder="请输入机构简介" />
													</div>
													<div class="col-xs-6">	
													</div>
												</div>
												<div class="form-actions">
													<div class="col-xs-6">
														<div class="btnBox">
															<div class="form-btn formSave">保存</div>
														</div>
													</div>
													<div class="col-xs-6">	
													</div>
												</div>
											</form:form>
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
