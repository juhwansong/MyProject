<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF/views/common/top.jsp" />



<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-streamingUpdate">
		
	  <div class="vm-section">
		<div id="vui-table">
			<form name="to-ajax">
				<table class="table">
					
					<tr>
						<th><label>제목</label></th>
						<td>
							<div class="row">
								<div class="col-md-12">								
									<input type="text" class="form-control form-control-alternative" id="title" name="title" value="${Streaming.title }">							
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<th><label>주소</label></th>
						<td>
							<div class="row">
								<div class="col-md-12">								
									<input type="text" class="form-control form-control-alternative" id="thumbnail" name="thumbnail" value="${Streaming.thumbnail }">					
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<th><label>내용</label></th>
						<td>
							<div class="row">
								<div class="col-md-12">								
									<textarea rows="18" class="form-control form-control-alternative" id="content" name="content">${Streaming.content}</textarea>				
								</div>	
							</div>						
						</td>			
					</tr>
					<tr>
						<th><label>넘버</label></th>
						<td>
							<div class="row">
								<div class="col-md-12">								
									<input type="hidden" class="form-control form-control-alternative" id="no" name="no" value="${Streaming.no }">					
								</div>
							</div>
						</td>
					</tr>
				</table>
			</form>
			</div>
			<hr>
			<div class="col text-right">
				<button type="button" class="btn btn-primary" style="outline: none;" onclick="submit(); return false;">수정 등록</button>
				<input type="button" class="btn btn-primary" onclick="window.history.back();" value="취소" style="outline: none;">
			</div>
			
		</div>
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<script>
	(function ($) {
		// do not remove this string
		"use strict";
		
		if("${sessionScope.loginMemberDto.type}" !== "ADMIN"){
			alert("수정 권한이 없습니다.");
			location.href="/Streaming";
		}
		
		// javascript code here
	}(jQuery));
	
	
	function submit(){
		if(confirm("수정하시겠습니까?")){
			
			
			$.ajax({
				url: 'updateStreaming',
				data : $("form[name=to-ajax]").serialize(),
				type : 'post',
				success : function(data){
					if(data.resultMessage === "success"){
						alert("수정이 성공하였습니다.");
						location.href="/StreamingDetail?no=${Streaming.no}";
					}else{
						alert("수정이 실패하였습니다.");
					}
				}
			});
		}
		
	}
	
	
	
</script>
<%-- -------- //JavaScript -------- --%>