<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*" %>

<c:import url="/WEB-INF/views/common/top.jsp" />
<link rel="stylesheet" href="/resources/each/css/channelDetail.css?${verQuery}" />

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-channelDetail">

		<div class="vm-section">

			<div class="vui-headline">채널</div>

			<div class="vm-channelDetail__detail-wrapper">

					<div class="vm-channelDetail__content-wrapper list-group-item list-group-item-action flex-column align-items-start">

						<div class="d-flex w-100 justify-content-between">
							 <h5 class="mb-1 vm-channelDetail__title"><span>${channelDto.title }</span></h5>
							 <small class="text-muted"><span class="vm-channelDetail__date">${channelDto.write_date }</span><span class="vm-channelDetail__readCount">조회 ${channelDto.read_count }</span></small>
					  </div>
					  <hr>
					  		<div class="vm-channelDetail__detail__content">${channelDto.content_tag }</div>
				<hr>
				<div class="vm-channelDetail__detail__reply-wrapper">
					<div class="vm-channelDetail__detail__reply-totalcount">
						댓글 0<%-- 댓글수 --%>
					</div>
					<br>
					<c:if test="${ !empty loginMemberDto}">
					<div class="vm-channelDetail__detail__reply-write-wrapper">
						<div class="vm-channelDetail__detail__reply-write">
							<textarea class="vm-channelDetail__detail__reply-write__textarea" rows="2"></textarea>
						</div>
						<div class="vm-channelDetail__detail__reply-btn-wrapper">
							<button class="vm-channelDetail__detail__reply-btn btn btn-primary" id="replyRegBtn" type="button">등록</button>
						</div>
					</div>
					</c:if>
				</div>
					<div class="vm-channelDetail__detail__reply-read">
						<%-- 댓글 내용 --%>
					</div>

					<div class="col vm-channelDetail__detail__pagination">
						<%-- 페이징 처리 --%>
					</div>

				</div>

				<div class="col text-center vm-channelDetail__detail-list-btn-wrapper">
					<c:if test="${ sessionScope.loginMemberDto.id eq channelDto.id }">
						<form action="WriteChannel" method=POST>
							<input type="hidden" name="type" value="update">
							<input type="hidden" name="no" value="${channelDto.no }">
							<input type="hidden" name="animal_id" value="${channelDto.animal_id }">
							<input type="hidden" name="title" value="${channelDto.title }">
							<input type="hidden" name="content" value="${channelDto.content }">
							<input type="hidden" name="content_tag" value='${channelDto.content_tag }'>
							<button type="submit" class="btn btn-primary">수정</button>
						</form>
							<button type="button" class="btn btn-primary" id="deleteChannelBtn">삭제</button>
					</c:if>
					<button type="button" class="btn btn-primary vm-channelDetail__listBack">목록</button>
				</div>
				
			</div>
		</div>
		
	</div>
</div>

<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<style type="text/css">

</style>

<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/channelDetail.js?${verQuery}"></script> --%>

<%-- underscore template --%>
<script id="replyTemplate" type="text/template">
<div class="vm-channelDetail__reply-wrapper list-group">
	<div class="vm-channelDetail__datail__reply-content-wrapper list-group-item list-group-item-action flex-column align-items-start">
		<div class="d-flex w-100 justify-content-between">
			<h5 class="mb-1"><@= data.nickname @></h5>
			<small>
				<span class="vm-channelDetail__reply-date"><@= data.write_date @></span>
				<div class="vm-channelDetail__reply-modified">
					<@ if( null !== data.loginUser && data.id === data.loginUser ) { @>
						<button type="button" class="vm-channelDetail__reply-update" value="<@=data.no@>">수정</button>
						<button type="button" class="vm-channelDetail__reply-delete" value="<@=data.no@>">삭제</button>
					<@ } @>
				</div>
			</small>
		</div>
		<p class="mb-1 vm_channelDetail__reply-content"><@= data.reply_content@></p>
	</div>
</div>
</script>


<%-- 댓글 페이징 처리 --%>
<script id="pageTemplate" type="text/template">
<nav class="vui-navigation" aria-label="Page navigation example">
	<ul class="pagination justify-content-center vm-channelDetail__datail__pagination-content">

		<@ if( ( data.startPage - data.printPage ) >= 1 ) { @>
			<li class="page-item">
				<a class="page-link" data-currentpage="<@= data.startPage - data.printPage @>" tabindex="-1">
					<i class="fa fa-angle-left"></i><span class="sr-only">Previous</span>
				</a>
			</li>
		<@ } @>
		<@ for( var i = data.startPage; i <= data.endPage; i++ ) { @>
			<@ if( data.currentPage === i ) { @>
				<li class="vm-channelDetail__page-color page-item"><a class="page-link" data-currentpage="<@= i @>"> <@= i @> </a></li>
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

		$(document).on('click', '.vm-channelDetail .vui-navigation .page-link', function (e) {
			e.preventDefault();
			var $this = $(this);
			
			replySelectAjax( $this.data("currentpage") );
		});

		function replySelectAjax( currentpage  ) {

			var dataObj = {
				'channel_no' : ${channelDto.no}
			};
			
			if ( 'undefined' !== currentpage ) {
				dataObj.currentPage = currentpage;
			}


			$.ajax({
				url: "/ChannelReplyList"
				, type: "get"
				, data: dataObj
				, dataTpye: "json"
				, success: function(data, status, xhr){

					var tempStr = $("#replyTemplate").html(); // 템플릿 판형
					var tempFun = _.template(tempStr, { variable: 'data' }); // 템플릿 세팅 (아직 빈 껍데기)
					
					// 세팅된 변수에 객체를 담아서 호출하면 데이터가 들어간  html 을 반환  ex) tempFun( { id : 'foo', name : 'bar' } );

					$(".vm-channelDetail__detail__reply-read").html('');
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
							
							$(".vm-channelDetail__detail__reply-read").append( tempFun( objData ) );
							// tempFun( objData ) ->  동적으로 데이터 들어간  html 반환
							
							// 페이지네이션 판형
							var pageTempStr = $("#pageTemplate").html();
							var pageTempFun = _.template(pageTempStr, { variable: 'data' });
							
							//제이쿼리 메서드 체인 
							$(".vm-channelDetail__detail__pagination").html('').append( pageTempFun( data ) ); 

							$(".vm-channelDetail__detail__reply-totalcount").html('').html( '댓글 ' + data.totalCount );
							
						}(i));
					}
				}, error : function(jqXHR, textstatus, errorThrown){
					console.dir("error : " + jqXHR + textstatus + errorThrown);
				}
			}); 
		}

		//댓글 등록
		$("#replyRegBtn").on('click', function () {
			
			var $replyContent = $('.vm-channelDetail__detail__reply-write__textarea');
			var userId = '${loginMemberDto.id }';
			
			if( "undefined" !== userId ) 
			{
				if( "" === $replyContent.val() )
				{
					alert("내용을 입력해주세요.");
				}
				else 
				{
					$.ajax({
						url : "/InsertChannelReply",
						type : "post",
						data : { 
							reply_content: $replyContent.val()
							, id: userId
							, channel_no: '${channelDto.no }'
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
		});

		//댓글 수정
		$(document).on('click', '.vm-channelDetail__reply-update', function (e) {
			var no = $(this).attr("value");
			var $replyWrapper = $(e.target).parents('.vm-channelDetail__reply-wrapper');
			replyUpdate( no, $replyWrapper );
			console.log( $replyWrapper );
		});

		function replyUpdate( no, $replyWrapper ){
			
			var replyText = $replyWrapper.find('.vm_channelDetail__reply-content').text();
			
			var value = '<div class="vm-channelDetail__detail__reply-write">'
						+ 	'<textarea class="vm-channelDetail__detail__reply-write__textarea" rows="2">'+ replyText +'</textarea>'
						+ '</div>'
						+ '<div class="vm-channelDetail__detail__replyBtn-wrapper">'
						+	'<button class="vm-channelDetail__reply-updateBtn btn btn-primary" id ="replyUpdateBtn" type="button">수정</button>'
						+	'<button class="vm-channelDetail__reply-cancleBtn btn btn-primary" id ="replyCancleBtn" type="button">취소</button>'
						+ '</div>'
						;
					
			$('.vm-channelDetail__detail__reply-write-wrapper').hide(0);
			$replyWrapper.html( value );
			
			$replyWrapper.find('#replyUpdateBtn').on('click', function () {
				$.ajax({
					url: "/UpdateChannelReply",
					type:"get",
					data: { 
						  no: no
						, reply_content: $replyWrapper.find('.vm-channelDetail__detail__reply-write__textarea').val()
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
		$(document).on('click', '.vm-channelDetail__reply-delete', function (e) {
			var no = $(this).attr("value");
			var $replyWrapper = $(e.target).parents('.vm-channelDetail__reply-wrapper');
			replyDelete( no );
		});
		
		function replyDelete( no ){
			$.ajax({
				url: "/DeleteChannelReply"
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
		
		//글 삭제
		$("#deleteChannelBtn").on("click", function(){

			if(  confirm('삭제하시겠습니까?') ){
				$.ajax({
					url: "/UpdateNonActiveChannel"
					, type: 'get'
					, data: { no: '${channelDto.no}' }
					, dataTpye: 'json'
					, success : function( data ){
						var ifStatement = data.result === 1;

						if ( ifStatement ) 
						{
							alert("삭제되었습니다.");
							location.href="ChannelList";
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
		
		//목록 버튼 클릭시
		$(".vm-channelDetail__listBack").on("click", function(){
			location.href="/ChannelList?animal_id=" + '${ animal_id }' + "&currentPage=" + ${ currentPage } ;
		});
		

		// javascript code here
	}(jQuery));
</script>
<%-- -------- //JavaScript -------- --%>