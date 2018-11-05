<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF/views/common/top.jsp" />

<link rel="stylesheet" href="/resources/each/css/streamingList.css?${verQuery}" />
<a href="/RealStreaming">진짜얌</a>


	<div class="container">

      <!-- Page Heading -->
      <h1 class="my-4">Page Heading
        <small>Secondary Text</small>
      </h1>

      <div class="row">
        <div class="col-lg-4 col-sm-6 portfolio-item">
          <div class="card h-100">
            <a href="/StreamingDetail"><!-- <img class="card-img-top" src="http://placehold.it/700x400" alt=""> -->
            	<!-- <video class="card-img-top" src="https://youtu.be/3gH1JH8xIhw" controls loop muted>브라우저가 지원하지 못할 시 표시할 내용</video> -->
            	<iframe class="card-img-top" src="https://www.youtube.com/embed/3gH1JH8xIhw" frameborder="0" allow="autoplay; encrypted-media"  allowfullscreen></iframe></a>
            <div class="card-body">
              <h4 class="card-title">
                <a href="/WEB-INF/views/client/streaming/streamingDetail.jsp">Project One</a>
              </h4>
              <p class="card-text">룰루랄라</p>
            </div>
          </div>
        </div>
        <div class="col-lg-4 col-sm-6 portfolio-item">
          <div class="card h-100">
            <a href="#"><!-- <img class="card-img-top" src="http://placehold.it/700x400" alt=""> -->
            	<iframe class="card-img-top" src="https://www.youtube.com/embed/D3ZFtSoWtRc" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe></a>
            <div class="card-body">
              <h4 class="card-title">
                <a href="#">계획대로 되고 있어</a>
              </h4>
              <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam viverra euismod odio, gravida pellentesque urna varius vitae.</p>
            </div>
          </div>
        </div>
        <div class="col-lg-4 col-sm-6 portfolio-item">
          <div class="card h-100">
            <a href="#"><img class="card-img-top" src="http://placehold.it/700x400" alt=""></a>
            <div class="card-body">
              <h4 class="card-title">
                <a href="#">Project Three</a>
              </h4>
              <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quos quisquam, error quod sed cumque, odio distinctio velit nostrum temporibus necessitatibus et facere atque iure perspiciatis mollitia recusandae vero vel quam!</p>
            </div>
          </div>
        </div>
        <div class="col-lg-4 col-sm-6 portfolio-item">
          <div class="card h-100">
            <a href="#"><img class="card-img-top" src="http://placehold.it/700x400" alt=""></a>
            <div class="card-body">
              <h4 class="card-title">
                <a href="#">Project Four</a>
              </h4>
              <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam viverra euismod odio, gravida pellentesque urna varius vitae.</p>
            </div>
          </div>
        </div>
        <div class="col-lg-4 col-sm-6 portfolio-item">
          <div class="card h-100">
            <a href="#"><img class="card-img-top" src="http://placehold.it/700x400" alt=""></a>
            <div class="card-body">
              <h4 class="card-title">
                <a href="#">Project Five</a>
              </h4>
              <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam viverra euismod odio, gravida pellentesque urna varius vitae.</p>
            </div>
          </div>
        </div>
        <div class="col-lg-4 col-sm-6 portfolio-item">
          <div class="card h-100">
            <a href="#"><img class="card-img-top" src="http://placehold.it/700x400" alt=""></a>
            <div class="card-body">
              <h4 class="card-title">
                <a href="#">Project Six</a>
              </h4>
              <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Itaque earum nostrum suscipit ducimus nihil provident, perferendis rem illo, voluptate atque, sit eius in voluptates, nemo repellat fugiat excepturi! Nemo, esse.</p>
            </div>
          </div>
        </div>
      </div>
      <!-- /.row -->

      <!-- Pagination -->
      <ul class="pagination justify-content-center">
        <li class="page-item">
          <a class="page-link" href="#" aria-label="Previous">
            <span aria-hidden="true">&laquo;</span>
            <span class="sr-only">Previous</span>
          </a>
        </li>
        <li class="page-item">
          <a class="page-link" href="#">1</a>
        </li>
        <li class="page-item">
          <a class="page-link" href="#">2</a>
        </li>
        <li class="page-item">
          <a class="page-link" href="#">3</a>
        </li>
        <li class="page-item">
          <a class="page-link" href="#" aria-label="Next">
            <span aria-hidden="true">&raquo;</span>
            <span class="sr-only">Next</span>
          </a>
        </li>
      </ul>

    </div>
























<hr>



<%-- -------- JSP -------- --%>
<!-- <div class="vm-container">
	<div class="vm-content vm-streamingList">
		스트리밍 리스트 페이지
	</div>
</div> -->
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/streamingList.js?${verQuery}"></script> --%>
<script>
	(function ($) {
		// do not remove this string
		"use strict";

		// javascript code here
	}(jQuery));
</script>
<%-- -------- //JavaScript -------- --%>