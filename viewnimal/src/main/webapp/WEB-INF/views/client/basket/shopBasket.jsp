<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.*" %>
<%
	request.setAttribute( "verQuery", "ver=" + Calendar.getInstance().get(Calendar.MILLISECOND) );
%>

<c:import url="/WEB-INF/views/common/top.jsp" />

<link rel="stylesheet" href="/resources/each/css/shopBasket.css?${verQuery}" />

<!-- 배송비 조건에 따른 합계 -->
<c:choose>
	<c:when test="${ totalPrice >= 50000 }">
		<fmt:formatNumber var="deliveryTotalPrice" value="${ totalPrice }" pattern="#,###,###"/>
	</c:when>
	<c:otherwise>
		<fmt:formatNumber var="deliveryTotalPrice" value="${ totalPrice + 2500 }" pattern="#,###,###"/>
	</c:otherwise>
</c:choose>

<fmt:formatNumber var="patternTotalPrice" value="${ totalPrice }" pattern="#,###,###"/>

<%-- -------- JSP -------- --%>
<div class="vm-container">
	
	
	<div class="vm-content vm-shopBasket">
		
		<div class="vm-section">
		
			<div class="vm-shopBasket__title">
				<h2><span>장바구니</span></h2>
			</div>
			
			<div class="vm-shopBasket__inner__order">
				<ul>
					<li><a href="#">국내배송상품</a></li>
				</ul>
			</div>
			
			<c:choose>
				<c:when test="${ empty list }">
					<div class="vm-shopBasket__emptyBasket">
						<p>장바구니가 비어 있습니다.</p>
					</div>
				</c:when>
				
				<c:otherwise>
			
					<!--  장바구니 정보 -->
					<div class="vm-shopBasket__info">
						<div class="vm-shopBasket__info__title">
							<h3>일반상품</h3>
						</div>
						
						<table>
							<colgroup>
								<col style="width: 35px;" />
								<col style="width: 130px;" />
								<col style="" />
								<col style="width: 95px;" />
								<col style="width: 80px;" />
								<col style="width: 90px;" />
								<col style="width: 70px;" />
								<col style="width: 90px;" />
								<col style="width: 105px;" />
							</colgroup>

							<thead>
								<tr>
									<%-- <th class="vm-shopBasket__info__checkbox"><input type="checkbox" id="info__checkbox__all" ></th> --%>
									<th class="vm-shopBasket__info__checkbox">
										<div class="custom-control custom-checkbox" style="padding-left: 35px;">
											<input class="custom-control-input" id="info__checkbox__all" type="checkbox" />
											<label class="custom-control-label" for="info__checkbox__all">&nbsp;</label>
										</div>
									</th>
									<th class="vm-shopBasket__info__img">이미지</th>
									<th class="vm-shopBasket__info__productInfo">상품정보</th>
									<th class="vm-shopBasket__info__price">판매가</th>
									<th class="vm-shopBasket__info__count">수량</th>
									<th class="vm-shopBasket__info__delivery">배송구분</th>
									<th class="vm-shopBasket__info__delivery__prcie">배송비</th>
									<th class="vm-shopBasket__info__total">합계</th>
									<th class="vm-shopBasket__info__select">선택</th>
								</tr>
							</thead>
							
							<tbody>
								
								<c:forEach items="${ list }" var="basketList" varStatus="status">
								<fmt:formatNumber var="patternPrice" value="${ basketList.price }" pattern="#,###,###"/>
								<tr id="vm-shopBasket__info__tr">
									<input type="hidden" value="${ basketList.product_id }" id="productId_${ status.index }">
									<input type="hidden" value="${ basketList.price }" class="vm-shopBasket__info__hiddenPrice" id="price_${ status.index }">
									<input type="hidden" value="${ status.index }" id="hiddenCount_${ status.index }">
									<%-- <td><input type="checkbox" clas="vm-shopBasket__info__tbody__productCheck" id="info__tbody__productCheck__${ status.index }" name="info__tbody__input__name"></td> --%>
									<td>
										<div class="custom-control custom-checkbox" style="padding-left: 35px;">
											<input class="custom-control-input" id="info__tbody__productCheck__${ status.index }" type="checkbox" name="info__tbody__input__name" />
											<label class="custom-control-label" for="info__tbody__productCheck__${ status.index }">&nbsp;</label>
										</div>
									</td>
									<td class="vm-shopBasket__info__tbody__img">
										<c:url var="ProductDetailPage" value="ProductDetail">
											<c:param name="productId" value="${ basketList.product_id }"></c:param>
										</c:url>
										<a href="${ ProductDetailPage }"><img src="/resources/images/product/main/${ basketList.main_img_name }"></a>
									</td>
									<td class="vm-shopBasket__info__tbody__productInfo">
										<c:url var="ProductDetailPage" value="ProductDetail">
											<c:param name="productId" value="${ basketList.product_id }"></c:param>
										</c:url>
										<a href="${ ProductDetailPage }">${ basketList.name }</a>
									</td>
									<td class="vm-shopBasket__info__tbody__price"><strong id="vm-shopBasket__info__strongPrice">${ patternPrice }</strong><strong>원</strong></td>
									<td class="vm-shopBasket__info__tbody__count">
										<span class="vm-shopBasket__info__tbody__count__span">
											<input type="text" class="vm-shopBasket__info__tbody__count__select__input" id="inputCount_${ status.index }" value="${ basketList.amount }">
											<a href="#" onclick="countUp(${ status.index }); return false;">
												<img class="vm-shopBasket__up" src="/resources/images/product/btn_count_up.gif">
											</a>
											<a href="#" onclick="countDown(${ status.index }); return false;">
												<img class="vm-shopBasket__down" src="/resources/images/product/btn_count_down.gif">
											</a>
										</span>
										<%-- <a href="#" class="badge badge-pill badge-secondary vm-shopBasket__info__tbody__countChange" onclick="countUpdate(${ status.index }); return false;">
											<img src="/resources/images/product/btn_quantity_modify.gif">
										</a> --%>
										<a onclick="countUpdate(${ status.index });" class="btn btn-secondary vm-shopBasket__info__tbody__countChange">변경</a>
									</td>
									<td class="vm-shopBasket__info__tbody__delivery">기본배송</td>
									<c:choose>
										<c:when test="${ totalPrice >= 50000 }">
											<td>무료</td>
										</c:when>
										<c:otherwise>
											<td>2,500원<br>조건</td>
										</c:otherwise>
									</c:choose>
									<fmt:formatNumber var="patternSum" value="${ basketList.price * basketList.amount }" pattern="#,###,###"/>
									<td id="totalPrice_${ status.index }"><strong class="vm-shopBasket__info__tbody__totalPriceOut" id="totalPriceOut_${ status.index }">${ patternSum }원</strong></td>
									<td class="vm-shopBasket__info__tbody__select">
										<c:url var="orderOne" value="OrderProductOne">
											<c:param name="product_id" value="${ basketList.product_id }" />
											<c:param name="price" value="${ basketList.price }" />
											<c:param name="name" value="${ basketList.name }" />
											<c:param name="main_img_name" value="${ basketList.main_img_name }" />
											<c:param name="amount" value="${ basketList.amount }" />
										</c:url>
										<a href="${ orderOne }" class="badge badge-default" id="oneBuynow">주문하기</a>
										<a href="#" class="badge badge-primary" onclick="deleteProductOne('${ basketList.product_id }'); return false;">삭제</a>
									</td>
								</tr>
								</c:forEach>
								
							</tbody>
							
							<tfoot>
								<tr>
									<td colspan="9">
										<strong class="vm-shopBasket__info__strong">[기본배송]</strong>
										상품구매금액
										<strong>${ patternTotalPrice }</strong>
										 + 배송비 
										 <c:choose>
											<c:when test="${ totalPrice >= 50000 }">
												0(무료)
											</c:when>
											<c:otherwise>
												2,500
											</c:otherwise>
										</c:choose>
										  = 합계 : 
										<strong class="vm-shopBasket__info__strong__total"><span>${ deliveryTotalPrice }</span>원</strong>
									</td>
								</tr>
							</tfoot>
						</table>
			</div>
			
			<!-- 선택 제품 삭제 -->
			<div class="vm-shopBasket__checkDelete">
				<span>
					<strong>선택상품을</strong>
					<a href="#" class="badge badge-default" onclick="selectDelete(); return false;">삭제하기</a>
				</span>
				
				<a href="#" class="badge badge-default" onclick="deleteProductAll(); return false;">장바구니비우기</a>
			</div>
			
			<!-- 총 주문 금액 -->
			<div class="vm-shopBasket__total">
				<table border="1">
					<thead>
						<tr>
							<th><span>총 상품금액</span></th>
							<th>총 배송비</th>
							<th>결제예정금액</th>
						</tr>
					</thead>
					
					<tbody>
						<tr>
							<td><strong>${ patternTotalPrice }</strong>원</td>
							<td><strong>
								<c:choose>
									<c:when test="${ totalPrice >= 50000 }">
										+0
									</c:when>
									<c:otherwise>
										+2,500
									</c:otherwise>
								</c:choose>
							</strong>원</td>
							<td class="vm-shopBasket__total__table__td"><strong>=${ deliveryTotalPrice }</strong>원</td>
						</tr>
					</tbody>
				</table>
			</div>
			
			</c:otherwise>
			</c:choose>
			
			<!-- 주문 버튼 -->
			<div class="vm-shopBasket__orderBtn">
				<div>
					<c:url var="payMove" value="AllOrder">
						<c:forEach items="${ list }" var="basketList" varStatus="status">
							<c:param name="product_id" value="${ basketList.product_id }" />
						</c:forEach>
					</c:url>
					<a href="${ payMove }" class="badge badge-default vm-shopBasket__orderBtn__allOrder">전체상품주문</a><!-- onclick="allOrder(); return false;" -->
				</div>
				
				<div>
					<a href="#" class="badge badge-primary" onclick="selectOrder(); return false;">선택상품주문</a>
				</div>
				
				<div>
					<a href="/ProductList" class="badge badge-info">쇼핑계속하기</a>
				</div>
			</div>
			
			<!-- 이용안내 -->
			<div class="vm-shopBasket__operation">
				<h3>이용안내</h3>
				
				<div>
					<h4>
						장바구니 이용안내
					</h4>
					<ol>
						<li>선택하신 상품의 수량을 변경하시려면 수량변경 후 [변경] 버튼을 누르시면 됩니다.</li>
						<li>[쇼핑계속하기] 버튼을 누르시면 쇼핑을 계속 하실 수 있습니다.</li>
						<li>장바구니와 관심상품을 이용하여 원하시는 상품만 주문하거나 관심상품으로 등록하실 수 있습니다.</li>
						<li>파일첨부 옵션은 동일상품을 장바구니에 추가할 경우 마지막에 업로드 한 파일로 교체됩니다.</li>
					</ol>
					
					<h4>무이자할부 이용안내</h4>
					<ol>
						<li>상품별 무이자할부 혜택을 받으시려면 무이자할부 상품만 선택하여 [주문하기] 버튼을 눌러 주문/결제 하시면 됩니다.</li>
						<li>[전체 상품 주문] 버튼을 누르시면 장바구니의 구분없이 선택된 모든 상품에 대한 주문/결제가 이루어집니다.</li>
						<li>단, 전체 상품을 주문/결제하실 경우, 상품별 무이자할부 혜택을 받으실 수 없습니다.</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/shopBasket.js?${verQuery}"></script> --%>
<script>
	(function ($) {
		// do not remove this string
		"use strict";
		
		$("#info__checkbox__all").on("change", function() {
			console.log("info__checkbox__all");
			
			$("input[name=info__tbody__input__name]").prop( "checked", $(this).prop("checked") );
		});
		
		$(".vm-shopBasket__info__tbody__count__select__input").on("change", function() {
			console.log("dd");
			
			var amount = $(this).parents("#vm-shopBasket__info__tr").find(".vm-shopBasket__info__tbody__count__select__input").val();
			var price = $(this).parents("#vm-shopBasket__info__tr").find(".vm-shopBasket__info__hiddenPrice").val();
			
			console.log("amount = " + amount);
			console.log("price = " + price);
			
			if(amount >= 1) {
				$(this).parents("#vm-shopBasket__info__tr").find(".vm-shopBasket__info__tbody__totalPriceOut").text(amount * price);
			} else {
				alert("최소 주문 수량은 1개 입니다.");
				$(this).parents("#vm-shopBasket__info__tr").find(".vm-shopBasket__info__tbody__count__select__input").val("1");
			}
			
		});
		
		
		
		$("input[name=info__tbody__input__name]").on("change", function() {
			var checkLength = "${fn:length(list)}";
			
			var count = 0;
			
			$("input[name=info__tbody__input__name]").each(function(index, item) {
				
				if(item.checked === true) {
					count += 1;
				}
				console.log(count);
			});
			
			if(count == checkLength) {
				$("#info__checkbox__all").prop('checked', true);
			} else {
				$("#info__checkbox__all").prop('checked', false);
			}
			/* for(var i = 0; i < checkLength; i++) {
				$("#info__tbody__productCheck__" + i).
			} */
		});
		// javascript code here
	}(jQuery));
	
	function changeCount(i) {
		if($("#inputCount_" + i).val() >= 1) {
			console.log("수량 변경  = " + i)
			$("#totalPriceOut_" + i).text($("#inputCount_" + i).val() * $("price_" + i).val());
		} else {
			alert("최소 주문 수량은 1개 입니다.");
			$("#inputCount_" + i).val("1");
		}
	}
			
			
	function deleteProductOne(product_id) {
		
		var id = "${ loginMemberDto.id }";
		
		$.ajax({
			url: "/deleteOneBasket",
			type: "post",
			datatype: "json",
			data: { product_id : product_id, id : id },
			success: function(data, status, xhr) {
				if(data.okAndFail == "ok") {
					location.reload();
				}
			},
			error: function(request, status, errorData) {
				
			}
			
		});
	}
	
	function deleteProductAll() {
		$.ajax({
			url: "/deleteAllBasket",
			type: "post",
			datatype: "json",
			data: {id : "${ loginMemberDto.id }"},
			success: function(data, status, xhr) {
				if(data.okAndFail == "ok") {
					location.href = "/SelectCart";
				}
			},
			error: function(request, status, errorData) {
				
			}
		});
	}
	
	function selectDelete() {
		var id = "${ loginMemberDto.id }";
		
		var productDto = [];
		
		var lengthList = "${fn:length(list)}";
		
		for(var i = 0; i < lengthList; i++) {
			var idCheck = "#info__tbody__productCheck__" + i;
			var idHidden = "#productId_" + i;
			
			if($(idCheck).is(":checked")) {
				console.log(i);
				productDto.push($(idHidden).val());
			}
			console.log(productDto);
		}
		
		productDto.push(id);
		
		$.ajax({
			url: "/deleteCheckBasket",
			type: "post",
			data: {json : JSON.stringify(productDto), id : id},
			/* contentType: "application/json; charset=utf-8", */
			success: function(data, status, xhr) {
				if(data.okAndFail == "ok") {
					location.href = "/SelectCart";
				}
			},
			error: function(request, status, errorData) {
				
			}
		});
	}

	function selectOrder() {
		var product_id;
		
		var lengthList = "${fn:length(list)}";
		
		for(var i = 0; i < lengthList; i++) {
			var idCheck = "#info__tbody__productCheck__" + i;
			var idHidden = "#productId_" + i;
			
			if($(idCheck).is(":checked")) {
				console.log(i);
				product_id += $(idHidden).val() + ",";
			}
			console.log(product_id);
		}
		product_id = product_id.substring(9);
		location.href = "AllOrder?product_id=" + product_id;
	}
	
	function countUp(i) {
		$("#inputCount_" + i).val(parseInt($("#inputCount_" + i).val()) + 1);
		
		var pattPrice = commaPrice($("#price_" + i).val() * $("#inputCount_" + i).val());
		$("#totalPrice_" + i).html("<strong>"+ pattPrice+"원</strong>");
	}
	
	function countDown(i) {
		if($("#inputCount_" + i).val() >= 2) {
		$("#inputCount_" + i).val($("#inputCount_" + i).val() - 1);
		
		var pattPrice = commaPrice($("#price_" + i).val() * $("#inputCount_" + i).val());
		
		$("#totalPrice_" + i).html("<strong>"+ pattPrice + "원</strong>");
		} else {
			alert("최소 주문 수량은 1개 입니다.");
		}
	}
	
	function commaPrice(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	function countUpdate(i) {
		var amount = $("#inputCount_" + i).val();
		var product_id = $("#productId_" + i).val();
		
		$.ajax({
			url: "/countUpdate",
			type: "post",
			datatype: "json",
			data: {amount : amount, product_id : product_id},
			success: function(data, status, xhr) {
				if(data.okAndFail == "ok") {
					location.reload();
				}
			},
			error: function(request, status, errorData) {
				
			}
		});
	}
</script>
<%-- -------- //JavaScript -------- --%>