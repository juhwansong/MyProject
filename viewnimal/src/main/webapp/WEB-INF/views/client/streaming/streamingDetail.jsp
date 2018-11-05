<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF/views/common/top.jsp" />

<link rel="stylesheet" href="/resources/each/css/streamingDetail.css?${verQuery}" />

<style>
#line {
    border-bottom: 1px solid #ddd;
    margin-bottom: 10px;
}
.vm-streamingDetail .cat-title {
    border-bottom: 1px solid #dedede;
    margin: -30px 0 50px 0;
    padding-bottom: 20px;
    text-align: center;
}
.vm-streamingDetail .cat-title ul {
    margin: 0;
    padding: 0;
    list-style: none;
}
.vm-streamingDetail .cat-title ul li {
    display: inline;
}
.vm-streamingDetail .cat-title a {
    color: #5b75e7;
    text-transform: uppercase;
}

.vm-streamingReply {
	font-size: 1.3rem;
	color: #172b4d;
}
.vm-streamingDetail .commentBox .txt_btn {
	position:absolute; top: 15px; right: 10px;
}

.vm-channelDetail__detail__reply-btn {
	background-color : #5b75e7;
	border : #5b75e7;
}
.vm-streamingDetail .page-item.active .page-link {
	    border-color: #5b75e7;
    background-color: #5b75e7;
}

.vm-infoBoardDetail__fn a {
color : #5b75e7;
}

.vm-streamingDetail .btn.btn-xs.comment-reply {
	color : #5b75e7;
}

.vm-streamingDetail {
	word-break : break-all;
}

.vm-streamingDetail .myReply {
	background-color: #f6f9fc;
	
	/* #EAEFF8*/
}

.vm-streaingDetail .list-group-item-action:focus, .list-group-item-action:hover {
	background-color : #fff;
}

</style>






<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-streamingDetail">
		<div class="vm-section" >
			<div class="vui-headline">
				스트리밍
			</div>
			<!-- <hr class="mt-0"> -->
			<%-- top --%>
				<div class="vui-board__box vui-board__box--t row">
				<c:if test="${sessionScope.loginMemberDto.type == 'ADMIN'}">
					<div class="col">
						<a href="/StreamingUpdate?no=${Streaming.no }"><button type="button" class="btn btn-primary" >수정하기</button></a>
					</div>
					<div class="col text-right">
						<button type="button" class="btn btn-secondary" id="deleteStreaming">삭제하기</button> 
					</div>
				</c:if>
				</div>
				<%-- //top --%>
				
				
				
				<div class="cat-title"></div>
				<div class="cat-title pb-2">
				<ul class="post-categories">
					<li><a style="font-size:30px; font-weight : bolder;">${Streaming.title }</a></li>
					<%-- <small class="text-muted list-group-item-action"><span class="vm-channelDetail__detail__video-date">${Streaming.write_date }</span></small> --%>
				</ul>		
				<div class="text-right mr-2" style="color:#888; font-size:15px;"><i class="fa fa-calendar-o" aria-hidden="true"></i>&nbsp;<span>${Streaming.write_date }</span></div>	
			</div>
			
			<div class="vm-channelDetail__detail__video-play" style="padding-bottom: 10.25%;">
				<iframe width="100%" height="700px" class="youtube_play_test" src="${Streaming.thumbnail }?autoplay=1&loop=1&rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
			</div>
			
			<div class="vm-streamingDetail__content"><p>${Streaming.content }</p></div>
				
				
				
				
				
		<!-- 댓글ㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹ -->		
		
			<div class="vm-channelDetail__detail-wrapper" >
			  <div class="vm-channelDetail__dateil__video-wrapper list-group-item list-group-item-action flex-column align-items-start" >
				
				<div class="vm-channelDetail__detail__reply-wrapper">
						<div class="vm-channelDetail__detail__reply-totalcount">
							댓글 <font id="streaming-comment-count"></font>
						</div>
						<br>
						
					<c:if test="${sessionScope.loginMemberDto.id != null }">
						<div id="streaming-comment-insert-box">
							<div class="vm-channelDetail__detail__reply-write">
								<textarea class="comment-text-area streamingReply-write-box" id="comment-text-area-id" onkeyup="chkword(this, 200)" rows="2" placeholder="최대 100자로만 앓을 수 있습니다..."></textarea>
							</div>
							<div class="vm-channelDetail__detail__reply-btn-wrapper">
								<button class="vm-channelDetail__detail__reply-btn" id="streaming-comment-insert-btn" type="button">등록</button>
							</div>
						</div>
					</c:if>
						<div id="streaming-comment-box"></div> 
						
		<%-- 			<c:if test="${sessionScope.loginMemberDto.id == Streaming.id }">
						<div id="streaming-comment-box" style="background-color:red;"></div>
						</c:if>
						<c:if test="${sessionScope.loginMemberDto.id != Streaming.id }">
						<div id="streaming-comment-box"></div>
						</c:if>
					 --%>
					
				</div>
				
				
				
				
				
				
			
		<script id="streaming-comment-template" type="text/template">

			<div class="<@=data.comment_no @> <@=data.myReply@> vm-channelDetail__datail__reply-content-wrapper list-group-item"  >

				<div class="w-100 justify-content-between" >
					<b class="vm-infoBoardDetail__fn"><@=data.nickname @></b>&nbsp;&nbsp;&nbsp;
						<@if(data.sessionId == data.id){ @>
						    <a rel='nofollow' class='btn btn-xs comment-reply'  onclick="updateCommentFunc('<@=data.comment_no @>', '<@=data.write_date_format @>'); return false;">수정</a>
						    <a rel='nofollow' class='btn btn-xs comment-reply'  onclick="deleteCommentFunc('<@=data.delete_comment_no @>', '<@=data.current_page @>'); return false;">삭제</a>
						 <@} @>
						<div class="commentBox">
						    <small class="txt_btn" style="color:#8898aa!important;"><@=data.write_date_format @></small>
                        </div>
				</div>
						<p class="mb-1"><@=data.reply_content @></p>
							
			 </div>	

			


		</script>
		
		
		<!-- 수정버튼 클릭 시 바뀌는 템플릿 -->
		<script id="comment-update-template" type="text/template">

			<div class="<@=data.comment_no_write @> vm-channelDetail__datail__reply-content-wrapper list-group-item streaming-comment-enroll-box">
				<div class="w-100 justify-content-between">
					<b class="vm-infoBoardDetail__fn"><@=data.nickname @></b>&nbsp;&nbsp;&nbsp;
						 
						    <a rel='nofollow' class='btn btn-xs comment-reply'  onclick="updateCommentInsertFunc('<@=data.comment_no @>', '<@=data.comment_no_write @>'); return false;">완료</a>
						    <a rel='nofollow' class='btn btn-xs comment-reply'  onclick="cancelCommentInsertFunc('<@=data.comment_no @>', '<@=data.comment_no_write @>'); return false;">취소</a>
						 	
							<div class="commentBox">
						      <small class="txt_btn" style="color:#8898aa!important;"><@=data.write_date_format @></small>
                            </div>
				</div>
						      <div class="vm-channelDetail__detail__reply-write">
							<textarea class="comment-text-area streamingReply-write-box" id="comment-text-area-id" onkeyup="chkword(this, 200)" rows="2" placeholder="최대 100자로만 앓을 수 있습니다..."><@=data.commentContentStr@></textarea>
						</div>
			</div>

		</script>
		

					<div class="col vm-channelDetail__detail__pagination">
						<nav class="vui-navigation" aria-label="Page navigation example">
							<ul class="pagination justify-content-center" id="streaming-pagination-box"></ul>
						</nav>
						
						<script id="prevPageTemplate" type="text/template">
							<li class="page-item <@=data.disabled @>">
								<a class="page-link streamingList-prev" href="#" tabindex="-1">
								<i class="fa fa-angle-left"></i>
								<span class="sr-only">Previous</span>
								</a>
							</li>
						</script>
						<script id="numberPageTemplate" type="text/template">
							<li class="page-item <@=data.active @>"><a class="page-link <@=data.active @>" href="#"><@=data.pageNumber @></a></li>
						</script>
						<script id="nextPageTemplate" type="text/template">
							<li class="page-item <@=data.disabled @>">
								<a class="page-link streamingList-next" href="#">
								<i class="fa fa-angle-right"></i>
								<span class="sr-only">Next</span>
								</a>
							</li>
						</script>
					</div>
				</div>

				<div class="col text-center vm-channelDetail__detail-list-btn-wrapper">
					<a href="Streaming"><button type="button" class="btn btn-primary">목록으로</button></a>
				</div>
				
					

			</div>
		</div>
	</div>
</div>
<input id="start_page" hidden="">
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<script>
	
	var parentBoardNumber = ${param.no};
	var streamingCommentCurrentPage = 1;
	
	(function ($) {
		// do not remove this string
		"use strict";
		
		// 페이지 호출 시 첫 페이지 리스트 불러오기
		var commentInitData = {'no' : parentBoardNumber, 'current_page' : 1};
		loadBody(commentInitData);
		
		// 페이지 버튼 클릭 시 해당 영역 클릭 이벤트 발생
		$(document).on("click", ".vm-streamingDetail .page-link", function(event){
			event.preventDefault();
			
			var start_page = $("#start_page").val();
			var currentPage;
			
			// 현재 버튼 클릭 시
			if($(this).hasClass("active")){
				return;
				
			}else if($(this).hasClass("streamingList-prev")){
				currentPage = Number(start_page);
				
			}else if($(this).hasClass("streamingList-next")){
				currentPage = Number(start_page)+3;
				
			}else{
				currentPage = this.innerHTML;
			}
			
			loadBody({'current_page' : currentPage, 'no' : parentBoardNumber});
			
		});
		
		
		
		
		
		// 댓글 추가
		$(document).on("click", "#streaming-comment-insert-btn", function(event){
			
			var commentTextAreaVal = $(".comment-text-area").val();  //trim() 있었음
			
			if(commentTextAreaVal === ""){
				alert("내용을 입력해 주세요.");
				$(".comment-text-area").val("");
				return false;
				
			}if(!chkword(document.getElementById("comment-text-area-id"), 200)){
				return false;
				
			}if(!confirm("댓글을 등록 하시겠습니까?")){
				return false;
			}
			
			
			$.ajax({
					url      : '/insertStreamingReply',
					type     : 'POST',
					dataType : 'json',
					data     : {'reply_content' : commentTextAreaVal, 'no' : parentBoardNumber},
					async    : true,
					success  : function(data, status, xhr){
										if(data.resultMessage === 'fail'){
											alert("등록에 실패하였습니다.");
											return false;
										}
	
											$(".comment-text-area").val(""); // 입력 성공 시 textarea 초기화
											loadBody({'current_page' : 1, 'no' : parentBoardNumber});
										},
					error    : function(xhr, status, error){
									alert('문제가 발생하였습니다. \n다시 시도 해주십시오.');
					}
				
			});
			
			
		});
		

	}(jQuery));
	
	// 글 삭제
	$("#deleteStreaming").on("click", function(){
		if(confirm('삭제 하시겠습니까?')){
			
			$.ajax({
				url : "streamingDelete",
				type : "POST",
				data : { no : '${Streaming.no}'},
				success : function(data){
					
					if(data.result === "ok"){
						alert("삭제되었습니다.");
						location.href="Streaming";
					}else{
						alert("삭제가 되지 않았습니다. \n다시 시도 해주세요.");
					}
				}
			});
			
		}
	});
	
	//댓글 수정 클릭 시 이벤트 함수
	function updateCommentFunc(comment_no, write_date_format){

		var commentContentStr = $("." +comment_no + " .mb-1").html();//댓글 내용 가져오기
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

		$("." +comment_no).css("display", "none");//기존 댓글 안보이게 숨기기
	}	
	
	//댓글 수정 창에서 취소버튼 클릭 시
	function cancelCommentInsertFunc(comment_no, comment_no_write){
		$("." + comment_no_write).remove();//댓글 수정 폼 삭제
		$("." + comment_no).css("display", "block");//기존 댓글 보이게 하기
	}	

	//댓글 수정 완료 버튼 클릭 시 이벤트 함수
	function updateCommentInsertFunc(comment_no, comment_no_write){
		
		//해당 댓글번호 입력폼의 텍스트에리어 값 가져오기	
		var reply_content = $("." + comment_no_write + " .streamingReply-write-box").val();  // trim() 있었음
		
		if(reply_content === ""){
			alert("내용을 입력 해 주세요.");
			return false;
		}
		
		$.ajax({
			  url 		: '/updateStreamingReply'
			, type 		: 'POST'
			, dataType 	: 'json'
			, data 		: {
				'reply_content' : reply_content,
				'no' : parentBoardNumber, //처음 페이지 진입 시 전역 변수에 저장한 글번호
				'reply_no' : comment_no.replace("streaming-comment-", "")  //클래스이름으로 가공한 데이터를 다시 댓글 번호로 바꿈
			}
			, async		: true
			, success 	: function ( data, status, xhr ) {
				if(data.resultMessage === 'fail'){
					alert("댓글 수정에 실패하셨습니다.");
					return false;
				}
				alert("댓글 수정에 성공하셨습니다.");
				
				var streamingCommentTemplateStr = $("#streaming-comment-template").html();
				var streamingCommentFun = _.template(streamingCommentTemplateStr,{variable : 'data'});
				var commentDateFormat = getTimeStamp();
				var templateHtml = {					
					write_date_format : commentDateFormat,
					reply_content : reply_content,
					no : parentBoardNumber,
					nickname : '${sessionScope.loginMemberDto.nickname}',
					comment_no : comment_no, //댓글 박스에 해당 이름의 클래스 선언
					id : '${sessionScope.loginMemberDto.id}',
					sessionId : '${sessionScope.loginMemberDto.id}',
					delete_comment_no : comment_no.replace("streaming-comment-", "")
					
				};
				
				$("." + comment_no_write).remove(); //댓글 수정 창 지우기
				$("." + comment_no).addClass("deletePastComment"); //temp 변수 쓰는 용
				$(".deletePastComment").before(		
					streamingCommentFun(templateHtml)
				);	
				$(".deletePastComment").remove(); //수정 전 댓글창 지우기		
			}
			, error 	: function ( xhr, status, error ) {
				alert('문제가 발생했습니다.\n다시 시도해주세요.');
			}
		});
	}
	
	//댓글 삭제 클릭 시 이벤트 함수
	function deleteCommentFunc(comment_no, current_page){
		
		$.ajax({
			  url 		: '/deleteStreamingReply'
			, type 		: 'POST'
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
				alert("댓글 삭제에 성공하셨습니다.");
					
				//삭제 성공하고 현재 페이지 리스트 다시 불러오기
				loadBody({'current_page' : streamingCommentCurrentPage, 'no' : parentBoardNumber});
			}
			, error 	: function ( xhr, status, error ) {
				alert('문제가 발생했습니다.\n다시 시도해주세요.');
			}
		});
	}
		
	
	
	
	
	
	function loadBody(commentData){
		
		$.ajax({
				url : '/selectStreamingReplyList',
				type : 'POST',
				dataType : 'json',
				data : commentData,
				async : true,
				success : function(data, status, xhr){
					$("#start_page").val(data.infoMap.start_page);
					$("#streaming-comment-count").html(data.infoMap.board_count);
					
					streamingCommentCurrentPage = data.infoMap.current_page;
					
					
					// 게시글 리스트
					var $streamingCommentBox = $("#streaming-comment-box");
					//이전 댓글 목록 전부 지우기
					//$("#vm-channelDetail__detail__reply-wrapper")
					//streaming-comment-insert-box
										
					//댓글 목록 리스트 초기화
					$streamingCommentBox.empty();
									
					// 페이지 이동 이벤트 경우 이전에 남아있는 수정 박스 삭제 해야함!!!!!!!!!!!!!!!!!!!!!!!!!!!!
					$(".streaming-comment-enroll-box").empty();
					
					//템플릿 태그에 지정 된 아이디를 통하여, 해당 변수에 템플릿 안의 저장 된 값들을 담음
					var streamingCommentTemplateStr =$("#streaming-comment-template").html();
					var streamingCommentFun = _.template(streamingCommentTemplateStr, {variable : 'data'});
					
					for(var i=0; i <data.list.length ; i++){
						var templateHtml = {
								write_date_format : data.list[i].write_date_format,
								reply_content : data.list[i].reply_content,
								no : data.list[i].no,
								nickname : data.list[i].nickname,
								comment_no : "streaming-comment-" + data.list[i].reply_no,
								delete_comment_no : data.list[i].reply_no,
								id : data.list[i].id,
								sessionId : '${sessionScope.loginMemberDto.id}',
								current_page : data.infoMap.current_page		
						};
						
						if(data.list[i].id === '${sessionScope.loginMemberDto.id}'){
							templateHtml.myReply = 'myReply';
						}
						
						$streamingCommentBox.append(streamingCommentFun(templateHtml));
					}
					
					// pagenation 
					var $streamingPaginationBox = $("#streaming-pagination-box");
					
					$streamingPaginationBox.empty();
					
					var prevPageTemplateStr = $("#prevPageTemplate").html();
					var prevPageTemplateFun = _.template(prevPageTemplateStr, {variable : 'data'});
					
					if(Number(data.infoMap.start_page) >= 1){
						$streamingPaginationBox.append(prevPageTemplateFun({}));
					}else{
						$streamingPaginationBox.append(prevPageTemplateFun({disabled : 'disabled'}));
					}
					
					// body pagenation
					var numberPageTemplateStr = $("#numberPageTemplate").html();
					var numberPageTemplateFun = _.template(numberPageTemplateStr, {variable : 'data'});
					
					for(var i=data.infoMap.start_page; i <=data.infoMap.end_page; i++){
						if(Number(data.infoMap.current_page) === i){
							$streamingPaginationBox.append(numberPageTemplateFun({pageNumber : i, active : 'active'}));
							
						}else{
							$streamingPaginationBox.append(numberPageTemplateFun({pageNumber : i}));
						}
					}
					
					var nextPageTemplateStr = $("#nextPageTemplate").html();
					var nextPageTemplateFun = _.template(nextPageTemplateStr, {variable: 'data'});
					if(Number(data.infoMap.start_page)+2 <= Number(data.infoMap.max_page)){
						$streamingPaginationBox.append(nextPageTemplateFun({}));
					}else{
						$streamingPaginationBox.append(nextPageTemplateFun({disabled : 'disabled'}));
					}
				},
				
				error : function(xhr, status,error){
					alert("문제가 발생했습니다. \n다시 시도 해주세요.")
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
	function chkword(obj, maxByte) {	 
        
		var strValue = obj.value;
        var strLen = strValue.length;
        var totalByte = 0;
        var len = 0;
        var oneChar = "";
        var str2 = "";
 
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
            alert(maxByte/2 + "자를 초과하여 입력 할 수 없습니다.");
            str2 = strValue.substr(0, len);
            obj.value = str2;
            chkword(obj, 4000);
            return false;
        }
        return true;
    }

	
</script>

<%-- -------- //JavaScript -------- --%>