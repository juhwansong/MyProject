<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:import url="/WEB-INF/views/common/top.jsp" />

<link rel="stylesheet" href="/resources/each/css/shopPaymentComplete.css?${verQuery}" />

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-shopPaymentComplete">
		<div class="vm-section">
		
		<div class="vm-shopPaymentComplete__title">
			<h2><span>주문완료</span></h2>
		</div>
		
		<!-- 결제 내역 -->
		<div>
			<div class="vm-shopPaymentComplete__orderNo">
				<p>
					<strong>고객님의 주문이 완료 되었습니다.</strong>
					주문내역 및 배송에 관한 안내는 주문조회를 통하여 확인 가능합니다.
				</p>
				
				<ul>
					<li>
						주문번호 : 
						<strong class="vm-shopPaymentComplete__orderNo__number">${ order_no }</strong>
					</li>
					
					<li>
						주문일자 : <span>${ payDate }</span>
					</li>
				</ul>
			</div>
			
			<div class="vm-shopPaymentComplete__orderArea">
				<div class="vm-shopPaymentComplete__orderArea__title">
					<h3>결제정보</h3>
				</div>
				
				<div class="vm-shopPaymentComplete__orderArea__boardView">
					<table border="1">
						<tbody>
							<tr>
								<th class="vm-shopPaymentComplete__orderArea__boardView__th">최종결제금액</th>
								<td class="vm-shopPaymentComplete__orderArea__boardView__price">
								<fmt:formatNumber var="patternPrice" value="${ totalPrice }" pattern="#,###"/>
								<fmt:formatNumber var="patternPriceDelivery" value="${ totalPrice + 2500 }" pattern="#,###"/>
									${ totalPrice > 50000 ? patternPrice : patternPriceDelivery }원
								</td>
							</tr>
							
							<tr>
								<th>결제수단</th>
								<td class="vm-shopPaymentComplete__orderArea__boardView__method">
									<strong>
										<c:choose>
											<c:when test="${ methodpay == '1' }">
												<span>카드 결제</span>
											</c:when>
											<c:when test="${ methodpay == '2' }">
												<span>실시간 계좌 이체</span>
											</c:when>
											<c:when test="${ methodpay == '3' }">
												<span>휴대폰 결제</span>
											</c:when>
										</c:choose>
										
									</strong>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			
			<div class="vm-shopPaymentComplete__orderList">
				<div class="vm-shopPaymentComplete__orderList__div">
					<h3>주문 상품 정보</h3>
				</div>
				
				<div class="vm-shopPaymentComplete__orderList__tableDiv">
					<table border="1">
						<thead>
							<tr>
								<th class="vm-shopPaymentComplete__table__img">이미지</th>
								<th class="vm-shopPaymentComplete__table__info">상품정보</th>
								<th class="vm-shopPaymentComplete__table__price">판매가</th>
								<th class="vm-shopPaymentComplete__table__count">수량</th>
								<th class="vm-shopPaymentComplete__table__method">배송구분</th>
								<th class="vm-shopPaymentComplete__table__total">합계</th>
							</tr>
						</thead>
						<c:forEach items="${ list }" var="payList" varStatus="status">
						<c:if test="${ status.index eq 0 }">
							<c:set var="address" value="${ payList.address }"/>
						</c:if>
							<tbody>
								<tr>
									<td>
										<c:url var="ProductDetailPage" value="ProductDetail">
											<c:param name="productId" value="${ payList.product_id }"></c:param>
										</c:url>
										<a href="${ ProductDetailPage }"><img src="/resources/images/product/main/${ payList.main_img_name }"></a>
									</td>
									<td>
										<a href="${ ProductDetailPage }"><strong>${ payList.name }</strong></a>
									</td>
									<fmt:formatNumber var="patternPriceProduct" value="${ payList.price }" pattern="#,###"/>
									<td><strong>${ patternPriceProduct }원</strong></td>
									<td>${ payList.amount }</td>
									<td>기본배송</td>
									<fmt:formatNumber var="patternPriceSum" value="${ payList.price * payList.amount }" pattern="#,###"/>
									<td><strong>${ patternPriceSum }원</strong></td>
								</tr>
							</tbody>
						</c:forEach>
							
						<tfoot>
							<tr>
								<td colspan="6">
									<strong class="vm-shopPaymentComplete__orderList__strong">[기본배송]</strong>
									상품구매금액
									<fmt:formatNumber var="patternTotalPrice" value="${ totalPrice }" pattern="#,###"/>
									<strong>${ patternTotalPrice }원</strong>
									 + 배송비 ${ totalPrice > 50000 ? 0 : "2,500" } = 합계 : 
									<strong class="vm-shopPaymentComplete__orderList__strong__total">${ totalPrice > 50000 ? patternPrice : patternPriceDelivery }원</strong>
								</td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
			
			<!-- 배송정보 -->
			<div class="vm-shopPaymentComplete__delivery">
				<div class="vm-shopPaymentComplete__delivery__title">
					<h3>배송지정보</h3>
				</div>
				
				<div class="vm-shopPaymentComplete__delivery__title__boardView">
					<table border="1">
						<tr>
							<th>받으시는분</th>
							<td><span>${ loginMemberDto.nickname }</span></td>
						</tr>
						<tr>
							<th>우편번호</th>
							<td>${fn:substring(address, 1, 6)}</td>
						</tr>
						<tr>
							<th>주소</th>
							<td>${fn:substringAfter(address, ')')}</td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td>${ loginMemberDto.phone }</td>
						</tr>
					</table>
				</div>
			</div>
			
			<div class="vm-shopPaymentComplete__mainBtn">
				<a href="/ProductList" class="badge badge-primary vm-shopPaymentComplete__shopMain">메인으로</a>
			</div>
			
		</div>
		
		</div>
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/shopPaymentComplete.js?${verQuery}"></script> --%>
<script>
	(function ($) {
		// do not remove this string
		"use strict";

		// javascript code here
	}(jQuery));
</script>
<%-- -------- //JavaScript -------- --%>