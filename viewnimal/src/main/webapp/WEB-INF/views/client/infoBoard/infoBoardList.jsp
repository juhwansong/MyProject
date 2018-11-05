<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF/views/common/top.jsp" />

<link rel="stylesheet" href="/resources/each/css/infoBoardList.css?${verQuery}" />
<br>

<style>


</style>

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-infoBoardList">
		

		<div class="vm-section">

			<div class="vui-board">
				<%-- top --%>
				<div class="vui-board__box vui-board__box--t row">
					<div class="col">
						<button type="button" class="btn btn-default" onclick="location.href='InfoBoardWrite'">글쓰기</button>
					</div>

					<div class="col text-right">
						<div class="btn-group">
							<button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">말머리</button>
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

						<button type="button" class="btn btn-outline-primary">검색</button>
					</div>
				</div>
				<%-- //top --%>

				<%-- table --%>
				<div class="vui-table">
					<table class="table table-hover">
						<thead>
							<tr>
								<th scope="col" width="80">번호</th>
								<th scope="col" width="100">말머리</th>
								<th scope="col" colspan="2" ><!-- <span class="d-inline-block text-truncate" style="max-width: 150px;"> -->제목<!-- </span> --></th>
								<!-- <th scope="col">Handle</th>
								<th scope="col">First</th> -->
								<th scope="col" width="150">작성자</th>
								<th scope="col" width="150">작성일</th>
								<th scope="col" width="90">조회</th>
							</tr>
						</thead>
						
						<tbody>
							<tr>
								<th scope="row">10</th>
								<td>[etc]</td>
								<td colspan="2" class="text-truncate" style="max-width: 200px; "><a href="InfoBoardDetail" >Seems like everybody's got a price I wonder how they sleep at night When the sale comes first And the truth comes second Just stop for a minute and smile Why is everybody so serious Acting so damn mysterious Got shades on your eyes And your heels so high That you can't even have a good time</a></td>
								<td>Price Tag</td>
								<td>10-04</td>
								<td>10</td>
							</tr>
							<tr>
								<th scope="row">9</th>
								<td>[강아지]</td>
								<td colspan="2">Thornton</td>
								<td>Thornton</td>
								<td>@fat</td>
								<td>10</td>
							</tr>
							<tr>
								<th scope="row">8</th>
								<td>[고양이]</td>
								<td colspan="2">the Bird</td>
								<td>the Bird</td>
								<td>@twitter</td>
								<td>10</td>
							</tr>
							<tr>
								<th scope="row">7</th>
								<td>Mark</td>
								<td colspan="2">Otto</td>
								<td>Otto</td>
								<td>@mdo</td>
								<td>10</td>
							</tr>
							<tr>
								<th scope="row">6</th>
								<td>Jacob</td>
								<td colspan="2">Thornton</td>
								<td>Thornton</td>
								<td>@fat</td>
								<td>10</td>
							</tr>
							<tr>
								<th scope="row">5</th>
								<td>Larry</td>
								<td colspan="2">the Bird</td>
								<td>the Bird</td>
								<td>@twitter</td>
								<td>10</td>
							</tr>
							<tr>
								<th scope="row">4</th>
								<td>Mark</td>
								<td colspan="2">Otto</td>
								<td>Otto</td>
								<td>@mdo</td>
								<td>10</td>
							</tr>
							<tr>
								<th scope="row">3</th>
								<td>Jacob</td>
								<td colspan="2">Thornton</td>
								<td>Thornton</td>
								<td>@fat</td>
								<td>10</td>
							</tr>
							<tr>
								<th scope="row">2</th>
								<td>Larry</td>
								<td colspan="2">the Bird</td>
								<td>the Bird</td>
								<td>@twitter</td>
								<td>10</td>
							</tr>
							<tr>
								<th scope="row">1</th>
								<td>Mark</td>
								<td colspan="2">Otto</td>
								<td>Otto</td>
								<td>@mdo</td>
								<td>10</td>
							</tr>
						</tbody>
					</table>
				</div>
				<%-- //table --%>

				<%-- bottom --%>
				<div class="vui-board__box vui-board__box--b row">
					<div class="col">
						<button type="button" class="btn btn-primary">Primary</button>
					</div>

					<div class="col">
						<nav class="vui-navigation" aria-label="Page navigation example">
							<ul class="pagination justify-content-center">
								<li class="page-item disabled">
									<a class="page-link" href="#" tabindex="-1">
									<i class="fa fa-angle-left"></i>
									<span class="sr-only">Previous</span>
									</a>
								</li>
								<li class="page-item active"><a class="page-link" href="#">1</a></li>
								<li class="page-item"><a class="page-link" href="#">2</a></li>
								<li class="page-item"><a class="page-link" href="#">3</a></li>
								<li class="page-item"><a class="page-link" href="#">4</a></li>
								<li class="page-item"><a class="page-link" href="#">5</a></li>
								<li class="page-item"><a class="page-link" href="#">6</a></li>
								<li class="page-item"><a class="page-link" href="#">7</a></li>
								<li class="page-item"><a class="page-link" href="#">8</a></li>
								<li class="page-item"><a class="page-link" href="#">9</a></li>
								<li class="page-item"><a class="page-link" href="#">10</a></li>
								<li class="page-item">
									<a class="page-link" href="#">
									<i class="fa fa-angle-right"></i>
									<span class="sr-only">Next</span>
									</a>
								</li>
							</ul>
						</nav>
					</div>

					<div class="col text-right">
						<button type="button" class="btn btn-secondary">Secondary</button>
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
<%-- <script src="/resources/each/js/infoBoardList.js?${verQuery}"></script> --%>
<script>
	(function ($) {
		// do not remove this string
		"use strict";

		// javascript code here
	}(jQuery));
</script>
<%-- -------- //JavaScript -------- --%>