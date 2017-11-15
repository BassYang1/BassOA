<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

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

.width140{
	width: 140px !important;
}

.width200{
	width: 200px !important;
}
</style>
<body>
	<div class="main-container">
		<div class="container">
			<div class="modal-dialog form-edit">
				<div class="modal-content">
					<form>						
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title" id="gridSystemModalLabel">今日用药</h4>
						</div>
						<br />						
						<div class="form-group form-item">
							<label for="unit">药品</label>
							<div class="dropdown inline-block">
								<button class="btn btn-default dropdown-toggle" type="button"
									id="srcDrug" data-toggle="dropdown" aria-haspopup="true"
									aria-expanded="true">
									请选择药品 <span class="caret"></span>
								</button>
								<ul class="dropdown-menu" aria-labelledby="srcDrugItems">
									<li><a href="#">华法林</a></li>
								</ul>
							</div>
							<input type="text" name="drug" id="txtDrug" class="form-control inline-block width200" placeholder="填写药品" />
						</div>
						<div class="form-group form-item">
							<label for="unit">单位</label>
							<div class="btn-group" data-toggle="buttons">
								<label class="btn btn-primary">
									<input type="radio" name="unitOption" id="rdPiece" autocomplete="off">片
								</label> 
								<label class="btn btn-primary"> 
									<input type="radio" name="unitOption" id="rdGrain" autocomplete="off">粒
								</label>
							</div>
							<input type="text" name="unit" id="txtUnit" class="form-control inline-block width140" placeholder="填写其它计量单位" />
						</div>
	  					<div class="form-group form-item">
							<label for="dose">药量</label>
							<div class="btn-group" data-toggle="buttons">
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
							<input type="text" name="dose" id="txtDose" class="form-control inline-block width140" placeholder="填写用药量" />					
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default">取消</button>
							&nbsp;
							<button type="submit" class="btn btn-primary">提交</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>