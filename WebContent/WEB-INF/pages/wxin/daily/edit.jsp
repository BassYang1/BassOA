<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="frm"%>

<!DOCTYPE html>
<html>
<c:set var="pagename" scope="page" value="今日用药" />
<%@ include file="../../shared/_header.jsp"%>
<style>
.form-edit {
	width: 500px;
}

.form-item {
	padding: 0 5px !important;
}

.form-item:nth-child(even){
	margin-top:10px;
	margin-bottom:5px;
}

.form-item:nth-child(odd){
	margin-bottom:10px;
}

.form-error{
	height: 20px;
	margin-top: 5px;
	margin-bottom: 5px;
}

.form-item-msg {
	padding-left:10px;
}

.form-item-label {
	width: 50px;
	text-align:right;
	padding-right:5px;
}

#txtDose, #txtUnit{
	width: 140px !important;
}

#txtDrug{
	width: 200px !important;
}
</style>
<script>
	$(function() {
		$("#srcDrugItems a").each(function(i) {
			$(this).click(function() {
				if ($.trim($(this).text()) == "请选择药品") {
					$("#txtDrug").val("");
				} else {
					$("#txtDrug").val($.trim($(this).text()));
				}
			});
		});

		$("#unitOptions>label>input").change(function() {
			$("#txtUnit").val($.trim($("#unitOptions>label.active").text()));
		});

		$("#doseOptions>label>input").change(function() {
			var dose = "";

			$("#doseOptions>label.active").each(function() {
				dose += "," + $.trim($(this).text());
			});

			if (dose != "") {
				$("#txtDose").val(dose.substr(1));
			}
		});
	
		$(".form-group input").change(function(){
			$(".drug-error, .unit-error, .dose-error, .form-error").text("");
		});
		
		$(".btn-submit").click(function() {
			var doSubmit = true;
			var drugName = $.trim($("#txtDrug").val());
			var unit = $.trim($("#txtUnit").val());
			var dose = $.trim($("#txtDose").val());

			if (drugName == "") {
				doSubmit = false;
				$(".drug-error").text("请填写药品名称");
			}

			if (unit == "") {
				doSubmit = false;
				$(".unit-error").text("请选择剂量名称");
			}

			if (dose == "") {
				doSubmit = false;
				$(".dose-error").text("请选择用药剂量");
			}

			if (doSubmit) {
				$.post("${pageContext.request.contextPath}/wxin/daily/edit.do", {
					drugName : "",
					unit : "",
					dose : dose
				}).then(function(a,b,c) {
					alert("添加成功");
				}, function(a,b,c) {
					alert(a);
					alert(b);
					alert(c);
				});
			}
			else{
				$(".form-error").text("添加失败");
			}
		});
	});
</script>
<body>
	<div class="main-container">
		<div class="container">
			<div class="modal-dialog form-edit">
				<div class="modal-content">	
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title" id="gridSystemModalLabel">今日用药</h4>
						</div>				
						<div class="form-group form-inline form-item">
							<label class="form-item-label">药品</label>
							<div class="dropdown inline-block">
								<button class="btn btn-default dropdown-toggle" type="button"
									id="srcDrug" data-toggle="dropdown" aria-haspopup="true"
									aria-expanded="true">
									请选择药品 <span class="caret"></span>
								</button>
								<ul id="srcDrugItems" class="dropdown-menu" aria-labelledby="srcDrugItems">
									<c:forEach var="drug" items="${drugs}">
									<li><a href="#" title="${drug}">${drug}</a></li>
									</c:forEach>
								</ul>
							</div>
						</div>
						<div class="form-group form-inline form-item">
							<label class="form-item-label"></label>
							<input type="text" name="drug" id="txtDrug" class="form-control inline-block width200" placeholder="填写药品" />
							<label class="text-error drug-error form-item-msg"></label>
						</div>							
						<div class="form-group form-inline form-item">
							<label class="form-item-label">单位</label>
							<div id="unitOptions" class="btn-group" data-toggle="buttons">
								<label class="btn btn-primary">
									<input type="radio" name="unitOption" id="rdPiece" autocomplete="off">片
								</label> 
								<label class="btn btn-primary"> 
									<input type="radio" name="unitOption" id="rdGrain" autocomplete="off">粒
								</label>
							</div>
						</div>
						<div class="form-group form-inline form-item">
							<label class="form-item-label"></label>
							<input type="text" name="unit" id="txtUnit" class="form-control inline-block" placeholder="填写其它计量单位" />
							<label class="text-error unit-error form-item-msg"></label>
						</div>						
						<div class="form-group form-inline form-item">
							<label class="form-item-label">药量</label>
							<div id="doseOptions" class="btn-group" data-toggle="buttons">
								<label class="btn btn-primary"> 
									<input type="checkbox" name="optDose" id="cbDose3" autocomplete="off">3
								</label>
								<label class="btn btn-primary"> 
									<input type="checkbox" name="optDose" id="cbDose2" autocomplete="off">2
								</label>
								<label class="btn btn-primary"> 
									<input type="checkbox" name="optDose" id="cbDose1" autocomplete="off">1
								</label> 
								<label class="btn btn-primary"> 
									<input type="checkbox" name="optDose" id="cbDose1$2" autocomplete="off">1/2
								</label> 
								<label class="btn btn-primary"> 
									<input type="checkbox" name="optDose" id="cbDose3$4" autocomplete="off">3/4
								</label> 
								<label class="btn btn-primary"> 
									<input type="checkbox" name="optDose" id="cbDose1$4" autocomplete="off">1/4
								</label>
							</div>
						</div>
						<div class="form-group form-inline form-item">
							<label class="form-item-label"></label>	
							<input type="text" name="dose" id="txtDose" class="form-control inline-block" placeholder="填写用药量" />					
							<label class="text-error dose-error form-item-msg"></label>
						</div>
						<div class="text-error form-error form-item-msg"></div>	
						<div class="modal-footer">
							<button type="button" class="btn btn-default btn-cancel">取消</button>
							&nbsp;
							<button type="submit" class="btn btn-primary btn-submit">提交</button>
						</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>