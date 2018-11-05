<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:import url="/WEB-INF/views/common/top.jsp" />

<link rel="stylesheet" href="/resources/each/css/qnaWrite.css?${verQuery}" />

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-qnaWrite">
		<div class="vm-section">
			<div class="vui-headline">
				1:1 문의
			</div>
			<hr class="mt-0">
			<div class="vui-board">
				<form name="for-ajax">
					<input type="hidden" name="id" value="${loginMemberDto.id}">
					<table class="table vm-qnaWrite__table text-left mb-0">
					
						<tbody>
							<tr>
								<th class="align-middle" width=10%>문의 종류</th>
								<td>&nbsp;
								
									<div class="custom-radio ml-4">
									  <input name="category" class="custom-control-input" id="customRadio1" type="radio" value="입양">
									  <label class="custom-control-label" for="customRadio1">입양</label>
									</div>
									<div class="custom-radio">
									  <input name="category" class="custom-control-input" id="customRadio2" type="radio" value="자원봉사">
									  <label class="custom-control-label" for="customRadio2">자원봉사</label>
									</div>
									<div class="custom-radio">
									  <input name="category" class="custom-control-input" id="customRadio3" type="radio" value="쇼핑몰">
									  <label class="custom-control-label" for="customRadio3">쇼핑몰</label>
									</div>
									<div class="custom-radio">
									  <input name="category" class="custom-control-input" id="customRadio4" type="radio" value="건의">
									  <label class="custom-control-label" for="customRadio4">건의</label>
									</div>
									<div class="custom-radio">
									  <input name="category" class="custom-control-input" id="customRadio5" type="radio" value="신고">
									  <label class="custom-control-label" for="customRadio5">신고</label>
									</div>
									<div class="custom-radio">
									  <input name="category" class="custom-control-input" id="customRadio6" type="radio" value="기타" checked>
									  <label class="custom-control-label" for="customRadio6">기타</label>
									</div>							
								
								</td>
							</tr>
							
							<tr>
								<th class="align-middle">회원 ID</th>
								
								<c:choose>
									<c:when test="$fn{contains(loginMemberDto.id, '@')}">
										<td>&nbsp;&nbsp;<b>${loginMemberDto.id}</b></td>
									</c:when>
									<c:otherwise>
										<td>&nbsp;&nbsp;<b>(Google Account)&nbsp;${loginMemberDto.email}</b></td>
									</c:otherwise>
								</c:choose>
								
								<%-- <td>&nbsp;&nbsp;<b>${loginMemberDto.id}</b></td> --%>
							</tr>
							
							<tr>
								<th class="align-middle">닉네임</th>
								<td>&nbsp;&nbsp;<b>${loginMemberDto.nickname}</b></td>
							</tr>
							
							<tr>
								<th class="align-middle">제목</th>
								<td><input type="text" class="form-control" id="title" name="title" placeholder="title"></td>
							</tr>
							
							<tr>
								<th class="align-middle">내용</th>
								<td>
									<textarea rows="12" class="form-control" id="content" name="content"></textarea>
									&nbsp;&nbsp;<b>문의 시 유의해주세요!</b><br>
									&nbsp;&nbsp;-회원간 직거래로 발생하는 피해에 대해 랜선집사는 책임지지 않습니다.<br>
									&nbsp;&nbsp;-주민등록번호, 연락처 등의 정보는 타인에게 노출될 경우 개인정보 도용의 위험이 있으니 주의해 주시기 바랍니다.<br>
									&nbsp;&nbsp;-비방, 광고, 불건전한 내용의 글은 관리자에 의해 사전 동의 없이 삭제 될 수 있습니다.<br>
									&nbsp;&nbsp;-문의게시판 본래의 사용 목적(문의/건의/신고 등)과 무관한 게시글의 경우 관리자에 의해 노출 차단될 수 있습니다.<br>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				<%-- //table --%>
				<hr class="mt-0 mb-1">
				<%-- bottom buttons --%>
				<div class="vui-board__box vui-board__box--b row mt-3 mb-3">
					<div class="col text-center">
						<button class="btn btn-primary" type="button" onclick="submit(); return false;">등록</button>
						<button class="btn btn-primary" type="button" onclick="location.href='QnaList'">취소</button>
					</div>
				</div>
				<%-- //bottom buttons --%>
			
			
			
			</div>
		</div>
		
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/qnaWrite.js?${verQuery}"></script> --%>
<script>
	(function ($) {
		// do not remove this string
		"use strict";

		// javascript code here
		
		
		
	}(jQuery));
	
	function submit(){
		if(confirm("등록 하시겠습니까?")){
			var titleLength = $('#title').val().length;
			var contentLength = $('#content').val().length
			if(titleLength > 30 || titleLength < 1){
				alert("제목은 최소 한 글자 이상 최대 30 글자 이하여야합니다.\n(현재 " + titleLength + " 자)");
				return;
			}else if(contentLength > 100 || contentLength < 1){ /*띄어쓰기 포함*/
				alert("내용은 최소 한 글자 이상 최대 100 글자 이하여야합니다.\n(현재 " + contentLength + " 자)");
				return;
			}
			
			$.ajax({
				url : 'qnaWrite',
                data :  $("form[name=for-ajax]").serialize(),
				type : 'post',
				success : function(){
					location.href='QnaList'
				}
			});//ajax close
		}
	}
	
	
</script>
<%-- -------- //JavaScript -------- --%>