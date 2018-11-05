<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>	
	.vm-adoptionPetEnroll_btn {
		color: #fff;		
		background-color: #5e72e4;
		border-radius: 5px;
	}
	.vui-board { padding: 10px; }
	.vui-board .table td, .vui-board .table tr {
	 	padding: 10px; 
	 	text-align: center;
	}	
	.vui-board__box { align-items: center; }
	.vui-board__box--b { margin-top: 40px; }	
	.vui-board__box > .col > * { margin: 0; }
	.vui-table { overflow: hidden; border-radius: 5px; }
	.vui-table td:nth-child(2n+1) {
		background-color: #5e72e4;
		color: #fff;
		width: 10%;
		text-align: center;
		vertical-align: middle;
	}	
	.vui-table td:nth-child(2n) { 
		width: 30%;	
		padding-left: 10px;
		padding-top: 10px;
		padding-bottom: 10px;
		position: relative;			
	}
	.vm-AdoptionPetEnroll_dc, 
	.vm-AdoptionPetEnroll_gender, 
	.vm-AdoptionPetEnroll_neuter,
	.form-group {
		float: left;
		padding: 5px;	
		width: 30%;
	}
	.form-group label { margin-top: 15px; }
</style>
<c:import url="/WEB-INF/views/common/top.jsp" />

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-section">
	
	<form action="PetEnroll" method="post" enctype="multipart/form-data" onsubmit="return check();">
		
		<div class="vm-content vm-AdoptionPetEnroll">
			<div class="vui-headline">입양 동물 등록</div><%--추가 --%>
			<hr class="mt-0 mb-4">	
			
			<%-- //table --%>
			<div class="vui-table">
				<table class="table">						
					<tr>
						<td>이름</td>
						<td>
							<input type="text" id="name" class="form-control form-control-alternative" name="name" style="width: 200px;">
						</td>
						<td>견종/묘종</td>
						<td>
							<div class="custom-control custom-radio mb-3 vm-AdoptionPetEnroll_dc">
								<input name="breed" class="custom-control-input" id="dog" value="dog" type="radio">
							  	<label class="custom-control-label" for="dog"> Dog</label>
							</div>												
							<div class="custom-control custom-radio mb-3 vm-AdoptionPetEnroll_dc">
							  	<input name="breed" class="custom-control-input" id="cat" value="cat" type="radio">
							  	<label class="custom-control-label" for="cat"> Cat</label>
							</div>						
							<input type="text" id="bdetail" class="form-control form-control-alternative" name="bdetail" style="width: 150px;">
						</td>															
					</tr>					
					<tr>
						<td>성별</td>
						<td>						
							<div class="custom-control custom-radio mb-3 vm-AdoptionPetEnroll_gender">
							  	<input name="gender" class="custom-control-input" id="F" value="F" type="radio">
							  	<label class="custom-control-label" for="F"> 여아</label>
							</div>
							<div class="custom-control custom-radio mb-3 vm-AdoptionPetEnroll_gender">
							  	<input name="gender" class="custom-control-input" id="M" value="M" type="radio">
							  	<label class="custom-control-label" for="M"> 남아</label>
							</div>
						</td>
						<td>몸무게</td>
						<td>
							<div class="form-group">
								<input type="number" name="weight" class="form-control form-control-alternative" id="weight" min="0" step="0.1">
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
								<input type="number" name="age" class="form-control form-control-alternative" id="age" min="0" step="0.1" max="20">
							</div>
							<div class="form-group">
								<label>세</label>
							</div>
						</td>
						<td>중성화 여부</td>
						<td>
							<div class="custom-control custom-radio mb-3 vm-AdoptionPetEnroll_neuter">
								<input name="neuter" class="custom-control-input" id="O" value="O" type="radio">
							  	<label class="custom-control-label" for="O"> O</label>
							</div>
							<div class="custom-control custom-radio mb-3 vm-AdoptionPetEnroll_neuter">
							  	<input name="neuter" class="custom-control-input" id="X" value="X" type="radio">
							  	<label class="custom-control-label" for="X"> X</label>
							</div>
						</td>						
					</tr>
					<tr>
						<td>사진</td>
						<td colspan="2">
							<form id="test" runat="server">
								<img src="/resources/images/adoption/info/file.png" id="testImage" style="width:100%;">			
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
					<input type="submit" class="btn btn-primary btn" value="등록">
					<button type="reset" class="btn btn-primary btn">취소</button>			
				</div>
				<div class="col text-right">
				
				</div>
			</div>			
			<%-- bottom --%>			
		</div>
		
	</form>	
		
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<script type="text/javascript">

	//빈칸 체크
	function check(){
		var name = $("#name").val();
		var breed = $("input[name='breed']:checked").val();
		var bdetail = $("#bdetail").val();
		var gender = $("input[name='gender']:checked").val();
		var weight = $("#weight").val();
		var age = $("#age").val();
		var neuter = $("input[name='neuter']:checked").val();
		var file = $("#testFile").val();			
	
		if(name == "" || breed == "" || bdetail == "" || gender == "" || weight == "" ||
				age == "" || neuter == "" || file == ""){
			
			alert("빈칸을 모두 채워주세요 !");
			return false;
		}
	} //check() 
	
	$(function(){		
		$("#testFile").on("change", function(){
			readURL(this);
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
		} //readURL()
		
	}); //document.ready
</script>
<%-- -------- //JavaScript -------- --%>