<%@ page pageEncoding="utf-8"%>
<button type="button" class="btn btn-primary btn-lg hidden" data-toggle="modal" data-target="#myInfo">
  Launch demo modal
</button>

<!-- Modal -->
<div class="modal fade" id="myInfo" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog my-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">个人信息</h4>
			</div>
			<div class="modal-body">
				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-default">修改</button>
			</div>
		</div>
	</div>
</div>

<script>
	$(function() {
		setTimeout(function() {
			sidebarHeight();//控制侧导航的高度
		}, 0);
	})
</script>