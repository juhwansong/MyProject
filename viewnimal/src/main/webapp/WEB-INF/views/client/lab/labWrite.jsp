<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF/views/common/top.jsp" />


<link rel="stylesheet" href="/resources/each/css/volunteerApplyWrite.css?${verQuery}" />



<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-labWrite">
		<div class="vm-section">
		<div id="vui-table">
		<form id="lab-form" action="/insertLab" method="post">
				<table class="table">
					<tr>
						<th><label>제목</label></th>
						<td>
							<div class="row">
								<div class="col-md-12">								
									<input type="text" class="form-control form-control-alternative" id="lab-title" name="title" placeholder="제목을 입력해주세요." required>							
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<th><label>내용</label></th>
						<td>
							<div class="row">
								<div class="col-md-12">								
									<textarea  id="summernote_area" name="content_tag" placeholder="내용을 적어주세요" ></textarea>				
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
				<button type="button" id="lab-insert-btn" class="btn btn-primary" style="outline: none;">등록</button>
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
			alert("글쓰기 권한이 없습니다.");
			location.href="/Lab";
		}
		
		$("#summernote_area").summernote({//summernote 선언
			height:500, //에디터 높이
			fontNames : ['맑은고딕', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New'],//폰트들
			fontNamesIgnoreCheck : ['맑은고딕'],
			minHeight : null,//최소 높이
			maxHeigth: null, //최대 높이
			focus: true,
			placeholder : '쌍따옴표랑 아닌거랑 차이가 있나욤 껄껄껄껄껄껄껄껄껄껄껄 넴 넴 알겠읍니다,,,껄껄',
			callbacks: {
				
				onImageUpload: function(files, editor, welEditable){
					for(var i=files.length-1; i>=0; i--){
						sendFile(files[i], this);	
					}					
				},  
				onKeydown: function(e) {
		            var t = e.currentTarget.innerText;
		            if (t.trim().length >= 2000){//최대 길이 제한
		              //delete key
		              if (e.keyCode != 8){//뒤로가기 키가 아닐때
		                e.preventDefault();
		              }
		              callbackMax(2000, e.currentTarget);
		              // add other keys ...
		            }
			    },
				onKeyup: function(e) {
		            var t = e.currentTarget.innerText;
		            if (typeof callbackMax == 'function') {
		              callbackMax(2000, e.currentTarget);
		            }
			    },
				//키보드 입력 콜백 함수 (글자 수 제한)
		        onPaste: function(e) {	        	
		            var t = e.currentTarget.innerText;
		            var bufferText = ((e.originalEvent || e).clipboardData || window.clipboardData).getData('Text');
		            e.preventDefault();
		            //var all = t + bufferText;
		            var all = bufferText;
		            document.execCommand('insertText', false, all.trim().substring(0, 2000));//복사한걸 붙이는 함수(복사 붙여넣기 할때 복사한 문자열의 2000번째까지만 복사가됨(복사문자 천자제한))
		          
		            if (typeof callbackMax == 'function') {		        	 
		        	    callbackMax(2000, e.currentTarget);
		            }     
		        }		       
			}
			
		});
		
		 $("#summernote_area").summernote('lineHeight', 1); 
		
		$(document).on("click", "#lab-insert-btn", function(){
			
			var contentTag = $("#summernote_area").summernote("code");
			var imgObject = "";
			var imgListArr = new Array();
			var content = $(contentTag).text();
			
			$(contentTag).find("img").each(function(i, element){
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
			
			
			$.ajax({
				url : '/insertLab',
				type : 'post',
				dataType : 'json',
				data : formSerializeValues,
				cache : false,
				async : true,
				success : function (data, status, xhr){
					if(data.resultMessage === "success"){
						alert("등록이 성공하였습니다.");
						location.href = "/Lab";
					}else{
						alert("등록이 실패하였습니다.");
					}
					
				},
				error : function(xhr, status, error){
					alert("문제가 발생하였습니다. \n다시 시도해주십시오.");
				}
				
			});
		});
		
		function sendFile(file, el){
			
			var fileExtension = file.name.slice(file.name.lastIndexOf(".") + 1).toLowerCase();		 
		    if (!(fileExtension == "gif" || fileExtension == "jpg" || fileExtension == "png")) {
		        alert("이미지 파일(.jpg, .png, .gif )만 업로드 가능합니다.");
		        return false;
		    } 
			//최대 용량 제한
		    if (file.size > 10000000) {
		        alert("이미지가 최대 제한 용량을 초과합니다.");
		        return false;
		    }
			
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
		
		
		var htmlRestore = $("#summernote_area").summernote('code'); //서머노트의 이전 html태그코드를 저장하기 위한 변수
		function callbackMax(max, t){
			var remainLength = max - t.innerText.length;
			if(remainLength > 0){	
				htmlRestore = $("#summernote_area").summernote('code');
			}
			else{
				alert(max + "자를 넘을 수 없습니다!");
				$("#summernote_area").summernote('code', htmlRestore);//이전에 저장한 코드로 바꿔치기한다.(innerText하면 사진도 사라짐)	
				$(".note-editable").placeCursorAtEnd(); //class note-editable이 실질적인 서머노트의 텍스트 에리어 부분		
			}
		}
		
		$.fn.extend({ //마지막 노드를 찾아 포커스온(서머노트에 이용)
	        placeCursorAtEnd: function () {
	            // Places the cursor at the end of a contenteditable container (should also work for textarea / input)
	            if (this.length === 0) {
	                throw new Error("Cannot manipulate an element if there is no element!");
	            }
	            var el = this[0];
	            var range = document.createRange();
	            var sel = window.getSelection();
	            var childLength = el.childNodes.length;
	            if (childLength > 0) {
	                var lastNode = el.childNodes[childLength - 1];
	                var lastNodeChildren = lastNode.childNodes.length;
	                range.setStart(lastNode, lastNodeChildren);
	                range.collapse(true);
	                sel.removeAllRanges();
	                sel.addRange(range);
	            }
	            return this;
	        }
	    });

		// javascript code here
	}(jQuery));
</script>
<%-- -------- //JavaScript -------- --%>