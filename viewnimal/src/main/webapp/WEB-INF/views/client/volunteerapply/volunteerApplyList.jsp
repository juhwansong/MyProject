<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Calendar"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF/views/common/top.jsp" />

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.2/css/bootstrap-select.min.css?${verQuery}">
<link rel="stylesheet" href="/resources/vendor/calendar/monthly.css?${verQuery}">
<!--bootstrap select : bootstrap4.0 support  -->

<!-- <link rel="stylesheet" href="/resources/each/css/volunteerApplyList.css?${verQuery}" /> -->

 <style type="text/css">
	/* .vm-volunteerApplyList .monthly{
		width: 100%;
		margin: 2em auto 0 auto;
		max-width: 80em;
		border: 1px solid #666;
	}   */
	.vm-volunteerApplyList .monthly {
		/*box-shadow: 0 13px 40px rgba(0, 0, 0, 0.5);*/
		/*font-size: 0.8em;*/
		border: 1px solid #ccc;
		border-radius: 10px;
		overflow: hidden;
	} 
	.vm-volunteerApplyList .monthly-day:hover {
		background-color: #f5f6f8;
	}
	/*셀렉트 박스의 옵션 중 선택되있는 옵션 색깔*/
	/* .vm-volunteerApplyList .dropdown-item.selected.active{
		background: #11cdef;	
	}   */
	/*셀렉트 박스의 옵션 중 포커스중인 옵션 색깔*/
	/* .vm-volunteerApplyList .dropdown-item:FOCUS{ 
		background: #11cdef;
	} */
	.vm-volunteerApplyList .monthly-event-blank-box { height: auto; }
	/* .vm-volunteerApplyList > .vm-section > hr{	
		margin-top: 0px;
	} */
</style> 
			


<%-- -------- JSP -------- --%>
<% 
	request.setAttribute("currentYear", Calendar.getInstance().get(Calendar.YEAR)); 
%>

<div class="vm-container">
	<div class="vm-content vm-volunteerApplyList">		
		<div class="vm-section">
			<div class="vui-headline">자원봉사</div>
			<hr>
			<%-- top --%>
			<div class="vui-board__box vui-board__box--t row">
				<div class="col text-right">			
					<div class="btn-group">
						<c:set var="beginYear" value="2017"/>
						<select id="selectpicker-year" name="selectpicker-year" class="selectpicker" data-style="btn-primary" data-width="120px">
							<c:forEach var="yearI" begin="${beginYear}" end="${requestScope.currentYear}">
								<c:choose>
									<c:when test="${yearI == requestScope.currentYear}">
										<option value="${yearI}" selected>${yearI}년</option>
									</c:when>
									<c:otherwise>
										<option value="${yearI}">${yearI}년</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>				
					</div>

					<div class="btn-group">
						<select id="selectpicker-month" name="selectpicker-month" class="selectpicker" data-style="btn-primary" data-width="100px">
						</select>
					</div>

					<button id="apply-list-search-date" type="button" class="btn btn-outline-primary">검색 <i class="fa fa-search" aria-hidden="true"></i></button>
				</div>
			</div>
			<%-- //top --%>
			<!-- 본문 시작 -->
			<div class="monthly  form-control-alternative" id="volunteerApplyList-calendar"></div> 
			<!-- 본문 끝 -->	
			
			<%-- bottom --%>
			<div class="vui-board__box vui-board__box--b row">
				<div class="col text-right">
					<c:if test="${sessionScope.loginMemberDto.type == 'ADMIN'}">
						<button type="button" class="btn btn-secondary" id="volunteer-apply-write-btn">모집글 등록</button>
					</c:if>
				</div>
			</div>
			<%-- //bottom --%>
			
		</div>	
	</div>
</div>

			
		

<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.2/js/bootstrap-select.min.js?${verQuery}"></script>
<script src="/resources/vendor/calendar/monthly.js?${verQuery}"></script>
<!--bootstrap select : bootstrap4.0 support  -->

<%-- <script src="/resources/each/js/volunteerApplyList.js?${verQuery}"></script> --%>
<script>
	(function ($) {
		// do not remove this string
		// javascript code here
		"use strict"; 
		
		
			 
		
	
		//처음 페이지 로딩 시 달력 설정하기(초기값)
		$('#volunteerApplyList-calendar').monthly({
			mode: 'event', 
			dataType: 'json',
			pageType: 'select'
		});
		
		//글쓰기 버튼 클릭 시
		$(document).on("click", "#volunteer-apply-write-btn", function(){
			location.href="/VolunteerApplyWrite";
		});	
		
		
			
	}(jQuery));
</script>
<%-- -------- //JavaScript -------- --%>