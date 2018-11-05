<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF/views/common/adminTop.jsp" />

<link rel="stylesheet" href="/resources/each/css/adminDonationList.css?${verQuery}" />

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-adminDonationList">
		관리자 입양 후기 작성 페이지
		<br>
		<form action="ReviewEnroll" method="post" enctype="multipart/form-data">
			
			<div class="vm-content vm-AdoptionReviewEnroll">
				입양 동물 등록 페이지
				<br>
				
				<%-- //table --%>
				<div class="vui-table">
					<table>						
						<tr>
							<td>이름</td>
							<td>
								<input type="text" id="name" class="form-control form-control-alternative" name="name" style="width: 200px;">
							</td>
							<td>견종/묘종</td>
							<td>
								<div class="custom-control custom-radio mb-3 vm-AdoptionReviewEnroll_dc">
									<input name="breed" class="custom-control-input" id="dog" value="dog" type="radio">
								  	<label class="custom-control-label" for="dog"> Dog</label>
								</div>												
								<div class="custom-control custom-radio mb-3 vm-AdoptionReviewEnroll_dc">
								  	<input name="breed" class="custom-control-input" id="cat" value="cat" type="radio">
								  	<label class="custom-control-label" for="cat"> Cat</label>
								</div>						
								<input type="text" id="breedDetail" class="form-control form-control-alternative" name="breedDetail" style="width: 150px;">
							</td>															
						</tr>					
						<tr>
							<td>성별</td>
							<td>						
								<div class="custom-control custom-radio mb-3 vm-AdoptionReviewEnroll_gender">
								  	<input name="gender" class="custom-control-input" id="F" value="F" type="radio">
								  	<label class="custom-control-label" for="F"> 암컷</label>
								</div>
								<div class="custom-control custom-radio mb-3 vm-AdoptionReviewEnroll_gender">
								  	<input name="gender" class="custom-control-input" id="M" value="M" type="radio">
								  	<label class="custom-control-label" for="M"> 수컷</label>
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
							<td>중성화</td>
							<td>
								<div class="custom-control custom-radio mb-3 vm-AdoptionReviewEnroll_neuter">
									<input name="neuter" class="custom-control-input" id="O" value="O" type="radio">
								  	<label class="custom-control-label" for="O"> O</label>
								</div>
								<div class="custom-control custom-radio mb-3 vm-AdoptionReviewEnroll_neuter">
								  	<input name="neuter" class="custom-control-input" id="X" value="X" type="radio">
								  	<label class="custom-control-label" for="X"> X</label>
								</div>
							</td>						
						</tr>
						<tr>
							<td>사진</td>
							<td colspan="2">
								<form id="test" runat="server">
									<img src="#" id="testImage" style="width:300; height:300;">			
									<input type="file" id="testFile" class="btn btn-primary btn" name="imageFile" accept="image/*">
								</form>	
								
							</td>							
						</tr>	
						<tr>
							<textarea>
							<center>
								안녕하세요. Viewnimal 입니다.
								보호중이던 믹스견 인절미를 책임분양으로
								가족으로 맞이해주셨어요 !
							</center>
							</textarea>
						</tr>							
					</table>
				</div>
				<%-- //table --%>
				
				<%-- bottom --%>
				<div class="vui-board__box vui-board__box--b row">
					<div class="col">	
									
					</div>
	
					<div class="col" style="text-align: center;">	
						<input type="submit" class="btn btn-primary btn" value="등록하기">
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

<c:import url="/WEB-INF/views/common/adminBottom.jsp" />

<%-- -------- JavaScript -------- --%>
<script>
	(function ($) {
		// do not remove this string
		"use strict";

		// javascript code here
	}(jQuery));
</script>
<%-- -------- //JavaScript -------- --%>