<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF/views/common/top.jsp" />

<%-- <link rel="stylesheet" href="/resources/each/css/volunteerEpilogueDetail.css?${verQuery}" /> --%>

<style>
	.vm-volunteerEpilogueDetail #content-tag-area{
		min-height:400px;
		margin-left:20px;
		margin-top:10px;
	}  
	.vm-volunteerEpilogueDetail .vm-volunteerEpilogueDetail__content{
		margin-top:32px;
	} 
	.vm-volunteerEpilogueDetail .vm-volunteerEpilogueDetail__btn-box{
		display:flex; 
		flex-direction:row; 
		justify-content:center;
	}
	.vm-volunteerEpilogueDetail .vm-volunteerEpilogueDetail__btn-box__left{
		width:50%;
	}
	.vm-volunteerEpilogueDetail .vm-volunteerEpilogueDetail__btn-box__right{
		width:50%;
		text-align:right;
	}
	.vm-volunteerEpilogueDetail .vm-volunteerEpilogueDetail_reply-box{
		display:flex;	
		flex-direction:row;
	}
	.vm-volunteerEpilogueDetail .vm-volunteerEpilogueDetail_reply-box__write-box{ 
		width: 90%;
	}
	.vm-volunteerEpilogueDetail .vm-volunteerEpilogueDetail_reply-box__write-box__textarea{ 
		resize: none;
		width: 100%; 
		height: 80px;
		vertical-align: middle;
	}
	.vm-volunteerEpilogueDetail .vm-volunteerEpilogueDetail__reply-box__btn-box{ 
		width: 10%;	
		text-align: right;	
	}
	.vm-volunteerEpilogueDetail .vm-volunteerEpilogueDetail__reply-box__btn-box__btn{ 
		width: 90%; 
		height: 80px;
		font-size: 20px;
		letter-spacing: 5px; 
	}
	.vm-volunteerEpilogueDetail .vm-volunteerEpilogueDetail__content-table tr > *{
		vertical-align: middle!important;
	}
	.vm-volunteerEpilogueDetail .vm-volunteerEpilogueDetail__content-table__comment-text-td{
		margin-top : 3%;
		position:relative;
	}	
	.vm-volunteerEpilogueDetail .vm-volunteerEpilogueDetail__content-table__comment-text-td > label{
		position:absolute; 
		top:6%; 
		font-weight: bold; 
		font-size:15px;
	}
	.vm-volunteerEpilogueDetail .vm-volunteerEpilogueDetail__comment-box{
		margin-top: 10px; 
		margin-bottom: 10px;
	}
	.vm-volunteerEpilogueDetail .vm-volunteerEpilogueDetail__comment-box__write-info-box{
		display:flex; 
		flex-direction:row;
	}
	.vm-volunteerEpilogueDetail .info-box__left-box{
		width:50%;
	}
	.vm-volunteerEpilogueDetail .info-box__right-box{
		width:50%; 
		text-align:right;
	}
	.vm-volunteerEpilogueDetail .vm-volunteerEpilogueDetail__comment-box__content-box{
		margin-top:30px; 
		margin-right:5px;
	}	
	.vm-volunteerEpilogueDetail{
		word-break : break-all;
	}
</style>

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-volunteerEpilogueDetail">
		<div class="vm-section">
			<div class="vui-headline">자원봉사 후기</div>
			<div class="vm-volunteerEpilogueDetail__content">			
				<table id="epilogue-comment-box" class="table vm-volunteerEpilogueDetail__content-table">
					<tr>
						<th width="12%">no.${requestScope.volunteerEpilogueDetailData.no}</th>
						<th width="*">${requestScope.volunteerEpilogueDetailData.title}</th>
						<th width="28%" style="text-align: right;">
							<div style="position: relative;">
							 	<div style="position:absolute; width:600px; bottom:-11px; right:0px;">
									<font>${requestScope.volunteerEpilogueDetailData.nickname}</font>
									&nbsp;&nbsp;&nbsp;
									<i class="fa fa-search"></i>${requestScope.volunteerEpilogueDetailData.write_date_format}&nbsp;&nbsp;&nbsp;
									<i class="fa fa-clock-o"></i>${requestScope.volunteerEpilogueDetailData.read_count}
								</div>
							</div>
						</th>				
					</tr>
					<tr>
						<th>봉사날짜</th>
						<td colspan="2">${requestScope.volunteerEpilogueDetailData.volunteer_date}</td>	
					</tr>
					<tr>
						<th>봉사지</th>
						<td colspan="2">${requestScope.volunteerEpilogueDetailData.volunteer_area}</td>
					</tr>
					<tr>
						<td colspan="3">
							<div class="volunteer-comment-content" style="margin-left:10%; width:976px;" id="content-tag-area">			
								${requestScope.volunteerEpilogueDetailData.content_tag}
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="3" height="120px">
							<!-- 목록,신청 등 버튼 영역 -->
							<div class="vm-volunteerEpilogueDetail__btn-box">
								<div class="vm-volunteerEpilogueDetail__btn-box__left">
									<button type="button" id="volunteer-go-list-btn" class="btn btn-primary" style="outline: none;">목록</button>
								</div>
								<div class="vm-volunteerEpilogueDetail__btn-box__right">
									<!-- 작성자와 일치 시 -->
									<c:if test="${sessionScope.loginMemberDto.id == requestScope.volunteerEpilogueDetailData.id}">
							   			<button type="button" id="volunteer-epilogue-modify-btn" class="btn btn-secondary" style="outline: none;">수정</button>
							   		</c:if>
							   		<!-- 작성자와 일치하거나 관리자일시 -->
							   		<c:if test="${sessionScope.loginMemberDto.id == requestScope.volunteerEpilogueDetailData.id || sessionScope.loginMemberDto.type == 'ADMIN'}">	
							   			<button type="button" id="volunteer-epilogue-delete-btn" class="btn btn-secondary" style="outline: none;">삭제</button>
							   		</c:if>
							   	</div>
							</div>
						</td>
					</tr>			
					<!-- 댓글 갯수 영역 부분 -->
					<tr>
						<th height="100px" colspan="3">
							댓글&nbsp;<font id="epilogue-comment-count"></font>
						</th>
					</tr>
					<!-- /댓글 갯수 영역 부분 끝 -->
					
					<!-- 댓글 시작 들어가는부분-->
					
					<!-- /댓글 끝 -->						
				</table>
				
				
				
				<script id="epilogue-comment-template" type="text/template">
						<tr class="<@=data.comment_no@> epilogue-comment-real-box">				
							<th colspan="3">
								<div class="vm-volunteerEpilogueDetail__comment-box">
									<div class="vm-volunteerEpilogueDetail__comment-box__write-info-box">
									    <div class="info-box__left-box" style="">
									      <@=data.nickname@>&nbsp;&nbsp;
									      <i class="fa fa-clock-o"></i><@=data.write_date_format@>
									    </div>
									    <div class="info-box__right-box"> 
										<@if(data.sessionId == data.id){@>
									      <small><a href="#" onclick="updateCommentFunc('<@=data.comment_no@>', '<@=data.write_date_format@>'); return false;">수정</a></small>
										<@}@>
										<@if(data.sessionId == data.id || data.sessionType == 'ADMIN'){@>
									      <small><a href="#" onclick="deleteCommentFunc('<@=data.real_comment_no@>', '<@=data.current_page@>'); return false;">삭제</a></small>
										<@}@>
									    </div>
								    </div>
								    <div class="vm-volunteerEpilogueDetail__comment-box__content-box">
								    	<p class="volunteer-epilogue-reply-content"><@=data.reply_content@></p>
								    </div>						    	
							  	</div>
							</th>	
						</tr>				
					</script>
				
				<%-- bottom --%>
				<div class="vui-board__box vui-board__box--b row">				
					<div class="col">
						<!-- 페이지네이션 영역 -->
						<nav class="vui-navigation" aria-label="Page navigation example">
							<ul id="epilogue-pagination-box" class="pagination justify-content-center"></ul>
						</nav>
						<script id="prevPageTemplate" type="text/template">
							<li class="page-item <@=data.disabled@>">
								<a class="page-link volunteerEpilogueList-prev" href="#" tabindex="-1">
								<i class="fa fa-angle-left"></i>
								<span class="sr-only">Previous</span>
								</a>
							</li>
						</script>
						<script id="numberPageTemplate" type="text/template">
							<li class="page-item <@=data.active@>"><a class="page-link <@=data.active@>" href="#"><@=data.pageNumber@></a></li>
						</script>
						<script id="nextPageTemplate" type="text/template">
							<li class="page-item <@=data.disabled@>">
								<a class="page-link volunteerEpilogueList-next" href="#">
								<i class="fa fa-angle-right"></i>
								<span class="sr-only">Next</span>
								</a>
							</li>
						</script>
						<!-- /페이지네이션 영역 끝 -->
					</div>
				</div>
				<!-- 댓글 작성부분 -->
				<c:if test="${sessionScope.loginMemberDto.id != null}">
					<div id="volunteer-comment-insert-box" class="vm-volunteerEpilogueDetail__content-table__comment-text-td" height="200px">
						<!-- 댓글 입력창 영역 -->		
						<div class="vm-volunteerEpilogueDetail_reply-box">
							<div class="vm-volunteerEpilogueDetail_reply-box__write-box">
								<!-- chkword함수 이용 한글은 한글자가 2바이트기 때문에 200자 제한 x2 400바이트 -->									
								<textarea placeholder="글자 수 100자 제한입니다!" id="comment-text-area-id" onkeyup="chkword(this, 200, 'volunteer-comment-insert-btn')" class="comment-text-area vm-volunteerEpilogueDetail_reply-box__write-box__textarea" rows="2"></textarea>
							</div>
							
							<div class="vm-volunteerEpilogueDetail__reply-box__btn-box">
								<button id="volunteer-comment-insert-btn" class="btn btn-primary vm-volunteerEpilogueDetail__reply-box__btn-box__btn" type="button">등록</button>
							</div>
						</div>
						<!-- /댓글 입력창 영역 끝-->
					</div>	
				</c:if>					
				<!-- /댓글 작성부분 끝 -->
				<%-- //bottom --%>
				<!-- 수정버튼 클릭 시 바뀌는 텍스트 박스 템플릿 -->
				<script id="comment-update-template" type="text/template">		
				<tr class="<@=data.comment_no_write@> volunteer-epilogue-comment-enroll-box">						
					<th colspan="3">
						<div class="vm-volunteerEpilogueDetail__comment-box">
							<div class="vm-volunteerEpilogueDetail__comment-box__write-info-box">
								<div class="info-box__left-box" style="">
									<@=data.commentNickname@>&nbsp;&nbsp;
									     <i class="fa fa-clock-o"></i><@=data.write_date_format@>
								</div>
								<div class="info-box__right-box"> 
									
									<small><a href="#" id="update-comment-complete-btn" onclick="updateCommentInsertFunc('<@=data.comment_no@>', '<@=data.comment_no_write@>'); return false;">완료</a></small>
									<small><a href="#" id="cancel-comment-btn" onclick="cancelCommentInsertFunc('<@=data.comment_no@>','<@=data.comment_no_write@>'); return false;">취소</a></small>
								</div>
							</div>
							<div class="vm-volunteerEpilogueDetail__comment-box__content-box">
								<textarea id="comment-text-area-id" placeholder="글자 수 100자 제한입니다!" onkeyup="chkword(this, 200, 'update-comment-complete-btn', 'cancel-comment-btn')" class="vm-volunteerEpilogueDetail_reply-box__write-box__textarea" rows="2"><@=data.commentContentStr@></textarea>
							</div>						    	
						</div>
					</th>
				 </tr>								
				</script>			
			</div>			
		</div>
	</div>
</div>


<!-- 히든 input 영역(현재 페이지 값과 검색 시 입력한 키워드 값 저장용(ajax로만 처리하는건 페이지 이동없이 현재 페이지에서 계속 유지되는거니 ajax통신 갔다와도 변수값도 계속 저장됨 -->
<!-- 굳이 input 히든으로 할 필요없이 자바스크립트에서 변수선언해서 저장해도 유지됨 -->
<input id="start_page" hidden="">
<!--  /히든 input 영역 끝 -->
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/volunteerEpilogueDetail.js?${verQuery}"></script> --%>
<script>
	var parentBoardNumber = ${param.no};
	var volunteerEpilogueCommentCurrentPage = 1;//현재 페이지 저장 전역변수
	
	(function ($) {
		// do not remove this string
		"use strict";
		// javascript code here
		//전역변수에 해당 게시물번호 초기값
		
		
		//목록 버튼 누를시
		$(document).on("click", "#volunteer-go-list-btn", function(){
			
			var hrefStr = "/VolunteerEpilogueList?current_page=";
			
			if(${requestScope.volunteerEpilogueDetailData.current_page} !== 0){//컨트롤러에서 커맨드 객체에 current_page값을 설정안했을 시 int형 초기값인 0이 넘어옴
			//String형 초기값은 null, int는 0임	
				hrefStr += "${requestScope.volunteerEpilogueDetailData.current_page}";
			}
			else{
				hrefStr += "1";
			}
			if('${requestScope.volunteerEpilogueDetailData.myboard_search}' !== ''){
				hrefStr += '&myboard_search=${requestScope.volunteerEpilogueDetailData.myboard_search}';
			}
			if('${requestScope.volunteerEpilogueDetailData.date_keword}' !== ''){
				hrefStr += "&date_keword=${requestScope.volunteerEpilogueDetailData.date_keword}";
			}
			
			location.href = hrefStr;
			
		});
		
		//처음 페이지 호출시 페이지 1 리스트 불러오기
		var commentInitData = {'no' : parentBoardNumber, 'current_page' : 1};
		loadBody(commentInitData);
		
		//------------------페이지 버튼 클릭 이벤트 리스너 영역--------------------------------------
		//페이지 버튼 클릭 시(페이지네이션 태그에 공통으로 들어가 있는 page-link 클래스를 이용하여 해당 영역 클릭 이벤트 발생시 if문으로 처리)
		$(document).on("click", ".vm-volunteerEpilogueDetail .page-link", function(event){
			event.preventDefault();
			
			var start_page = $("#start_page").val();
			var currentPage;
			
			//현재 페이지 버튼을 클릭 시
			if($(this).hasClass("active")){
				return;
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
			
			loadBody({'current_page' : currentPage, 'no' : parentBoardNumber});
		});
		//------------------/페이지 버튼 클릭 이벤트 리스너 영역 끝--------------------------------------
		//댓글 추가 영역
		$(document).on("click", "#volunteer-comment-insert-btn", function(event){
			
			var commentTextAreaVal = $(".comment-text-area").val().trim();
			
			if(commentTextAreaVal === ""){
				//alert("내용을 입력 해 주세요.");
				App.messagePop.show('내용을 입력 해 주세요.');
				$(".comment-text-area").val("");
				return false;
			}
			
			//글자 수 200바이트 제한
			if(!chkword(document.getElementById("comment-text-area-id"), 200)){
				return false;
			}
				
			$.ajax({
				  url 		: '/insertVolunteerEpilogueReply'
				, type 		: 'post'
				, dataType 	: 'json'
				, data 		: {
					'reply_content' : commentTextAreaVal,
					'no' : parentBoardNumber
				}
				, async		: true
				, success 	: function ( data, status, xhr ) {
					if(data.resultMessage === 'fail'){
						alert("등록에 실패하셨습니다.");
						return false;
					}
					$(".comment-text-area").val(""); //성공시 텍스트 에어리어 초기화
					App.messagePop.show('댓글이 등록됐습니다.');
					loadBody({'current_page' : 1, 'no' : parentBoardNumber}); //자신의 추가된 댓글 보이게 하게 위해 다시 아작스 호출(무조건 첫페이지)
				}
				, error 	: function ( xhr, status, error ) {
					alert('문제가 발생했습니다.\n다시 시도해주세요.');
				}
			});
			
		});		
		// /댓글 추가 영역 끝
		//자원봉사 후기 수정 버튼 클릭 시
		$(document).on("click", "#volunteer-epilogue-modify-btn", function(){
			//자바스크립트에서 get 방식으로 보내기(개인적으로 자바스크립트에서 post 방식으로 보낼때 가끔씩 유용한것 같음)
			var form = document.createElement("form");
			var input = [];
			var parm = []; //input 태그안의 name,value값 설정
			//파라미터 추가
			parm.push(["no", ${requestScope.volunteerEpilogueDetailData.no}]);
	
			for(var i=0; i<parm.length; i++){
				input[i]=document.createElement("input");
				input[i].setAttribute("type", "hidden");
				input[i].setAttribute("name", parm[i][0]);
				input[i].setAttribute("value", parm[i][1]);
				form.appendChild(input[i]);
			}
			
			form.method = "get"; 
			form.action = "/VolunteerEpilogueModify";
			document.body.appendChild(form);
			form.submit();
		});	
		
		//삭제 버튼 누를 시
		$(document).on("click", "#volunteer-epilogue-delete-btn", function(){
			if(!confirm("정말로 삭제하시겠습니까?")){
				return false;
			}
			
			App.loading.show(); //로딩 띄우기
			
			$.ajax({
				  url 		: '/updateNonActiveVolunteerEpilogue'
				, type 		: 'post'
				, dataType 	: 'json'
				, data 		: {
					'no' : ${requestScope.volunteerEpilogueDetailData.no},
					'volunteer_date' : '${requestScope.volunteerEpilogueDetailData.volunteer_date}',
					'id' : '${requestScope.volunteerEpilogueDetailData.id}'
				}
				, async		: true
				, success 	: function ( data, status, xhr ) {
					if(data.resultMessage === 'fail'){
						alert("삭제에 실패하셨습니다.");
						return false;
					}
					alert("삭제에 성공하셨습니다.");
					location.href = "/VolunteerEpilogueList";
				}
				, error 	: function ( xhr, status, error ) {
					alert('문제가 발생했습니다.\n다시 시도해주세요.');
				}
				, complete : function(xhr, status){
					App.loading.hide(); //로딩 끄기
				}
			});
		});
		
	}(jQuery));
	//댓글 수정 클릭 시 이벤트 함수
	function updateCommentFunc(comment_no, write_date_format){

		var commentContentStr = $("." +comment_no + " .volunteer-epilogue-reply-content").html();//댓글 내용 가져오기
		
		var commentUpdateTemplateStr = $("#comment-update-template").html();
		var commentUpdateTemplateFun = _.template(commentUpdateTemplateStr, {variable : 'data'});
		$("." + comment_no).after(commentUpdateTemplateFun(
				{
					commentContentStr : commentContentStr, 
					commentNickname : '${sessionScope.loginMemberDto.nickname}', 
					write_date_format : write_date_format,
					comment_no : comment_no,
					comment_no_write : comment_no + "-write"
	
				}
			)
		);	
		$("." +comment_no).css("display", "none");//기존 댓글 안보이게 숨기기(바로 지우지 않는 이유는 수정 화면에서 다시 취소 버튼 누를 시 보이게 하기 위해-조금이라도 효율적으로 처리하기 위해.. 안그러면 취소 버튼 누를때도 현재 페이지 댓글 리스트 다 불러야함.. 비효율..)
	}	
	
	//댓글 수정 창에서 취소버튼 클릭 시
	function cancelCommentInsertFunc(comment_no, comment_no_write){
		$("." + comment_no_write).remove();//댓글 수정 폼 삭제
		$("." + comment_no).css("display", "table-row");//기존 댓글 보이게 하기
	}
	
	//댓글 수정 완료 버튼 클릭 시 이벤트 함수
	function updateCommentInsertFunc(comment_no, comment_no_write){
		
		//해당 댓글번호 입력폼의 텍스트에리어 값 가져오기	
		var reply_content = $("." + comment_no_write + " .vm-volunteerEpilogueDetail_reply-box__write-box__textarea").val().trim();
		
		if(reply_content === ""){
			//alert("내용을 입력 해 주세요.");
			App.messagePop.show('내용을 입력 해 주세요.');
			return false;
		}
		
		App.loading.show(); //로딩 띄우기
		
		$.ajax({
			  url 		: '/updateVolunteerEpilogueReply'
			, type 		: 'post'
			, dataType 	: 'json'
			, data 		: {
				'reply_content' : reply_content,
				'no' : parentBoardNumber, //처음 페이지 진입 시 전역 변수에 저장한 글번호
				'reply_no' : comment_no.replace("epilogue-comment-", "")  //클래스이름으로 가공한 데이터를 다시 댓글 번호로 바꿈
			}
			, async		: true
			, success 	: function ( data, status, xhr ) {
				if(data.resultMessage === 'fail'){
					alert("댓글 수정에 실패하셨습니다.");
					return false;
				}
				//alert("댓글 수정에 성공하셨습니다.");
				App.messagePop.show('댓글 수정에 성공하셨습니다.');
				
				var epilogueCommentTemplateStr = $("#epilogue-comment-template").html();
				var epilogueCommentFun = _.template(epilogueCommentTemplateStr,{variable : 'data'});
				var commentDateFormat = getTimeStamp();
				var templateHtml = {					
					write_date_format : commentDateFormat,
					reply_content : reply_content,
					no : parentBoardNumber,
					nickname : '${sessionScope.loginMemberDto.nickname}',
					comment_no : comment_no, //댓글 박스에 해당 이름의 클래스 선언
					id : '${sessionScope.loginMemberDto.id}',
					sessionId : '${sessionScope.loginMemberDto.id}',
					real_comment_no : comment_no.replace("epilogue-comment-", "")
					
				};
				
				$("." + comment_no_write).remove(); //댓글 수정 창 지우기
				$("." + comment_no).addClass("deletePastComment"); //temp 변수 쓰는 용
				$(".deletePastComment").before(//현재 태그 바로 앞에 append, after는 현재 태그 바로 뒤에 append임		
					epilogueCommentFun(templateHtml)
				);	
				$(".deletePastComment").remove(); //수정 전 댓글창 지우기(지금 처리한 방법은 댓글 박스 새로 생성하는 방식인데 굳이 새로 생성안하고 수정 전 댓글창의 값만 바꿔치기 하고 다시 display 보이게 해도 됨)	
				//댓글 삭제, 인서트 와는 다르게 수정시엔 현재 댓글창의 정보만 바꾸면 되는것이기 때문에 댓글 리스트를 따로 다시 안불러옴(개인적으로 비효율인것같아서)
			}
			, error 	: function ( xhr, status, error ) {
				alert('문제가 발생했습니다.\n다시 시도해주세요.');
			}
			, complete : function(xhr, status){
				App.loading.hide(); //로딩 끄기
			}
		});
	}
	
	//댓글 삭제 클릭 시 이벤트 함수
	function deleteCommentFunc(comment_no, current_page){
		
		if(!confirm("댓글을 삭제하시겠습니까?")){
			return false;
		}
		
		$.ajax({
			  url 		: '/deleteVolunteerEpilogueReply'
			, type 		: 'post'
			, dataType 	: 'json'
			, data 		: {
				'no' : parentBoardNumber, //처음 페이지 진입 시 전역 변수에 저장한 글번호
				'reply_no' : comment_no
			}
			, async		: true
			, success 	: function ( data, status, xhr ) {
				if(data.resultMessage === 'fail'){
					alert("댓글 삭제에 실패하셨습니다.");
					return false;
				}
				//alert("댓글 삭제에 성공하셨습니다.");
				App.messagePop.show('댓글 삭제에 성공하셨습니다.');
					
				//삭제 성공하고 현재 페이지 리스트 다시 불러오기
				loadBody({'current_page' : volunteerEpilogueCommentCurrentPage, 'no' : parentBoardNumber});
			}
			, error 	: function ( xhr, status, error ) {
				alert('문제가 발생했습니다.\n다시 시도해주세요.');
			}
		});
	}
	
	// 아작스 통신을 통해 게시물 리스트 가져오고 + 페이지네이션 생성을 하는 함수
	function loadBody(commentData){
		
		App.loading.show(); //로딩 띄우기
		
		$.ajax({
			  url 		: '/selectVolunteerEpilogueReplyList'
			, type 		: 'post'
			, dataType 	: 'json'
			, data 		: commentData
			, async		: true
			, success 	: function ( data, status, xhr ) {
							
				//hidden input에 값 저장(값 저장용 변수 용도)
				$("#start_page").val(data.infoMap.start_page);
				//댓글 갯수 뿌려주기
				$("#epilogue-comment-count").html(data.infoMap.board_count);
				//페이지 이동 시 currentPage 전역변수에 저장
				volunteerEpilogueCommentCurrentPage = data.infoMap.current_page;
				 					
				 
				//----------바디 영역 게시판 목록 추가 작업 영역----------------				
				//게시글 리스트가 들어갈 div 박스
				var $epilogueCommentBox = $("#epilogue-comment-box");
				//이전 댓글 목록 전부 지우기(이전에 아작스 통해 갖고 온 게시물 목록 데이터가 남아있으니 깨끗하게 비워줌)
				$("#epilogue-comment-box .epilogue-comment-real-box").remove();
				
				//페이지 이동 이벤트 시 이전에 남아있는 수정 박스들도 삭제
				$(".volunteer-epilogue-comment-enroll-box").empty();
				
				//템플릿 태그에 지정된 아이디를 통하여 해당 변수에 템플릿 안에 저장된 값들을 담음
				var epilogueCommentTemplateStr = $("#epilogue-comment-template").html();
				//언더스코어에서 제공해주는 함수  (1번째 매개변수:탬플릿태그 안의 값, 2번째 매개변수:{variable : 'data'})- variable은 고유 키 이름이고
				//템플릿 안에 넣을 데이터 이름을 임의로 설정 -> {variable: 'dataList'}라고 선언했으면  템플릿안에 값을 주고 싶을땐 <@=dataList@>라는 식으로 쓰면 됨.
				var epilogueCommentFun = _.template(epilogueCommentTemplateStr,{variable : 'data'});
				//아작스를 통해 갖고 온 보드 리스트 데이터 = data.list를 for문으로  게시물 리스트들을 담는 div 박스안에 순서대로 집어넣음
				for(var i=data.list.length-1; i>=0; i--){
					var templateHtml = {
						
						//변수 이름 (키 이름)  :   실제로 들어갈 값
						write_date_format : data.list[i].write_date_format,
						reply_content : data.list[i].reply_content,
						no : data.list[i].no,
						nickname : data.list[i].nickname,
						comment_no : "epilogue-comment-" + data.list[i].reply_no, //댓글 박스에 해당 이름의 클래스 선언
						real_comment_no : data.list[i].reply_no, //삭제용 실제 번호
						id : data.list[i].id,
						sessionId : '${sessionScope.loginMemberDto.id}',
						current_page : data.infoMap.current_page,
						sessionType : '${sessionScope.loginMemberDto.type}'
					};
					
					$epilogueCommentBox.append(
							epilogueCommentFun(templateHtml)
					);		
					//템플릿안에 동적으로 넣은 데이터 변수명을 보면 알겠지만, 아까 variable을 dataList라고 설정했으면 여기 선언된 reply_count키로 설정된 데이터를 넣고싶으면
					//템플릿안에 넣을땐 <@=dataList.reply_count@>라고 넣으면 됨
					//문법 ->  $(해당 데이터들을 담을 div박스).append(동적으로 넣은 데이터가 들어간 템플릿 html코드);
					//동적으로 넣은 데이터가 들어간 템플릿 html코드 (문법)->   
					//     _.template(템플릿박스에 들어간 html코드,{variable : '해당 템플릿안에서 쓸 변수이름'})({실제 템플릿안 변수에 담을 데이터(키(이름):실제데이터)})
				}
				
				//페이지 네이션 추가 작업 영역//
				var $epiloguePaginationBox = $("#epilogue-pagination-box");
				//이전 페이지네이션 전부 지우기
				$epiloguePaginationBox.empty();//이전에 아작스로 넣은 값들이 남아있기때문에 다시 페이지네이션을 담는 div 박스안의 html코드를 깨끗하게 지워줌
				//페이지네이션 div박스 영역에 순서대로  이전 버튼 페이지네이션 -> 숫자 버튼 페이지네이션 -> 다음 버튼 페이지네이션  을  언더스코어의 템플릿 기능을 이용해 차곡차곡 넣어줌
				//이전 버튼(-10개)
				var prevPageTemplateStr = $("#prevPageTemplate").html();
				var prevPageTemplateFun = _.template(prevPageTemplateStr, {variable : 'data'});
				
				if(Number(data.infoMap.start_page)-10 >= 1){
					$epiloguePaginationBox.append(prevPageTemplateFun({}));
				}
				else{
					$epiloguePaginationBox.append(prevPageTemplateFun({disabled  : 'disabled'}));
				}
				
				//바디 페이지네이션
				var numberPageTemplateStr = $("#numberPageTemplate").html();
				var numberPageTemplateFun = _.template(numberPageTemplateStr, {variable : 'data'});
				
				for(var i=data.infoMap.start_page; i<=data.infoMap.end_page; i++){
					if(Number(data.infoMap.current_page) === i){
						$epiloguePaginationBox.append(numberPageTemplateFun({pageNumber : i, active : 'active'}));
					}
					else{
						$epiloguePaginationBox.append(numberPageTemplateFun({pageNumber : i}));
					}
				}
				
				//다음 버튼(+10개)
				var nextPageTemplateStr = $("#nextPageTemplate").html();
				var nextPageTemplateFun = _.template(nextPageTemplateStr, {variable : 'data'});
				if(Number(data.infoMap.start_page)+10 <= Number(data.infoMap.max_page)){
					$epiloguePaginationBox.append(nextPageTemplateFun({}));
				}
				else{
					$epiloguePaginationBox.append(nextPageTemplateFun({disabled : 'disabled'}));						
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
	
	//날짜 포맷 함수
	function getTimeStamp() {
  		var d = new Date();
	  	var s =
		    leadingZeros(d.getFullYear(), 4) + '-' +
		    leadingZeros(d.getMonth() + 1, 2) + '-' +
		    leadingZeros(d.getDate(), 2) + ' ' +
	
		    leadingZeros(d.getHours(), 2) + '시' +
		    leadingZeros(d.getMinutes(), 2) + '분'
		    //leadingZeros(d.getSeconds(), 2);

	 	return s;
	}
	function leadingZeros(n, digits) {
		var zero = '';
	  	n = n.toString();

	  	if (n.length < digits) {
	    	for (i = 0; i < digits - n.length; i++){
	      		zero += '0';
	    	}
	  	}
	  	return zero + n;
	}
	
	//글자수 제한 함수(바이트 제한)
	function chkword(obj, maxByte, idStr, escapeIdStr) {	 
        
		var strValue = obj.value;
        var strLen = strValue.length;
        var totalByte = 0;
        var len = 0;
        var oneChar = "";
        var str2 = "";
		
        if(window.event.keyCode == 13){ //엔터키 눌리면
        	// 엔터키가 눌렸을 때 실행할 내용
        	obj.value = strValue.replace(/\s+$/gim, '');  
        	//오른쪽 공백(\s)제거 -엔터 친 순간 오른쪽 공백이 생긴거니 제거해줘야 함(댓글 성공시엔 어차피 input의 value값을 비워줘서)
        	//해줄 필요 없지만  실패 할 경우는 엔터가 남아있음
        	$("#" + idStr).trigger("click");
        }
        else if(escapeIdStr !== undefined && window.event.keyCode == 27){//escape키 누르면 취소 트리거
        	$("#" + escapeIdStr).trigger("click");
        }
        for (var i = 0; i < strLen; i++){
            oneChar = strValue.charAt(i);
            if (escape(oneChar).length > 4){
                totalByte += 2;
            } else {
                totalByte++;
            }
 
            // 입력한 문자 길이보다 넘치면 잘라내기 위해 저장
            if (totalByte <= maxByte) {
                len = i + 1;
            }
        }
        // 넘어가는 글자는 자른다.
        if (totalByte > maxByte){
        	
            //alert(maxByte/2 + "자를 초과하여 입력 할 수 없습니다.");
            App.messagePop.show(maxByte/2 + '자를 초과하여 입력 할 수 없습니다.');
            
            str2 = strValue.substr(0, len);
            obj.value = str2;
            chkword(obj, 4000);
            return false;
        }
        return true;
    }

	
	
</script>
<%-- -------- //JavaScript -------- --%>