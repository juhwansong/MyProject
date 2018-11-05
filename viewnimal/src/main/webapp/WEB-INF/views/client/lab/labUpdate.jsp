<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF/views/common/top.jsp" />

<link rel="stylesheet" href="/resources/each/css/volunteerApplyWrite.css?${verQuery}" />



<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-labUpdate">
		<div class="vm-section">
		<div id="vui-table">
		<form id="lab-form" action="/updateLab" method="post">
				<table class="table">
					<tr>
						<th><label>제목</label></th>
						<td>
							<div class="row">
								<div class="col-md-12">								
									<input type="text" class="form-control form-control-alternative" id="lab-title" name="title" value="${Lab.title }" required>							
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<th><label>내용</label></th>
						<td>
							<div class="row">
								<div class="col-md-12">								
									<textarea  id="summernote_area" name="content_tag" >${Lab.content_tag }</textarea>				
								</div>	
							</div>						
						</td>			
					</tr>
					<!-- <tr>
						<th><label>태그</label></th>
						<td><div class="row">
								<div class="col-md-12">
								<textarea rows="3" cols="130" title="태그" id="lab_tag" name="lab_tag"></textarea>							
								</div>
							</div>
						</td>
					</tr> -->
				</table>
			</form>
			</div>
			<hr>
			<div class="col text-right">
				<button type="button" id="lab-update-btn" class="btn btn-primary" style="outline: none;">수정 등록</button>
				<input type="button" class="btn btn-primary" onclick="window.history.back();" value="취소" style="outline: none;">
			</div>
		</form>	
		</div>
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/labWrite.js?${verQuery}"></script> --%>
<script>
	(function ($) {
		// do not remove this string
		"use strict";
		
		if("${sessionScope.loginMemberDto.type}" !== "ADMIN"){
			alert("수정 권한이 없습니다.");
			location.href="/Lab";
		}
		
		$("#summernote_area").summernote({//summernote 선언
			height:500, //에디터 높이
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
		
		$("#summernote_area").summernote('lineHeight', 1);

		
		$(document).on("click", "#lab-update-btn", function(){
			
			var $contentTag = $("#summernote_area").summernote("code");
			var imgObject = "";
			var imgListArr = [];
			var content = $($contentTag).text();
			
			$($contentTag).find("img").each(function(i, element){
				imgObject = element.getAttribute("src");
				imgListArr.push(imgObject);
			});
			
			/* if(imgListArr.length === 0 &(contentTag).text().trim() === ""){
				alert("내용을 입력해 주세요.");
				return false;
			} */
			
			var formSerializeValues = $("#lab-form").serializeArray();
			formSerializeValues.push({'name': 'imgListArr', 'value' : JSON.stringify(imgListArr)});
			formSerializeValues.push({'name': 'content', 'value' : JSON.stringify( content )});
			formSerializeValues.push({'name': 'no', 'value' : ${Lab.no} });
			
			
			$.ajax({
				url : '/updateLab',
				type : 'post',
				dataType : 'json',
				data : formSerializeValues,
				cache : false,
				async : true,
				success : function (data, status, xhr){
					if(data.resultMessage === "success"){
						alert("수정이 성공하였습니다.");
						/* history.go(-1); */
						location.href= "/LabDetail?no=${Lab.no}";
					}else{
						alert("수정이 실패하였습니다.");
					}
					
				},
				error : function(xhr, status, error){
					alert("문제가 발생하였습니다. \n다시 시도해주십시오.");
				}
				
			});
		});
		
		function sendFile(file, el){
			var form_data = new FormData();
			form_data.append("file", file);
			$.ajax({
				data : form_data,
				type : "post",
				url: "/labFileUpload",
				cache : false,
				contentType : false,
				processData : false,
				async : true, //동기화설정을 안하면  파일 연속 추가할때 섹션에 이미지 경로 데이터가 제대로 안들어감
				success:function(data){
					//에디터에 이미지 출력
					$(el).summernote('editor.insertImage', data.imgUrl);
				}
			});
		}

		// javascript code here
	}(jQuery));
</script>
<%-- -------- //JavaScript -------- --%>