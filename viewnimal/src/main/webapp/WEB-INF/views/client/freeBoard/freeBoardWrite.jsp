<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*" %>

<c:import url="/WEB-INF/views/common/top.jsp" />
<link rel="stylesheet" href="/resources/each/css/freeBoardWrite.css?${verQuery}" />

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-freeBoardWrite">
		<div class="vm-section">

		<div class="vui-headline">자유게시판</div>

		<div id="vui-table">
			
			<form id="vm-freeBoardWrite__write-form">
				<table class="table">
					<tr>
						<th><label>말머리</label></th>
						<td>
							<div class="row">
								<div class="col-md-12">
									<c:if test="${'update' eq type }">
										<c:set var="category" value="${freeBoardDto.category }"/>
											<c:if test="${ '[사담]' eq category }">
												<c:set var="selected0" value="selected"/>
											</c:if>
											<c:if test="${ '[자랑]' eq category }">
												<c:set var="selected1" value="selected"/>
											</c:if>
											<c:if test="${ '[질문]' eq category }">
												<c:set var="selected2" value="selected"/>
											</c:if>
											<c:if test="${ '[기타]' eq category }">
												<c:set var="selected3" value="selected"/>
											</c:if>
																													
										<select class="vm-freeBoardWrite__category" id="category" name="category">
										  <option value="말머리선택">말머리선택</option>
										  <option value="[사담]" ${selected1 }>[사담]</option>
										  <option value="[자랑]" ${selected2 }>[자랑]</option>
										  <option value="[질문]" ${selected3 }>[질문]</option>
										  <option value="[기타]" ${selected4 }>[기타]</option>
										</select>
									</c:if>
									<c:if test="${'update' ne type }">
									<select class="vm-freeBoardWrite__category" id="category" name="category">
									  <option value="말머리선택">말머리선택</option>
									  <option value="[사담]">[사담]</option>
									  <option value="[자랑]">[자랑]</option>
									  <option value="[질문]">[질문]</option>
									  <option value="[기타]">[기타]</option>
									</select>
									</c:if>
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
										<input type="text" class="vm-freeBoardWrite__title-input form-control form-control-alternative" id="title"  name="title" value='${freeBoardDto.title }'>	
									</c:if>
									<c:if test="${'update' ne type }">
										<input type="text" class="vm-freeBoardWrite__title-input form-control form-control-alternative" id="title"  name="title">
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
				<c:if test="${'reply' eq requestScope.type }">
					<button type="button" class="btn btn-default" style="outline: none;" id="replyWrite">등록</button>
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
<style type="text/css">

</style>

<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/freeBoardWrite.js?${verQuery}"></script> --%>
<script>
	(function ($) {
		// do not remove this string
		"use strict";

		console.log("---------타입확인 : " + "${requestScope.type }");

		$("#summernote_area").summernote({//summernote 선언
			width:976, //에디터 넓이
			height:570, //에디터 높이
			fontNames : ['맑은고딕', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New'],//폰트들
			fontNamesIgnoreCheck : ['맑은고딕'],
			minHeight : null,//최소 높이
			maxHeigth: null, //최대 높이
			focus: true,
			callbacks: {
				onImageUpload: function(files, editor, welEditable){
					for(var i=files.length-1; i>=0; i--){
						sendFile(files[i], this);	
					}					
				}
			}
		}); 

		$(".note-popover").css("display", "none"); //네비바 숨김
		$("#summernote_area").summernote('lineHeight', 1); //썸머노트 줄간격 1로 줄이기
		
		
		// 수정일 경우 섬머노트 textarea에 값 넣기
		if( 'update' === '${type }')
		{
			$("#summernote_area").summernote("code", '${freeBoardDto.content_tag }');
		}

		//원글 등록
		$("#firstWrite").on("click", function(){

			// 유효성 검사
			//제목
			if($(".vm-freeBoardWrite__title-input").val().trim() === ""){
				alert("제목을 입력 해주세요.");
				return false;
			}

			// 채널선택
			if($(".vm-freeBoardWrite__category").val() === "말머리선택"){
			alert("말머리를 선택 해주세요.");
			return false;
			}

			var $contentTag	= $("#summernote_area").summernote("code");
			var imgObject	= "";
			var imgListArr	= [];

			$($contentTag).find("img").each(function(i, element){
				imgObject = element.getAttribute("src");
				imgListArr.push( imgObject );
			});
			
			//내용이 입력되지 않은 경우 (썸머노트코드.text().trim()값이 빈문자열이면서, 이미지 등록도 안했을때)
			if(imgListArr.length === 0 && $($contentTag).text().trim() === ""){
				alert("내용을 입력 해 주세요.");
				return false;
			}

			var formSerializeValues = $("#vm-freeBoardWrite__write-form").serializeArray();
			formSerializeValues.push({'name': 'imgListArr', 'value' : JSON.stringify(imgListArr)});
			formSerializeValues.push({'name': 'content', 'value' : JSON.stringify($($contentTag).text())});
			
			$.ajax({
				url: "/InsertFreeBoard"
				, type: 'post'
				, data : formSerializeValues
				, cache : false
				, async : true
				, success:function ( data, status, xhr ) {
					if(data.resultMessage === "success"){
						location.href = "/FreeBoardList";				
					}
					else{
						alert("글 등록에 실패했습니다.\n다시 시도해주세요.");
					}

				}, error : function(jqXHR, textstatus, errorThrown){
					console.dir("error : " + jqXHR + textstatus + errorThrown);
				}
			});
		});
		
		//summernote에서 이미지 업로드시 실행 함수
		function sendFile(file, el){
			//파일 전송 위한 폼생성
			var form_data = new FormData();
			form_data.append("file", file);
			$.ajax({
				data : form_data,
				type : "post",
				url: "/freeBoardFileUpload",
				cache : false,
				contentType : false,
				processData : false,
				async : true, 
				success:function(data){
					//에디터에 이미지 출력
					$(el).summernote('editor.insertImage', data.imgUrl);//서머노트 에디터에 이미지 등록	
				}
			});
		}
		
		//답글 등록
		$("#replyWrite").on("click", function(){

			// 유효성 검사
			//제목
			if($(".vm-freeBoardWrite__title-input").val().trim() === ""){
				alert("제목을 입력 해주세요.");
				return false;
			}

			// 채널선택
			if($(".vm-freeBoardWrite__category").val() === "말머리선택"){
			alert("말머리를 선택 해주세요.");
			return false;
			}

			var $contentTag	= $("#summernote_area").summernote("code");
			var imgObject	= "";
			var imgListArr	= [];

			$($contentTag).find("img").each(function(i, element){
				imgObject = element.getAttribute("src");
				imgListArr.push( imgObject );
			}); 			

			//내용이 입력되지 않은 경우 (썸머노트코드.text().trim()값이 빈문자열이면서, 이미지 등록도 안했을때)
			if(imgListArr.length === 0 && $($contentTag).text().trim() === ""){
				alert("내용을 입력 해 주세요.");
				return false;
			}

			var formSerializeValues = $("#vm-freeBoardWrite__write-form").serializeArray();
			formSerializeValues.push({'name': 'imgListArr', 'value' : JSON.stringify(imgListArr)});
			formSerializeValues.push({'name': 'content', 'value' : JSON.stringify($($contentTag).text())});
			formSerializeValues.push( {'name': 'group_no', 'value' : '${freeBoardDto.group_no }'} );
			formSerializeValues.push( {'name': 'parent_no', 'value' : '${freeBoardDto.parent_no }' } );
			formSerializeValues.push( {'name': 'group_order', 'value' : '${freeBoardDto.group_order }' } );
			formSerializeValues.push( {'name': 'board_level', 'value' : '${freeBoardDto.board_level }' } );
			
			$.ajax({
				url: "/InsertWriteReplyFreeBoard"
				, type: 'post'
				, data : formSerializeValues
				, cache : false
				, async : true
				, success:function ( data, status, xhr ) {
					if(data.resultMessage === "success"){
						location.href = "/FreeBoardList";				
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

			// 유효성 검사
			//제목
			if($(".vm-freeBoardWrite__title-input").val().trim() === ""){
				alert("제목을 입력 해주세요.");
				return false;
			}

			// 채널선택
			if($(".vm-freeBoardWrite__category").val() === "말머리선택"){
			alert("말머리를 선택 해주세요.");
			return false;
			}

			var $contentTag	= $("#summernote_area").summernote("code");
			var imgObject	= new Object();
			var imgListArr	= new Array();

			$($contentTag).find("img").each(function(i, element){
				imgObject = element.getAttribute("src");
				imgListArr.push( imgObject );
			}); 			
			
			console.log(">>>>>>>>>>>" + '${freeBoardDto.no }');
			
			var formSerializeValues = $("#vm-freeBoardWrite__write-form").serializeArray();
			formSerializeValues.push({'name': 'imgListArr', 'value' : JSON.stringify(imgListArr)});
			formSerializeValues.push({'name': 'content', 'value' : JSON.stringify( $($contentTag).text() )});
			formSerializeValues.push({'name': 'no', 'value' : '${freeBoardDto.no }' });
			
			$.ajax({
				url: "/updateFreeBaord"
				, type: 'post'
				, data : formSerializeValues
				, cache : false
				, async : true
				, success:function ( data, status, xhr ) {
					if(data.resultMessage === "success"){
						location.href = "/FreeBoardList";				
					}
					else{
						alert("글 수정에 실패했습니다.\n다시 시도해주세요.");
					}

				}, error : function(jqXHR, textstatus, errorThrown){
					console.dir("error : " + jqXHR + textstatus + errorThrown);
				}
			});
		});
		
		
		
		
		//답글 등록
		/* $("#replyWrite").on("click", function(){

			var $contentTag	= $("#summernote_area").summernote("code");
			var imgObject	= "";
			var imgListArr	= [];

			$($contentTag).find("img").each(function(i, element){
				imgObject = element.getAttribute("src");
				imgListArr.push( imgObject );
			}); 			

			var allData = {
				"category"		: $('#category').val()
				, "title"		: $('#title').val()
				, "content"		: $($contentTag).text()
				, "content_tag"	: $contentTag
				, "id"			: '${sessionScope.loginMemberDto.id }'
				, "group_no"	: '${freeBoardDto.group_no }'
				, "parent_no"	: '${freeBoardDto.parent_no }'
				, "group_order"	: '${freeBoardDto.group_order }'
				, "board_level"	: '${freeBoardDto.board_level }'
				, "imgListArr"	: imgListArr
			}
			
			$.ajax({
				url: 'InsertWriteReplyFreeBoard'
				, type: 'post'
				, data : JSON.stringify( allData )
				, contentType: "application/json; charset=UTF-8"
				, success: function(){
					
					location.href="FreeBoardList";

				}, error : function(jqXHR, textstatus, errorThrown){
					console.dir("error : " + jqXHR + textstatus + errorThrown);
				}
			});
		}); */
		
		// javascript code here
	}(jQuery));
</script>
<%-- -------- //JavaScript -------- --%>