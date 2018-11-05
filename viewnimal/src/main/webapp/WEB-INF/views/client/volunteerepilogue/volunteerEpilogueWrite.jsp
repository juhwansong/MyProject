<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF/views/common/top.jsp" />

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.2/css/bootstrap-select.min.css?${verQuery}">
<link rel="stylesheet" href="/resources/each/css/volunteerEpilogueWrite.css?${verQuery}" />
<style>
	.vm-volunteerEpilogueWrite .vm-section table label{
		line-height: 38px;
	} 
	.vm-volunteerEpilogueWrite .vm-volunteerEpilogueWrite__content{
		margin-top:32px;
	} 
	.vm-volunteerEpilogueWrite .vm-volunteerEpilogueWrite__content__thumnail-box{
		position:relative;
		height:300px;
	}
	.vm-volunteerEpilogueWrite .vm-volunteerEpilogueWrite__content__thumnail-box div{
		display:flex;
		flex-direction: column;
		justify-content:center;
		align-items:center;
	}
	.vm-volunteerEpilogueWrite .vm-volunteerEpilogueWrite__content__thumnail-box__text{
		position:absolute;
		top:20%;
		left:12%;
		color:#2196F3;
	}
	.vm-volunteerEpilogueWrite .td__thumnail{
		padding-top:0px;
		padding-bottom:0px; 
		padding-right:32px;
		padding-left:32px;
	}
	.vm-volunteerEpilogueWrite .td__button-box{
		margin-top:20px;
		padding:0px;
	}
	.vm-volunteerEpilogueWrite .thumnail-box__background{
		/* background:#172b4d; */
		background: white;
	}
	.vm-volunteerEpilogueWrite .thumnail-box__img-box{
		background:white;
		width:300px;
		height:300px;	
		border-radius: 20px;		
	}
	.vm-volunteerEpilogueWrite .thumnail-box__img-box__img{
		position:absolute;
		left:40px;
		width:360px;
		height:280px;
		object-fit: cover;
		border-radius: 20px;
	}
	.vm-volunteerEpilogueWrite #img-preview-delete-btn{
		position:absolute;
		margin:0px;
		padding:0px;
		width:60px;
		height:60px;
		top:10px;
		right:10px;
		display:none;
		color:#f5365c;
		
		background: white;
		border-color: white;
	}
	.vm-volunteerEpilogueWrite{
		word-break : break-all;
	}
	
</style>
<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-volunteerEpilogueWrite">	
		<div class="vm-section">
			<div class="vui-headline">자원봉사 후기</div>
			<div class="vm-volunteerEpilogueWrite__content">
				<form id="volunteer-epilogue-write-form" >
					<table class="table">
						<tr>
							<th width="20%"><label>봉사날짜</label></th>
							<td width="80%">
								 <div class="row">	
								 	 <div class="col-md-12">						   	 
									   	 <div class="btn-group">
											<select id="volunteer-write-category" class="selectpicker" name="volunteer_date-select-box" data-style="btn-primary" data-width="200px">	
											</select>	
											<input hidden="" id="hidden-volunteer-date" name="volunteer_date">			
										 </div>	
									 </div>
								 </div>						   	 						  	
							</td>
						</tr>
						<tr>
							<th><label>봉사지</label></th>
							<td>
								<div class="row">
									<div class="col-md-12">							
										<input id="volunteer_area" type="text" name="volunteer_area" class="form-control form-control-alternative" readonly="readonly">								
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th><label>제목</label></th>
							<td>
								<div class="row">
									<div class="col-md-12">								
										<input type="text" maxlength="32" id="volunteer-epilogue-title" name="title" class="form-control form-control-alternative">							
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th><label>내용</label></th>
							<td>
								<div class="row">
									<div class="col-md-12">								
										<textarea name="content_tag"  id="summernote_area"></textarea>	
										<input hidden="" name="content" id="content-no-tag">	
										<input hidden="" name="imgListArr" id="imgListArr">		
									</div>	
								</div>						
							</td>			
						</tr>
						<tr>
							<th><label>썸네일</label></th>
							<td class="td__thumnail">							
								<div class="row vm-volunteerEpilogueWrite__content__thumnail-box">
									<label class="vm-volunteerEpilogueWrite__content__thumnail-box__text">썸네일 파일은 한개만 등록 가능합니다.</label>	
									<div class="col-md-6 form-control-alternative">								
										<input type="button" class="btn btn-primary " id="thumnail-file-btn" style="outline: none;" value="파일 첨부">
										<input type="file" hidden="" id="real-file-btn">								
									</div>
									<div class="col-md-6 form-control-alternative thumnail-box__background">
										<button type="button" class="btn btn-secondary" id="img-preview-delete-btn">
											<i class="fa fa-times-circle-o" style="font-size:30pt;"></i>
										</button>								
										<div class="thumnail-box__img-box" id="img-preview-box">
										</div>													
									</div>								
								</div>										
							</td>			
						</tr>
						<tr>
							<th></th>
							<td>
								<div class="col text-right td__button-box">
									<button type="button" id="volunteer-epilogue-insert-btn" class="btn btn-secondary" style="outline: none;">등록</button>
									<input type="button" class="btn btn-secondary" onclick="window.history.back();" value="취소" style="outline: none;">
								</div>
							</td>
						</tr>	
					</table>
				</form>	
			</div>			
		</div>
	</div>
</div>		

<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/volunteerEpilogueWrite.js?${verQuery}"></script> --%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.2/js/bootstrap-select.min.js?${verQuery}"></script>
<script>
	(function ($) {
		// do not remove this string
		"use strict";
		
		// javascript code here
		var realThumnailFile = "";
		
		//회원 전용 글쓰기 페이지에서 관리자 로그인 로그아웃 시
		if("${sessionScope.loginMemberDto.id}" === ""){
			alert("글쓰기 권한이 없기 때문에 메인으로 돌아갑니다.");
			location.href="/";
		}
		//작성 가능한 카테고리 목록 가져오기
		
		var volunteerAreaList = "";//봉사지역을 담는 배열

		//카테고리 목록 가져오는 함수
		App.loading.show(); //로딩 띄우기
		
		$.ajax({
			  url 		: '/selectVolunteerEpilogueWriteCategoryList'
			, type 		: 'post'
			, dataType 	: 'json'
			, async		: true
			, success 	: function ( data, status, xhr ) {
				
				for(var i=0; i < data.categoryList.length; i++){
					if(i === data.categoryList.length-1){
						$("#volunteer-write-category").append("<option selected>" + data.categoryList[i].volunteer_date + "</option>");		
					}
					else{
						$("#volunteer-write-category").append("<option>" + data.categoryList[i].volunteer_date + "</option>");
					}				
				}
				
				volunteerAreaList = data.categoryList;				
				//처음 불러왔을때 change 트리거 이용하여 change 이벤트 발생 처리
				$("#volunteer-write-category").trigger("change");
				
			}
			, error : function ( xhr, status, error ) {
				alert('문제가 발생했습니다.\n다시 시도해주세요.');
			}
			, complete : function(xhr, status){
				App.loading.hide(); //로딩 끄기
			}
		});
		
		
		
		
		//summernote 선언
		$("#summernote_area").summernote({
			width:976,
			height:570, //에디터 높이
			fontNames : ['맑은고딕', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New'],//폰트들
			fontNamesIgnoreCheck : ['맑은고딕'],
			minHeight : null,//최소 높이
			maxHeigth: null, //최대 높이
			focus: false,
			placeholder : '1000자 제한',
			//theme: 'monokai',
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
		        onPaste: function(e) {	        	
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
		
		$(document).on("click","#thumnail-file-btn",function(){ //파일 첨부 버튼 클릭 시
			$("#real-file-btn").trigger("click"); //자동으로 속성이 hidden인 input file 버튼이 클릭되게 트리거 발동 
		});
		
		$(document).on("change","#real-file-btn",function(){//로컬 파일 선택 창에서 파일 선택 후 확인 시
			
			var fileName = $("#real-file-btn").val(); 
			var fileExtension = fileName.slice(fileName.lastIndexOf(".") + 1).toLowerCase(); //파일 이름중 확장자 부분만 잘라서 저장
			
			if(fileName === ""){ //파일 선택창에서 x나 취소 버튼 클릭 시(input file은 취소 버튼 클릭 시 이전에 선택한 파일을 저장하는게 아니라 빈파일을 저장(초기화)하게 설계돼있다.)
			//input file은 보안 상 코드 상으로 직접 값을 넣어 줄 수 없다.
			//그래서 파일을 저장 할 변수를 따로 만들고 controller로 보낼때는 formData에 따로 append 메소드로 파일을 추가하여 보낸다.
				return false;
			}
			
		    if (!(fileExtension == "gif" || fileExtension == "jpg" || fileExtension == "png")) {//확장자가 이미지 파일이 아니라면

		    	$("#real-file-btn").val(""); //input file의 val값(저장된 파일) 초기화
		    	
		   		alert("이미지 파일(.jpg, .png, .gif )만 업로드 가능합니다.");
		    
		        return false;
		    }
			
			var thumnailFile = $("#real-file-btn")[0].files[0];
			if(thumnailFile.size > 10000000){ //업로드 용량 제한
				alert("이미지가 최대 제한 용량을 초과합니다.");
				return false;
			}
			var fileReader = new FileReader();
			
			fileReader.addEventListener("load", function () {
				if(!$("#img-preview-box").find("img").length > 0){ //길이가 0보다 크다는것은 img를 갖고 있다는 뜻
					$("#img-preview-box").append("<img></img>"); //이미지 태그 생성
					$("#img-preview-box img").addClass("thumnail-box__img-box__img");
					$("#img-preview-delete-btn").css("display","block");// 썸네일 파일 삭제 버튼 보이게
				}
				$("#img-preview-box img").attr("src", fileReader.result);
			}, false);

			if(thumnailFile){
				fileReader.readAsDataURL(thumnailFile);
				realThumnailFile = thumnailFile; //form으로 보낼 파일을 담음
			}		
		});
		$(document).on("click", "#img-preview-delete-btn", function(){
			$("#img-preview-delete-btn").css("display","none"); // 썸네일 파일 삭제 버튼 안보이게
			$("#img-preview-box img").remove(); // 썸네일 파일 보여주는 img 태그 삭제
			$("#real-file-btn").val(""); //input file의 val값(저장된 파일) 초기화
			
			realThumnailFile = ""; //실질적으로 formData로 보낼 파일이 담긴 변수 초기화
		});
		
		$(document).on("click", "#volunteer-epilogue-insert-btn", function(){
			
			//유효성 검사
			
			//제목 유효성
			if($("#volunteer-epilogue-title").val().trim() === ""){
				alert("제목을 입력 해 주세요.");
				return false;
			}
			
			/* if($("#real-file-btn")[0].files[0] === undefined){
				alert("썸네일을 첨부 해 주세요.");
				return false;
			} */
			if(realThumnailFile === ""){
				alert("썸네일을 첨부 해 주세요.");
				return false;
			}
			
			var contentTag	= $("#summernote_area").summernote("code");						
			var imgObject	= "";
			var imgListArr	= new Array();
			
			$(contentTag).find("img").each(function(i, element){
				imgObject = element.getAttribute("src");
				imgListArr.push( imgObject );
			}); 
			
			//내용이 입력되지 않은 경우 (썸머노트코드.text().trim()값이 빈문자열이면서, 이미지 등록도 안했을때)
			if(imgListArr.length === 0 && $(contentTag).text().trim() === ""){
				alert("내용을 입력 해 주세요.");
				return false;
			}
			
			//제목에 있는 "제거 불러올때 문제가 된다.		
			$("#volunteer-epilogue-title").val($("#volunteer-epilogue-title").val().replace(/[\"]/gim, "")); 
			
			//태그 없는 텍스트 내용만
			$("#content-no-tag").val($(contentTag).text());
					
			//히든 인풋 태그에 이미지 경로를 담은 배열 객체를 문자열로 변환하여 담음
			$("#imgListArr").val(JSON.stringify(imgListArr));
			
			$("#hidden-volunteer-date").val($("select[name=volunteer_date-select-box]").val());
			
			//폼 태그  변수에 담기
			var formSerializeValues = document.getElementById("volunteer-epilogue-write-form");			
			//멀티파트로 보낼 FormData객체 생성 (생성자로 폼 태그를 넣어 멀티파트로 보낼 수 있음)
			var formDataValues = new FormData(formSerializeValues);
			formDataValues.append("thumbnailfile", realThumnailFile);
			
			App.loading.show(); //로딩 띄우기
			
			$.ajax({
				  url 		: '/insertVolunteerEpilogue'
				, type 		: 'post'
				, dataType 	: 'json'
				, data 		: formDataValues
				, contentType : false
				, cache     : false
				, async		: true
				, processData : false
				, success 	: function ( data, status, xhr ) {
					if(data.resultMessage === "success"){
						alert("성공적으로 등록되었습니다.");	
						location.replace("/VolunteerEpilogueList");	//뒤로가기 했을때 글쓰기 페이지 보이면 이상하니 리스트 페이지로 대체		
					}
					else{
						alert("글 등록에 실패했습니다.");
					}
				}
				, error 	: function ( xhr, status, error ) {
					alert('문제가 발생했습니다.\n다시 시도해주세요.');
				}
				, complete : function(xhr, status){
					App.loading.hide(); //로딩 끄기
				}
			});		
		});
		
		//summernote에서 이미지 업로드시 실행 함수
		function sendFile(file, el){
			//확장자 확인 후 그림파일 아니면 return false
			var fileExtension = file.name.slice(file.name.lastIndexOf(".") + 1).toLowerCase();		 
		    if (!(fileExtension == "gif" || fileExtension == "jpg" || fileExtension == "png")) {
		        alert("이미지 파일(.jpg, .png, .gif )만 업로드 가능합니다.");
		        return false;
		    } 
	
			//업로드 용량 제한
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
		
		//봉사날짜 카테고리가 바뀔때마다 지정된 봉사지로 바뀜
		$(document).on("change", "#volunteer-write-category", function(){
			$("#volunteer-write-category").selectpicker("refresh")
			var categoryIndex = $("#volunteer-write-category option").index($("#volunteer-write-category option:selected"));			
			$("#volunteer_area").val(volunteerAreaList[categoryIndex].volunteer_area);			
		});
		
		
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