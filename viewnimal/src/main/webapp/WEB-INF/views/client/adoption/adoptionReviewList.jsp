<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.vm-adoptionReviewList__table {
	margin: 0 auto 0 auto;
}
.vm-adoptionReviewList__table tr td img {
	width: 410px;
	height: 500px;
	border-radius: 15px;
}
.vm-adoptionReviewList__img {
	opacity: 1;
    transition: opacity .25s ease-in-out;
}
.vm-adoptionReviewList__img:hover {
	opacity: 0.8;
}
.vm-adoptionReviewList__div {
	width: 100%;
	height: 100%;
	padding: 40px;	
}

</style>
<c:import url="/WEB-INF/views/common/top.jsp" />

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-section">
		<div class="vm-content vm-adoptionReviewList">
		<div class="vui-headline">입양 후기 리스트</div>

		<hr>
		

			<table class="vm-adoptionReviewList__table">
				<tr>
					<c:forEach items="${ requestScope.reviewList }" var="review" varStatus="status">
						<c:if test="${ status.count ge 1 && status.count le 2 }">
						<td>
							<div class="vm-adoptionReviewList__div">
								<input type="hidden" value="${ review.pet_id }" id="pet_id">
								<input type="hidden" value="${ review.no }" id="review_no">
								<a href="AdoptionReviewDetail?pet_id=${ review.pet_id }&no=${ review.no }" id="reviewDetail" style="color: #555;">
									<img class="vm-adoptionReviewList__img"
									src="resources/images/adoption/${ review.image }"/>
								<br>
								<center><br>
									${ review.bdetail }<b>
									${ review.name }</b><br>
									${ review.write_date } &nbsp; <i class="fa fa-eye" aria-hidden="true"></i>${ review.count }
								</center></a>
							</div>
						</td>
						</c:if>
					</c:forEach>					
				</tr>
				<tr>
					<c:forEach items="${ requestScope.reviewList }" var="review" varStatus="status">
						<c:if test="${ status.count ge 3 && status.count le 4 }">
						<td>
							<div class="vm-adoptionReviewList__div">
								<input type="hidden" value="${ review.pet_id }" id="pet_id">
								<input type="hidden" value="${ review.no }" id="review_no">
								<a href="AdoptionReviewDetail?pet_id=${ review.pet_id }&no=${ review.no }" id="reviewDetail" style="color: #555;">
									<img class="vm-adoptionReviewList__img"
									src="resources/images/adoption/${ review.image }"/>
								<br>
								<center><br>
									${ review.bdetail }<b>
									${ review.name }</b><br>
									${ review.write_date } &nbsp; <i class="fa fa-eye" aria-hidden="true"></i>${ review.count }
								</center></a>
							</div>
						</td>
						</c:if>
					</c:forEach>					
				</tr>
			</table>
		</div>

		<div class="vui-board__box vui-board__box--b row">
			<div class="col">
					
			</div>
		
			<div class="col">
				<nav class="vui-navigation" aria-label="Page navigation example">
					<ul class="pagination justify-content-center">
						<c:if test="${ requestScope.prev }">
							<li class="page-item">
								<a class="page-link" href="javascript:page(${ currentPage - 1 });" tabindex="-1">
								<i class="fa fa-angle-left"></i>
								<span class="sr-only">Previous</span>
								</a>
							</li>
						</c:if>
						<c:forEach begin="${ startPage }" end="${ endPage }" var="pageIdx">
							<c:choose>
								<c:when test="${ currentPage eq pageIdx }">
									<li class="page-item active"><a class="page-link" href="javascript:page(${ pageIdx });">${ pageIdx }</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a class="page-link" href="javascript:page(${ pageIdx });">${ pageIdx }</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${ requestScope.next }">
							<li class="page-item">
							<c:if test="${ requestScope.totalPage eq requestScope.currentPage }">
								<a class="page-link" href="#">
								<i class="fa fa-angle-right"></i>
								<span class="sr-only">Next</span>
								</a>
							</c:if>
							<c:if test="${ requestScope.totalPage ne requestScope.currentPage }">
								<a class="page-link" href="javascript:page(${ currentPage + 1 });">
								<i class="fa fa-angle-right"></i>
								<span class="sr-only">Next</span>
								</a>
							</c:if>	
							</li>
						</c:if>
					</ul>
				</nav>
			</div>	
			
			<div class="col text-right">

			</div>								
		</div>	
		<br><br><br>		
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<script>
	
	function page(pageIdx){
		
		var nowPage = pageIdx;
		location.href = "/AdoptionReviewPage?currentPage="+pageIdx+"&limit=4";	
	}; //page()
</script>
<%-- -------- //JavaScript -------- --%>