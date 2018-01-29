<%@ page pageEncoding="utf-8"%>
<div class="sidebar" id="sidebar">
	<ul class="nav nav-list">
		<%-- <li data-html="index">
			<a href="${pageContext.request.contextPath }/index.do"> 
				<i class="nav-icon fa fa-tachometer"></i> 
				<span class="menu-text">Dashboard</span>
			</a>
		</li> --%>
		<li data-html="table" data-blean="false" idx="1">
			<a> 
				<i class="nav-icon fa fa-th-large"></i> 
				<span class="menu-text">组织架构</span>
				<b class="arrow fa fa-angle-down"></b>
			</a>
			<ul class="submenu">
				<li data-html="Simple">
					<a href="${pageContext.request.contextPath }/org/detail.do"> 
						<i class="subnav-icon fa fa-caret-right"></i> <span>公司</span>
					</a>
				</li>
				<li data-html="jqGrid"><a href="${pageContext.request.contextPath }/org/dept/list.do"> <i
						class="subnav-icon fa fa-caret-right"></i> <span>部门</span>
				</a></li>
			</ul></li>
	</ul>
</div>

<script type="text/javascript">
	$(function() {
		$("#sidebar > ul > li").on("click", function() {
			$.cookie("sidebar", $(this).prop("idx"));
			
			//转变箭头的方向
			if ($(this).attr("data-blean") == "true") {
				$(this).find("b").css({
					"-webkit-transform" : "rotateX(180deg)"
				});
				$(this).attr("data-blean", "false");
			} else {
				$(this).find("b").css({
					"-webkit-transform" : "rotateX(0deg)"
				});
				$(this).attr("data-blean", "true");
			}

			$(this).find(".submenu").slideToggle("fast");
			$(".submenu").on("click", function() {
				event.stopPropagation();//阻止冒泡事件
			});
		});
		
		var idx = $.cookie("sidebar");
		
		if(idx == undefined || typeof idx  != "number" || $.isEmpty($("#sidebar > ul > li:eq(" + idx + ")"))){
			$("#sidebar > ul > li:eq(0)").click();
		}
		else{
			$("#sidebar > ul > li:eq(" + idx + ")").click();
		}
	});
</script>