<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF/views/common/top.jsp" />

<link rel="stylesheet" href="/resources/vendor/calendar/monthly.css?${verQuery}">
<link rel="stylesheet" href="/resources/each/css/volunteerApplyWrite.css?${verQuery}" />

 <style type="text/css">
	.vm-volunteerApplyWrite .monthly {
		box-shadow: 0 13px 40px rgba(0, 0, 0, 0.5);
		font-size: 0.8em;
	} 
	.vm-volunteerApplyWrite .picker-monthly{
		text-align:center; 	
		line-height: 1.33em;
	}  
	
	.vm-volunteerApplyWrite .vm-volunteerApplyWrite__picker-calendar-box{
		z-index: 5;
	}
	.vm-volunteerApplyWrite .vm-volunteerApplyWrite__applydate-box input{
		text-align:right;
	}
	.vm-volunteerApplyWrite .vm-volunteerApplyWrite__content{
		margin-top:32px;
	} 
	.vm-volunteerApplyWrite .td__button-box{
		margin-top:20px;
		padding:0px;
	}
	.vm-volunteerApplyWrite{
		word-break : break-all;
	}
</style> 

<%-- -------- JSP -------- --%>

<div class="vm-container">
	<div class="vm-content vm-volunteerApplyWrite">	
		<div class="vm-section">
			<div class="vui-headline">자원봉사</div>
			
			<!-- 본문 시작 -->
			<div class="vm-volunteerApplyWrite__content">
				<form id="volunteer-apply-write-form">
					<table class="table">
						<tr>
							<th width="20%"><label>등록일자</label></th>
							<td width="80%">
								<div class="row vm-volunteerApplyWrite__applydate-box">	
									<div class="col-md-1">																									
										<button type="button" class="btn btn-primary" id="picker-btn" style="outline: none;"><i class="ni ni-calendar-grid-58"></i></button>
										<div class="monthly picker-monthly vm-volunteerApplyWrite__picker-calendar-box" id="picker-calendar"></div>														   				      	 						     	 								     	 									
									</div>										    				
							   		<div class="col-md-3">					
						      	 		<input type="text" id="applydate-year" readonly="readonly" class="form-control form-control-alternative" >					      	 						     	 						     	 		
							   	 	 </div>	
							   	 	 <label>년</label>
								   	 <div class="col-md-2">						     	
							     	   	<input type="text" id="applydate-month" readonly="readonly" class="form-control form-control-alternative"/>							    	
								   	 </div>
								   	 <label>월</label>
								   	 <div class="col-md-2">							     	
							     	   	<input type="text" id="applydate-date" readonly="readonly"  class="form-control form-control-alternative"/>					    	
								   	 </div>
								   	 <label>일</label>
								   	 <input type="text" id="applydate-format" name="volunteer_date" hidden="" class="form-control form-control-alternative" value=""/>	
							  	</div>
							</td>
						</tr>
						<tr>
							<th><label>모집기한</label></th>
							<td>
								<div class="row vm-volunteerApplyWrite__applydate-box">	
									<div class="col-md-1">																									
										<button type="button" class="btn btn-primary" id="limit-picker-btn" style="outline: none;"><i class="ni ni-calendar-grid-58"></i></button>
										<button hidden="" type="button" id="hidden-limit-picker-btn"></button>
										<div class="monthly picker-monthly vm-volunteerApplyWrite__picker-calendar-box" id="limit-picker-calendar"></div>														   				      	 						     	 								     	 									
									</div>												    				
							   		<div class="col-md-3">					     	
						      	 		<input type="text" id="limit-applydate-year" readonly="readonly" class="form-control form-control-alternative" >					      	 						     	 							     	
							   	 	 </div>
							   	 	 <label>년</label>
								   	 <div class="col-md-2">					     	
							     		<input type="text" id="limit-applydate-month" readonly="readonly" class="form-control form-control-alternative"/>							    
								   	 </div>
								   	 <label>월</label>
								   	 <div class="col-md-2">						     
							     	  	<input type="text" id="limit-applydate-date" readonly="readonly" class="form-control form-control-alternative"/>							    
								   	 </div>
								   	 <label>일</label>
								   	 <input type="hidden" name="limit_date" id="limit-applydate-format">
							  	</div>
							</td>
						</tr>
						<tr>
							<th><label>모집인원</label></th>
							<td>
								<div class="row">
									<div class="col-md-2">							
										<input type="text" id="apply_max_count" name="apply_max_count" maxlength="5" class="form-control form-control-alternative">
									</div>
									<div class="col-md-2">	
										<label>명</label>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th><label>봉사지</label></th>
							<td>
								<div class="row">
									<div class="col-md-12">							
										<input type="text" id="volunteer_area" name="volunteer_area" maxlength="32" class="form-control form-control-alternative">								
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th><label>제목</label></th>
							<td>
								<div class="row">
									<div class="col-md-12">								
										<input type="text" id="volunteer-apply-title" name="title" maxlength="32" class="form-control form-control-alternative">							
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
									<input hidden="" id="content-no-tag" name="content">
								</div>						
							</td>			
						</tr>
						<tr>
							<th></th>
							<td>
								<div class="col text-right td__button-box">
									<button type="button" class="btn btn-secondary" id="volunteer-apply-insert-btn" style="outline: none;">등록</button>
									<input type="button" class="btn btn-secondary" onclick="window.history.back();" value="취소" style="outline: none;">
								</div>
							</td>
						</tr>
					</table>
				</form>
				<!-- 본문끝 -->
			</div>
		</div>
	</div>
</div>


<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<script src="/resources/vendor/calendar/monthly.js?${verQuery}"></script>
<%-- <script src="/resources/each/js/volunteerApplyWrite.js?${verQuery}"></script> --%>
<script>
	(function ($) {
		// do not remove this string
		"use strict";
		
		var limitCalendarFlag = false; //모집 기한 클릭 시 처음에만 생성
		
		//관리자 전용 글쓰기 페이지에서 관리자 로그인 로그아웃 시
		if("${sessionScope.loginMemberDto.type}" !== "ADMIN"){
			alert("글쓰기 권한이 없기 때문에 메인으로 돌아갑니다.");
			location.href="/";
		}
		
		//monthly함수는 monthly.js에 정의돼 있음 (기본 UI에서 임의로 이것 저것 추가함)
		// target-> picker달력에서 원하는 날짜 클릭 시 target input에 해당 날짜 데이터가 뿌려짐
		// childTarget -> 모집 기한 데이터 정보 input
		$('#picker-calendar').monthly({ 
			mode: 'picker',
			target : '#applydate-format', 
			targetYear : '#applydate-year',
			targetMonth : '#applydate-month',
			targetDate : '#applydate-date',
			childTarget : '#limit-applydate-format',
			childTargetYear : '#limit-applydate-year',
			childTargetMonth : '#limit-applydate-month',
			childTargetDate : '#limit-applydate-date',
			setWidth: '250px',
			startHidden: true,
			showTrigger: '#picker-btn',
			stylePast: true,
			disablePast: true
		}); 
		

		$(document).on("click","#limit-picker-btn", function(){
			if($("#applydate-format").val() === ""){
				alert("등록일자를 먼저 등록해 주세요.");
			}
			else{
				if(limitCalendarFlag === false){
					limitCalendarFlag = true;
					$('#limit-picker-calendar').monthly({
						mode: 'limit-picker',
						target : '#limit-applydate-format',
						targetYear : '#limit-applydate-year',
						targetMonth : '#limit-applydate-month',
						targetDate : '#limit-applydate-date',
						setWidth: '250px',
						startHidden: true,
						limitDateId: 'applydate-format',
						showTrigger: '#hidden-limit-picker-btn',
						stylePast: true,
						disablePast: true
					});
				}
				$("#hidden-limit-picker-btn").trigger("click");				
			}
		});
				
	
				
		$("#summernote_area").summernote({//summernote 선언
			width:976,
			height:570, //에디터 높이
			focus: false,
			placeholder: '글자는 1000자 제한입니다.',
			fontNames : ['맑은고딕', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New'],//폰트들
			fontNamesIgnoreCheck : ['맑은고딕'],
			minHeight : null,//최소 높이
			maxHeigth: null, //최대 높이
			callbacks: {
				
				onImageUpload: function(files, editor, welEditable){
					for(var i=files.length-1; i>=0; i--){
						sendFile(files[i], this);	
					}					
				},  
				onKeydown: function(e) {
		            var t = e.currentTarget.innerText;
		            if (t.trim().length >= 1000){//최대 길이 제한
		              //delete key
		              if (e.keyCode != 8){//뒤로가기 키가 아닐때
		                e.preventDefault();
		              }
		              callbackMax(1000, e.currentTarget);
		              // add other keys ...
		            }
			    },
				onKeyup: function(e) {
		            var t = e.currentTarget.innerText;
		            if (typeof callbackMax == 'function') {
		              callbackMax(1000, e.currentTarget);
		            }
			    },
				//키보드 입력 콜백 함수 (글자 수 제한)
		        onPaste: function(e) {	//복붙 할때 이벤트        	
		            var t = e.currentTarget.innerText;
		            var bufferText = ((e.originalEvent || e).clipboardData || window.clipboardData).getData('Text');
		            e.preventDefault();
		            //var all = t + bufferText;
		            var all = bufferText;
		            document.execCommand('insertText', false, all.trim().substring(0, 1000));//복사한걸 붙이는 함수(복사 붙여넣기 할때 복사한 문자열의 1000번째까지만 복사가됨(복사문자 천자제한))
		          
		            if (typeof callbackMax == 'function') {		        	 
		        	    callbackMax(1000, e.currentTarget);
		            }     
		        },		       
			}
		}); 
		
		$(".note-popover").css("display", "none"); //네비바 숨김
		//$(".note-toolbar *").css("background", "#11cdef");
		//$(".note-toolbar *").css("border-color", "#11cdef");
		
		$(document).on("click", "#volunteer-apply-insert-btn", function(){
			//유효성 검사
			//등록일자 유효성
			if($("#applydate-format").val() === ""){
				alert("등록일자를 입력 해 주세요.");
				return false;
			}
			//모집기한 유효성
			if($("#limit-applydate-format").val() === ""){
				alert("모집기한을 입력 해 주세요.");
				return false;
			}
			//모집인원 유효성
			//공백 제거
			$("#apply_max_count").val($("#apply_max_count").val().trim());
			if($("#apply_max_count").val() === ""){
				alert("모집인원을 입력 해 주세요.");
				return false;
			}		
			//모집인원은 숫자만 입력되게
			var applyMaxCountReg = /^[0-9]*$/;
			if(!applyMaxCountReg.test($("#apply_max_count").val())){
				alert("모집인원을 올바르게 입력 해 주세요.");
				return false;
			}
			//모집인원 값 왼쪽에 숫자 0붙었을 시 삭제
			$("#apply_max_count").val($("#apply_max_count").val().replace(/(^0+)/, ""));
			if($("#apply_max_count").val() === ""){
				alert("모집인원은 반드시 1명 이상으로 입력 해 주세요.");
				return false;
			}
			//봉사지 유효성
			//공배 제거
			$("#volunteer_area").val($("#volunteer_area").val().trim());
			if($("#volunteer_area").val() === ""){
				alert("봉사지를 입력 해 주세요.");
				return false;
			}
			//제목 유효성
			//공백 제거
			$("#volunteer-apply-title").val($("#volunteer-apply-title").val().trim());
			if($("#volunteer-apply-title").val() === ""){
				alert("제목을 입력 해 주세요.");
				return false;
			}
			
			var contentTag	= $("#summernote_area").summernote("code");						
			var imgObject	= "";
			var imgListArr	= [];
			
			$(contentTag).find("img").each(function(i, element){
				imgObject = element.getAttribute("src");
				imgListArr.push( imgObject );
			}); 
			
			//내용이 입력되지 않은 경우 (썸머노트코드.text().trim()값이 빈문자열이면서, 이미지 등록도 안했을때)
			if(imgListArr.length === 0 && $(contentTag).text().trim() === ""){
				alert("내용을 입력 해 주세요.");
				return false;
			}
			
			//봉사지와 제목의 "특수문자 제거
			$("#volunteer_area").val($("#volunteer_area").val().replace(/[\"]/gim, ""));
			$("#volunteer-apply-title").val($("#volunteer-apply-title").val().replace(/[\"]/gim, ""));
			
			$("#content-no-tag").val($(contentTag).text());
			
			var formSerializeValues = $("#volunteer-apply-write-form").serializeArray();
			formSerializeValues.push({'name': 'imgListArr', 'value' : JSON.stringify(imgListArr)});
			App.loading.show(); //로딩 띄우기
			$.ajax({
				  url 		: '/insertVolunteerApply'
				, type 		: 'post'
				, dataType 	: 'json'
				, data 		: formSerializeValues
				, cache     : false
				, async		: true
				, success 	: function ( data, status, xhr ) {
					if(data.resultMessage === "success"){
						alert("성공적으로 등록되었습니다.");
						location.replace("/VolunteerApplyList");	//뒤로가기 했을때 글쓰기 페이지 보이면 이상하니 리스트 페이지로 대체			
					}
					else{
						alert("글 등록에 실패했습니다.");
					}
				}
				, error 	: function ( xhr, status, error ) {
					alert('문제가 발생했습니다.\n다시 시도해주세요.');
				}
				, complete: function( xhr, status){
					App.loading.hide();//로딩 끝
				}
			});		
		});

		// javascript code here
		//summernote에서 이미지 업로드시 실행 함수
		function sendFile(file, el){    
			//확장자 확인 후 그림파일 아니면 return false
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
			
		    App.loading.show(); //로딩 띄우기
			//파일 전송 위한 폼생성
			var form_data = new FormData();
			form_data.append("file", file);
			$.ajax({
				data : form_data,
				type : "post",
				url: "/volunteerApplyfileupload",
				cache : false,
				contentType : false,
				processData : false,
				async : true, 
				success:function(data){
					//에디터에 이미지 출력
					$(el).summernote('editor.insertImage', data.imgUrl);//서머노트 에디터에 이미지 등록	
				},
				complete : function(xhr, status){
					App.loading.hide(); //로딩 끄기
				}
			});
		}
	
	
		var htmlRestore = ""; //서머노트의 이전 html태그코드를 저장하기 위한 변수
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
		
	}(jQuery));
	


</script>
<%-- -------- //JavaScript -------- --%>