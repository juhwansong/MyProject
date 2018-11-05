<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 세션에 계정 정보 없으면 메인으로 리다이렉트 --%>
<c:if test="${null == loginMemberDto}">
	<c:redirect url = "/"/>
</c:if>

<c:import url="/WEB-INF/views/common/top.jsp" />

<link rel="stylesheet" href="/resources/each/css/donateList.css?${verQuery}" />

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-donateList">
		
		<div class="vm-section">
			<div class="vui-headline">마이페이지</div>

			<div class="vui-my-submenu">
				<a href="/MyProfile" class="vui-my-submenu__link">
					<span class="vui-my-submenu__text">내 정보 수정</span>
				</a>
				<a class="vui-my-submenu__link on">
					<span class="vui-my-submenu__text">후원내역</span>
				</a>
				<a href="/QnaList" class="vui-my-submenu__link">
					<span class="vui-my-submenu__text">Q&amp;A</span>
				</a>
			</div>

			<div class="vm-donateList__article">
				<div class="vui-board">
					<%-- top --%>
					<div class="vui-board__box vui-board__box--t row">
						<div class="col">
							<a href="/DonateList" class="btn btn-secondary">전체목록</a>
						</div>

						<form id="donateSearchForm" class="col text-right">
							<div class="input-group">
								<select class="custom-select" name="category">
									<option value="account_host"	${ null == param.category || 'account_host' == param.category ? 'selected' : '' }>예금주</option>
									<option value="bank"			${ 'bank' == param.category ? 'selected' : '' }>은행</option>
								</select>
							</div>

							<div class="input-group">
								<input class="form-control" placeholder="Search" type="text" name="keyword" value="${param.keyword}" />
							</div>

							<button type="submit" class="btn btn-outline-primary">검색</button>
						</form>
					</div>
					<%-- //top --%>

					<%-- ============================ Ajax Dom 조작을 위한 템플릿 ============================ --%>
					<%-- Data Row --%>
					<script id="listDataTemplate" type="text/template">
						<tr>
							<td><@= data.rnum @></td>
							<td><@= data.account_no @></td>
							<td><@= data.account_host @></td>
							<td><@= data.bank @></td>
							<td><@= data.donation @> 원</td>
							<td><@= data.donate_date_str @></td>
						</tr>
					</script>
					<%-- No Data Row --%>
					<script id="listNoDataTemplate" type="text/template">
						<tr class="vm-donateList__board__no-data">
							<td colspan="6">
								<span class="vm-donateList__board__no-data__text">조회된 내역이 없습니다.</span>
							</td>
						</tr>
					</script>
					<%-- Previous Pagination --%>
					<script id="paginationPrevTemplate" type="text/template">
						<li class="page-item">
							<a class="page-link" 
								href="<@= undefined !== data.currentPage && 1 !== data.currentPage ? '/DonateList?page=1' + data.searchParams : 'javascript: void(0);' @>">
								<i class="fa fa-angle-left"></i>
								<i class="fa fa-angle-left"></i>
								<span class="sr-only">Previous</span>
							</a>
						</li>

						<li class="page-item">
							<a class="page-link" 
								href="<@= undefined !== data.currentPage && 1 !== data.currentPage ? '/DonateList?page=' + (data.currentPage - 1) + data.searchParams : 'javascript: void(0);' @>">
								<i class="fa fa-angle-left"></i>
								<span class="sr-only">Previous</span>
							</a>
						</li>
					</script>
					<%-- Data Pagination --%>
					<script id="paginationDataTemplate" type="text/template">
						<li class="page-item <@= data.num === data.currentPage ? 'active' : '' @>">
							<a class="page-link" 
								href="<@= data.num !== data.currentPage ? '/DonateList?page=' + data.num + data.searchParams : 'javascript: void(0);' @>"><@= data.num @></a>
						</li>
					</script>
					<%-- No Data Pagination --%>
					<script id="paginationNoDataTemplate" type="text/template">
						<li class="page-item">
							<a class="page-link" href="javascript: void(0);">1</a>
						</li>
					</script>
					<%-- Next Pagination --%>
					<script id="paginationNextTemplate" type="text/template">
						<li class="page-item">
							<a class="page-link" 
								href="<@= undefined !== data.currentPage && data.currentPage !== data.maxPage ? '/DonateList?page=' + (data.currentPage + 1) + data.searchParams : 'javascript: void(0);' @>">
								<i class="fa fa-angle-right"></i>
								<span class="sr-only">Next</span>
							</a>
						</li>

						<li class="page-item">
							<a class="page-link" 
								href="<@= undefined != data.currentPage && data.currentPage !== data.maxPage ? '/DonateList?page=' + data.maxPage + data.searchParams : 'javascript: void(0);' @>">
								<i class="fa fa-angle-right"></i>
								<i class="fa fa-angle-right"></i>
								<span class="sr-only">Next</span>
							</a>
						</li>
					</script>
					<%-- ============================ //Ajax Dom 조작을 위한 템플릿 ============================ --%>

					<%-- table --%>
					<div class="vui-table">
						<table class="table table-hover">
							<thead>
								<tr>
									<th style="width: 60px;" scope="col">No</th>
									<th style="width: 300px;" scope="col">계좌번호</th>
									<th style="width: 180px;" scope="col">예금주</th>
									<th style="width: 180px;" scope="col">은행</th>
									<th style="" scope="col">금액</th>
									<th style="width: 200px;" scope="col">입금날짜</th>
								</tr>
							</thead>
							
							<tbody>
								<c:choose>
									<c:when test="${ totalBoard > 0 }">
										<c:forEach var="item" items="${donateDtoList}" varStatus="status">
											<tr>
												<td>${item.rnum}</td>
												<td>${item.account_no}</td>
												<td>${item.account_host}</td>
												<td>${item.bank}</td>
												<td>${item.donation} 원</td>
												<td>${item.donate_date}</td>
											</tr>
										</c:forEach>
									</c:when>

									<c:otherwise>
										<tr class="vm-donateList__board__no-data">
											<td colspan="6">
												<span class="vm-donateList__board__no-data__text">조회된 내역이 없습니다.</span>
											</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
					<%-- //table --%>

					<%-- bottom --%>
					<div class="vui-board__box vui-board__box--b row">
						<div class="col"></div>

						<div class="col">
							<nav class="vui-navigation" aria-label="Page navigation example">
								<ul class="pagination justify-content-center">

									<c:set var="searchParams"
										value="${ null != param.category && null != param.keyword ? '&category=' += param.category += '&keyword=' += param.keyword : '' }" />

									<li class="page-item">
										<a class="page-link" 
											href="${ null != currentPage && 1 != currentPage ? '/DonateList?page=1' += searchParams : 'javascript: void(0);' }">
											<i class="fa fa-angle-left"></i>
											<i class="fa fa-angle-left"></i>
											<span class="sr-only">Previous</span>
										</a>
									</li>

									<li class="page-item">
										<a class="page-link" 
											href="${ null != currentPage && 1 != currentPage ? '/DonateList?page=' += (currentPage - 1) += searchParams : 'javascript: void(0);' }">
											<i class="fa fa-angle-left"></i>
											<span class="sr-only">Previous</span>
										</a>
									</li>

									<c:choose>
										<c:when test="${ totalBoard > 0 }">
											<c:forEach var="num" begin="${startPage}" end="${endPage}">
												<li class="page-item ${ num == currentPage ? 'active' : '' }">
													<a class="page-link" 
														href="${ num != currentPage ? '/DonateList?page=' += num += searchParams : 'javascript: void(0);' }">${num}</a>
												</li>
											</c:forEach>
										</c:when>

										<c:otherwise>
											<li class="page-item">
												<a class="page-link" href="javascript: void(0);">1</a>
											</li>
										</c:otherwise>
									</c:choose>


									<li class="page-item">
										<a class="page-link" 
											href="${ null != currentPage && currentPage != maxPage ? '/DonateList?page=' += (currentPage + 1) += searchParams : 'javascript: void(0);' }">
											<i class="fa fa-angle-right"></i>
											<span class="sr-only">Next</span>
										</a>
									</li>

									<li class="page-item">
										<a class="page-link" 
											href="${ null != currentPage && currentPage != maxPage ? '/DonateList?page=' += maxPage += searchParams : 'javascript: void(0);' }">
											<i class="fa fa-angle-right"></i>
											<i class="fa fa-angle-right"></i>
											<span class="sr-only">Next</span>
										</a>
									</li>

								</ul>
							</nav>
						</div>

						<div class="col text-right"></div>
					</div>
					<%-- //bottom --%>
				</div>
			</div>
		</div>

	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<script src="/resources/each/js/donateList.js?${verQuery}"></script>
<%-- -------- //JavaScript -------- --%>