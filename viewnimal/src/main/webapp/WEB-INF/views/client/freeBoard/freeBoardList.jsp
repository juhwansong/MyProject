<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF/views/common/top.jsp" />

<link rel="stylesheet" href="/resources/each/css/freeBoardList.css?${verQuery}" />

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-freeBoardList">

		<div class="vm-section">

			<div class="vui-headline">자유게시판</div>

			<hr>
  
			<div class="vui-board">
				<%-- top --%>
				<%-- <div class="vui-board__box vui-board__box--t row"> --%>
					<!-- <div class="col">
						<button type="button" class="btn btn-default">Default</button>
					</div> -->

					<%-- <div class="col text-right"> --%>
						<!-- <div class="btn-group">
							<button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Secondary</button>
							<div class="dropdown-menu">
								<a class="dropdown-item" href="#">Action</a>
								<a class="dropdown-item" href="#">Another action</a>
								<a class="dropdown-item" href="#">Something else here</a>
								<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="#">Separated link</a>
							</div>
						</div>

						<div class="input-group">
							<div class="input-group-prepend">
								<span class="input-group-text"><i class="ni ni-zoom-split-in"></i></span>
							</div>
							<input class="form-control" placeholder="Search" type="text">
						</div>

						<button type="button" class="btn btn-outline-primary">검색</button> -->
					<%-- </div> --%>
				<%-- </div> --%>
				<%-- //top --%>

				<%-- table --%>
				<div class="vui-table">
					<table class="table table-hover text-center vm-freeBoardList__table-color">
						<thead>
							<tr >
								<th scope="col" width="5%">No</th>
								<th scope="col" width="10%">말머리</th>
								<th scope="col" width="*">제목</th>
								<th scope="col" width="15%">작성자</th>
								<th scope="col" width="15%">작성일</th>
								<th scope="col" width="10%">조회</th>
								
							</tr>
						</thead>
						
						<tbody>
							<c:forEach items="${requestScope.list }" var="freeBoard">
							<c:url var="FreeBoardDetail" value="FreeBoardDetail">
								<c:param name="no" value="${freeBoard.no }"/>
							</c:url>
									
							<tr onclick="location.href='${FreeBoardDetail}'">
								<td>${freeBoard.no }</td>
								<td>${freeBoard.category }</td>
								<td class="text-left">
									
									
										<c:if test="${0 eq freeBoard.board_level }">
											${freeBoard.title }
										</c:if>
										<c:if test="${0 ne freeBoard.board_level }">
											<c:if test="${freeBoard.board_level >= 4 }">
												<c:forEach begin="0" end="4" step="1">
												&nbsp;
												</c:forEach>
												└&nbsp;${freeBoard.title }
											</c:if>
											<c:if test="${freeBoard.board_level < 4 }">
												<c:forEach begin="0" end="${freeBoard.board_level }" step="1">
													&nbsp;
												</c:forEach>
												└&nbsp;${freeBoard.title }
											</c:if>
										</c:if>
									
								</td>
								<td>${freeBoard.nickname }</td>
								<td>${freeBoard.write_date }</td>
								<td>${freeBoard.read_count }</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<%-- //table --%>

				<form action="/FreeBoardWrite" method=POST>
				<%-- bottom --%>
				<div class="vui-board__box vui-board__box--b row">
					<div class="col"></div>
					<div class="col">
						<nav class="vui-navigation" aria-label="Page navigation example">
							<ul class="pagination justify-content-center">
								
								<c:if test="${(startPage - printPage) >= 1 }">
									<li class="page-item">
										<a class="page-link" href="/FreeBoardList?currentPage=${startPage - 1 }" tabindex="-1">
											<i class="fa fa-angle-left"></i><span class="sr-only">Previous</span>
										</a>
									</li>
								</c:if>
								<c:forEach begin="${startPage }" end="${endPage }" var="page">
									<c:if test="${currentPage eq page }">
										<li class="vm-freeBoardList__page-color page-item"><a class="page-link" href="/FreeBoardList?currentPage=${page }">${page }</a></li>
									</c:if>
									<c:if test="${currentPage ne page }">
										<li class="page-item"><a class="page-link" href="/FreeBoardList?currentPage=${page }">${page }</a></li>
									</c:if>
								</c:forEach>
								<c:if test="${( startPage + printPage ) <= totalPage }">
									<li class="page-item">
										<a class="page-link" href="/FreeBoardList?currentPage=${startPage + printPage }">
											<i class="fa fa-angle-right"></i><span class="sr-only">Next</span>
										</a>
									</li>
								</c:if>
								
							</ul>
						</nav>
					</div>
 
					<input type="hidden" name="type" value="first">
					<div class="col text-right">
						<c:if test="${ !empty loginMemberDto}">
							<button type="submit" class="btn btn-secondary" id="writeBtn">글쓰기</button> 
						</c:if>
					</div> 
				</div>
				<%-- //bottom --%>
				</form>
				
			</div>

		</div>
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/freeBoardList.js?${verQuery}"></script> --%>
<script>
	(function ($) {
		// do not remove this string
		"use strict";
	

		// javascript code here
	}(jQuery));
</script>
<%-- -------- //JavaScript -------- --%>