<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF/views/common/top.jsp" />

<%-- <link rel="stylesheet" href="/resources/each/css/volunteerEpilogueList.css?${verQuery}" /> --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.2/css/bootstrap-select.min.css?${verQuery}">
<style type="text/css">
	.vm-volunteerEpilogueList .vm-volunteerEpilogueList__board-box{
		margin-bottom: 30px;
	}
	.vm-volunteerEpilogueList .vm-volunteerEpilogueList__board-box__border{
		width: 360px;
		height: 350px;
		border-radius: 5px;
		-moz-border-radius: 5px;
		-webkit-border-radius: 5px;
		border: 1px solid #ccc;
	}
	.vm-volunteerEpilogueList .vm-volunteerEpilogueList__board-box__border__img-box{
		position: relative;
		width: 100%;
		height: 250px;
		overflow:hidden;
		border-radius: 5px;
		-moz-border-radius: 5px;
		-webkit-border-radius: 5px;
	}

	.vm-volunteerEpilogueList .vm-volunteerEpilogueList__board-box__border__img-box__icon-box{
		position: absolute;
		width: 358px;
		top: 215px;
		height: 35px;
		background: rgba(0, 0, 0, .3);
		border-radius: 0 0 5px 5px;
		z-index:1;
	}

	.vm-volunteerEpilogueList .vm-volunteerEpilogueList__img-mover:hover{
		transform:scale(1.1);
		-webkit-transform:scale(1.1);
		-moz-transform:scale(1.1);
		-o-transform:scale(1.1);
		transition: all 0.1s linear;
	}

	.vm-volunteerEpilogueList .vm-volunteerEpilogueList__board-box__border__contents{
		margin: 10px;
	}

	.vm-volunteerEpilogueList .vm-volunteerEpilogueList__board-box__border__contents__table{
		border: 0;
		width: 100%;	
	}
	
	.vm-volunteerEpilogueList .vm-volunteerEpilogueList__board-box__border__contents__table_right-content{
		text-align:right;
		font-size: 12px; 
		vertical-aling:bottom;
		color: #666;
	}
	
	.vm-volunteerEpilogueList .vm-volunteerEpilogueList__board-box__border__contents__table h4{
		margin: 1px;
		font-size: 20px;
		font-weight: 600;
		max-width: 250px;
		max-height: 25px;	   
	    overflow: hidden; 
		text-overflow: ellipsis;
		white-space: nowrap; 
	}
	
	.vm-volunteerEpilogueList .vm-volunteerEpilogueList__board-box__border__contents__text{
		font-size: 14px;
		color: #888;
		max-height: 80px;
		display:-webkit-box;
	    -webkit-line-clamp:2;
	    -webkit-box-orient:vertical;
	    overflow:hidden;
	    text-overflow:ellipsis;
	}
	
	.vm-volunteerEpilogueList .vm-volunteerEpilogueList__board-box__border__img-box__icon-box__left{
		position: absolute;
		display:block;
		left:10px;
		padding: 8px 0 0 5px;
		color: white;
		opacity: .8;
	}
	
	.vm-volunteerEpilogueList .vm-volunteerEpilogueList__board-box__border__img-box__icon-box__right{
		position: absolute;
		display:block;
		right:10px;
		padding: 8px 0 0 5px;
		color: white;
		opacity: .8;
	}
	.vm-volunteerEpilogueList .vm-volunteerEpilogueList__board-box__border__img-box__img{
		object-fit: cover;
		width: 100%;
		height: 250px;
	}
	.vm-volunteerEpilogueList__my-content-btn{
		margin-right:8px;
	}
	#volunteer-epilogue-write-btn{
		margin-right:8px;
	}
	/* .vm-volunteerEpilogueList > .vm-section > hr{
		margin-top: 0px;
	} */
</style>
<%-- -------- JSP -------- --%>
<!-- 년도만 디비에서 뽑아오는게 아닌 최소 시작 년도를 정해서 현재 날짜의 년도까지 목록 보이게 -->
<% 
	request.setAttribute("currentYear", Calendar.getInstance().get(Calendar.YEAR)); 
%> 

<div class="vm-container">
	<div class="vm-content vm-volunteerEpilogueList">
		<div class="vm-section">
			<div class="vui-headline">자원봉사 후기</div>
			<hr>
			<!-- 검색 -->
			<%-- top --%>
			<div class="vui-board__box vui-board__box--t row">
				<div class="col">
					<c:if test="${sessionScope.loginMemberDto.type == 'USER'}">
						<button type="button" id="myboard-search" class="btn btn-outline-primary">내가 쓴 글 <i class="fa fa-search" aria-hidden="true"></i></button>
					</c:if>
				</div>
				<!-- 카테고리 영역 -->
				<div class="col text-right vm-volunteerEpilogueList__my-content-btn">		
					<div class="btn-group">
						<select id="selectpicker-year" name="selectpicker-year" class="selectpicker" data-style="btn-primary" data-width="120px">
							<c:forEach var="yearI" begin="2017" end="${requestScope.currentYear}">
								<c:choose>
									<c:when test="${yearI == requestScope.currentYear}">
										<option value="${yearI}" selected>${yearI}년</option>
									</c:when>
									<c:otherwise>
										<option value="${yearI}">${yearI}년</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>				
						</select>				
					</div>
		
					<div class="btn-group">
						<select id="selectpicker-month" name="selectpicker-month" class="selectpicker" data-style="btn-primary" data-width="100px">
							<option selected>전체</option>
						</select>
					</div>
					
					<div class="btn-group">
						<select id="selectpicker-date" name="selectpicker-date" class="selectpicker" data-style="btn-primary" data-width="100px">
							<option selected>전체</option>
						</select>
					</div>	
					<button type="button" id="volunteer-date-search-btn" class="btn btn-outline-primary">검색 <i class="fa fa-search" aria-hidden="true"></i></button>
				</div>
				<!-- /카테고리 영역 끝 -->
			</div>
			<%-- //top --%>
		
			<!-- 게시글 리스트 영역 시작 -->
			<!-- 언더스코어 템플릿 기능을 이용하여 해당 div 박스안에 동적으로 데이터 넣을 수 있음 -->
			<div id="epilogue-body" class="row"></div>
			
			<!-- 게시글 리스트 데이터 템플릿 -->
			<script id="epilogue-body-template" type="text/template">
				<div class="col-lg-4 col-sm-6 vm-volunteerEpilogueList__board-box">
					<div class="vm-volunteerEpilogueList__board-box__border"><!-- 카드 테두리 둥글게 -->
						<div class="vm-volunteerEpilogueList__board-box__border__img-box"><!-- 이미지 박스 -->
							<div class="vm-volunteerEpilogueList__board-box__border__img-box__icon-box"><!-- 이미지 하단 아이콘(조회수, 댓글수)영역 -->
								<span class="vm-volunteerEpilogueList__board-box__border__img-box__icon-box__left"> 
									<i class="fa fa-search"></i><@=data.read_count@><!-- 조회수 -->&nbsp;&nbsp;
									<i class="fa fa-commenting-o"></i><@=data.reply_count@><!-- 댓글 -->&nbsp;&nbsp;																		
								</span>
								<span class="vm-volunteerEpilogueList__board-box__border__img-box__icon-box__right">
									<i class="fa fa-clock-o"></i><@=data.write_date_format@><!-- 작성일 -->
								</span>							
							</div>
							<!-- 해당 게시물로 이동 -->
							<a href="/VolunteerEpilogueDetail?no=<@=data.no@>&current_page=<@=data.current_page@><@=data.date_keword@><@=data.myboard_search@>">
								<!-- 이미지 삽입 -->
								<img class="vm-volunteerEpilogueList__board-box__border__img-box__img vm-volunteerEpilogueList__img-mover" src="<@=data.thumbnail@>">
							</a>
						</div>
						<div class="vm-volunteerEpilogueList__board-box__border__contents"><!-- 본문영역 -->
							<table class="vm-volunteerEpilogueList__board-box__border__contents__table"><!-- 본문영역 테이블 지정 -->
								<tr>
									<td>
										<h4>
											<!-- 해당 게시물로 이동 -->
											<a href="/VolunteerEpilogueDetail?no=<@=data.no@>&current_page=<@=data.current_page@><@=data.date_keword@><@=data.myboard_search@>"><@=data.title@></a>
										</h4> <!-- 한글 최대 14글자 -->
			
									</td>
									<td class="vm-volunteerEpilogueList__board-box__border__contents__table_right-content">
										<@=data.nickname@><!-- 작성자 -->
									</td>
								</tr>
							</table>
							<p class="vm-volunteerEpilogueList__board-box__border__contents__text"><@=data.content@></p>
						</div>
					</div>
				</div>
			</script>		
			<!-- 게시물 리스트 영역 끝 -->
			
			<%-- bottom --%>
				<div class="vui-board__box vui-board__box--b row">
					
					<!-- 페이지네이션 영역 정렬을 위한 빈 박스-->
					<div class="col">
					</div>
					
					
					<div  class="col">
						<nav class="vui-navigation" aria-label="Page navigation example">
							<!--prev버튼 페이지네이션 박스(현재는 안에 아무 요소도 없는 빈박스지만 underscore의 script/template 태그박스를 이용하여 이영역에 넣음)-->
							<ul id="epilogue-pagination" class="pagination justify-content-center"></ul>
						</nav>
					</div>
					<!-- underscore의 script/template 태그박스(그냥 이상태론 페이지에 아무영역을 주지않는다. 말그대로 만들어놓은 템플릿을 갖다 쓰기 위한 편리한 기능) -->
					<!--  안에 동적으로 데이터 처리를 하고 싶을때 <@=넣을데이터@>태그를 이용하여 안에 편하게 동적으로 데이터를 넣을수있음 -->
					<script id="epilogue-prev-pagination-template" type="text/template">	
						<li class="page-item <@=data.disabled@>">
							<a class="page-link volunteerEpilogueList-prev" href="#" tabindex="-1">
							<i class="fa fa-angle-left"></i>
							<span class="sr-only">Previous</span>
							</a>
						</li>														
					</script>
					<!-- 페이지네이션 템플릿 -->
					<script id="epilogue-body-pagination-template" type="text/template">
						<li class="page-item <@=data.active@>"><a class="<@=data.active@> page-link" href="#"><@=data.pageNumber@></a></li>
					</script>
					<!-- next 버튼 페이지네이션 템플릿 -->
					<script id="epilogue-next-pagination-template" type="text/template">
						<li class="page-item <@=data.disabled@>">
							<a class="page-link volunteerEpilogueList-next" href="#">
							<i class="fa fa-angle-right"></i>
							<span class="sr-only">Next</span>
							</a>
						</li>	
					</script>
					<!-- /페이지네이션 영역 끝 -->
					
					<div class="col text-right">
						<c:if test="${sessionScope.loginMemberDto.id != null && sessionScope.loginMemberDto.type == 'USER'}">
						<button type="button" class="btn btn-secondary" id="volunteer-epilogue-write-btn" >글쓰기</button>
						</c:if>
					</div>
				</div>
				<%-- //bottom --%>
			
		</div>
	</div>
</div>
<!-- 히든 input 영역(현재 페이지 값과 검색 시 입력한 키워드 값 저장용(ajax로만 처리하는건 페이지 이동없이 현재 페이지에서 계속 유지되는거니 ajax통신 갔다와도 변수값도 계속 저장됨 -->
<!-- 굳이 input 히든으로 할 필요없이 자바스크립트에서 변수선언해서 저장해도 유지됨 -->
<input id="start_page" hidden="">
<input id="initcurrent-page" hidden="" value="${param.current_page}">
<input id="volunteer_keword" hidden="" value="${param.date_keword}">
<input id="volunteer_myboard_search" hidden="" value="${param.myboard_search}">
<!--  /히든 input 영역 끝 -->
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />
<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/volunteerEpilogueList.js?${verQuery}"></script> --%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.2/js/bootstrap-select.min.js?${verQuery}"></script>
<script>
	(function ($) {
		// do not remove this string
		"use strict";
		// javascript code here

		//-------------------카테고리 영역-----------------------------------------------------
		//처음 페이지 불러올 때 달 카테고리 가져옴
		//history.back()했을때 이전에 선택된 값들이 계속 선택되있어서 초기화
		$("select[name=selectpicker-year]").val("${requestScope.currentYear}");
		$("select[name=selectpicker-month]").val("전체");
		$("select[name=selectpicker-date]").val("전체");
		//------------------------/카테고리 영역 끝-----------------------------
		
		//처음 페이지 로딩 시 카테고리 월을 가져오는 함수 실행
		selectCategoryList($("select[name=selectpicker-year]").val());
		
		
		//---------------------------------처음 로딩 시 초기화 부분-------------------------------
		//처음 페이지 불러올 때 게시글 리스트 목록 + 페이지네이션 로딩
		var currentPageFormData = 1;
		//히스토리에 페이지 별로 저장(뒤로가기 가능하게)
		var renameURL = location.href;//아작스 처리 후 변경할 url이름
		renameURL = renameURL.split('?current_page=')[0];
		
		if($("#initcurrent-page").val() !== ""){
			currentPageFormData = $("#initcurrent-page").val();
		}
		renameURL += '?current_page=' + currentPageFormData;
		
		var volunteerFormData = {'current_page': currentPageFormData};	
		var sessionHistoryData = {flag : 'volunteerEpilogueList', current_page : currentPageFormData};		
		if($("#volunteer_keword").val() !== ""){		
			volunteerFormData.date_keword = $("#volunteer_keword").val();
			renameURL +='&date_keword=' + $("#volunteer_keword").val();
			sessionHistoryData.date_keword = $("#volunteer_keword").val();	
		}
		if($("#volunteer_myboard_search").val() !== ""){		
			volunteerFormData.myboard_search = $("#volunteer_myboard_search").val();
			renameURL +='&myboard_search=' + $("#volunteer_myboard_search").val();
			sessionHistoryData.myboard_search = $("#volunteer_myboard_search").val();	
		}
		//ajax로 전송할 데이터 정보를 히스토리 세션에 저장(새로 히스토리 저장을 하는 방식이 아닌 기존 히스토리를 바꿔치기 하는 방법)-안하면 새로고침 시 히스토리에 계속 쌓임
		history.replaceState(sessionHistoryData, 'volunteerEpilogueList', renameURL);		
		loadBody(volunteerFormData);	
		//-----------------------------/처음 로딩 시 초기화 부분 끝---------------------------------------
		
		
		
		//------------------페이지 버튼 클릭 이벤트 리스너 영역--------------------------------------
		//페이지 버튼 클릭 시(페이지네이션 태그에 공통으로 들어가 있는 page-link 클래스를 이용하여 해당 영역 클릭 이벤트 발생시 if문으로 처리)
		$(document).on("click", ".vm-volunteerEpilogueList .page-link", function(){
			event.preventDefault();
			
			var start_page = $("#start_page").val();
			var currentPage;
			
			//현재 페이지 버튼을 클릭 시
			if($(this).hasClass("active")){
				return false;
			}
			//이전 버튼 클릭시(이전 버튼이란걸 알기 위해 임의로 이전 버튼에 prev라는 클래스를 넣음)
			else if($(this).hasClass("volunteerEpilogueList-prev")){
				currentPage = Number(start_page)-1;
			}
			//다음 버튼 클릭시
			else if($(this).hasClass("volunteerEpilogueList-next")){
				currentPage = Number(start_page)+10;
			}
			//숫자 버튼 클릭 시
			else{
				currentPage = this.innerHTML;
			}
			
			
			//히스토리에 페이지 별로 저장(뒤로가기 가능하게)
			var renameURL = location.href;//아작스 처리 후 변경할 url이름
			renameURL = renameURL.split('?current_page=')[0];
			renameURL += '?current_page=' + currentPage;
			var sessionHistoryData = {flag : 'volunteerEpilogueList', current_page : currentPage};			
			if($("#volunteer_keword").val() !== ""){
				sessionHistoryData.date_keword = $("#volunteer_keword").val();
				renameURL += '&date_keword=' + $("#volunteer_keword").val();
			}		
			if($("#volunteer_myboard_search").val() !== ""){
				sessionHistoryData.myboard_search = $("#volunteer_myboard_search").val();
				renameURL += '&myboard_search=' + $("#volunteer_myboard_search").val();
			}
			//ajax로 전송할 데이터 정보를 히스토리 세션에 저장
			history.pushState(sessionHistoryData, 'volunteerEpilogueList', renameURL);		
			
			//전송할 데이터를 매개변수로 받는 함수 호출(이 함수안에서 아작스 통신 이뤄짐)
			loadBody(sessionHistoryData);
		});
		//------------------/페이지 버튼 클릭 이벤트 리스너 영역 끝--------------------------------------
		
		
		$(document).on("click", "#volunteer-epilogue-write-btn", function(){
			App.loading.show(); //로딩 띄우기
			$.ajax({
				  url 		: '/selectVolunteerEpiloguePossibleState'
				, type 		: 'post'
				, dataType 	: 'json'
				, async		: true
				, success 	: function ( data, status, xhr ) {
					if(data.resultMessage !== "success"){
						alert(data.resultMessage);
						return false;
					}
					location.href="/VolunteerEpilogueWrite";
				}
				, error : function ( xhr, status, error ) {
					alert('문제가 발생했습니다.\n다시 시도해주세요.');
				}
				, complete: function( xhr, status){
					App.loading.hide();//로딩 끝
				}
			});
		});
		
		//년 select 태그의 값이 변할때
		$(document).on("change", "#selectpicker-year", function(){
			//전체 옵션을 제외한 모든 옵션 제거
			//월 옵션 제거
			$("select[name=selectpicker-month] option").each(function(index, element){
				if(index != 0){
					element.remove();
				}
			});	
			//일 옵션도 제거
			$("select[name=selectpicker-date] option").each(function(index, element){
				if(index != 0){
					element.remove();
				}
			});	 
			selectCategoryList($("select[name=selectpicker-year]").val());		
		});
		//월 select 태그의 값이 변할때
		$(document).on("change", "#selectpicker-month", function(){
			//전체 옵션을 제외한 모든 옵션 제거
			$("select[name=selectpicker-date] option").each(function(index, element){
				if(index != 0){
					element.remove();
				}
			});
			selectCategoryList($("select[name=selectpicker-year]").val() + "-" + $("select[name=selectpicker-month]").val());			
		});
		
		//카테고리 목록 가져오는 함수
		function selectCategoryList(categoryKeword){
			$.ajax({
				  url 		: '/selectVolunteerEpilogueCategoryList'
				, type 		: 'post'
				, dataType 	: 'json'
				, data 		: {'categoryKeword' : categoryKeword}
				, async		: true
				, success 	: function ( data, status, xhr ) {
			
					for(var i=0 ; i<data.categoryList.length; i++){					
						if(categoryKeword.length === 4){ //보낸데이터가 연도일때(카테고리 달 목록을 가져올 때)
							$("#selectpicker-month").append('<option value="' + data.categoryList[i] + '">'+ data.categoryList[i] +'월</option>');	
						}
						else{ //카테고리 일 목록을 가져올 때
							$("#selectpicker-date").append('<option value="' + data.categoryList[i] + '">'+ data.categoryList[i] +'일</option>');	
						
						}
					}

					//selectpicker.js 사용시 live로 보여주려면 제공하는 refresh 값을 넣어야 된다.
					//가져온 데이터 정보가 없어도 지우고 나서 refresh 필요하기 때문에(여기서 한꺼번에 refresh 처리)
					if(categoryKeword.length === 4){ //보낸데이터가 연도일때(카테고리 달 목록을 가져올 때)
						$("#selectpicker-month").selectpicker("refresh");
					}				
					$("#selectpicker-date").selectpicker("refresh");
					
				}
				, error : function ( xhr, status, error ) {
					alert('문제가 발생했습니다.\n다시 시도해주세요.');
				}
			});
		}
		// 아작스 통신을 통해 게시물 리스트 가져오고 + 페이지네이션 생성을 하는 함수
		function loadBody(kewordData){
			
			App.loading.show(); //로딩 띄우기
			
			$.ajax({
				  url 		: '/selectSearchVolunteerEpilogue'
				, type 		: 'post'
				, dataType 	: 'json'
				, data 		: kewordData
				, async		: true
				, success 	: function ( data, status, xhr ) {
					//데이터가 없을 때(게시물 데이터가 없을때)					
					
					//hidden input에 값 저장(값 저장용 변수 용도)
					$("#start_page").val(data.infoMap.start_page);
										
					//----------바디 영역 게시판 목록 추가 작업 영역----------------				
					//게시글 리스트가 들어갈 div 박스
					var $epilogueBody = $("#epilogue-body");
					//이전 게시글 목록 전부 지우기(이전에 아작스 통해 갖고 온 게시물 목록 데이터가 남아있으니 깨끗하게 비워줌)
					$epilogueBody.empty();
					//템플릿 태그에 지정된 아이디를 통하여 해당 변수에 템플릿 안에 저장된 값들을 담음
					var epilogueBodyStr = $("#epilogue-body-template").html();
					//언더스코어에서 제공해주는 함수  (1번째 매개변수:탬플릿태그 안의 값, 2번째 매개변수:{variable : 'data'})- variable은 고유 키 이름이고
					//템플릿 안에 넣을 데이터 이름을 임의로 설정 -> {variable: 'dataList'}라고 선언했으면  템플릿안에 값을 주고 싶을땐 <@=dataList@>라는 식으로 쓰면 됨.
					var epilogueBodyFun = _.template(epilogueBodyStr,{variable : 'data'});
					//아작스를 통해 갖고 온 보드 리스트 데이터 = data.list를 for문으로  게시물 리스트들을 담는 div 박스안에 순서대로 집어넣음
					for(var i=0; i<data.list.length; i++){
						var templateHtml = {
							//변수 이름 (키 이름)  :   실제로 들어갈 값
							reply_count : data.list[i].reply_count,
							nickname : data.list[i].nickname,
							write_date_format : data.list[i].write_date_format,
							title : data.list[i].title,
							content : data.list[i].content,
							read_count : data.list[i].read_count,
							thumbnail : data.list[i].thumbnail,
							no : data.list[i].no,
							current_page : data.infoMap.current_page
						};
						if(kewordData.date_keword !== undefined){//날짜 카테고리 검색어가 있으면
							templateHtml.date_keword = '&date_keword=' + kewordData.date_keword;
						}
						if(kewordData.myboard_search !== undefined){
							templateHtml.myboard_search = '&myboard_search=' + kewordData.myboard_search;
						}
						$epilogueBody.append(
							epilogueBodyFun(templateHtml)
						);		
						//템플릿안에 동적으로 넣은 데이터 변수명을 보면 알겠지만, 아까 variable을 dataList라고 설정했으면 여기 선언된 reply_count키로 설정된 데이터를 넣고싶으면
						//템플릿안에 넣을땐 <@=dataList.reply_count@>라고 넣으면 됨
						//문법 ->  $(해당 데이터들을 담을 div박스).append(동적으로 넣은 데이터가 들어간 템플릿 html코드);
						//동적으로 넣은 데이터가 들어간 템플릿 html코드 (문법)->   
						//     _.template(템플릿박스에 들어간 html코드,{variable : '해당 템플릿안에서 쓸 변수이름'})({실제 템플릿안 변수에 담을 데이터(키(이름):실제데이터)})
					}
					
					//페이지 네이션 추가 작업 영역//
					var $epiloguePagination = $("#epilogue-pagination");
					//이전 페이지네이션 전부 지우기
					$epiloguePagination.empty();//이전에 아작스로 넣은 값들이 남아있기때문에 다시 페이지네이션을 담는 div 박스안의 html코드를 깨끗하게 지워줌
					//페이지네이션 div박스 영역에 순서대로  이전 버튼 페이지네이션 -> 숫자 버튼 페이지네이션 -> 다음 버튼 페이지네이션  을  언더스코어의 템플릿 기능을 이용해 차곡차곡 넣어줌
					//이전 버튼(-10개)
					var prevPaginationStr = $("#epilogue-prev-pagination-template").html();
					var prevPaginationFun = _.template(prevPaginationStr, {variable : 'data'});
					
					if(Number(data.infoMap.start_page)-10 >= 1){
						$epiloguePagination.append(prevPaginationFun({}));
					}
					else{
						$epiloguePagination.append(prevPaginationFun({disabled  : 'disabled'}));
					}
					
					//바디 페이지네이션
					var bodyPaginationStr = $("#epilogue-body-pagination-template").html();
					var bodyPaginationFun = _.template(bodyPaginationStr, {variable : 'data'});
					
					for(var i=data.infoMap.start_page; i<=data.infoMap.end_page; i++){
						if(Number(data.infoMap.current_page) === i){
							$epiloguePagination.append(bodyPaginationFun({pageNumber : i, active : 'active'}));
						}
						else{
							$epiloguePagination.append(bodyPaginationFun({pageNumber : i}));
						}
					}
					
					//다음 버튼(+10개)
					var prevPaginationStr = $("#epilogue-next-pagination-template").html();
					var prevPaginationFun = _.template(prevPaginationStr, {variable : 'data'});
					if(Number(data.infoMap.start_page)+10 <= Number(data.infoMap.max_page)){
						$epiloguePagination.append(prevPaginationFun({}));
					}
					else{
						$epiloguePagination.append(prevPaginationFun({disabled : 'disabled'}));						
					}
					//페이지네이션 추가 작업 영역 끝//
				}
				, error 	: function ( xhr, status, error ) {
					alert('문제가 발생했습니다.\n다시 시도해주세요.');
				}
				, complete: function( xhr, status){
					App.loading.hide();//로딩 끝
				}
			});
		}
		
		$(window).bind("popstate", function(event) {
			//state에 저장된 객체가 없을 수 있으니 !=null 조건 필요
			if(event.originalEvent.state != null && event.originalEvent.state.flag == 'volunteerEpilogueList'){	//뒤에 flag는 현재는 의미없음 flag나눠서 저장하고 싶을때 이용하면 될듯
				
				//이전 히스토리에 내 게시글 검색 키워드가 있고, 로그아웃을 한 상태일때(내 게시글 검색 페이지에 접근하기 위해선 세션 id가 있어야 하기 때문)
				if(event.originalEvent.state.myboard_search != null && '${sessionScope.loginMemberDto.id}' === ""){					
					delete(event.originalEvent.state.myboard_search); //로그아웃하고 뒤로 가기 했을때 state객체에서 myboard_search속성을 뺀 데이터를 아작스로 보냄
				}
			
				loadBody(event.originalEvent.state); //현재 히스토리에 저장된 state객체를 아작스를 통해 화면에 뿌려줌(페이지 이동과 같은 눈속임 효과)	
				
			}
		});
		
		//봉사날짜 검색 버튼 클릭 시
		$(document).on("click", "#volunteer-date-search-btn", function(){
			//다른 필터검색이기 때문에 기존에 내 게시물 검색 값이 남아있을 수 있으니 초기화
			$("#volunteer_myboard_search").val("");
			
			var categoryDateKeword = $("select[name=selectpicker-year]").val();
			var categoryMonth = $("select[name=selectpicker-month]").val();
			var categoryDate = $("select[name=selectpicker-date]").val();
			
			if(categoryMonth != '전체'){
				categoryDateKeword += "-" + categoryMonth;
			}
			if(categoryDate != '전체'){
				categoryDateKeword += "-" + categoryDate;
			}
		
			//히스토리에 페이지 별도 저장(뒤로가기 가능하게)
			var renameURL = location.href;//아작스 처리 후 변경할 url이름
			renameURL = renameURL.split('?current_page=')[0];
			renameURL += '?current_page=' + 1 + '&date_keword=' + categoryDateKeword;
					
			var sessionHistoryData = {flag : 'volunteerEpilogueList', current_page : 1};			
			sessionHistoryData.date_keword = categoryDateKeword;	
			
			//히든 인풋에 검색 카테고리 저장
			$("#volunteer_keword").val(categoryDateKeword);		
			
			//ajax로 전송할 데이터 정보를 히스토리 세션에 저장
			history.pushState(sessionHistoryData, 'volunteerEpilogueList', renameURL);		
			
			//전송할 데이터를 매개변수로 받는 함수 호출(이 함수안에서 아작스 통신 이뤄짐)
			loadBody(sessionHistoryData);
			
		});
		
		//내가 쓴 글 보기 버튼 클릭 시
		$(document).on("click", "#myboard-search", function(){
			//히스토리에 페이지 별도 저장(뒤로가기 가능하게)
			
			//다른 필터검색이기 때문에 기존에 내 게시물 검색 값이 남아있을 수 있으니 초기화
			$("#volunteer_keword").val("");
			
			var renameURL = location.href;//아작스 처리 후 변경할 url이름
			renameURL = renameURL.split('?current_page=')[0];
			renameURL += '?current_page=' + 1 + '&myboard-search=' + 'active';
					
			var sessionHistoryData = {flag : 'volunteerEpilogueList', current_page : 1};			
			sessionHistoryData.myboard_search = 'active';	
			
			//히든 인풋에 내 게시글 검색 상태키 저장
			$("#volunteer_myboard_search").val('active');	
						
			//ajax로 전송할 데이터 정보를 히스토리 세션에 저장
			history.pushState(sessionHistoryData, 'volunteerEpilogueList', renameURL);		
			
			//전송할 데이터를 매개변수로 받는 함수 호출(이 함수안에서 아작스 통신 이뤄짐)
			loadBody(sessionHistoryData);
		});
		
	}(jQuery));
	
</script>
<%-- -------- //JavaScript -------- --%>