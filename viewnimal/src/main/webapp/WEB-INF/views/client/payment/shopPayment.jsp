<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page import="java.util.*" %>

<%
	request.setAttribute( "verQuery", "ver=" + Calendar.getInstance().get(Calendar.MILLISECOND) );
%>

<c:import url="/WEB-INF/views/common/top.jsp" />

<link rel="stylesheet" href="/resources/each/css/shopPayment.css?${ verQuery }" />

<c:choose>
	<c:when test="${ totalPrice >= 50000 }">
		<c:set var="deliveryTotalPriceSet" value="${ totalPrice }" />
		<fmt:formatNumber var="deliveryTotalPrice" value="${ totalPrice }" pattern="#,###"/>
	</c:when>
	<c:otherwise>
		<c:set var="deliveryTotalPriceSet" value="${ totalPrice + 2500 }" />
		<fmt:formatNumber var="deliveryTotalPrice" value="${ totalPrice + 2500 }" pattern="#,###"/>
	</c:otherwise>
</c:choose>

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-shopPayment">
		
		<div class="vm-section">
			<div>
				<h2>주문서 작성</h2>
			</div>
			
			<!-- 주문 상품 정보 -->
			<div>
				<form id="finalPayment">
					<input type="hidden" name="id" value="${ loginMemberDto.id }">
					<div>
						<div class="vm-shopPayment__option__top__contents">
							상품의 옵션 및 수량 변경은 상품상세 또는 장바구니에서 가능합니다.
						</div>
						
						<div>
							<div class="vm-shopPayment__delivery__contents">
								<h3>국내배송상품 주문내역</h3>
							</div>
							
							<div class="vm-shopPayment__delivery__product__info">
								<table class="vm-shopPayment__delivery__table" border="1">
									<thead>
										<tr>
											<th class="vm-shopPayment__payment__img">이미지</th>
											<th class="vm-shopPayment__payment__product__info">상품정보</th>
											<th class="vm-shopPayment__payment__price">판매가</th>
											<th class="vm-shopPayment__payment__count">수량</th>
											<th class="vm-shopPayment__payment__delivery__division">배송구분</th>
											<th class="vm-shopPayment__payment__delivery__pay">배송비</th>
											<th>합계</th>
										</tr>
									</thead>
									
									<tbody>
										<c:forEach items="${ list }" var="orderList" varStatus="status">
										<c:if test="${ status.index eq 0 }">
											<c:set var="productNameFrist" value="${ orderList.name }"/>
										</c:if>
										
										<c:set var="productid" value="${ orderList.product_id }" />
										
										<input type="hidden" name="product_id" value="${ orderList.product_id }">
										<input type="hidden" name="temporarilyPrice" value="${ orderList.price }">
										<input type="hidden" name="name" value="${ orderList.name }">
										<input type="hidden" name="main_img_name" value="${ orderList.main_img_name }">
										
										<tr>
											<c:url var="ProductDetailPage" value="ProductDetail">
												<c:param name="productId" value="${ orderList.product_id }"></c:param>
											</c:url>
											<td class="vm-shopPayment__payment__img"><a href="${ ProductDetailPage }"><img src="/resources/images/product/main/${ orderList.main_img_name }"></a></td>
											
											<c:url var="ProductDetailPage" value="ProductDetail">
												<c:param name="productId" value="${ orderList.product_id }"></c:param>
											</c:url>
											<td class="vm-shopPayment__payment__product__info"><a href="${ ProductDetailPage }">${ orderList.name }</a></td>
											
											<fmt:formatNumber var="patternPrice" value="${ orderList.price }" pattern="#,###"/>
											<td class="vm-shopPayment__payment__price">${ patternPrice }원</td>
											<td class="vm-shopPayment__payment__count" id="payment__count">
												<input type="hidden" name="temporarilyAmount" value="${ orderList.amount }">
												${ orderList.amount }개
											</td>
											<td class="vm-shopPayment__payment__delivery__division">기본배송</td>
											
											<c:choose>
												<c:when test="${ totalPrice >= 50000 }">
													<td class="vm-shopPayment__payment__delivery__pay">무료</td>
												</c:when>
												<c:otherwise>
													<td class="vm-shopPayment__payment__delivery__pay">2,500원</td>
												</c:otherwise>
											</c:choose>
											
											<fmt:formatNumber var="patternSum" value="${ orderList.price * orderList.amount }" pattern="#,###"/>
											<td>${ patternSum }원</td>
										</tr>
										</c:forEach>
									</tbody>
									
									<tfoot>
										<tr>
											<td colspan="7">
												<strong class="vm-shopPayment__payment__table__tfoot__strong">[기본배송]</strong>
												<fmt:formatNumber var="patternTotal" value="${ totalPrice }" pattern="#,###"/>
												상품구매금액 <strong>${ patternTotal }</strong> 
												 + 배송비 
												 	<c:choose>
														<c:when test="${ totalPrice >= 50000 }">
															0원 (무료) = 합계: <strong><span>${ patternTotal }원</span></strong>
														</c:when>
														<c:otherwise>
															<fmt:formatNumber var="patternTotalPlus" value="${ totalPrice + 2500 }" pattern="#,###"/>
															2,500원 = 합계: <strong><span>${ patternTotalPlus }원</span></strong>
														</c:otherwise>
													</c:choose>
												  
											</td>
										</tr>
									</tfoot>
								</table>
							</div>
						</div>
						
						<div class="vm-shopPayment__option__bottom__contents">
							상품의 옵션 및 수량 변경은 상품상세 또는 장바구니에서 가능합니다.
						</div>
						
						<div class="vm-shopPayment__empty"></div>
						
					</div>
			</div>
			
			<!-- 주문자 정보 -->
			<div>
				<div class="vm-shopPayment__orderer">
					<h3>주문자 정보</h3>
				</div>
				
				<div class="vm-shopPayment__orderer__info">
					<table border="1">
						<tbody>
							<tr><th>주문하시는 분</th><td><input class="vm-shopPayment__name" id="ordererName" type="text" value="${ loginMemberDto.nickname }" required></td></tr>
						<tr>
							<th>주소</th>
							<td>
								<input type="text" class="vm-shopPayment__zipcode" id="ordererZipcode" required><a href="#" class="badge badge-primary" onclick="postSearch(0); return false;">우편번호</a><br>
								<input type="text" class="vm-shopPayment__address__basic" id="ordererAddress__basic" required><span>기본주소</span><br>
								<input type="text" class="vm-shopPayment__address__basic" id="ordererAddress__reminder" required><span>나머지주소</span>
							</td>
						</tr>
						
						<tr>
							<th>휴대전화</th>
							<td>
								<c:set var="varPhone" value="${loginMemberDto.phone}" />
								<c:set var="phoneFirst" value="${fn:substring(varPhone, 0, 3)}" />
								<select id="phoneKeyNumber">
									<c:choose>
										<c:when test="${ phoneFirst == '010' }">
											<option selected>010</option>
											<option>011</option>
											<option>016</option>
											<option>017</option>
										</c:when>
										<c:when test="${ phoneFirst == '011' }">
											<option>010</option>
											<option selected>011</option>
											<option>016</option>
											<option>017</option>
										</c:when>
										<c:when test="${ phoneFirst == '017' }">
											<option>010</option>
											<option>011</option>
											<option>016</option>
											<option selected>017</option>
										</c:when>
										<c:when test="${ phoneFirst == '016' }">
											<option>010</option>
											<option>011</option>
											<option selected>016</option>
											<option>017</option>
										</c:when>
										
										<c:otherwise>
											<option>010</option>
											<option>011</option>
											<option>016</option>
											<option>017</option>
										</c:otherwise>
									</c:choose>
								</select>
								
								<c:choose>
									<c:when test="${ 10 == fn:length(varPhone) }">
										
										- <input class="vm-shopPayment__phone" id="ordererPhonMiddle" type="text" value="${fn:substring(varPhone, 3, 6)}" required maxlength="4">
										- <input class="vm-shopPayment__phone" id="ordererPhonend" type="text" value="${fn:substring(varPhone, 6, 10)}" required maxlength="4">
									</c:when>

									<c:otherwise>
										- <input class="vm-shopPayment__phone" id="ordererPhoneMiddle" type="text" value="${fn:substring(varPhone, 3, 7)}" required maxlength="4">
										- <input class="vm-shopPayment__phone" id="ordererPhoneEnd" type="text" value="${fn:substring(varPhone, 7, 11)}" required maxlength="4">
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>
								<c:set var="varEmail" value="${ loginMemberDto.email }"/>
								<c:set var="EmailName" value="${ fn:substringAfter(varEmail, '@') }"/>
								<input class="vm-shopPayment__email" type="text" id="ordererEmailStart" value="${ fn:substringBefore(varEmail, '@') }" required> @ 
								<input class="vm-shopPayment__email" type="text" id="ordererEmailEnd" value="${ EmailName }" required readonly="readonly">
								
								<select id="memberEmailName">
									<option>-이메일 선택-</option>
									<c:choose>
										<c:when test="${ EmailName == 'gmail.com' }">
											<option selected>gmail.com</option>
											<option>naver.com</option>
											<option>hanmail.com</option>
										</c:when>
										
										<c:when test="${ EmailName == 'naver.com' }">
											<option>gmail.com</option>
											<option selected>naver.com</option>
											<option>hanmail.com</option>
										</c:when>
										
										<c:when test="${ EmailName == 'hanmail.com' }">
											<option>gmail.com</option>
											<option>naver.com</option>
											<option selected>hanmail.com</option>
										</c:when>
										
										<c:otherwise>
											<option>gmail.com</option>
											<option>naver.com</option>
											<option>hanmail.com</option>
										</c:otherwise>
									</c:choose>
									<option>직접입력</option>
								</select>
							</td>
						</tr>
						</tbody>
					</table>
				</div>
				
			</div>			
			
			<!-- 배송 정보 -->
			<div>
				<div class="vm-shopPayment__orderer">
					<h3>배송지 정보</h3>
				</div>
				
				<div class="vm-shopPayment__orderer__info">
					<table border="1">
						<tr>
							<th>배송지 선택</th>
							<td>
								<div>
									<input type="radio" id="ordererSelectDelivery" name="deliveryRadio">
									<label>주문자 정보와 동일</label>
									<input type="radio" id="newSelectDelivery" name="deliveryRadio">
									<label>새로운 배송지</label>
								</div>
							</td>
						</tr>
						<tr><th>배송받으시는 분</th><td><input class="vm-shopPayment__name" id="deliveryName" type="text" required></td></tr>
						
						<tr>
							<th>주소</th>
							<td>
								<input type="text" class="vm-shopPayment__zipcode" id="deliveryZipcode" name="address" required><a href="#" class="badge badge-primary" onclick="postSearch(1); return false;">우편번호</a><br>
								<input type="text" class="vm-shopPayment__address__basic" id="deliveryAddress__basic" name="address" required><span>기본주소</span><br>
								<input type="text" class="vm-shopPayment__address__basic" id="deliveryAddress__reminder" name="address" required><span>나머지주소</span>
							</td>
						</tr>
						
						<tr>
							<th>휴대전화</th>
							<td>
								<select id="deliveryPhoneKeyNumber">
									<option>010</option>
									<option>011</option>
									<option>016</option>
									<option>017</option>
								</select>
								
								</div>
								 - <input class="vm-shopPayment__phone" id="deliveryPhoneMiddle" type="text" required maxlength="4">
								 - <input class="vm-shopPayment__phone" id="deliveryPhoneEnd" type="text" required maxlength="4">
							</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>
								<input class="vm-shopPayment__email" id="deliveryEmailStart" type="text" required>
								 @ <input class="vm-shopPayment__email" id="deliveryEmailEnd" type="text" required readonly="readonly">
								<select id="deliveryMemberEmailName">
									<option>-이메일선택-</option>
									<option>gmail.com</option>
									<option>naver.com</option>
									<option>hanmail.com</option>
									<option>직접입력</option>
								</select>
							</td>
						</tr>
					</table>
				</div>
			</div>
			
			<!-- 결제 예정 금액 -->
			<div>
				<div class="vm-shopPayment__pay__due">
					<h3>결제 예정 금액</h3>
				</div>
				
				<div class="vm-shopPayment__total">
					<div class="vm-shopPayment__total__div">
						<table border="1 ">
							<thead>
								<tr>
									<th>총 주문 금액</th>
									<th>총 할인 금액 + 부가결제 금액</th>
									<th>총 결제 예정 금액</th>
								</tr>
							</thead>
							
							<tbody>
								<tr>
									<td><strong><span class="vm-shopPayment__total__span">
										${ deliveryTotalPrice }원
									</span></strong></td>
									<td><strong><span>- 0원</span></strong></td>
									<td><strong><span class="vm-shopPayment__total__span">= 
										${ deliveryTotalPrice }원
									</span></strong></td>
								</tr>
							</tbody>
						</table>
					</div>
					
					<div class="vm-shopPayment__discount">
						<div>
							<table border="1 ">
								<tbody>
									<tr><th><strong>총 할인금액</strong></th><td><strong>0원</strong></td></tr>
								</tbody>
							</table>
						</div>
						
						<div>
							<table border="1 ">
								<tbody>
									<tr><th><strong>총 부가결제금액</strong></th><td><strong>0원</strong></td></tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 결제 수단 -->
			<div class="vm-shopPayment__pay__method__contents">
					<h3>결제 수단</h3>
			</div>
			
			<div class="vm-shopPayment__pay__method">
								
				<div class="vm-shopPayment__pay__method__div">
					<div class="vm-shopPayment__pay__method__choose">
						<div class="vm-shopPayment__pay__method__choose__check">
							<span><input type="radio" id="payMethodCard" name="payMethod" checked><label>카드 결제</label></span>
							<span><input type="radio" id="payMethodrealTime" name="payMethod"><label>에스크로(실시간 계좌이체)</label></span>
							<span><input type="radio" id="payMethodPhone" name="payMethod"><label>휴대폰 결제</label></span>
						</div>
					
						<div class="vm-shopPayment__pay__method__choose__check__contents">
							<div class="vm-shopPayment__pay__method__choose__check__contents__div" id="payMethodDiv">
								<p>최소 결제 가능 금액은 결제금액에서 배송비를 제외한 금액입니다.</p>
								<p>소액 결제의 경우 PG사 정책에 따라 결제 금액 제한이 있을 수 있습니다.</p>
							</div>
						</div>
					</div>
					
					<div class="vm-shopPayment__pay__method__div__result">
						<h4><strong id="payMethodOut">카드 결제</strong> 최종결제 금액</h4>
						<p>
							${ deliveryTotalPrice }원
						</p>
						<div class="vm-shopPayment__pay__method__div__result__button">
							<button type="submit" class="btn btn-default vm-shopPayment__pay__btn">결제하기</button>
						</div>
					</div>
				</div>
				
				<div>
				
				</div>
			</div>
			</form>
			<!-- 이용 안내 -->
			<div class="vm-shopPayment__help">
				<h3>이용안내</h3>
				<div class="vm-shopPayment__help__window">
					<h4>WindowXP 서비스팩2를 설치하신후 결제가 정상적인 단계로 처리되지 않는경우, 아래의 절차에 따라 해결하시기 바랍니다.</h4>
					<ol>
						<li><a onclick="window.open('http://service-api.echosting.cafe24.com/shop/notice_XP_ActiveX.html','','width=795,height=500,scrollbars=yes',resizable=1);">안심클릭 결제모듈이 설치되지 않은 경우 ActiveX 수동설치</a></li>
						<li><a href="http://www.microsoft.com/korea/windowsxp/sp2/default.asp">Service Pack 2에 대한 Microsoft사의 상세안내 </a></li>
					</ol>
				</div>
					
				<div>
					<h4>아래의 쇼핑몰일 경우에는 모든 브라우저 사용이 가능합니다.</h4>
					<ol>
						<li>KG이니시스, KCP, LG U+를 사용하는 쇼핑몰일 경우</li>
						<li>결제가능브라우저 : 크롬,파이어폭스,사파리,오페라 브라우저에서 결제 가능</li>
						<li>최초 결제 시도시에는 플러그인을 추가 설치 후 반드시 브라우저 종료 후 재시작해야만 결제가 가능합니다.</li>
					</ol>
				</div>
				
				<div>
					<h4>부가가치세법 변경에 따른 신용카드매출전표 및 세금계산서 변경안내</h4>
					<ol>
						<li>변경된 부가가치세법에 의거, 2004.7.1 이후 신용카드로 결제하신 주문에 대해서는 세금계산서 발행이 불가하며</li>
						<li>신용카드매출전표로 부가가치세 신고를 하셔야 합니다.(부가가치세법 시행령 57조)</li>
						<li>상기 부가가치세법 변경내용에 따라 신용카드 이외의 결제건에 대해서만 세금계산서 발행이 가능함을 양지하여 주시기 바랍니다.</li>
					</ol>
				</div>
				
				<div>
					<h4>현금영수증 이용안내</h4>
					<ol>
						<li>현금영수증은 1원 이상의 현금성거래(무통장입금, 실시간계좌이체, 에스크로, 예치금)에 대해 발행이 됩니다.</li>
						<li>현금영수증 발행 금액에는 배송비는 포함되고, 적립금사용액은 포함되지 않습니다.</li>
						<li>발행신청 기간제한 현금영수증은 입금확인일로 부터 48시간안에 발행을 해야 합니다.</li>
						<li>현금영수증 발행 취소의 경우는 시간 제한이 없습니다. (국세청의 정책에 따라 변경 될 수 있습니다.)</li>
						<li>현금영수증이나 세금계산서 중 하나만 발행 가능 합니다.</li>
					</ol>
				</div>
			</div>
		</div>
		
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/shopPayment.js?${verQuery}"></script> --%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>
	(function ($) {
		// do not remove this string
		"use strict";
		$("input[name=deliveryRadio]").on("change", function() {
			if($("#ordererSelectDelivery").is(":checked")) {
				$("#deliveryName").val($("#ordererName").val());
				$("#deliveryZipcode").val($("#ordererZipcode").val());
				$("#deliveryAddress__basic").val($("#ordererAddress__basic").val());
				$("#deliveryAddress__reminder").val($("#ordererAddress__reminder").val());
				$("#deliveryPhoneMiddle").val($("#ordererPhoneMiddle").val());
				$("#deliveryPhoneEnd").val($("#ordererPhoneEnd").val());
				$("#deliveryEmailStart").val($("#ordererEmailStart").val());
				$("#deliveryEmailEnd").val($("#ordererEmailEnd").val());
				$("#deliveryMemberEmailName").val($("#ordererEmailEnd").val());
				
				if($("#memberEmailName option:selected").text() == '직접입력') {
					$("#deliveryEmailEnd").attr("readonly", false);
					$("#deliveryMemberEmailName").val("직접입력");
				}
			} else {
				$("#deliveryName").val("");
				$("#deliveryZipcode").val("");
				$("#deliveryAddress__basic").val("");
				$("#deliveryAddress__reminder").val("");
				$("#deliveryPhoneMiddle").val("");
				$("#deliveryPhoneEnd").val("");
				$("#deliveryEmailStart").val("");
				$("#deliveryEmailEnd").val("");
			}
		});
		
		$("input[name=payMethod]").on("change", function() {
			if($("#payMethodCard").is(":checked")) {
				$("#payMethodOut").text("카드 결제");
				$("#payMethodDiv").html("<p>최소 결제 가능 금액은 결제금액에서 배송비를 제외한 금액입니다.</p><p>소액 결제의 경우 PG사 정책에 따라 결제 금액 제한이 있을 수 있습니다.</p>");
			} else if($("#payMethodrealTime").is(":checked")) {
				$("#payMethodOut").text("에스크로 결제");
				$("#payMethodDiv").html("<label>예금주명</label> <input type='text' id='payDeposit'>");
			} else {
				$("#payMethodOut").text("휴대폰 결제");
				$("#payMethodDiv").html("<p>소액 결제의 경우 PG사 정책에 따라 결제 금액 제한이 있을 수 있습니다.</p>");
			}
		});
		
		finalPayment();
		
			function finalPayment() {
				var $finalPayment = $("#finalPayment");
				
				$finalPayment.on("submit", function(e) {
					e.preventDefault();
					$finalPayment.formSubmit(false);
					
		    	var product_id = $("input[name=product_id]").val();
		    	
		    	var price = "${ deliveryTotalPriceSet }";
		    	var payMethodVar = "";
		    	var IMP = window.IMP;
		    	
		    	if($("#payMethodCard").is(":checked")) {
		    		payMethodVar = "card";
		    	} else if($("#payMethodrealTime").is(":checked")) {
		    		payMethodVar = "trans";
		    	} else {
		    		payMethodVar = "phone";
		    	}
		    	
		    	var orderName = $("#deliveryName").val();
		    	if(orderName != $("#payDeposit").val()) {
		    		orderName = $("#payDeposit").val();
		    	}
		    	
		    	console.log(orderName);
		    	
		    	var orderProductName = "${ productNameFrist }" + "외 (${fn:length(list)}-1)건";
		    	var orderPhone = "${loginMemberDto.phone}";
		    	var orderEmail = $("#deliveryEmailStart").val() + "@" + $("#deliveryEmailEnd").val()
		    	var orderAddress = $("#deliveryAddress__basic").val() + " "  + $("#deliveryAddress__reminder").val();
		    	var orderZipcode = $("#deliveryZipcode").val();
		    	
		    	
		    	var okFail = "fail";
		    	
		    	var now = "${now}";
		    	
				IMP.init("imp10675025");

				IMP.request_pay({
					pg : "html5_inicis",
					pay_method : payMethodVar,
					merchant_uid : "merchant_" + new Date().getTime(),
					name : orderProductName,
					amount : price,

					buyer_email : orderEmail,
					buyer_name : orderName,
					buyer_tel : orderPhone, // session 으로 받기
					buyer_addr : orderAddress,
					buyer_postcode : orderZipcode,

				}, function(rsp) {
					console.log(rsp);
					if (rsp.success) {
						var msg = "결제가 완료되었습니다.";
						msg += "고유ID : " + rsp.imp_uid;
						msg += "상점 거래ID : " + rsp.merchant_uid;
						msg += "결제 금액 : " + rsp.paid_amount;
						msg += "카드 승인번호 : " + rsp.apply_num;
						alert(msg);
						
						if(now != "buynow") {
							$.ajax({
								url: "payOrder",
								type: "post",
								dataType: "json",
								data: $finalPayment.serialize(),
								success: function(data, status, xhr) {
									if(data.okAndFail == "ok") {
										basketDelete();
									}
								},
								error: function(request, status, errorData) {
								}
							});
						} else {
							
							if($("#payMethodCard").is(":checked")) {
					    		payMethodVar = 1;
					    	} else if($("#payMethodrealTime").is(":checked")) {
					    		payMethodVar = 2;
					    	} else {
					    		payMethodVar = 3;
					    	}
							
							$.ajax({
								url: "payOrder",
								type: "post",
								dataType: "json",
								data: $finalPayment.serialize(),
								success: function(data, status, xhr) {
									if(data.okAndFail == "ok") {
										location.href="PayComplete?product_id=" + product_id + "&methodpay=" + payMethodVar + "&totalPrice=${totalPrice}";
									}
								},
								error: function(request, status, errorData) {
								}
							});
						}
						
					} else {
						var msg = "결제에 실패하였습니다.";
						msg += "에러내용 : " + rsp.error_msg;
						alert(msg);
					}
					
					
					});
				});
				
				
				
		    }
			
			function basketDelete() {
				var $finalPayment = $("#finalPayment");
				var payMethodVar = "";
				
				
				if($("#payMethodCard").is(":checked")) {
		    		payMethodVar = 1;
		    	} else if($("#payMethodrealTime").is(":checked")) {
		    		payMethodVar = 2;
		    	} else {
		    		payMethodVar = 3;
		    	}
				
				$.ajax({
					url: "payCompleteBasketDelete",
					type: "post",
					dataType: "json",
					data: $finalPayment.serialize(),
					success: function(data, status, xhr) {
						console.log(data);
						if(data.okAndFail == "ok") {
							location.href="PayComplete?product_id=" + data.product_id + "&methodpay=" + payMethodVar + "&totalPrice=${totalPrice}";	
						}
					},
					error: function(request, status, errorData) {
					}
				});
			}
			
			$("#memberEmailName").on("change", function() {
				
				if($("#memberEmailName option:selected").text() == '직접입력') {
					$("#ordererEmailEnd").val("");
					$("#ordererEmailEnd").attr("readonly", false);
				} else if($("#memberEmailName option:selected").text() == '-이메일 선택-') {
					$("#ordererEmailEnd").val("");
				}else {
					$("#ordererEmailEnd").val($("#memberEmailName option:selected").text());
					$("#ordererEmailEnd").attr("readonly", true);
				}
			});
			
			$("#deliveryMemberEmailName").on("change", function() {
				if($("#deliveryMemberEmailName option:selected").text() == '직접입력') {
					$("#deliveryEmailEnd").val("");
					$("#deliveryEmailEnd").attr("readonly", false);
				} else if($("#deliveryMemberEmailName option:selected").text() == '-이메일선택-') {
					$("#deliveryEmailEnd").val("");
				} else {
					$("#deliveryEmailEnd").val($("#deliveryMemberEmailName option:selected").text());
					$("#deliveryEmailEnd").attr("readonly", true);
				}
			});
		
			
			$("#ordererZipcode").on("click", function() {
				postSearch(0);
			});
			
			$("#deliveryZipcode").on("click", function() {
				if($("#deliveryZipcode").val() == "") {
					postSearch(0);
				}				
			});
		// javascript code here
	}(jQuery));
	
	    function postSearch(chooseAddress) {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
	                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }
	                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
	                if(fullRoadAddr !== ''){
	                    fullRoadAddr += extraRoadAddr;
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                if(chooseAddress == 0) {
	                	document.getElementById('ordererZipcode').value = data.zonecode; //5자리 새우편번호 사용
		                document.getElementById('ordererAddress__basic').value = fullRoadAddr;
	                } else {
	                	document.getElementById('deliveryZipcode').value = data.zonecode; //5자리 새우편번호 사용
		                document.getElementById('deliveryAddress__basic').value = fullRoadAddr;
	                }
	                
	            }
	        }).open();
	    }

</script>
<%-- -------- //JavaScript -------- --%>