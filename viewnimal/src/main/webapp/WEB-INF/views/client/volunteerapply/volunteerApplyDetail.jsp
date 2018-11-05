<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF/views/common/top.jsp" />

<%-- <link rel="stylesheet" href="/resources/each/css/volunteerApplyDetail.css?${verQuery}" /> --%>

<style>
	.vm-volunteerApplyDetail #content-tag-area{
		min-height:400px;
		margin-left:20px;
		margin-top:10px;
	}  
	.vm-volunteerApplyDetail .vm-volunteerApplyDetail__content{
		margin-top:32px;
	} 
	.vm-volunteerApplyDetail .vm-volunteerApplyDetail__btn-box{
		display:flex; 
		flex-direction:row; 
		justify-content:center;
	}
	.vm-volunteerApplyDetail .vm-volunteerApplyDetail__btn-box__left{
		width:50%;
	}
	.vm-volunteerApplyDetail .vm-volunteerApplyDetail__btn-box__right{
		width:50%;
		text-align:right;
	}
	.vm-volunteerApplyDetail .vm-volunteerApplyDetail__head-icon-box{
		text-align:right;
		position: relative;
	}
	.vm-volunteerApplyDetail .vm-volunteerApplyDetail__title-th{
		font-size:25px;
	}
	.vm-volunteerApplyDetail .vm-volunteerApplyDetail__icon-th{
		vertical-align:middle;
	}
	.vm-volunteerApplyDetail .vm-volunteerApplyDetail__content-table tr > *{
		vertical-align: middle!important;
	}
	.vm-volunteerApplyDetail #volunteer-apply-insert-btn{
		display: none;
	}
	.vm-volunteerApplyDetail #volunteer-apply-delete-btn{
		display: none;
	}
	.vm-volunteerApplyDetail .volunteer-applier-list-box{
		margin-top: 30px;
		margin-bottom: 50px;
	}
	.vm-volunteerApplyDetail .volunteer-applier-table{
		font-size: 14px;
	}
	/* .vm-volunteerApplyDetail .volunteer-applier-table thead tr{
		background:#172b4d;
	} */
	.vm-volunteerApplyDetail #applier-list{
		display:none;
	}
	.vm-volunteerApplyDetail .applier-table-header{
		margin-top:30px;
	} 
	.vm-volunteerApplyDetail{
		word-break : break-all;
	}
</style>

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-volunteerApplyDetail">
		<div class="vm-section">
			<div class="vui-headline">자원봉사</div>
			<div class="vm-volunteerApplyDetail__content">			
				<table class="table vm-volunteerApplyDetail__content-table">
					<tr>
						<th class="vm-volunteerApplyDetail__title-th" colspan="2" width="72%">
							<c:choose>
								<c:when test="${requestScope.volunteerApplyDto.apply_state == '모집중'}">
									[<font style="color:#5b75e7;">${requestScope.volunteerApplyDto.apply_state}</font>]
								</c:when>
								<c:otherwise>
									[<font style="color:#f06199;">${requestScope.volunteerApplyDto.apply_state}</font>]
								</c:otherwise>
							</c:choose>
							${requestScope.volunteerApplyDto.title}
						</th>
						<th class="vm-volunteerApplyDetail__icon-th" width="28%">
							<div class="vm-volunteerApplyDetail__head-icon-box">
								<div style="position:absolute; width:600px; bottom:-12px; right:0px;">
									${requestScope.volunteerApplyDto.nickname}&nbsp;&nbsp;&nbsp;
									<i class="fa fa-clock-o"></i>${requestScope.volunteerApplyDto.write_date_format}
								</div>
							</div>	
						</th>				
					</tr>
					<tr>
						<th width="12%">봉사날짜</th>
						<td colspan="2" width="88%">${requestScope.volunteerApplyDto.volunteer_date}</td>			
					</tr>
					<tr>
						<th>모집기한</th>
						<td colspan="2">${requestScope.volunteerApplyDto.limit_date}</td>
					</tr>
					<tr>
						<th>봉사지</th>
						<td colspan="2">${requestScope.volunteerApplyDto.volunteer_area}</td>
					</tr>
					<tr>
						<th>모집인원</th>
						<td colspan="2">
							<c:choose>
								<c:when test="${requestScope.volunteerApplyDto.apply_count >= requestScope.volunteerApplyDto.apply_max_count}">
									<font style="color : #f06199;">${requestScope.volunteerApplyDto.apply_count}</font>
								</c:when>
								<c:otherwise>
									<font>${requestScope.volunteerApplyDto.apply_count}</font>
								</c:otherwise>
							</c:choose>														
							 / 
							<font>${requestScope.volunteerApplyDto.apply_max_count}</font>
							<!-- 관리자일때만 -->
							<c:if test="${sessionScope.loginMemberDto.type == 'ADMIN'}">
								<button id="applier-list-btn" style="margin-left: 60px;" class="btn btn-primary">
									<i class="fa fa-caret-down" aria-hidden="true"></i>
								</button>
							</c:if>
							
						</td>
					</tr>
					<tr>
						<td id="applier-list" colspan="3">			
							<%-- table --%>
							<div class="applier-table-header vm-volunteerApplyDetail__title-th">
								<font>신청자 리스트</font>
							</div>
							<div class="volunteer-applier-list-box">
								<div class="vui-table volunteer-applier-table">
									<table class="table" style="text-align: center;">
										<thead >
											<tr>
												<th width="17%" scope="col">No</th>
												<th width="27%" scope="col">닉네임</th>
												<th width="27%" scope="col">휴대폰 번호</th>
												<th width="30%" scope="col">e-mail</th>			
											</tr>
										</thead>					
										<tbody id="volunteer-applier-table-body-box"></tbody>														
									</table>
										<script id="applier-body-template" type="text/template">	
											<tr>
												<th scope="row"><@=data.no@></th>
												<td><@=data.nickname@></td>
												<td><@=data.phone@></td>
												<td><@=data.email@></td>						
											</tr>
										</script>
								</div>
								<%-- //table --%>
								<div class="vui-board__box vui-board__box--b row">
									<div class="col">
										<nav class="vui-navigation" aria-label="Page navigation example">
											<ul id="applier-pagination" class="pagination justify-content-center"></ul>
												<!-- 페이지네이션 템플릿 영역 시작 -->
												<script id="applier-prev-pagination-template" type="text/template">
													<li class="page-item <@=data.disabled@>">
														<a class="page-link volunteer-applier-prev" href="#" tabindex="-1">
														<i class="fa fa-angle-left"></i>
														<span class="sr-only">Previous</span>
														</a>
													</li>
												</script>
												<script id="applier-body-pagination-template" type="text/template">	
													<li class="page-item <@=data.active@>"><a class="<@=data.active@> page-link" href="#"><@=data.pageNumber@></a></li>
												</script>	
												<script id="applier-next-pagination-template" type="text/template">
													<li class="page-item <@=data.disabled@>">
														<a class="page-link volunteer-applier-next" href="#">
														<i class="fa fa-angle-right"></i>
														<span class="sr-only">Next</span>
														</a>
													</li>
												</script>
												<!-- /페이지네이션 템플릿 영역 끝 -->	
										</nav>
									</div>
								</div>								
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<div id="content-tag-area" style="margin-left:10%; width:976px;">${requestScope.volunteerApplyDto.content_tag}</div>
						</td>
					</tr>
					<tr>
						<td colspan="3" height="120px;">
							<!-- 목록,신청 등 버튼 영역 -->
							<div class="vm-volunteerApplyDetail__btn-box">
								<div class="vm-volunteerApplyDetail__btn-box__left">
									<button id="volunteer-apply-list-btn" class="btn btn-primary" type="button" style="outline: none;">목록</button>
								</div>
								
								<div class="vm-volunteerApplyDetail__btn-box__right">
							   		<button id="volunteer-apply-insert-btn"  class="btn btn-secondary" type="button" style="outline: none;">신청하기</button>
							   		<c:if test="${sessionScope.loginMemberDto.type == 'ADMIN'}">						   			
									   	<button id="volunteer-apply-modify-btn"  class="btn btn-secondary" type="button" style="outline: none;">수정</button>		
									</c:if>
									<button id="volunteer-apply-delete-btn"  class="btn btn-secondary" type="button" style="outline: none;">취소하기</button>
							   	</div>
							</div>
						</td>
					</tr>
				</table>
			</div>		
		</div>
	</div>
</div>

<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/volunteerApplyDetail.js?${verQuery}"></script> --%>
<script>
	(function ($) {
		// do not remove this string
		"use strict";	
		// javascript code here
		var applierStartPage = 1;
		
		//총 신청자 수가 0명이 아닐때 처음 페이지 로딩 시 1페이지 신청자 목록 가져오기
		if(${requestScope.volunteerApplyDto.apply_count} !== 0 && '${sessionScope.loginMemberDto.type}' === "ADMIN"){
			var initFormData = {volunteer_date :'${requestScope.volunteerApplyDto.volunteer_date}' , current_page : 1}
			
			loadBody(initFormData);	
		}
		
		//------------------페이지 버튼 클릭 이벤트 리스너 영역--------------------------------------
		//페이지 버튼 클릭 시(페이지네이션 태그에 공통으로 들어가 있는 page-link 클래스를 이용하여 해당 영역 클릭 이벤트 발생시 if문으로 처리)
		$(document).on("click", ".vm-volunteerApplyDetail .page-link", function(){
			event.preventDefault();
			
			var start_page = applierStartPage;
			var currentPage;
			
			//현재 페이지 버튼을 클릭 시
			if($(this).hasClass("active")){
				return false;
			}
			//이전 버튼 클릭시(이전 버튼이란걸 알기 위해 임의로 이전 버튼에 prev라는 클래스를 넣음)
			else if($(this).hasClass("volunteer-applier-prev")){
				currentPage = Number(start_page)-1;
			}
			//다음 버튼 클릭시
			else if($(this).hasClass("volunteer-applier-next")){
				currentPage = Number(start_page)+5;
			}
			//숫자 버튼 클릭 시
			else{
				currentPage = this.innerHTML;
			}
					
			var pageFormData = {volunteer_date :'${requestScope.volunteerApplyDto.volunteer_date}' , current_page : currentPage};				
			//전송할 데이터를 매개변수로 받는 함수 호출(이 함수안에서 아작스 통신 이뤄짐)
			loadBody(pageFormData);
		});
		//------------------/페이지 버튼 클릭 이벤트 리스너 영역 끝--------------------------------------
		
		
		//비회원이 아닐 때(회원일때) 
		if('${sessionScope.loginMemberDto.type}' === "USER"){
			
			App.loading.show(); //로딩 띄우기
			
			$.ajax({
				  url 		: '/selectCheckVolunteerApply'
				, type 		: 'post'
				, data		: {'volunteer_date' : '${requestScope.volunteerApplyDto.volunteer_date}'}
				, dataType 	: 'json'
				, async		: true
				, success 	: function ( data, status, xhr ) {
					//자원봉사 신청 상태가 0이면(신청을 안했으면) 신청하기 버튼 보이기
					if(data.checkApply == 0){
						$("#volunteer-apply-insert-btn").css("display", "inline-block");
					}
					//자원봉사 신청 상태가 1이면 (신청을 했으면) 신청 취소하기 버튼 보이기(모집마감된 글이 아니라면)
					//리턴값 1,0 처리는 디비에 설정한 프로시저 안에서 처리
					else if("${requestScope.volunteerApplyDto.apply_state}" !== "모집마감"){
						$("#volunteer-apply-delete-btn").css("display", "inline-block");
					}
				}
				, error 	: function ( xhr, status, error ) {
					alert('문제가 발생했습니다.\n다시 시도해주세요.');
				}
				, complete : function(xhr, status){
					App.loading.hide(); //로딩 끄기
				}
			});		
		}
		else if('${sessionScope.loginMemberDto.type}' !== "ADMIN"){
			$("#volunteer-apply-insert-btn").css("display", "inline-block");
		}
		
		$(document).on("click", "#volunteer-apply-list-btn", function(){
			//달력 리스트 ui는 굳이 페이지 번호를 물 필요성이 없어보여..
			location.href = "/VolunteerApplyList";
		});
		
		$(document).on("click", "#volunteer-apply-insert-btn", function(){
			//비회원일때
			if('${sessionScope.loginMemberDto.id}' === ""){
				alert("로그인 시 이용 가능한 서비스입니다.");
			}
			else{
				
				App.loading.show(); //로딩 띄우기
				
				$.ajax({
					  url 		: '/insertApplyVolunteer'
					, type 		: 'post'
					, dataType 	: 'json'
					, data 		: {'volunteer_date' : '${requestScope.volunteerApplyDto.volunteer_date}'}
					, async		: true
					, success 	: function ( data, status, xhr ) {
						if(data.resultValue == 1){
							alert("신청에 성공하셨습니다.");	
							$("#volunteer-apply-count").html(Number($("#volunteer-apply-count").html())+1);
						}
						else if(data.resultValue == 0){
							alert("인원이 가득찼습니다.");
						}
						else if(data.resultValue == 2){
							alert("모집 마감됐습니다.");
						}
						//새로고침
						location.reload();
					}
					, error 	: function ( xhr, status, error ) {
						alert('문제가 발생했습니다.\n다시 시도해주세요.');
					}
					, complete : function(xhr, status){
						App.loading.hide(); //로딩 끄기
					}
				});
			}
		});
		
		//글 수정하기
		$(document).on("click", "#volunteer-apply-modify-btn", function(){
				
			//자바스크립트에서 get 방식으로 보내기(개인적으로 post 방식으로 보낼 때 편한 방식)
			var form = document.createElement("form");
			var input = [];
			var parm = []; //input 태그안의 name,value값 설정
			//파라미터 추가
			parm.push(["volunteer_date", '${requestScope.volunteerApplyDto.volunteer_date}']);
	
			for(var i=0; i<parm.length; i++){
				input[i]=document.createElement("input");
				input[i].setAttribute("type", "hidden");
				input[i].setAttribute("name", parm[i][0]);
				input[i].setAttribute("value", parm[i][1]);
				form.appendChild(input[i]);
			}
			
			form.method = "get"; 
			form.action = "/VolunteerApplyModify";
			document.body.appendChild(form);
			form.submit();
			
		});
		
		//신청 취소 버튼 누를 시
		$(document).on("click", "#volunteer-apply-delete-btn", function(){
			
			App.loading.show(); //로딩 띄우기
			
			$.ajax({
				  url 		: '/deleteApplyVolunteer'
				, type 		: 'post'
				, dataType 	: 'json'
				, data 		: {'volunteer_date' : '${requestScope.volunteerApplyDto.volunteer_date}'}
				, async		: true
				, success 	: function ( data, status, xhr ) {
					if(data.result === "fail"){
						alert("취소에 실패하셨습니다.");
						
						return false;
					}
					
					alert("취소에 성공하셨습니다.");
					//새로고침
					location.reload();
				}
				, error 	: function ( xhr, status, error ) {
					alert('문제가 발생했습니다.\n다시 시도해주세요.');
				}
				, complete : function(xhr, status){
					App.loading.hide(); //로딩 끄기
				}
			});
		});
		
		
		// 아작스 통신을 통해 게시물 리스트 가져오고 + 페이지네이션 생성을 하는 함수
		function loadBody(pageData){
			
			pageData.applier_count = ${requestScope.volunteerApplyDto.apply_count};
			
			App.loading.show(); //로딩 띄우기
			
			$.ajax({
				  url 		: '/selectVolunteerApplierList'
				, type 		: 'post'
				, dataType 	: 'json'
				, data 		: pageData
				, async		: true
				, success 	: function ( data, status, xhr ) {
	
					//자바스크립트 전역 변수에 값 저장
					applierStartPage = data.infoMap.start_page;
										
					//----------바디 영역 게시판 목록 추가 작업 영역----------------				
					//신청자 리스트가 들어갈 tbody 박스
					var $applierBody = $("#volunteer-applier-table-body-box");
					
					//이전 게시글 목록 전부 지우기(이전에 아작스 통해 갖고 온 게시물 목록 데이터가 남아있으니 깨끗하게 비워줌)
					$applierBody.empty();
					
					//템플릿 태그에 지정된 아이디를 통하여 해당 변수에 템플릿 안에 저장된 값들을 담음
					var applierBodyStr = $("#applier-body-template").html();
		
					var applierBodyFun = _.template(applierBodyStr,{variable : 'data'});
					
					//아작스를 통해 갖고 온 보드 리스트 데이터 = data.list를 for문으로  게시물 리스트들을 담는 div 박스안에 순서대로 집어넣음
					for(var i=0; i<data.list.length; i++){
						var templateHtml = {	
								
							no : (data.infoMap.current_page-1) * 5 + (i + 1),
							nickname : data.list[i].nickname,
							phone : data.list[i].phone,
							email : data.list[i].email
										
						};
										
						$applierBody.append(
							applierBodyFun(templateHtml)
						);				
					}
									
					//페이지 네이션 추가 작업 영역//
					var $applierPagination = $("#applier-pagination");
					//이전 페이지네이션 전부 지우기
					$applierPagination.empty();//이전에 아작스로 넣은 값들이 남아있기때문에 다시 페이지네이션을 담는 div 박스안의 html코드를 깨끗하게 지워줌
					//페이지네이션 div박스 영역에 순서대로  이전 버튼 페이지네이션 -> 숫자 버튼 페이지네이션 -> 다음 버튼 페이지네이션  을  언더스코어의 템플릿 기능을 이용해 차곡차곡 넣어줌
					//이전 버튼(-10개)
					var prevPaginationStr = $("#applier-prev-pagination-template").html();
					var prevPaginationFun = _.template(prevPaginationStr, {variable : 'data'});
					
					if(Number(data.infoMap.start_page)- 5 >= 1){
						$applierPagination.append(prevPaginationFun({}));
					}
					else{
						$applierPagination.append(prevPaginationFun({disabled  : 'disabled'}));
					}
					
					//바디 페이지네이션
					var bodyPaginationStr = $("#applier-body-pagination-template").html();
					var bodyPaginationFun = _.template(bodyPaginationStr, {variable : 'data'});
					
					for(var i=data.infoMap.start_page; i<=data.infoMap.end_page; i++){
						if(Number(data.infoMap.current_page) === i){
							$applierPagination.append(bodyPaginationFun({pageNumber : i, active : 'active'}));
						}
						else{
							$applierPagination.append(bodyPaginationFun({pageNumber : i}));
						}
					}
					
					//다음 버튼(+10개)
					var nextPaginationStr = $("#applier-next-pagination-template").html();
					var nextPaginationFun = _.template(nextPaginationStr, {variable : 'data'});
					if(Number(data.infoMap.start_page)+5 <= Number(data.infoMap.max_page)){
						$applierPagination.append(nextPaginationFun({}));
					}
					else{
						$applierPagination.append(nextPaginationFun({disabled : 'disabled'}));						
					}
					//페이지네이션 추가 작업 영역 끝//
				}
				, error 	: function ( xhr, status, error ) {
					alert('문제가 발생했습니다.\n다시 시도해주세요.');
				}
				, complete : function(xhr, status){
					App.loading.hide(); //로딩 끄기
				}
			});
		}
		
		//신청자 보기 토글 버튼 클릭 시
		$(document).on("click", "#applier-list-btn", function(){
			if(${requestScope.volunteerApplyDto.apply_count} === 0){
				alert("신청자가 0명입니다.");
				return false;
			}
			$("#applier-list").slideToggle("fast"); //slideDown + slideUp 이 합쳐진 메소드		
		});
		
		
	}(jQuery));
</script>
<%-- -------- //JavaScript -------- --%>