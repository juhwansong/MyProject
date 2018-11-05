<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF/views/common/top.jsp" />

<link rel="stylesheet" href="/resources/each/css/noticeList.css?${verQuery}" />

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-noticeList">
		<div class="vm-section">
			<div class="vui-headline">
				공지사항
			</div>

			<hr>
			
			<div class="vui-board">
				<%-- top --%>
				<div class="vui-board__box vui-board__box--t row">
					<form class="vm-noticeList__search-form form-inline ml-3 mr-3" action="" method="post" name="notice_selectbox">
						<%--이거개빡침 - 고쳐드렸습니다 :) --%>
						<div class="form-group">
							<select class="vm-noticeList__select-list form-control" id="select-list">
								<option value="10" selected>목록 개수</option>
								<option value="10">10 개</option>
								<option value="15">15 개</option>
								<option value="20">20 개</option>
							</select>
						</div>

						<div class="form-group vm-noticeList__search-input-box">
							<div class="btn-group">
								<select class="form-control" id="select-category">
									<option value="category" selected>Category</option>
									<option value="title">제목</option>
									<option value="content">내용</option>
									<option value="no">글번호</option>
								</select>
							</div>
	
	
							<%-- search field section --%>
							<div class="input-group">
								<input class="form-control" placeholder="Search" type="text" id="search-keyword">
							</div>
	
							<button type="button" class="btn btn-outline-primary" id="searchBtn" onclick='listFx(null);'>검색</button>
						</div>
					</form>
				</div>
				<%-- //top --%>
				<%-- table --%>
				<div class="vui-table vm-noticeList__table">
					<table class="table table-hover text-center">
					
						<thead>
							<tr>
								<th scope="col" width="10%">No</th>
								<th scope="col" width="*">제목</th>
								<th scope="col" width="15%">작성자</th>
								<th scope="col" width="15%">작성일</th>
								<th scope="col" width="13%">조회수</th>
							</tr>
						</thead>
						
						<tbody id="ajax-table">
							<c:forEach items="${list}" var="notice">
								<c:url var="NoticeDetail" value="NoticeDetail">
									<c:param name="no" value="${notice.no}"></c:param>
								</c:url>
							<tr onclick="location.href='${NoticeDetail}'">
								<td>${notice.no }</td>
								<td class="text-left">${notice.title }
									<c:if test="${!empty notice.original_file_name}">&nbsp;<i class="fa fa-file"></i></c:if>
								</td>
								<td>${notice.nickname }</td>
								<td>${notice.write_date }</td>
								<td>${notice.read_count }</td>
							</tr>
							
							</c:forEach>
						</tbody>
						
						
					</table>
				</div>
				<%-- //table --%>
				
				<%-- bottom --%>
				<div class="vui-board__box vui-board__box--b row mt-3">
					<div class="col"><%-- 칸맞추기용 --%></div>
					<div class="col">
						<nav class="vui-navigation" aria-label="Page navigation example">
							<ul class="pagination justify-content-center" id="my-pagination">
								<li class="page-item">
									<c:choose>
										<c:when test="${currentPage <= 1}">
											<a class="page-link disabled" href="javascript:void(0)"><i class="fa fa-angle-left"></i></a>
										</c:when>
										<c:otherwise>
											<a class="page-link" href="javascript:void(0)" onclick='listFx(1)'>
											<i class="fa fa-angle-left"></i></a>
										</c:otherwise>
									</c:choose>
								</li>
								
								<c:forEach var="p" begin="${startPage}" end="${endPage}">
									<c:choose>
										<c:when test="${currentPage eq p }">
											<li class="page-item active"><a class="page-link" href="javascript:void(0)">${p}</a></li>
										</c:when>
										<c:otherwise>
											<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick='listFx("${p}")'>${p}</a></li>
										</c:otherwise>
									</c:choose>	
								</c:forEach>
								<li class="page-item">
									<c:choose>
										<c:when test="${currentPage >= maxPage}">
										<a class="page-link disabled" href="javascript:void(0)">
											<i class="fa fa-angle-right"></i></a>
										</c:when>
										<c:otherwise>
											<a class="page-link" href="javascript:void(0)" onclick='listFx("${endPage + 1}")'>
											<i class="fa fa-angle-right"></i></a>
										</c:otherwise>
									</c:choose>
								</li>								
							</ul>
						</nav>
					</div>

					<div class="col text-right">
						<c:if test="${loginMemberDto.type eq 'ADMIN'}">
							<button class="btn btn-secondary" type="button" onclick="location.href='NoticeWrite'">글쓰기</button>
						</c:if>
					</div>
				</div>
				<%-- //bottom --%>
			</div>
		</div>
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/noticeList.js?${verQuery}"></script> --%>
<script>
	(function ($) {
		// do not remove this string
		"use strict";
		
		
		if('${countList}' === '10' || '${countList}' === '15' || '${countList}' === '20'){ //다른 숫자 강제 입력할 경우 배제
			$("#select-list").val('${countList}');
		}
		
		if('${category}' === 'title' || '${category}' === 'content' || '${category}' === 'no'){
			$("#select-category").val('${category}');
		}
		
		if('${keyword}'){
			$("#search-keyword").val('${keyword}');
		}
		
		
		
		//목록개수 변화 시 ajax 실행
		$("#select-list").on('change', function(){
			listFx(1); //변화 시 무조건 1page
		});
		
		//엔터키 누르면 자동 검색
		$("#search-keyword").keypress(function(event){
		     if (event.which == 13){
		         $("#searchBtn").click();
		         return false;
		     }
		});
		
		// javascript code here
	}(jQuery));


	
	function listFx(page){		
		selectList = $("#select-list").val();
		selectCategory = $("#select-category").val();
		searchKeyword = $("#search-keyword").val().trim();
		page = (!page) ? '${currentPage}' : page;
		
		$.ajax({
			url : 'NoticeList',
			data : {cl : selectList, c : selectCategory, k : searchKeyword, page : page},
			type : 'GET',
			success : function(){
				location.href='NoticeList?cl=' + selectList + '&c=' + selectCategory + '&k=' + searchKeyword + '&page=' + page; 
				
			}
		})//ajax close 
	}

</script>
<%-- -------- //JavaScript -------- --%>