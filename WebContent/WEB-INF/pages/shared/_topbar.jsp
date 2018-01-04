<%@ page pageEncoding="utf-8"%>
<div class="navbar-header pull-left">
	<a href="#" class="topNavTitle">demo</a>
</div>
<div class="navbar-header pull-right">
	<ul class="navRight">
		<li class="bg-grey"><a href="#"> <i
				class="fa fa-tasks nav-icon"></i> <span class="badge bg-grey-1">4</span>
		</a></li>
		<li class="bg-purple"><a href="#"> <i
				class="fa fa-bell nav-icon"></i> <span class="badge bg-purple-1">5</span>
		</a></li>
		<li class="bg-green"><a href="#"> <i
				class="fa fa-envelope nav-icon"></i> <span class="badge bg-green-1">8</span>
		</a></li>
		<li class="bg-blue dropdown user-menu">
			<a id="userMenu" data-target="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 
				<img class="nav-img" src="img/img-1.jpg">
				<span class="fwhite">${sessionScope.user.name }</span> 
				<i class="fa fa-angle-down nav-icon"></i>
			</a>
			<ul class="dropdown-menu" aria-labelledby="userMenu">
				<li role="separator" class="divider"></li>
				<li><a href="${pageContext.request.contextPath }/user/logout.do"><spring:message code="oa.logout" /></a></li>
			</ul>
		</li>
	</ul>
</div>

<script>
$(function(){
	com.init.style(); //样式初式化
});
</script>