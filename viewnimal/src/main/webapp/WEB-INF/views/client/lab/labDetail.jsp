<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF/views/common/top.jsp" />



<style>
#line {
    border-bottom: 1px solid #ddd;
    margin-bottom: 10px;
}

.vm-labDetail .cat-title {
    border-bottom: 1px solid #dedede;
    margin: -30px 0 50px 0;
    padding-bottom: 20px;
    text-align: center;
}
.vm-labDetail .cat-title ul {
    margin: 0;
    padding: 0;
    list-style: none;
}
.vm-labDetail .cat-title ul li {
    display: inline;
}
.vm-labDetail .cat-title a {
    color: Boston Blue;
   
    text-transform: uppercase;
}

.vm-labDetail__content p {
    margin-bottom: 25px;
    line-height: 26px;
   
}

.vm-labDetail .tagcloud {
    margin-top: 25px;
}
.vm-labDetail .tagcloud a {
    padding: 6px 8px;
    margin-right: 0;
    margin-bottom: 4px;
    line-height: 100%;
    display: inline-block;
    background-color: #f2f2f2;
    letter-spacing: 1px;
    font-family: "Montserrat", sans-serif;
    font-size: 10px !important;
    text-transform: uppercase;
}
.vm-labDetail .tagcloud a:hover {
    color: #ffffff!important;
    background-color : #172b4d;
    border-color: #172b4d;
}
.vm-labDetail .lab-tag> *, .lab-tag a {
    color: #696969;
    margin: 0 6px;
}

</style>

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-labDetail">
		<div class="vm-section">
			<div class="vui-headline">
				연구소
			</div>
			<!-- <hr class="mt-0"> -->
		<%-- top --%>
				<div class="vui-board__box vui-board__box--t row">
				<c:if test="${sessionScope.loginMemberDto.type == 'ADMIN'}">
					<div class="col">
						<a href="/LabUpdate?no=${Lab.no}"><button type="button" class="btn btn-primary" >수정하기</button></a>
					</div>
					<div class="col text-right">
				<c:if test="${sessionScope.loginMemberDto.type == 'ADMIN'}">
					<button type="button" class="btn btn-secondary" id="deleteLab">삭제하기</button> 
				</c:if>
			</div>
					</c:if>
				</div>
				
				<%-- //top --%>
		
			
			
		
			<div class="cat-title"></div>
			
			<div class="cat-title">
				<ul class="post-categories">
					<li><a style="font-size:30px; font-weight : bolder;">${Lab.title}</a></li>
					
				</ul>			
			</div>
			
				
			<div class="vm-labDetail__content"> ${Lab.content_tag }
			
				
				<br>
			
			<div id="line"></div>
			<br>
			
			
			</div>
			
			
			<br>
			
			<div class="col text-center vm-channelDetail__detail-list-btn-wrapper">
					<a href="Lab"><button type="button" class="btn btn-primary">목록으로</button></a>
				</div>
			
		</div>
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/labDetail.js?${verQuery}"></script> --%>
<script>
	(function ($) {
		"use strict";
	}(jQuery));
	
	$("#deleteLab").on("click", function(){
		if(confirm('삭제 하시겠습니까?')){
			
			$.ajax({
				url : "deleteLab",
				type : "POST",
				data : { no : '${Lab.no}'},
				success : function(data){
					
					if(data.result === "ok"){
						alert("삭제되었습니다.");
						location.href="Lab";
					}else{
						alert("삭제가 되지 않았습니다. \n다시 시도 해주세요.");
					}
				}, error : function(request, status, errorData){
					 alert("error code : " + request.status + "\n" 
							 + "message : " + request.responseText + "\n" 
							   + "error : " + errorData);
				}
			});
			
		}
	});
</script>
<%-- -------- //JavaScript -------- --%>