<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*" %>

<c:import url="/WEB-INF/views/common/top.jsp" />

<link rel="stylesheet" href="/resources/each/css/channelWrite.css?${verQuery}" />

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-channelWrite">
		<div class="vm-section">

			<div class="vui-headline">채널</div>

			<div id="vui-table">
				<form id="vm-channelWrite__write-form"> 
					<table class="table">
						<tr>
							<th><label>채널</label></th>
							<td>
								<div class="row">
									<div class="col-md-12">
										<select class="vm-channelWrite__category" name="animal_id">
										  <option value="채널선택">채널선택</option>
										 	<%--카테고리 리스트 --%>
										</select>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th><label>제목</label></th>
							<td>
								<div class="row">
									<div class="col-md-12">		

										<c:if test="${'update' eq type }">								
											<input type="text" class="vm-channelWrite__title-input form-control form-control-alternative" id="title"  name="title" value='${channelDto.title }'>	
										</c:if>
										<c:if test="${'update' ne type }">
											<input type="text" class="vm-channelWrite__title-input form-control form-control-alternative" id="title"  name="title">
										</c:if>			

									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th><label>내용</label></th>
							<td>
								<div class="row">
									<div class="col-md-12">								
										<textarea name="content_tag" id="summernote_area"></textarea>				
									</div>	
								</div>						
							</td>			
						</tr>
					</table>
				</form>
			</div>
			<hr>

			<div class="col text-right">

				<c:if test="${'first' eq requestScope.type }">
					<button type="button" class="btn btn-default" style="outline: none;" id="firstWrite">등록</button>
				</c:if>
				<c:if test="${'update' eq requestScope.type }">
					<button type="button" class="btn btn-default" style="outline: none;" id="updateWrite">수정</button>
				</c:if>

				<input type="button" class="btn btn-default" onclick="window.history.back();" value="취소" style="outline: none;">

			</div>

		</div>
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/channelWrite.js?${verQuery}"></script> --%>
<script>
	(function ($) {
		// do not remove this string
		"use strict";

		console.log("---------타입확인 : " + "${type }");
		
		$("#summernote_area").summernote({//summernote 선언
				height:500, //에디터 높이
				fontNames : ['맑은고딕', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New'],//폰트들
				fontNamesIgnoreCheck : ['맑은고딕'],
				minHeight : null,//최소 높이
				maxHeigth: null, //최대 높이
				focus: true,
				//theme: 'monokai',
			/*	callbacks: {
					onImageUpload: function(files, editor, welEditable){
						for(var i=files.length-1; i>=0; i--){
							sendFile(files[i], this);	
						}					
					}
				}*/
			});
		
		$(".note-popover").css("display", "none"); //네비바 숨김
		$("#summernote_area").summernote('lineHeight', 1); //썸머노트 줄간격 1로 줄이기

		// 수정일 경우 섬머노트 textarea에 값 넣기
		if( 'update' === '${type }')
		{
			$("#summernote_area").summernote("code", '${channelDto.content_tag }');
		}
		
		//채널 카테고리 불러오기
		$.ajax({
			url: '/ChannelCategory'
			,type:'get'
			,success: function( data, status, xhr ){
				
				for(var i = 0; i < data.list.length; i++){
				
					var value = '<option value="' + data.list[i].pet_id + '">[' + decodeURIComponent(data.list[i].name) + ']</option>'
					
					$('.vm-channelWrite__category').append( value );
					
				}
			}, error: function( xhr, status, error ){
				console.dir("error : " + jqXHR + textstatus + errorThrown);
			}
		}); 

		//글 등록
		$("#firstWrite").on("click", function(){

			// 유효성 검사
			//제목
			if($(".vm-channelWrite__title-input").val().trim() === ""){
				alert("제목을 입력 해주세요.");
				return false;
			}

			// 채널선택
			if($(".vm-channelWrite__category").val() === "채널선택"){
			alert("채널을 선택 해주세요.");
			return false;
			}

			var $contentTag	= $("#summernote_area").summernote("code");
			
			//유튜브 ID 추출하기
			var youtubeURL	= "";
		    var youtubeId	= "";

		    if(	$($contentTag).find("iframe") === null ){
		    	alert("영상을 등록해주세요!");
		    }
		    
		    $(".note-editable iframe").each(function(i, element){
		    	$(this).attr("height", 600);
		    	//element.setAttribute("height", 600);	
		    });
			$($contentTag).find("iframe").each(function(i, element){
				youtubeURL = element.getAttribute("src");
			});
		
			//내용이 입력되지 않은 경우 (썸머노트코드.text().trim()값이 빈문자열) 
			//이코드는 위치가 중요한 가 봄
			if($($contentTag).text().trim() === ""){
				alert("내용을 입력 해 주세요.");
				return false;
			}

	        var regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/;
	        var matchs = youtubeURL.match(regExp);
	        if (matchs) {
	        	youtubeId = matchs[7];
	        }
					
			var formSerializeValues = $("#vm-channelWrite__write-form").serializeArray();
			formSerializeValues.push({'name': 'content', 'value' : JSON.stringify( $($contentTag).text() )});
			formSerializeValues.push({'name': 'youtubeId', 'value':  youtubeId });
			
			$.ajax({
				url: "/ChannelWrite"
				, type: 'get'
				, data : formSerializeValues
				, cache : false
				, async : true
				, success:function ( data, status, xhr ) {
					if( 1 === data.result ){
						alert("성공적으로 등록되었습니다.");					
						location.href = "/ChannelList";				
					}
					else{
						alert("글 등록에 실패했습니다.\n다시 시도해주세요.");
					}

				}, error : function(jqXHR, textstatus, errorThrown){
					console.dir("error : " + jqXHR + textstatus + errorThrown);
				}
			});
		});
		
		//수정
		$("#updateWrite").on("click", function(){

			var $contentTag	= $("#summernote_area").summernote("code");
			
			//유튜브 ID 추출하기
			var youtubeURL	= "";
		    var youtubeId	= "";

			$($contentTag).find("iframe").each(function(i, element){
				youtubeURL = element.getAttribute("src");
			});
				
	        var regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/;
	        var matchs = youtubeURL.match(regExp);
	        if (matchs) {
	        	youtubeId = matchs[7];
	        }
					
			//내용이 입력되지 않은 경우 (썸머노트코드.text().trim()값이 빈문자열)
			if($($contentTag).text().trim() === ""){
				alert("내용을 입력 해 주세요.");
				return false;
			}

			var formSerializeValues = $("#vm-channelWrite__write-form").serializeArray();
			formSerializeValues.push({'name': 'content', 'value' : JSON.stringify( $($contentTag).text() )});
			formSerializeValues.push({'name': 'youtubeId', 'value':  youtubeId });
			formSerializeValues.push({'name': 'no', 'value' : '${channelDto.no }' });
			
			$.ajax({
				url: "/ChannelUpdate"
				, type: 'get'
				, data : formSerializeValues
				, cache : false
				, async : true
				, success:function ( data, status, xhr ) {
					if( 1 === data.result ){
						alert("성공적으로 등록되었습니다.");					
						location.href = "/ChannelList";				
					}
					else{
						alert("글 등록에 실패했습니다.\n다시 시도해주세요.");
					}

				}, error : function(jqXHR, textstatus, errorThrown){
					console.dir("error : " + jqXHR + textstatus + errorThrown);
				}
			});
		});
		

	}(jQuery));
</script>
<%-- -------- //JavaScript -------- --%>