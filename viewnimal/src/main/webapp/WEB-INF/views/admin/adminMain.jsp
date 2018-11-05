<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- 세션에 계정 정보 없으면 메인으로 리다이렉트 --%>
<c:if test="${null == loginMemberDto || 'ADMIN' != loginMemberDto.type}">
	<c:redirect url = "/"/>
</c:if>

<c:import url="/WEB-INF/views/common/adminTop.jsp" />

<!-- iCheck -->
<link href="/resources/vendor/gentelella/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
<!-- bootstrap-progressbar -->
<link href="/resources/vendor/gentelella/vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css" rel="stylesheet">
<!-- JQVMap -->
<link href="/resources/vendor/gentelella/vendors/jqvmap/dist/jqvmap.min.css" rel="stylesheet"/>
<!-- bootstrap-daterangepicker -->
<link href="/resources/vendor/gentelella/vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">
<!-- Custom Theme Style -->
<link href="/resources/vendor/gentelella/build/css/custom.min.css?${verQuery}" rel="stylesheet">

<link rel="stylesheet" href="/resources/each/css/adminMain.css?${verQuery}" />

<%-- -------- JSP -------- --%>
<!-- page content -->
<div class="right_col vm-admin-content vm-adminMain" role="main">
	<!-- top tiles -->
	<div class="vm-adminMain__title">VIEWNIM@L Manager</div>

	<div id="volunteerApplyGraphList" style="display: none;">
		<c:forEach var="item" items="${selectVolunteerApplyGraphList}" varStatus="status">
			<ul>
				<li data-count="${item.count}"></li>
				<li data-apply-date="${item.apply_date}"></li>
			</ul>
		</c:forEach>
	</div>

	<div class="row tile_count vm-adminMain__sec">
		<div class="col-md-2 tile_stats_count">
			<span class="count_top"><i class="fa fa-user"></i> 회원</span>
			<div class="count">${memberCountMap.total}</div>
			<span class="count_bottom">
				<div>일반 <i class="green">${memberCountMap.normal}</i></div>
				<div>소셜 <i class="green">${memberCountMap.google}</i></div>
			</span>
		</div>
		<div class="col-md-2 tile_stats_count">
			<span class="count_top"><i class="fa fa-shopping-cart"></i> 상품</span>
			<div class="count">${productCountMap.total}</div>
			<span class="count_bottom">
				<div>사료 <i class="green">${productCountMap.feed}</i></div>
				<div>간식 <i class="green">${productCountMap.snack}</i></div>
				<div>용품 <i class="green">${productCountMap.goods}</i></div>
			</span>
		</div>
		<div class="col-md-2 tile_stats_count">
			<span class="count_top"><i class="fa fa-play-circle"></i> 채널</span>
			<div class="count">${channelCountMap.total}</div>
			<span class="count_bottom">
				<div>행성 <i class="green">${channelCountMap.d25}</i></div>
				<div>소녀 <i class="green">${channelCountMap.d26}</i></div>
				<div>곰이 <i class="green">${channelCountMap.d27}</i></div>
				<div>탱이 <i class="green">${channelCountMap.d28}</i></div>
			</span>
		</div>

		<div class="col-md-2 tile_stats_count">
			<span class="count_top"><i class="fa fa-video-camera"></i> 스트리밍</span>
			<div class="count">${streamingCountMap.total}</div>
		</div>
		<div class="col-md-2 tile_stats_count">
			<span class="count_top"><i class="fa fa-book"></i> 연구소</span>
			<div class="count">${labCountMap.total}</div>
		</div>
		<div class="col-md-2 tile_stats_count">
			<span class="count_top"><i class="fa fa-bell-o"></i> 공지사항</span>
			<div class="count">${noticeCountMap.total}</div>
		</div>
	</div>

	<div class="row tile_count vm-adminMain__sec">
		<div class="col-md-2 tile_stats_count">
			<span class="count_top"><i class="fa fa-heart"></i> 자원봉사</span>
			<div class="count">${volunteerApplyCountMap.total}</div>
			<span class="count_bottom">
				<div>모집중 <i class="green">${volunteerApplyCountMap.enable}</i></div>
				<div>모집마감 <i class="red">${volunteerApplyCountMap.disable}</i></div>
			</span>
		</div>
		<div class="col-md-2 tile_stats_count">
			<span class="count_top"><i class="fa fa-heart-o"></i> 봉사후기</span>
			<div class="count">${volunteerEpilogueCountMap.total}</div>
		</div>
		<div class="col-md-2 tile_stats_count">
			<span class="count_top"><i class="fa fa-paw"></i> 입양신청</span>
			<div class="count">${adoptionApplyCountMap.total}</div>
			<span class="count_bottom">
				<div>신청 <i class="green">${adoptionApplyCountMap.request}</i></div>
				<div>처리 <i class="green">${adoptionApplyCountMap.ing}</i></div>
				<div>완료 <i class="red">${adoptionApplyCountMap.end}</i></div>
			</span>
		</div>
		<div class="col-md-2 tile_stats_count">
			<span class="count_top"><i class="fa fa-users"></i> 입양후기</span>
			<div class="count">${adoptionReviewCountMap.total}</div>
		</div>
		<div class="col-md-2 tile_stats_count">
			<span class="count_top"><i class="fa fa-bars"></i> 자유게시판</span>
			<div class="count">${freeBoardCountMap.total}</div>
		</div>
		<div class="col-md-2 tile_stats_count">
			<span class="count_top"><i class="fa fa-ban"></i> CLOSE</span>
			<div class="count">0</div>
		</div>
	</div>
	<!-- /top tiles -->
	
	<div class="row vm-adminMain__sec">
	  <div class="col-md-12 col-sm-12 col-xs-12">
		<div class="dashboard_graph">

		  <div class="row x_title">
			<div class="col-md-6">
			  <h3>자원봉사 <small>신청 현황</small></h3>
			</div>
			<%-- <div class="col-md-6">
			  <div id="reportrange" class="pull-right" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc">
				<i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
				<span>December 30, 2014 - January 28, 2015</span> <b class="caret"></b>
			  </div>
			</div> --%>
		  </div>

		  <div class="col-xs-12">
			<div id="chart_plot_custom" class="demo-placeholder"></div>
		  </div>
		  
		  <div class="clearfix"></div>
		</div>
	  </div>

	</div>
</div>
<!-- //page content -->
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/adminBottom.jsp" />

<!-- Chart.js -->
<script src="/resources/vendor/gentelella/vendors/Chart.js/dist/Chart.min.js"></script>
<!-- gauge.js -->
<script src="/resources/vendor/gentelella/vendors/gauge.js/dist/gauge.min.js"></script>
<!-- bootstrap-progressbar -->
<script src="/resources/vendor/gentelella/vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
<!-- iCheck -->
<script src="/resources/vendor/gentelella/vendors/iCheck/icheck.min.js"></script>
<!-- Skycons -->
<script src="/resources/vendor/gentelella/vendors/skycons/skycons.js"></script>
<!-- Flot -->
<script src="/resources/vendor/gentelella/vendors/Flot/jquery.flot.js"></script>
<script src="/resources/vendor/gentelella/vendors/Flot/jquery.flot.pie.js"></script>
<script src="/resources/vendor/gentelella/vendors/Flot/jquery.flot.time.js"></script>
<script src="/resources/vendor/gentelella/vendors/Flot/jquery.flot.stack.js"></script>
<script src="/resources/vendor/gentelella/vendors/Flot/jquery.flot.resize.js"></script>
<!-- Flot plugins -->
<script src="/resources/vendor/gentelella/vendors/flot.orderbars/js/jquery.flot.orderBars.js"></script>
<script src="/resources/vendor/gentelella/vendors/flot-spline/js/jquery.flot.spline.min.js"></script>
<script src="/resources/vendor/gentelella/vendors/flot.curvedlines/curvedLines.js"></script>
<!-- DateJS -->
<script src="/resources/vendor/gentelella/vendors/DateJS/build/date.js"></script>
<!-- JQVMap -->
<script src="/resources/vendor/gentelella/vendors/jqvmap/dist/jquery.vmap.js"></script>
<script src="/resources/vendor/gentelella/vendors/jqvmap/dist/maps/jquery.vmap.world.js"></script>
<script src="/resources/vendor/gentelella/vendors/jqvmap/examples/js/jquery.vmap.sampledata.js"></script>
<!-- bootstrap-daterangepicker -->
<script src="/resources/vendor/gentelella/vendors/moment/min/moment.min.js"></script>
<script src="/resources/vendor/gentelella/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
<!-- Custom Theme Scripts -->
<script src="/resources/vendor/gentelella/build/js/custom.js?${verQuery}"></script>

<%-- -------- JavaScript -------- --%>
<script src="/resources/each/js/adminMain.js?${verQuery}"></script>
<script>
	(function ($) {
		// do not remove this string
		"use strict";

		// javascript code here
	}(jQuery));
</script>
<%-- -------- //JavaScript -------- --%>