<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>
	.vm-adoptionReviewDetail__reply {
		display: flex;
		flex-direction: row;
	}	
	.vm-adoptionReviewDetail__reply-write {
		display: inline-block;
		width: 90%;
	}	
	.vm-adoptionReviewDetail .form-control .form-control-alternative {
		width: 100%;
		height: 80px;		
		padding: 15px;		
	}	
	.vm-adoptionReviewDetail__reply-btn-div {
		margin-top: 50px;
		display: inline-block;
		width: 9%;
	} 	
	.vm-adoptionReviewDetail__reply-btn { 
		position: relative;
		top: -33px;
		color: #fff;		
		background-color: #5e72e4;
		width: 100%; 
		height: 80px;
		text-align: center;
		border-radius: 5px;
		font-size: 20px;
		font-weight: bold;
		letter-spacing: 5px; 
		cursor: pointer;
	}	
	.vm-adoptionReviewDetail__reply-id {
		width: 85%;
		font-size: 13px;
	}	
	.vm-adoptionReviewDetail__reply-date {
		width: 14%;
		font-size: 13px;
	}	
	.vm-adoptionReviewDetail__reply-content {
		font-size: 22px;
		width: 85%;
	}	
	.vm-adoptionReviewDetail__reply-delete {
		width: 12%;
	}
	.vm-adoptionReviewDetail__reply-table {
		width: 100%;
	}
	.vm-adoptionReviewDetail .vui-table td:nth-child(2n+1) {
		background-color: #5e72e4;
		color: #fff;
		width: 10%;
		text-align: center;
		vertical-align: middle;
	}	
	.vm-adoptionReviewDetail .vui-table td:nth-child(2n) { 
		width: 30%;	
		padding-left: 10px;
		padding-top: 10px;
		padding-bottom: 10px;
		position: relative;			
	}
	.vm-adoptionReviewDetail .vui-board { padding: 10px; }
	.vm-adoptionReviewDetail .vui-board .table td, .vui-board .table tr {
	 	padding: 10px; 
	 	text-align: center;
	}
	.vm-AdoptionReviewUpdate_dc, 
	.vm-AdoptionReviewUpdate_gender, 
	.vm-AdoptionReviewUpdate_neuter,
	.vm-adoptionReviewDetail .form-group {
		float: left;
		padding: 5px;	
		width: 30%;
	}
	.vm-adoptionReviewDetail .form-group label { margin-top: 15px; }
</style>


<c:import url="/WEB-INF/views/common/top.jsp" />

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-section">
	
	<form action="ReviewUpdate" id="petReviewForm" method="post" enctype="multipart/form-data">
		<div class="vm-content vm-adoptionReviewDetail">
		<div class="vui-headline">입양 후기 수정</div>
			<hr class="mt-0 mb-4">
			<input type="hidden" value="${ requestScope.pet.pet_id }" id="pet_id" name="pet_id">
			<%-- table --%>
				<div class="vui-table">
					<table class="table" style="text-align: center;">						
						<tr>
							<td>이름</td>
							<td>
								<input type="text" value="${ requestScope.pet.name }" id="name" class="form-control form-control-alternative" name="name" style="width: 200px;" readonly>
							</td>
							<td>견종/묘종</td>
							<td>
								<input type="text" value="${ requestScope.pet.bdetail }" id="bedetail" class="form-control form-control-alternative" name="bedetail" style="width: 200px;" readonly>
							</td>
						</tr>					
						<tr>
							<td>성별</td>
							<td>	
										
								<c:if test="${ pet.gender eq 'F'.charAt(0) }">		
									<c:set var="fcheck" value="checked"/>
								</c:if>	
								<c:if test="${ pet.gender eq 'M'.charAt(0) }">		
									<c:set var="mcheck" value="checked"/>
								</c:if>
								<div class="custom-control custom-radio mb-3 vm-AdoptionReviewUpdate_gender">
								  	<input name="gender" class="custom-control-input" id="F" value="F" type="radio" ${ fcheck } disabled>
								  	<label class="custom-control-label" for="F"> 여아</label>
								</div>
								<div class="custom-control custom-radio mb-3 vm-AdoptionReviewUpdate_gender">
								  	<input name="gender" class="custom-control-input" id="M" value="M" type="radio" ${ mcheck } disabled>
								  	<label class="custom-control-label" for="M"> 남아</label>
								</div>
							</td>
							<td>몸무게</td>
							<td>
								<div class="form-group">
									<input type="number" value="${ pet.weight }" name="weight" class="form-control form-control-alternative" id="weight" min="0" step="0.1" readonly> 
								</div>
								<div class="form-group">
									<label>kg</label>
								</div>
							</td>				
						</tr>
						<tr>
							<td>나이</td>
							<td>
								<div class="form-group">
									<input type="number" value="${ pet.age }" name="age" class="form-control form-control-alternative" id="age" min="0" step="0.1" max="20" readonly>
								</div>
								<div class="form-group">
									<label>세</label>
								</div>
							</td>
							<td>중성화 여부</td>
							<td>
								<c:if test="${ pet.neuter eq 'O'.charAt(0) }">
									<c:set var="ocheck" value="checked"/>
								</c:if>
								<c:if test="${ pet.neuter eq 'X'.charAt(0) }">
									<c:set var="xcheck" value="checked"/>
								</c:if>
								<div class="custom-control custom-radio mb-3 vm-AdoptionReviewUpdate_neuter">
									<input name="neuter" class="custom-control-input" id="O" value="O" type="radio" ${ ocheck } disabled>
								  	<label class="custom-control-label" for="O"> O</label>
								</div>
								<div class="custom-control custom-radio mb-3 vm-AdoptionReviewUpdate_neuter">
								  	<input name="neuter" class="custom-control-input" id="X" value="X" type="radio" ${ xcheck } disabled>
								  	<label class="custom-control-label" for="X"> X</label>
								</div>
							</td>						
						</tr>
						<tr>
							<td>입양자</td>
							<td>
								<input type="text" value="${ requestScope.petReview.username }" id="username" class="form-control form-control-alternative" name="username" style="width: 200px;">
							</td>
							<td>입양처</td>
							<td>
								<input type="text" value="${ requestScope.petReview.address }" id="address" class="form-control form-control-alternative" name="address" style="width: 200px;">
							</td>
						</tr>	
						<tr>
							<td>사진</td>
							<td colspan="2">
								<form id="test" runat="server">
									<img src="resources/images/adoption/${ petReview.image }" id="testImage" style="width:100%;">			
									<input type="file" id="testFile" class="btn btn-primary btn" name="imageFile" accept="image/*">
								</form>	
							</td>							
						</tr>	
					</table>
				</div>
			<%-- //table --%>
			
			<%-- bottom --%>
			<div class="vui-board__box vui-board__box--b row">
				<div class="col">	
								
				</div>
				<div class="col" style="text-align: center;">	
					<input id="petReviewUpdate" type="submit" class="btn btn-primary btn" value="수정하기">								
				</div>
				<div class="col text-right">
				
				</div>
			</div>			
			<%-- bottom --%>	
			
			</div>
			
			<br><br><br>
			<input hidden="" name="image" id="image">
		</form>
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<script>
$(function(){	
	var imgFlag = true; //이미지 수정여부를 위한 변수
	
	/* $(".table td:nth-child(2n+1)").css("background-color", "#5e72e4")
			.css("color", "#fff").css("width", "100px");
	$(".table td:nth-child(2n)").css("width", "200px"); */

	$("#testFile").on("change", function(){
		readURL(this);
		imgFlag = false; //이미지 수정여부를 위한 변수
	})
	
	//파일 미리보기
	function readURL(data){
		if(data.files && data.files[0]){
			var reader = new FileReader();
			reader.onload = function(e){
				$("#testImage").attr("src", e.target.result);					
			}
			reader.readAsDataURL(data.files[0]);
		}
	}
		
	$(document).on("click", "#petReviewUpdate", function(){
		check();
	});
	
	//빈칸 체크
	function check(){
		var username = $("#username").val();
		var file = $("#testFile").val();
		
		if(imgFlag === true){
			var imgName = '${ petReview.image }';
			$("#image").val(imgName);
			file = imgName;
		}
		
		if(username == "" || file == ""){
			alert("빈칸을 모두 채워주세요 !");
			
			return false;
		}
		
		$("#petReviewForm").submit();
	} //check()		

});
</script>
<%-- -------- //JavaScript -------- --%>