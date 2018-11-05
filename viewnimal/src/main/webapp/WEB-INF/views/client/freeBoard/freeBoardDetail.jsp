<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/common/top.jsp" />

<link rel="stylesheet" href="/resources/each/css/freeBoardDetail.css?${verQuery}" />

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-freeBoardDetail">
		
		<div class="vm-section">

			<div class="vui-headline">자유게시판</div>

			<div class="vm-freeBoardDetail__detail-wrapper">

					<div class="vm-freeBoardDetail__dateil__wrapper list-group-item list-group-item-action flex-column align-items-start">

					   <div class="d-flex w-100 justify-content-between">
						 <h5 class="mb-1 vm-freeBoardDetail__title"><sapn>${freeBoardDto.no }&nbsp;&nbsp;</sapn><span><span>${freeBoardDto.category }&nbsp;&nbsp;</span><span>${freeBoardDto.title }</span></h5>
						 <small class="text-muted"><span class="vm-freeBoardDetail__detail__writer">${freeBoardDto.nickname }</span><span class="vm-freeBoardDetail__detail__date">${freeBoardDto.write_date }</span><span class="vm-freeBoardDetail__detail__readcount">조회 ${freeBoardDto.read_count }</span></small>
					  </div>
					   <hr>
					   <div class="vm-freeBoardDetail__detail__content">${freeBoardDto.content_tag }</div>
					   
				<hr>
				<div class="vm-freeBoardDetail__detail__reply-wrapper">
					<div class="vm-freeBoardDetail__detail__reply-totalcount">
						댓글 0<%-- 댓글 수 --%>
					</div>
					<br>
					<c:if test="${ !empty loginMemberDto}">
						<div class="vm_freeBoardDetail__detail__reply-write-wrapper">
							<div class="vm-freeBoardDetail__detail__reply-write">
								<textarea class="vm-freeBoardDetail__detail__reply-write__textarea" rows="2"></textarea>
							</div>
							<div class="vm-freeBoardDetail__detail__reply-btn-wrapper">
								<button class="vm-freeBoardDetail__detail__reply-btn" id="replyRegBtn" type="button">등록</button>
							</div>
						</div>
					</c:if>
				</div>
					<div class="vm-freeBoardDetail__detail__reply-read">
						<%-- 댓글 내용 --%>
					</div>

					<div class="col vm-freeBoardDetail__detail__pagination">
						<%-- 페이징 처리 --%>
					</div>
	

				</div>
				
					<div class="col text-center vm-freeBoardDetail__detail-list-btn-wrapper">
						<c:if test="${ sessionScope.loginMemberDto.id eq freeBoardDto.id }">
						
						<form action="FreeBoardWrite" method=POST>
							<input type="hidden" name="type" value="update">
							<input type="hidden" name="no" value="${freeBoardDto.no }">
							<input type="hidden" name="category" value="${freeBoardDto.category }">
							<input type="hidden" name="title" value="${freeBoardDto.title }">
							<input type="hidden" name="content" value="${freeBoardDto.content }">
							<input type="hidden" name="content_tag" value='${freeBoardDto.content_tag }'>
							<button type="submit" class="btn btn-primary">수정</button>
						</form>
							<button type="button" class="btn btn-primary" id="deleteFreeBoardBtn">삭제</button>
						</c:if>
						 <form action="FreeBoardWrite" method=POST>
							<input type="hidden" name="type" value="reply">
							<input type="hidden" name="group_no" value="${freeBoardDto.group_no}">
							<input type="hidden" name="parent_no" value="${freeBoardDto.parent_no }">
							<input type="hidden" name="group_order" value="${freeBoardDto.group_order }">
							<input type="hidden" name="board_level" value="${freeBoardDto.board_level }">
							<button type="submit" class="btn btn-primary">댭글</button>
						</form> 
						<button type="button" class="btn btn-primary" onclick="location.href='FreeBoardList'">목록</button>
					</div>
				

				<%-- upper lower title --%>
			<!-- 	<div class="vm-freeBoardDetail__bottom-div mt-4 mb-5">
				<div class="vui-board__box vui-board__box--b row mt-0">
					<div class="ml-3" style="width:10%;">
						<a href="#"><i class="fa fa-chevron-up"></i>&nbsp;윗글</a>
					</div>
					
					<div class="col text-truncate">
						<a href="#">강아지 목욕은 어떻게 시키나요?</a>
					</div>
				
					<div class="col text-right mr-2">
						2018-09-12
					</div>
				</div>
				
				<hr class="mt-1 mb-1">
				<div class="vui-board__box vui-board__box--b row mt-0">
					<div class="ml-3" style="width:10%;">
						<a href="#"><i class="fa fa-chevron-down"></i>&nbsp;아래글</a>
					</div>
					
					<div class="col text-truncate">
						<a href="#">말줄임표 테스트중 일이삼사오육칠팔구십!일이삼사오육칠팔구십!일이삼사오육칠팔구십!일이삼사오육칠팔구십!일이삼사오육칠팔구십!일이삼사오육칠팔구십!</a>
					</div>
				
					<div class="col text-right mr-2">
						2018-09-12
					</div>
				</div>
			</div> -->
				<%-- //upper lower title --%>



			</div>
		</div>
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/freeBoardDetail.js?${verQuery}"></script> --%>

<%-- underscore template --%>
<%-- 댓글리스트 script --%>
<script id="replyTemplate" type="text/template">
<div class="vm-freeBoardDetail__reply-wrapper list-group">
	<div class="vm-freeBoardDetail__datail__reply-content-wrapper list-group-item list-group-item-action flex-column align-items-start">
		<div class="d-flex w-100 justify-content-between">
			<h5 class="mb-1"><@= data.nickname @></h5>
			<small>
				<span class="vm-freeBoardDetail__reply-date"><@= data.write_date @></span>
				<div class="vm-freeBoardDetail__reply-modified">
					<@ if( null !== data.loginUser && data.id === data.loginUser ) { @>
						<button type="button" class="vm-freeBoardDetail__reply-update" value="<@=data.no@>">수정</button>
						<button type="button" class="vm-freeBoardDetail__reply-delete" value="<@=data.no@>">삭제</button>
					<@ } @>
				</div>
			</small>
		</div>
		<p class="mb-1 vm_freeBoardDetail__reply-content"><@= data.reply_content@></p>
	</div>
</div>
</script>

<%-- 댓글 페이징 처리 --%>
<script id="pageTemplate" type="text/template">
<nav class="vui-navigation" aria-label="Page navigation example">
	<ul class="pagination justify-content-center vm_freeBoardDetail__datail__pagination-content">

		<@ if( ( data.startPage - data.printPage ) >= 1 ) { @>
			<li class="page-item">
				<a class="page-link" data-currentpage="<@= data.startPage - 1 @>" tabindex="-1">
					<i class="fa fa-angle-left"></i><span class="sr-only">Previous</span>
				</a>
			</li>
		<@ } @>
		<@ for( var i = data.startPage; i <= data.endPage; i++ ) { @>
			<@ if( data.currentPage === i ) { @>
				<li class="vm-freeBoardList__page-color page-item"><a class="page-link" data-currentpage="<@= i @>"> <@= i @> </a></li>
			<@ } else { @>
				<li class="page-item"><a class="page-link" data-currentpage="<@= i @>"> <@= i @> </a></li>
			<@ } @>
		<@ } @>
		<@ if( ( data.startPage + data.printPage ) <= data.totalPage ) { @>
			<li class="page-item">
				<a class="page-link" data-currentpage="<@= data.startPage + data.printPage @>">
					<i class="fa fa-angle-right"></i><span class="sr-only">Next</span>
				</a>
			</li>
		<@ } @>

	</ul>
</nav>
</script>

<script>
	(function ($) {
		// do not remove this string
		"use strict";
		
		// 댓글 리스트
		replySelectAjax();
		
		$(document).on('click', '.vm-freeBoardDetail .vui-navigation .page-link', function (e) {
			e.preventDefault();
			var $this = $(this);
			
			replySelectAjax( $this.data("currentpage") );
		});

		function replySelectAjax( currentPage ) {
			var dataObj = {
				'board_no' : ${freeBoardDto.no}
			};
			
			if ( 'undefined' !== currentPage ) {
				dataObj.currentPage = currentPage;
			}
			
			$.ajax({
				url: "/SelectListFreeBoardReply"
				, type: "get"
				, data: dataObj
				, dataTpye: "json"
				, success: function(data, status, xhr){

					//댓글 리스트 판형
					var tempStr = $("#replyTemplate").html(); // 템플릿 판형
					var tempFun = _.template(tempStr, { variable: 'data' }); // 템플릿 세팅 (아직 빈 껍데기)
					
					// 세팅된 변수에 객체를 담아서 호출하면 데이터가 들어간  html 을 반환  ex) tempFun( { id : 'foo', name : 'bar' } );

					$(".vm-freeBoardDetail__detail__reply-read").html('');
					for(var i = 0; i < data.list.length; i++ ){
						(function(i){
							
							var objData = {
								  nickname 			: decodeURIComponent(data.list[i].nickname)
								, write_date 		: data.list[i].write_date
								, reply_content 	: decodeURIComponent(data.list[i].reply_content).replace(/\+/g, ' ')
								, no 				: data.list[i].no
								, loginUser 		: '${loginMemberDto.id }'
								, id 				: data.list[i].id
							};
							
							$(".vm-freeBoardDetail__detail__reply-read").append( tempFun( objData ) );
							// tempFun( objData ) ->  동적으로 데이터 들어간  html 반환'
							
						}(i));
					}
					
					// 페이지네이션 판형
					var pageTempStr = $("#pageTemplate").html();
					var pageTempFun = _.template(pageTempStr, { variable: 'data' });
					
					
					// 이름이 같으면 데이터 가공할 필요 X. 그대로 값을 넘겨주고 변수명 그대로 사용.
					/* var pageObj  ={
							startPage 		: data.startPage
							, endPage		: data.endPage
							, printPage		: data.printPage
							, currentPage	: data.currentPage
							, totalPage		: data.totalPage
						}
					 */
					
					//제이쿼리 메서드 체인 
					$(".vm-freeBoardDetail__detail__pagination").html('').append( pageTempFun( data ) ); 
					
					/* $(".vm-freeBoardDetail__detail__pagination").html('');
					$(".vm-freeBoardDetail__detail__pagination").append( pageTempFun( pageObj ) );  */
					
					$(".vm-freeBoardDetail__detail__reply-totalcount").html('').html( '댓글 ' + data.totalCount );
					
					
				}, error : function(jqXHR, textstatus, errorThrown){
					console.dir("error : " + jqXHR + textstatus + errorThrown);
				}
			}); 
		}
		
		//댓글 수정
		$(document).on('click', '.vm-freeBoardDetail__reply-update', function (e) {
			var no = $(this).attr("value");
			var $replyWrapper = $(e.target).parents('.vm-freeBoardDetail__reply-wrapper');
			replyUpdate( no, $replyWrapper );
			console.log( $replyWrapper );
		});

		function replyUpdate( no, $replyWrapper ){
			
			var replyText = $replyWrapper.find('.vm_freeBoardDetail__reply-content').text();
			
			var value = '<div class="vm-freeBoardDetail__detail__reply-write">'
						+ 	'<textarea class="vm-freeBoardDetail__detail__reply-write__textarea" rows="2">'+ replyText +'</textarea>'
						+ '</div>'
						+ '<div class="vm-freeBoardDetail__detail__replyBtn-wrapper">'
						+	'<button class="vm-freeBoardDetail__reply-updateBtn btn btn-primary" id ="replyUpdateBtn" type="button">수정</button>'
						+	'<button class="vm-freeBoardDetail__reply-cancleBtn btn btn-primary" id ="replyCancleBtn" type="button">취소</button>'
						+ '</div>'
						;
						
			$('.vm_freeBoardDetail__detail__reply-write-wrapper').hide(0);
			$replyWrapper.html( value );
			
			$replyWrapper.find('#replyUpdateBtn').on('click', function () {
				$.ajax({
					url: "/UpdateFreeBoardReply",
					type:"get",
					data: { 
						  no: no
						, reply_content: $replyWrapper.find('.vm-freeBoardDetail__detail__reply-write__textarea').val()
					},
					success : function( data, status, xhr ){
						if( 1 === data.result)
						{
							alert("수정되었습니다.");
							location.reload();
						}
						else
						{
							alert("댓글 수정에 실패했습니다.\n다시 시도해주세요.")
						}

					}, error : function(jqXHR, textstatus, errorThrown){
						console.dir("error : " + jqXHR + textstatus + errorThrown);
					}
				});
			});

			$replyWrapper.find('#replyCancleBtn').on('click', function () {
				location.reload();
			});
		}
			
		//댓글 삭제
		$(document).on('click', '.vm-freeBoardDetail__reply-delete', function (e) {
			var no = $(this).attr("value");
			var $replyWrapper = $(e.target).parents('.vm-freeBoardDetail__reply-wrapper');
			replyDelete( no );
		});
		
		function replyDelete( no ){
			$.ajax({
				url: "/DeleteFreeBoardReply"
				, type:"get"
				, data: { no : no }
				, success: function( data ){
					if( 1 === data.result )
					{
						alert("삭제되었습니다.");
						location.reload();
						
					}
					else
					{
						alert("댓글 수정에 실패했습니다.\n다시 시도해주세요.")
					}
				}, error : function(jqXHR, textstatus, errorThrown){
					console.dir("error : " + jqXHR + textstatus + errorThrown);
				}
				
			});
		}
		
		//댓글 등록
		$("#replyRegBtn").on('click', function () {
			
			var $replyContent = $('.vm-freeBoardDetail__detail__reply-write__textarea');
			var userId = '${loginMemberDto.id }';
			
			if( null !== userId ) 
			{
				if( "" === $replyContent.val() )
				{
					alert("내용을 입력해주세요.");
				}
				else 
				{
					$.ajax({
						url : "/InsertFreeBoardReply",
						type : "post",
						data : { 
							reply_content: $replyContent.val()
							, id: userId
							, board_no: '${freeBoardDto.no }'
						},
						dataType : "json",
						success: function( data, stauts, xhr )
						{
							if ( 1 === data.result ) 
							{
								location.reload();
							}
							else
							{
								alert('문제가 발생했습니다.\n다시 시도해주세요.');
							}
						}, error : function(jqXHR, textstatus, errorThrown){
							console.dir("error : " + jqXHR + textstatus + errorThrown);
						}
					});
	
				}
			} 
			else 
			{
				console.log("여기로 와야지 왜안와");
				//왜안먹힘???????????
				var loginOk = confirm('로그인 후 이용 가능합니다. 로그인하시겠습니까?');
				if( loginOk )
				{
					alert("로그인~");
					/* location.href = '/login.jsp'; */
				}
			}
		});
		
		
		//글 삭제
		$("#deleteFreeBoardBtn").on("click", function(){

			if(  confirm('삭제하시겠습니까?') ){
				$.ajax({
					url: "updateNonActiveFreeBoard"
					, type: 'post'
					, data: { no: '${freeBoardDto.no}' }
					, dataTpye: 'json'
					, success : function( data ){
						var ifStatement = data.result === 1;

						if ( ifStatement ) 
						{
							alert("삭제되었습니다.");
							location.href="FreeBoardList";
						} 
						else 
						{
							alert('문제가 발생했습니다.\n다시 시도해주세요.');
						}

					}, error : function(jqXHR, textstatus, errorThrown){
						console.dir("error : " + jqXHR + textstatus + errorThrown);
					}
				});
			}
		});
		
		
		
		
 /* 		function replySelectAjax( ) {
			$.ajax({
				url: "/selectListFreeBoardReply"
				, type: "get"
				, data: {'board_no' : ${freeBoardDto.no}}
				, dataTpye: "json"
				, success: function(data, status, xhr){

					for(var i = 0; i < data.list.length; i++ ){
						(function(i){ //즉시 실행 함수. 함수scope. 이 안에서 선언하 변수는 이 scope 안에서만 사용 가능. 선언 하지 않았을 경우,, 
							// 기존 html을 찾는 것이 아니라 새로 생성하여 넣음 
							var $replyDiv = $('<div class="vm-freeBoardDetail__reply-wrapper list-group">');
	
							var value = '<div class="vm-freeBoardDetail__datail__reply-content-wrapper list-group-item list-group-item-action flex-column align-items-start">'
										+	'<div class="d-flex w-100 justify-content-between">'
										+		'<h5 class="mb-1">' + decodeURIComponent(data.list[i].nickname) +'</h5>'
										+			'<small>'
										+				'<span class="vm-freeBoardDetail__reply-date">' + data.list[i].write_date + '</span>'
										+				'<span class="vm-freeBoardDetail__reply-rewrite"><a href="#">답댓글</a></span>'
										+				'<div class="vm-freeBoardDetail__reply-modified"></div>'
										+			'</small>'
										+	'</div>'
										+	'<p class="mb-1 vm_freeBoardDetail__reply-content">' + decodeURIComponent(data.list[i].reply_content).replace(/\+/g, ' ') + '</p>'
										+'</div>'
										;
	
							$replyDiv.append( value );
							
							// var loginUser = '${loginMemberDto.id }';
							
							// if( null !== loginUser)
							// {
							// 	if( data.list[i].id === loginUser )
							// 	{
							// 		var html = '<button type="button" class="vm-freeBoardDetail__reply-update" value="'+ data.list[i].no +'">수정</button>'
							// 				 + '<button type="button" class="vm-freeBoardDetail__reply-delete" value="'+ data.list[i].no +'">삭제</button>'
							// 				 ;
							// 		//find는 알겠음.. 근데 왜.. find 안하고 추가 했을 시, 모든 div에 생기는 건지? if를 했는데 왜? -> 그 클래스 이름으 가진 모든 코드에 생성.
							//			$replyDiv.는 for문을 돌면서 매번 새로 생성됨.
							// 		$replyDiv.find('.vm-freeBoardDetail__reply-modified').html( html );	
							// 	}
							// }
							
							// $(".vm-freeBoardDetail__detail__reply-read").append( $replyDiv );

						}(i));
					}
				}, error : function(jqXHR, textstatus, errorThrown){
					console.dir("error : " + jqXHR + textstatus + errorThrown);
				}
			}); 
		}  */
		
		// javascript code here
	}(jQuery));
</script>
<%-- -------- //JavaScript -------- --%>