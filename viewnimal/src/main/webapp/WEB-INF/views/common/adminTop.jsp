<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file = "/WEB-INF/views/common/adminStart.jsp" %>

<div class="container body">
	<div class="main_container">
		<div class="col-md-3 left_col">
			<div class="left_col scroll-view">
				<div class="navbar nav_title" style="border: 0;">
					<a href="/AdminMain" class="site_title"><i class="fa fa-paw"></i> <span>VIEWNIM@L</span></a>
				</div>
				<div class="clearfix"></div>
				<!-- menu profile quick info -->
				<div class="profile clearfix">
					<div class="profile_pic">
						<img src="/resources/common/images/dog_01.png" alt="..." class="img-circle profile_img">
					</div>
					<div class="profile_info">
						<span>WELCOME !</span>
						<h2>${loginMemberDto.nickname}</h2>
					</div>
				</div>
				<!-- /menu profile quick info -->
				<br />
				<!-- sidebar menu -->
				<div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
					<div class="menu_section">
						<h3>General</h3>
						<ul class="nav side-menu">
							<li><a href="/AdminMain"><i class="fa fa-home"></i> Home</a></li>
							<li><a href="/AdminMember"><i class="fa fa-table"></i> 회원관리</a></li>
							<li><a href="/AdminQna"><i class="fa fa-edit"></i> QNA</a></li>
							<li><a href="/AdminDonationList"><i class="fa fa-sitemap"></i> 후원내역</a></li>
							<li><a href="/AdminAdoption"><i class="fa fa-bug"></i> 입양관리</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<!-- top navigation -->
		<div class="top_nav">
			<div class="nav_menu">
				<nav>
					<div class="nav toggle">
					  <a id="menu_toggle"><i class="fa fa-bars"></i></a>
					</div>
					
					<ul class="nav navbar-nav navbar-right">
						<li class="">
							<a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
							<img src="/resources/common/images/dog_01.png" alt="">
							${loginMemberDto.id}
							<span class=" fa fa-angle-down"></span>
							</a>
							<ul class="dropdown-menu dropdown-usermenu pull-right">
								<li><a href="/">Viewnimal 홈페이지로 이동</a></li>
								<li><a id="removeSession" href="/common/removeSession"><i class="fa fa-sign-out pull-right"></i> Log Out</a></li>
							</ul>
						</li>
					</ul>
				</nav>
			</div>
		</div>
		<!-- /top navigation -->