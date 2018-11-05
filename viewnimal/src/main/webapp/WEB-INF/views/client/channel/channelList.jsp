<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*" %>

<c:import url="/WEB-INF/views/common/top.jsp" />

<link rel="stylesheet" href="/resources/each/css/channelList.css?${verQuery}" />

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-channelList">

		<div class="vm-section">

			<div class="vui-headline">채널</div>
			
			<hr>

			<div class="vm-channelList__headBtn">
				<c:if test="${loginMemberDto.type eq 'ADMIN'}">
					<form action="/WriteChannel" method="post">
						<input type="hidden" name="type" value="first">
							<button type="submit" class="btn btn-secondary vm-channelList__writeBtn">글쓰기</button>
					</form>
				</c:if>
				
				<button style="width: 100%;" class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample" id="anotherChannelBtn">
				    채널선택
				</button>

				<div class="collapse" id="collapseExample">
				  <div class="card card-body vm-channelList__anotherChannel">
				   <%--  다른 채널 동물 리스트 --%>
				  </div>
				</div>
			</div>
			

 			<div class="vm-channelList__profile-wrapper">
				<%--  동물 프로필 --%>
			</div>
			<hr>

			<div class="row" id="channelList">
			 	<%-- 리스트 --%>
		    </div>

		    <div class="col">
		    	<nav class="vui-navigation" aria-label="Page navigation example">
					<ul class="pagination justify-content-center vm-channelList__pagingDiv">
						<%-- 페이징처리 --%>
					</ul>
				</nav> 
			</div>
		        
		    </div>
			
		</div>

	</div>
</div>
<%-- -------- //JSP -------- --%>
<!-- <c:import url="/WEB-INF/views/client/channel/channelChoice.jsp" /> -->
<c:import url="/WEB-INF/views/common/bottom.jsp" />

<style type="text/css">

</style>

<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/channelList.js?${verQuery}"></script> --%>
<script>
	(function ($) {
		// do not remove this string
		"use strict";
		
		var animal_id;
		var currentPage;
		
		//다른 채널 리스트 
		anotherChannelBtn()
		function anotherChannelBtn(){
			$.ajax({
				
				url: "/SelectChannelChoice"
				, type: 'get'
				, success: function( data, status, xhr ){
					
					for(var i = 0; i < data.list.length; i++) {
						(function(i){ 
						
							var $channelList = $('<div class="vm-channelList__anotherChannelList">');
								
							var value = '<button type="button" class="vm-channelLsit__anotherAnimalBtn" value="' + data.list[i].pet_id + '">'
										+	'<div class="vm-channelList__anotherListImg">'
										+		'<img src="/resources/images/adoption/' + data.list[i].image + '" />'
										+	'</div>'
										+	'<div class="vm-channelList__anotherChannelList__name">' + decodeURIComponent(data.list[i].name) +'</div>'
										+'</button>'
										;
							
							$channelList.append( value );	
							$('.vm-channelList__anotherChannel').append( $channelList );
							
						}(i));
					}
				}, error: function ( xhr, status, error ){
					console.dir("error : " + xhr + status + error);
				}
			});
		}
		
		if( '' !== '${animal_id}')
		{
			animal_id = '${animal_id}';
			var reList = 'reList'
			animalprofile(animal_id, reList);
		}
		
		//el 값이 넘어올 때 null 값은 빈 공백 값이 됨.
		//예외) 커맨드 객체로 받을 때는 null일 경우 int는 0일 때
		if( '' !== '${currentPage }' )
		{
			currentPage = ${currentPage };
		}
		
		//채널 리스트&페이징 불러오기
		channelListAjax( currentPage, animal_id );
		
		
		
		//[채널선택] 이미지를 누르면 animal_id 값이 전달 && 프로필
		$(document).on('click', '.vm-channelLsit__anotherAnimalBtn', function (e) {
			
			animal_id = $(this).attr("value");
			channelListAjax( 'undefined', animal_id );
			animalprofile(animal_id);
			
		});
		

		function animalprofile( animal_id, reList ){
			$.ajax({
				
				url: "/SelectChannelChoice"
				, type: 'get'
				, data: {'pet_id': animal_id}
				, success: function( data, status, xhr ){
					
					var value = '<img class="vm-channelList__profile__img" src="/resources/images/adoption/' + data.list[0].image + '">'
								+'<div class="vm-channelList__profile__detail-wrapper">'
								+	'<div class="vm-channelList__profile__detail-name">' + decodeURIComponent(data.list[0].name) + '</div>'
								+	'<div class="vm-channelList__profile__detail-about">' + decodeURIComponent(data.list[0].content) + '<div>'
								+'</div>'
								;
					
					$('.vm-channelList__profile-wrapper').html( value );
					if( 'reList' !== reList){
						$('#anotherChannelBtn').trigger('click');
					}

				}, error: function ( xhr, status, error ){
					console.dir("error : " + xhr + status + error);
				}
			});		
		}
		
		$(document).on('click', '.vm-channelList .vui-navigation .page-link', function (e) {
			e.preventDefault(); //a태그 기본 이벤트 막기
			var $this = $(this);
			var currentPage = $this.data("currentpage")
			channelListAjax( currentPage, animal_id );
		});
		

		// 채널 리스트
		function channelListAjax( currentPage, animal_id ){
			
			var dataObj = {};

			if ( 'undefined' !== animal_id ){
				dataObj = { 'animal_id': animal_id };
			}
		
			if ( 'undefined' !== currentPage ) {
				dataObj.currentPage = currentPage;
			} else {
				dataObj.currentPage = 1;
			}
			
			

			$.ajax({
				url: "/ListChannel"
				, type: 'get'
				, data: dataObj
				, success: function( data, status, xhr ){
					
					$('#channelList').html('');
					for(var i = 0; i < data.list.length; i++){
						(function(i){ 
							var $listDiv = $('<div class="vm-channelList__video__list-wrapper col-lg-4 col-sm-6 portfolio-item">');
							
							var value = 	'<div class="card h-60">'
										+		'<a href="/ChannelDetail?no=' + data.list[i].no + '&animal_id=' + dataObj.animal_id + '&currentPage=' + dataObj.currentPage + '"><img class="card-img-top" src="' + data.list[i].thumbnail + '"></a>'
										+		'<div class="card-body">'
										+			'<h5 class="card-title">'
										+				'<a class="vm-channelList__video__title-link" href="/ChannelDetail?no=' + data.list[i].no + '&animal_id="' + dataObj.animal_id + '"&currentPage=' + dataObj.currentPage + '">' + decodeURIComponent(data.list[i].title).replace(/\+/g, ' ') + '</a>'
										+			'</h5>'
										+			'<small><div class="vm-channelList__video__date">' + data.list[i].write_date + '</div><div class="vm-channelList__video__readcount"> 조회수 ' + data.list[i].read_count + '</div></small>'
										+		'</div>'
										+	'</div>'
										;
										
							$listDiv.append( value );
							$('#channelList').append( $listDiv );
							
						}(i));
					}
					
					//페이징처리
					var pageValue = "";
					
					if( (data.startPage - data.printPage) >= 1 )
					{
						pageValue += '<li class="page-item">'
									+	'<a class="page-link" data-currentpage="' +(data.startPage - 1) + '" tabindex="-1">'
									+		'<i class="fa fa-angle-left"></i><span class="sr-only">Previous</span>'
									+	'</a>'
									+'</li>'
									;
					}
						
					for ( var i = data.startPage; i <= data.endPage; i++ ){
						(function(i){
							
							if( i === data.currentPage )
							{
								pageValue += '<li class="vm-channelList__page-color page-item"><a class="page-link" data-currentpage="' + i + '">' + i + '</a></li>' ;
							} 
							else 
							{
								 pageValue += '<li class="page-item"><a class="page-link" data-currentpage="' + i + '">' + i + '</a></li>';
							}
							
						}(i));
					}


					if ( (data.startPage + data.printPage) <= data.totalPage )
					{
						pageValue += '<li class="page-item">'
									+	'<a class="page-link" data-currentpage="' + (data.startPage + data.printPage) + '">'
									+		'<i class="fa fa-angle-right"></i><span class="sr-only">Next</span>'
									+	'</a>'
									+'</li>'
									;
					}

					$('.vm-channelList__pagingDiv').html('').append( pageValue );
					
				}, error: function ( xhr, status, error ){
					console.dir("error : " + xhr + status + error);
				}
				
			});
			
		}
		
		// javascript code here
	}(jQuery));
</script>
<%-- -------- //JavaScript -------- --%>