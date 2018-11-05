<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF/views/common/top.jsp" />

<style>

.vm-labList .btn {
    bottom : 0px;
}
.vm-labList .page-item.active .page-link {
    z-index: 1;
    color: #fff;
    border-color: #172b4d;
    background-color: #172b4d;
}

.vm-labList .block-with-text {
    overflow: hidden;
    display: -webkit-box;
    -webkit-line-clamp: 7;
    -webkit-box-orient: vertical;
    color: #8898aa;
}

.vm-labList .block-with-text:hover {
	color: #8898aa;
}

.vm-labList .page-item.active .page-link {
    z-index: 1;
    color: #fff;
    border-color: #5b75e7;
    background-color: #5b75e7;
}

</style>





<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-labList">
		<div class="vm-section">
			<div class="vui-headline">
				연구소
			</div>
			
			<hr>

			<div class="vui-board">
				<%-- top --%>
				<div class="vui-board__box vui-board__box--t row">
					<c:if test="${sessionScope.loginMemberDto.type == 'ADMIN'}">
					<div class="col">
						<a href="/LabWrite"><button type="button" class="btn btn-primary">글쓰기</button></a>
					</div>
					</c:if>
				</div>




    <!-- Page Content -->
    <div class="container">

      <!-- Page Heading -->
      <h1 class="my-4">
        <small></small>
      </h1>
      
    
      <c:forEach items="${list}" var="lab">
	       <div class="row">
	        <div class="col-md-6">
		         <c:url var="labDetailPage" value="LabDetail">
					<c:param name="no" value="${lab.no}" />
				 </c:url>
	          <a href="${labDetailPage}">
	            <img class="img-fluid rounded mb-3 mb-md-0" src="${lab.thumbnail}" alt="" >
	          </a>
	        </div>
	        <div class="col-md-6">
	          <h2><a href="${labDetailPage}" style="color:#32325d; font-weight:bold;">${lab.title}</a></h2>
	          <br>
	          <br>
	         <div style="height:270px;"><a class="block-with-text" href="${labDetailPage}">${lab.content}</a></div>
	          <button class="btn btn-primary" type="button" onclick="location.href='${labDetailPage}'" style="position: absolute; right: 0;">더 읽어보기</button>
	        </div>
      </div>
      
       <hr>
      </c:forEach>
      



    </div>
    <!-- /.container -->





				<%-- bottom --%>
				<div class="vui-board__box vui-board__box--b row">
					<div class="col">
					</div>

					<div class="col">
						<nav class="vui-navigation" aria-label="Page navigation example">
							<ul class="pagination justify-content-center" id="pagination">
								<li class="page-item">
									<c:choose>
										<c:when test="${currentPage <= 1 }">
											<a class="page-item disabled" href="javascript:void(0)"><i class="fa fa-angel-left"></i></a>
										</c:when>
										<c:otherwise>
											<a class="page-link" href="Lab?page=1" ><i class="fa fa-angel-left"><</i></a>
										</c:otherwise>
									</c:choose>
									
									<c:forEach var="p" begin="${startPage}" end="${endPage}">
										<c:choose>
											<c:when test="${currentPage eq p }">
												<li class="page-item active"><a class="page-link" href="javascript:void(0)">${p}</a></li>
											</c:when>
											<c:otherwise>
												<li class="page-item"><a class="page-link" href="Lab?page=${p}">${p}</a></li>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									
									<li class="page-item">
										<c:choose>
											<c:when test="${currentPage >= maxPage }">
												<a class="page-link disabled" href="javascript:void(0)"><i class="fa fa-angel-right">></i></a>
											</c:when>
											<c:otherwise>
												<a class="page-link" href="Lab?page=${maxPage}"><i class="fa fa-angel-right">></i></a>
											</c:otherwise>
										</c:choose>
								
								
								</li>
							</ul>
						</nav>
					</div>

					<div class="col text-right">
					</div>
				</div>
			</div>

		</div>
	</div>
</div>

<br>
<br>
<br>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/labList.js?${verQuery}"></script> --%>
<script>
	(function ($) {
		// do not remove this string
		"use strict";
		
		

		// javascript code here
	}(jQuery));
</script>
<%-- -------- //JavaScript -------- --%>