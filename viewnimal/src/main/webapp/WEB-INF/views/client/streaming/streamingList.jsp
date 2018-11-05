<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF/views/common/top.jsp" />
<link rel="stylesheet" href="/resources/each/css/streamingList.css?${verQuery}" />

<style>

.vm-labList .btn {
    bottom : 0px;
}

.vm-labList .block-with-text {
    overflow: hidden;
    display: -webkit-box;
    -webkit-line-clamp: 7;
    -webkit-box-orient: vertical;
    color: #8898aa;
}

.vm-labList .block-with-text:hover {
	color: #8898aa;
}

.vm-labList .page-item.active .page-link {
    z-index: 1;
    color: #fff;
    border-color: #5b75e7;
    background-color: #5b75e7;
}
.vm-labList .m-0 {
	color: #adb5bd;
}
.vm-labList .col-lg-4 h2 {
	color:#32325d; 
	font-weight:bold;
}

.vm-labList__notice-message {
	text-align: center;
	font-size: 20px;
	padding: 10px 0;
	border-radius: 10px;
	background: #5b75e7;
	color: #fff;
}
.vm-labList__notice-message__text { margin-left: 10px; }
.vm-labList__notice-message i {
	animation: movingCamera 750ms ease 0s infinite alternate forwards running;
}

@keyframes movingCamera {
	from { transform: scale(1); }
	to { transform: scale(1.2); }
}


</style>



<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-labList">
		<div class="vm-section">
			<div class="vui-headline">
				스트리밍
			</div>
			
			<hr>

			<div class="vui-board">
				<%-- top --%>
				<div class="vui-board__box vui-board__box--t row">
				<c:if test="${sessionScope.loginMemberDto.type == 'ADMIN'}">
					<div class="col">
						<a href="/StreamingWrite"><button type="button" class="btn btn-primary">글쓰기</button></a>
					</div>
				</c:if>
				</div>
				<%-- //top --%>


		<!-- Page Content -->
		    <div class="container">
		    
		    
		
		      <!-- 라이브 시작 -->
		      <div class="row my-4">
		        <div class="col-lg-8">
		        	<iframe width=100%; height=400px; src="${Live.thumbnail }" frameborder="0" allow="autoplay; encrypted-media"  allowfullscreen></iframe>
		         
		        </div>
		        <!-- /.col-lg-8 -->
		        <div class="col-lg-4">
		        	<a href="/StreamingDetail?no=${Live.no }">
		            <h2>${Live.title}</h2><br>
		            <p class="block-with-text">${Live.content }</p>
		          <button class="btn btn-primary" type="button"  style="position: absolute; "><i class="ni ni-chat-round"></i> ${Live.reply_count }</button></a>
		        </div>
		        
		      </div>
		      <!-- 라이브 끝-->
		      
		      
		      
		
		      <!-- 파티션 -->
		      <div class="vm-labList__notice-message">
		        <i class="fa fa-video-camera" aria-hidden="true"></i>
		        <span class="vm-labList__notice-message__text">녹화방송</span>
		      </div>
		
			 
			 <!-- 지난스트리밍 리스트 -->
			
		      <div id="streaming-body" class="row"></div>
		      
		      <script id="streaming-body-template" type="text/template">
			<a href="/StreamingDetail?no=<@=data.no@>&current_page=<@=data.current_page @>">
		      <div class="col-lg-4 col-sm-6 vm-streamingList__portfolio-item">
		          <div class="card h-100">
		            	<iframe class="card-img-top" width="348" height="198.84" src="<@=data.thumbnail @>" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen>
						</iframe>
					<a href="/StreamingDetail?no=<@=data.no@>&current_page=<@=data.current_page @>">
		            	<div class="card-body">
		              		<h4 class="card-title" style="color:#32325d; font-weight:bold;"><@=data.title @></h4><hr>
		              		<p class="card-text block-with-text" ><@=data.content @></p>
							<button type="button" class="btn btn-primary" style="position: absolute; right: 0;" ><i class="ni ni-chat-round"></i> <@=data.reply_count @></button>
		            	</div>
					</a>
		          </div>
		        </div>
			</a>
		      </script>
		      
		     
			 <!-- 라이브와 지난스트리밍 컨테이너 끝-->
		    </div>	 
	 
	 
	 
	 
	 
	 
	 
				<%-- bottom --%>
				<div class="vui-board__box vui-board__box--b row">
					<div class="col"></div>


					<div class="col">
						<nav class="vui-navigation" aria-label="Page navigation example">
							<ul class="pagination justify-content-center" id="streaming-pagination">
							</ul>
						</nav>
					</div>
					
					
					
					<script type="text/template" id="streaming-prev-pagination-template">
						<li class="page-item <@=data.disabled @>">
							<a class="page-link streamingList-prev" href="javascript:void(0)"><i class="fa fa-angel-left"><</i></a>
						</li>
					</script>
					
					<script type="text/template" id="streaming-body-pagination-template">
						<li class="page-item <@=data.active @>"><a class="<@=data.active @> page-link" href="javascript:void(0)"><@=data.pageNumber @></a></li>
					</script>
					
					<script type="text/template" id="streaming-next-pagination-template">
						<li class="page-item <@=data.disabled @>">
							<a class="page-link streamingList-next" href="javascript:void(0)"><i class="fa fa-angel-right">></i></a>
						</li>
					</script>



					<div class="col text-right"></div>
				</div>
				<%-- //bottom --%>
			</div>

		</div>
	</div>
</div>

<br>
<br>
<br>
<input id="start_page" hidden="">
<input id="initcurrent-page" hidden="" value=""> 
<%-- -------- //JSP -------- --%>




<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<script>
	(function ($) {
		// do not remove this string
		"use strict";

		// 처음 로딩 시
		/*  var currentPageFormData = 1;  */
		var currentPageFormData = {'current_page' : 1}; 
		
		if($("#initcurrent-page").val() !== ""){
			currentPageFormData = $("#initcurrent-page").val();
		}
		
		loadBody(currentPageFormData);
		
		
		// 페이지 버튼 클릭 이벤트
		$(document).on("click", ".vui-board .page-link", function(){
			event.preventDefault();
			
			var start_page = $("#start_page").val();
			
			var currentPage;
			
			// 현재 버튼 클릭 시
			if($(this).hasClass("active")){
				return false;
				
			}else if($(this).hasClass("streamingList-prev")){
				currentPage = Number(start_page);
				
			}else if($(this).hasClass("streamingList-next")){
				currentPage = Number(start_page)+3;                                      // 일단 10으로 한 것 나중에 다시,,
				
			}else{
				currentPage = this.innerHTML;
			}
			
			loadBody({'current_page' : currentPage});
			
		});
		
		function loadBody(kewordData){
			
			$.ajax({
				url : '/selectLastStreamingList',
				type : 'post',
				dataType : 'json',
				data : kewordData,
				async : true,
				success : function(data, status, xhr){
					
					$("#start_page").val(data.infoMap.start_page);
					
					
					var $streamingBody = $("#streaming-body");
					$streamingBody.empty();
					
					var streamingBodyStr = $("#streaming-body-template").html();
					
					var streamingBodyFun = _.template(streamingBodyStr,{variable : 'data'});
					
					for(var i=0; i<data.list.length; i++){
						var templateHtml = {
								
								title : data.list[i].title,
								content : data.list[i].content,
								thumbnail : data.list[i].thumbnail,
								no : data.list[i].no,
								current_page : data.infoMap.current_page,
								reply_count : data.list[i].reply_count
								
						};
						$streamingBody.append(streamingBodyFun(templateHtml));
					}
					
					var $streamingPagination = $("#streaming-pagination");
					$streamingPagination.empty();
					
					var prevPaginationStr = $("#streaming-prev-pagination-template").html();
					var prevPaginationFun = _.template(prevPaginationStr, {variable : 'data'});
					
					if(Number(data.infoMap.start_page) >= 1){
						$streamingPagination.append(prevPaginationFun({}));
						
					}else{
						$streamingPagination.append(prevPaginationFun({disabled  : 'disabled'}));
					}
					
					var bodyPaginationStr = $("#streaming-body-pagination-template").html();
					var bodyPaginationFun = _.template(bodyPaginationStr, {variable : 'data'});
					
					for(var i=data.infoMap.start_page; i<=data.infoMap.end_page; i++){
						if(Number(data.infoMap.current_page) === i){
							$streamingPagination.append(bodyPaginationFun({pageNumber : i, active : 'active'}));
						}
						else{
							 $streamingPagination.append(bodyPaginationFun({pageNumber : i})); 
						}
					}
					
					// 다음 버튼,,, 10개,,,!
					var prevPaginationStr = $("#streaming-next-pagination-template").html();
					var prevPaginationFun = _.template(prevPaginationStr, {variable : 'data'});
					
					if(Number(data.infoMap.start_page)+2 <= Number(data.infoMap.max_page)){
						$streamingPagination.append(prevPaginationFun({}));
					}
					else{
						$streamingPagination.append(prevPaginationFun({disabled : 'disabled'}));						
					}
					
				},
				
				error : function ( xhr, status, error ) {
					alert('문제가 발생했습니다.\n다시 시도해주세요.');
				}
					
				
			});
			
		}
		
		
	}(jQuery));
	
	
	
</script>
<%-- -------- //JavaScript -------- --%>