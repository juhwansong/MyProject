<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.*" %>

<c:import url="/WEB-INF/views/common/top.jsp" />

<link rel="stylesheet" href="/resources/each/css/shopProductList.css?${verQuery}" />

<%-- -------- JSP -------- --%>
<div class="vm-container">
	
	<div class="vm-content vm-shopProductList"> 
		
		<div class="vm-section">
		<!-- 상품 갯수, 정렬 -->
		
		<!-- <div class="container"> -->
		  <!-- <div class="row vm-shopProductList__row__list"> -->
		    <!-- <div class=".col-xl-"> -->
		    	<!-- <div class="vm-shopProductList__list"> -->
					<div class="vm-shopProductList__menuRange">
						<div class="vm-shopProductList__menuRange__count">상품 개수 : <strong>${ listCount }</strong> 개</div>
						
						<ul class="vm-shopProductList__menuRange__ul">
							<li>
								<c:url var="newList" value="ProductList">
									<c:if test="${ category != null && category != '전체' }">
			    						<c:param name="category" value="${ category }" />
			    					</c:if>
									<c:param name="productList" value="1" />
								</c:url>
								<a class="${null == param.productList || 1 == param.productList ? 'on' : ''}" href="${ newList }">신상품</a>
							</li>
							
							<li>
								<c:url var="nameList" value="ProductList">
									<c:if test="${ category != null && category != '전체' }">
			    						<c:param name="category" value="${ category }" />
			    					</c:if>
									<c:param name="productList" value="2" />
								</c:url>
								<a class="${2 == param.productList ? 'on' : ''}" href="${ nameList }">상품명</a>
							</li>
							
							<li>
								<c:url var="rowList" value="ProductList">
									<c:if test="${ category != null && category != '전체' }">
			    						<c:param name="category" value="${ category }" />
			    					</c:if>
									<c:param name="productList" value="3" />
								</c:url>
								<a class="${3 == param.productList ? 'on' : ''}" href="${ rowList }" id="rowPrice">낮은가격</a>
							</li>
							
							<li>
								<c:url var="highList" value="ProductList">
									<c:if test="${ category != null && category != '전체' }">
			    						<c:param name="category" value="${ category }" />
			    					</c:if>
									<c:param name="productList" value="4" />
								</c:url>
								<a class="${4 == param.productList ? 'on' : ''}" href="${ highList }">높은가격</a>
							</li>
						</ul>
					</div>
				<!-- </div> -->
			<!-- </div> -->
		  <!-- </div> -->
		
		<!-- 상품 리스트 정렬 -->
		
		<div class="row vm-shopProductList__product">
			<c:forEach items="${ list }" var="p">
				<c:url var="ProductDetailPage" value="ProductDetail">
					<c:param name="productId" value="${ p.product_id }"></c:param>
				</c:url>
					
				<a href="${ ProductDetailPage }" class="col-md-3 vm-shopProductList__item">
					<div class="vm-shopProductList__item__inner">
						<div class="vm-shopProductList__item__img">
							<img src="/resources/images/product/main/${ p.main_img_name }">
						</div>
						
						<div class="vm-shopProductList__item__name">${ p.name }</div>
						<div class="vm-shopProductList__item__explain">${ p.explain }</div>
						<div class="vm-shopProductList__item__price">
							<fmt:formatNumber var="patternPrice" value="${ p.price }" pattern="#,###"/>
							${ patternPrice } 원
						</div>
					</div>
				</a>
			</c:forEach>
		</div>
		
		<nav class="vm-shopProductList__navigation" aria-label="Page navigation example">
		  <ul class="pagination justify-content-center">
		    <c:choose>
		    	<c:when test="${ currentPage eq 1 }">
		    		<li class="page-item disabled">
		      			<a class="page-link" href="#" tabindex="-1">
		       				<i class="fa fa-angle-left"></i>
		       				<span class="sr-only">Previous</span>
		      			</a>
		   			 </li>
		    	</c:when>
		    	<c:otherwise>
		    		<li class="page-item">
		    			<c:url var="prePl" value="ProductList">
		    				<c:param name="page" value="${ currentPage-1 }"></c:param>
		    				<c:if test="${ category != null && category != '전체' }">
		    					<c:param name="category" value="${ category }"></c:param>
		    				</c:if>
		    				<c:if test="${ requestScope.productList != null }">
		    					<c:param name="productList" value="${ requestScope.productList }" />
		    				</c:if>
		    			</c:url>
		      			<a class="page-link" href="${ prePl }">
		       				<i class="fa fa-angle-left"></i>
		       				<span class="sr-only">Previous</span>
		      			</a>
		   			 </li>
		    	</c:otherwise>
		    </c:choose>
		    
		    <c:forEach var="p" begin="${ startPage }" end="${ endPage }">
		    	<c:choose>
		    		<c:when test="${ p eq currentPage }">
		    			<li class="page-item active">
		    				<a class="page-link" href="#">${ p }</a>
		    			</li>
		    		</c:when>
		    		<c:otherwise>
		    			 <li class="page-item">
		    			 	<c:url var="noPl" value="ProductList">
		    					<c:param name="page" value="${ p }"></c:param>
		    					<c:if test="${ category != null && category != '전체' }">
		    						<c:param name="category" value="${ category }"></c:param>
		    					</c:if>
		    					
		    					<c:if test="${ requestScope.productList != null }">
		    						<c:param name="productList" value="${ requestScope.productList }" />
		    					</c:if>
		    				</c:url>
		    			 	<a class="page-link" href="${ noPl }">${ p }</a>
		    			 </li>
		    		</c:otherwise>
		    	</c:choose>
		    </c:forEach>
		    
		    <c:choose>
		    	<c:when test="${ currentPage == maxPage }">
		    		<li class="page-item">
		      			<a class="page-link" href="#">
		        			<i class="fa fa-angle-right"></i>
		        			<span class="sr-only">Next</span>
		     			</a>
		    		</li>
		    	</c:when>
		    	<c:otherwise>
		    		<li class="page-item">
		    		<c:url var="nextPl" value="ProductList">
		    			<c:param name="page" value="${ currentPage+1 }"></c:param>
		    			<c:if test="${ category != null && category != '전체' }">
		    				<c:param name="category" value="${ category }"></c:param>
		    			</c:if>
		    			
		    			<c:if test="${ requestScope.productList != null }">
		    				<c:param name="productList" value="${ requestScope.productList }" />
		    			</c:if>
		    		</c:url>
		      			<a class="page-link" href="${ nextPl }">
		        			<i class="fa fa-angle-right"></i>
		        			<span class="sr-only">Next</span>
		     			</a>
		    		</li>
		    	</c:otherwise>
		    </c:choose>
		   
		  </ul>
		</nav>
		
		<!-- </div> -->
		</div>
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/shopProductList.js?${verQuery}"></script> --%>
<script>
	(function ($) {
		// do not remove this string
		"use strict";
		
		// javascript code here
	}(jQuery));
</script>
<%-- -------- //JavaScript -------- --%>