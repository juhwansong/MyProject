<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>	
  	.vm-adminApplyList_btn {
		color: #fff;		
		background-color: #5e72e4;
		border-radius: 5px;
	}
	.vm-adminApplyList .vui-board { padding: 10px; }
	.vm-adminApplyList .vui-board .table td, .vui-board .table tr {
	 	padding: 10px; 
	 	text-align: center;
}
	.vm-adminApplyList .vui-board__box { align-items: center; }
	.vm-adminApplyList .vui-board__box--b { margin-top: 40px; }	
	.vm-adminApplyList .vui-board__box > .col > * { margin: 0; }
	.vm-adminApplyList .vui-table { overflow: hidden; border-radius: 5px; }
	.vm-adminApplyList .vui-table td:nth-child(2n+1) {
		background-color: #5e72e4;
		color: #fff;
		width: 10%;
		text-align: center;
		vertical-align: middle;
	}	
	.vm-adminApplyList .vui-table td:nth-child(2n) { 
		width: 30%;	
		padding-left: 10px;
		padding-top: 10px;
		padding-bottom: 10px;
		position: relative;			
	}
 	.vm-adminApplyList, 	
	.vm-adminApplyList .form-group {
		float: left;
		padding: 5px;
	}
	.vm-adminApplyList .form-group label { margin-top: 15px; }
	.vm-section { overflow: hidden;	}
</style>

<c:import url="/WEB-INF/views/common/top.jsp" />

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-section">
	
	<div class="vm-content vm-adminApplyList">
		<div class="vui-headline">입양 후기 작성</div>
			<hr class="mt-0 mb-4">
		<form action="ReviewEnroll" method="post" enctype="multipart/form-data" onsubmit="return check();">
		<%-- //table --%>
		<div class="vui-table">
		<input type="hidden" name="pet_id" value="${ review. pet_id }">
		<input type="hidden" name="no" value="${ apply.no }">
		<input type="hidden" name="id" value="${ apply.id }">
			<table class="table">
				<tr>
					<td>이름</td>
					<td><input type="text" id="name" value="${ requestScope.review.name }"
						class="form-control form-control-alternative" name="name"
						style="width: 200px;" readonly></td>
					<td>견종/묘종</td>
					<td>
						<c:if test="${ requestScope.review.breed eq 'cat' }">		
							<c:set var="breed" value="고양이"/>
						</c:if>	
						<c:if test="${ requestScope.review.breed eq 'dog' }">		
							<c:set var="breed" value="강아지"/>
						</c:if>
						<input name="breed" class="form-control form-control-alternative" id="breed"
								type="text" value="${ breed }" style="width: 200px;" readonly>
					</td>
				</tr>
				<tr>
					<td>성별</td>
					<td>
						<c:if test="${ requestScope.review.gender eq 'F'.charAt(0) }">		
							<c:set var="gender" value="암컷"/>
						</c:if>	
						<c:if test="${ requestScope.review.gender eq 'M'.charAt(0) }">		
							<c:set var="gender" value="수컷"/>
						</c:if>
						<input name="gender" class="form-control form-control-alternative" id="gender"
								type="text" value="${ gender }" style="width: 200px;" readonly>
					</td>
					<td>몸무게</td>
					<td>
						<div class="form-group">
							<input name="weight" class="form-control form-control-alternative" id="weight"
								type="text" value="${ requestScope.review.weight }" readonly>
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
							<input name="age" class="form-control form-control-alternative" id="age"
								type="text" value="${ requestScope.review.age }" readonly>
						</div>
						<div class="form-group">
							<label>세</label>
						</div>
					</td>
					<td>중성화 여부</td>
					<td>
						<c:if test="${ requestScope.review.neuter eq 'O'.charAt(0) }">		
							<c:set var="n" value="O"/>
						</c:if>	
						<c:if test="${ requestScope.review.neuter eq 'X'.charAt(0) }">		
							<c:set var="n" value="X"/>
						</c:if>
						<div class="form-group">
							<input name="neuter" class="form-control form-control-alternative" id="neuter"
								type="text" value="${ n }" readonly>
						</div>
					</td>
				</tr>
				<tr>
					<td>입양자</td>
					<td>
						<div class="form-group">
							<input name="username" class="form-control form-control-alternative" id="a-name" type="text" value="${ apply.username }">
						</div>
					</td>
					<td>입양처</td>
					<td>
						<div class="form-group_">
							<input name="address" class="form-control form-control-alternative" id="a-address" type="text">
						</div>
					</td>
				</tr>
				<tr>
					<td>사진</td>
					<td colspan="2">
						<form id="test" runat="server">
							<img src="/resources/images/adoption/info/file.png" id="testImage" style="width: 100%;">
							<input type="file" id="testFile" class="btn btn-primary btn"
								name="imageFile" accept="image/*">
						</form>
						

					</td>
				</tr>
			</table>
		</div>
		<%-- //table --%>
		</form>
		
		<%-- bottom --%>
		<div class="vui-board__box vui-board__box--b row">
			<div class="col"></div>

			<div class="col" style="text-align: center;">
				<input type="submit" class="btn btn-primary btn" value="등록">
				<button type="reset" class="btn btn-primary btn">취소</button>
			</div>
			<div class="col text-right"></div>
		</div>
		<%-- bottom --%>

	</div>
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<script>
	
	//빈칸 체크
	function check(){
		var name = $('#a-name').val();
		var address = $("#a-address").val();
		var file = $("#testFile").val();
		var content = $("#exampleFormControlTextarea1").val();
		
		if(name == "" || file == ""){
			
			alert("빈칸을 확인해주세요!");
			return false;
		}
	} // check()
	
	
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
	})
</script>
<%-- -------- //JavaScript -------- --%>