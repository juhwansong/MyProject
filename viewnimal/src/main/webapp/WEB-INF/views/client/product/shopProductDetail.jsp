<%@page import="com.kh.viewnimal.product.model.dto.ProductDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.*" %>

<c:import url="/WEB-INF/views/common/top.jsp" />

<link rel="stylesheet" href="/resources/each/css/shopProductDetail.css?${ verQuery }" />

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-shopProductDetail">
		
		<div class="vm-section">
		
		<div class="vm-shopProductList__product__main">
			<!-- 주문 정보 -->
			<div>
				<div class="vm-shopProductList__product__main__img">
					<img src="/resources/images/product/main/${ productDto.main_img_name }">
				</div>
				
				<div class="vm-shopProductList__product__info">
					<h3>${ productDto.name }</h3>
					<table class="vm-shopProductList__product__info__table">
						<tbody>
							<tr><th><span>제조사(수입원)</span></th><td>${ productDto.production }</td></tr>
							<tr><th>원산지</th><td>${ productDto.origin }</td></tr>
							<tr class="vm-shopProductList__product__info__price">
								<th>판매가</th>
								<td>
									<fmt:formatNumber var="patternPrice" value="${ productDto.price }" pattern="#,###"/>
									${ patternPrice }원
								</td>
							</tr>
						</tbody>
					</table>
					
					<div class="vm-shopProductList__product__countSelect">
						<p>수량을 선택해주세요.</p>
						<table class="vm-shopProductList__product__countSelect__table">
							<colgroup>
								<col style="width: 284px;">
								<col style="width: 80px;">
								<col style="width: 110px;">
							</colgroup>
							<tbody>
								<tr>
									<td class="vm-shopProductList__productName">${ productDto.name }</td>
									<td class="vm-shopProductList__countSelect">
										<span class="vm-shopProductList__countSelect__span">
										<input type="text" value="1" class="vm-shopProductList__product__countSelect__input" id="inputCount">
										<a href="#" onclick="countUp(); return false;">
											<img class="vm-shopProductList__up" src="/resources/images/product/btn_count_up.gif">
										</a>
										<a href="#" onclick="countDown(); return false;">
											<img class="vm-shopProductList__down" src="/resources/images/product/btn_count_down.gif">
										</a>
										</span>
									</td>
									<c:set var="totalPrice" value="${ productDto.price }"/>
									<fmt:formatNumber var="patternPrice" value="${ totalPrice }" pattern="#,###"/>
									<td>
										<span id="totalPriceOut">${ patternPrice }원</span>
									</td>
								</tr>
							</tbody>
							
							<tfoot>
								<tr>
									<td colspan="3">
										<strong>총 상품금액</strong> (수량) : <strong id="totalPriceOutput"><span class="vm-shopProductList__product__tfoot__span">${ patternPrice }원</span></strong><span class="vm-shopProductList__product__tfoot__span">(</span><span class="vm-shopProductList__product__tfoot__span" id="outputCount">1</span><span class="vm-shopProductList__product__tfoot__span">개)</span>
									</td>
								</tr>
							</tfoot>
						</table>
					</div>
					
					<div class="vm-shopProductList__product__countSelect__btn">
						<a href="#" class="btn btn-primary btn-lg active vm-shopProductList__buynowBtn" id="buyNowOrder" role="button" aria-pressed="true">BUY NOW</a>
						<a href="#" class="btn btn-secondary btn-lg active btn-secondary__addCart" role="button" aria-pressed="true">ADD CART</a>
						
					</div>
					
				</div>
			</div>
		</div>
		
		<!-- 상품 정보 -->
		<div>
			<div class="vm-shopProductList__product__detail__start">
				<ul>
					<li>상품정보</li>
					<!-- <li>배송정보</li> -->
				</ul>
			</div>
			
			<!-- 상세 이미지 -->
			<div class="vm-shopProductList__product__detail__img">
				<img src="/resources/images/product/detail/${ productDto.detail_img_name }">
			</div>
		</div>
		
		<!-- 배송 정보 -->
		<div class="vm-shopProductList__product__delivery">
			<div class="vm-shopProductList__product__detail__start">
				<ul>
					<!-- <li style="float: left;">상품정보</li> -->
					<li>배송정보</li>
				</ul>
			</div>
			
			<div class="vm-shopProductList__product__delivery__info">
				<li class="vm-shopProductList__product__delivery__title">배송정보</li>
				<li class="vm-shopProductList__product__delivery__contents">배송 방법 : 택배</li>
				<li class="vm-shopProductList__product__delivery__contents">배송 비용 : 2,500원</li>
				<li class="vm-shopProductList__product__delivery__contents">배송 기간 : 1일 ~ 3일</li>
				<li class="vm-shopProductList__product__delivery__contents">배송 안내 : 산간벽지나 도서지방은 별도의 추가금액을 지불하셔야 하는 경우가 있습니다.</li>
				<li class="vm-shopProductList__product__delivery__contents">고객님께서 주문하신 상품은 입금 확인후 배송해 드립니다. 다만, 상품종류에 따라서 상품의 배송이 다소 지연될 수 있습니다.</li>
			</div>
		</div>
		
	</div>
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/shopProductDetail.js?${verQuery}"></script> --%>
<script>
	(function ($) {
		// do not remove this string
		"use strict";
		
		$(".btn-secondary__addCart").click(function() {
			var product_id = '${productDto.product_id}';
			var amount = $("#inputCount").val();
			var id = '${ loginMemberDto.id }';
			
			if(id != "") {
				$.ajax({
					url: "addCart",
					type: "post",
					dataType: "json",
					data: { product_id: product_id, amount : amount, id : id},
					success: function(data, status, xhr) {
						console.log(data);
						if(data.okAndFail == "ok") {
							App.messagePop.show(
								"장바구니에 추가 되었습니다. <br><span style='font-weight: 600;'>클릭</span>하시면 장바구니 페이지로 이동합니다.",
								{
									callback : function() {
										location.href = "/SelectCart"
									}
									, duration : 5000
								}
							);
							
							/* if(confirm("장바구니에 추가 되었습니다. 장바구니 페이지로 이동하시겠습니까?")) {
								location.href = "/SelectCart";
							} */
						}
					},
					error: function(request, status, errorData) {
						if(confirm("장바구니에 기존 제품이 존재합니다. 장바구니 페이지로 이동하시겠습니까?")) {
							location.href = "/SelectCart";
						}
					}
					
				});
			} else {
				alert("로그인 후 이용해 주세요!!");
				$("#modal-login").modal("show");
			}
		});
		
		$("#buyNowOrder").on("click", function() {
			var product_id = "${ productDto.product_id }";
			var amount = $("#inputCount").val();
			
			location.href="/NowOrder?product_id=" + product_id + "&amount=" + amount + "&now=buynow";
		});
		
		$("#inputCount").on("change", function() {
			if($("#inputCount").val() >= 1 && parseInt($("#inputCount").val()) <= 50) {
				var pattPrice = $("#inputCount").val() * "${totalPrice}";
			$("#totalPriceOut").text(commaPrice(pattPrice) + "원");
			$("#totalPriceOutput").html("<span class='vm-shopProductList__product__tfoot__span'>" + commaPrice(pattPrice) + "</span>");
			$("#outputCount").text($("#inputCount").val());
			} else if(parseInt($("#inputCount").val()) > 50) {
				alert("최대 주문 수량은 50개 입니다.");
				$("#inputCount").val("50");
			} else {
				alert("최소 주문 수량은 1개 입니다.");
				$("#inputCount").val("1");
			}
		});
		
		
		// javascript code here
	}(jQuery));
	
	function commaPrice(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	function countUp() {
		if(parseInt($("#inputCount").val()) <= 49) {
			$("#inputCount").val(parseInt($("#inputCount").val()) + 1);
			var pattPrice = commaPrice($("#inputCount").val() * "${totalPrice}");
			$("#totalPriceOut").text( pattPrice + "원");
			$("#totalPriceOutput").html("<span class='vm-shopProductList__product__tfoot__span'>" + pattPrice + "원</span>");
			$("#outputCount").text(parseInt($("#inputCount").val()));
		} else {
			alert("최대 주문 수량은 50개 입니다.");
		}
		
	}
	
	function countDown() {
		if($("#inputCount").val() >= 2) {
			$("#inputCount").val($("#inputCount").val() - 1);
			var pattPrice = commaPrice($("#inputCount").val() * "${totalPrice}");
			$("#totalPriceOut").text(pattPrice + "원");
			$("#totalPriceOutput").html("<span class='vm-shopProductList__product__tfoot__span'>" + pattPrice + "원</span>");
			$("#outputCount").text(parseInt($("#inputCount").val()));
		} else {
			alert("최소 주문 수량은 1개 입니다.");
		}
	}
</script>
<%-- -------- //JavaScript -------- --%>