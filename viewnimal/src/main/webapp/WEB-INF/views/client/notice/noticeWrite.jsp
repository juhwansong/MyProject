<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<c:if test="${loginMemberDto.type ne 'ADMIN'}">
	<c:redirect url = "/NoticeList"/>
</c:if>
<c:import url="/WEB-INF/views/common/top.jsp" />

<link rel="stylesheet" href="/resources/each/css/noticeWrite.css?${verQuery}" />


<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-noticeWrite">		
		<div class="vm-section">
			<div class="vui-headline">
			공지사항 작성
			</div>
			<div class="vui-board">
				<%-- table --%>
				<table class="table vm-noticeWrite__table mb-0">
					<tbody>
						<tr>
							<td colspan="2"><input type="text" class="form-control" id="title" placeholder="title"></td>
						</tr>
						
						<tr>
							<td colspan="2"><textarea rows="18" class="form-control" id="content"></textarea></td>
						</tr>
						
						<tr class="text-center" height="150">
							<td class="align-middle" width=10%>첨부 파일&nbsp;<i class="fa fa-file"></i></td>
							<td class="align-middle" id="fileTableTbody">
								<form action="multifileup" name="uploadForm" id="uploadForm" enctype="multipart/form-data" method="post">
							
									<div class="vm-noticeWrite__div" id="dropZone">
										 Drag & Drop
									 </div>
							    </form>				
									
							</td>
						</tr>
						<tr>
							<td colspan="2" class="text-right">
								파일 1개당 최대 첨부용량은 10MB입니다.&nbsp;&nbsp;
								<div class="vm-noticeWrite__filebox" style="float:right"><label for="multiup">파일 첨부</label>
           						<input type="file" id="multiup" class="vm-noticeWrite__upload-hidden" multiple="multiple" name="file"></div>
							</td>
						</tr>
					</tbody>
				</table>
				<%-- //table --%>
				<hr class="mt-0 mb-1">
				<%-- bottom buttons --%>
				<div class="vui-board__box vui-board__box--b row mt-3 mb-3">
					<div class="col text-center">
						<button class="btn btn-secondary"  type="button" onclick="uploadFile(); return false;">등록</button>
						<button class="btn btn-secondary" type="button" onclick="location.href='NoticeList'">취소</button>
					</div>
				</div>
				<%-- //bottom buttons --%>			
			</div>
		</div>
		<input type="hidden" id="sessionid" value="${loginMemberDto.id}">
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/noticeWrite.js?${verQuery}"></script> --%>
<script>
	(function ($) {
		// do not remove this string
		"use strict";

		// javascript code here
		
		
      fileDropDown();
        
      var fileTarget = $('.vm-noticeWrite__upload-hidden'); 
      fileTarget.on('change', function(){
      	selectFile(null);
      	return false;
      });
      
	}(jQuery));
	
    
	function submit(){
		var id = $('#sessionid').val();
		var title = $('#title').val();
		var content = $('#content').val().replace(/\n/g, '<br>');
		
		$.ajax({
			url : 'noticeWrite',
			data : {id : id, title : title, content : content, original_file_name : ofn, rename_file_name : rfn},
			type : 'post',
			success : function(data){
				location.href='NoticeList'
			}
		});//ajax close
	}
	
	
    var fileIndex = 0;
    var totalFileSize = 0;
    var fileList = new Array();
    var fileSizeList = new Array();
    var uploadSize = 10;	//10MB
    var maxUploadSize = 30; //30MB
    

    function fileDropDown(){
        var dropZone = $("#dropZone");
        dropZone.on('dragenter',function(e){
            e.stopPropagation(); //이벤트 상위 전파 방지
            e.preventDefault();	//이벤트 기본 동작 중단
            dropZone.css('background-color','#eee');
        });
        dropZone.on('dragleave',function(e){
            e.stopPropagation();
            e.preventDefault();
            dropZone.css('background-color','#fff');
        });
        dropZone.on('dragover',function(e){
            e.stopPropagation();
            e.preventDefault();
            dropZone.css('background-color','#eee');
        });
        dropZone.on('drop',function(e){
            e.preventDefault();
            dropZone.css('background-color','#fff');
            
            var files = e.originalEvent.dataTransfer.files;
            if(files != null){
                if(files.length < 1){
                    alert("폴더 업로드 불가");
                    return;
                }
                selectFile(files)
            }else{
                alert("ERROR");
            }
        });
    }
 
    function selectFile(fileObject){
        var files = null;
        if(fileObject != null){
            files = fileObject;
            //console.log(files);
        }else{
            files = $('#multiup')[0].files;
            //console.log(files);
        }
        
        if(files != null){
            for(var i = 0; i < files.length; i++){
                var fileName = files[i].name;
                var fileNameArr = fileName.split("\.");
                var ext = fileNameArr[fileNameArr.length - 1];
                var fileSize = files[i].size / 1024 / 1024;
                
                if($.inArray(ext, ['exe', 'bat', 'sh', 'java', 'jsp', 'html', 'js', 'css', 'xml']) >= 0){
                    alert("등록 불가능한 확장자입니다.");
                    break;
                }else if(fileSize > uploadSize){
                    alert("용량 초과\n업로드 가능 용량 : " + uploadSize + " MB");
                    break;
                }else if(files.length > 5){
                	alert("파일은 최대 5개까지 첨부할 수 있습니다.");
                	break;
                }else{
                    totalFileSize += fileSize;         
                    fileList[fileIndex] = files[i];
                    fileSizeList[fileIndex] = fileSize;
                    addFileList(fileIndex, fileName, fileSize);
                    fileIndex++;
                }
            }
        }else{
            alert("ERROR");
        }
    }
 
    function addFileList(fIndex, fileName){
	    var html = "";
	    html += "<div id='fileTr_" + fIndex + "' class='text-left' style='width:100%'>" + fileName
	    	 + "&nbsp;&nbsp;<a href='javascript:void(0)' onclick='deleteFile(" + fIndex + "); return false;'>삭제</a></div>";
	    $('#dropZone').append(html);
    }
 
    function deleteFile(fIndex){
        totalFileSize -= fileSizeList[fIndex];
        delete fileList[fIndex];
        delete fileSizeList[fIndex];
        $("#fileTr_" + fIndex).remove();
    }

    function uploadFile(){
    	if(confirm("등록 하시겠습니까?")){
	        var uploadFileList = Object.keys(fileList);
	        var titleLength = $('#title').val().length;
	        var contentLength = $('#content').val().length;
	        
			if(titleLength > 30 || titleLength < 1){
				alert("제목은 최소 한 글자 이상 최대 30 글자 이하여야합니다.\n(현재 " + titleLength + " 자.)");
				return;
			}else if(contentLength > 100 || contentLength < 1){
				alert("내용은 최소 한 글자 이상 최대 100 글자 이하여야합니다.\n(현재 " + contentLength + " 자.)");
				return;
			}else if(totalFileSize > maxUploadSize){
	            alert("총 용량 초과\n총 업로드 가능 용량 : " + maxUploadSize + " MB");
	            return;
	        }
	            
	        // 등록할 파일 리스트를 formData로 데이터 입력
	        var form = $('#uploadForm');
	        var formData = new FormData(form);
	        for(var i = 0; i < uploadFileList.length; i++){
	            formData.append('fileList', fileList[uploadFileList[i]]);
	        }
	        
	        $.ajax({
	            url: 'multifileup',
	            data: formData,
	            type:'POST',
	            dataType : 'json',
	            contentType : false,
	            processData : false,
	            cache:false,
	            success:function(data){
	            	var dataStr = JSON.stringify(data);
	        		var obj = JSON.parse(dataStr);
	        		ofn = obj.ofn;
	        		rfn = obj.rfn;
	        		
	        		submit();
	            }
	        });//ajax close
    	}
    }
</script>
<%-- -------- //JavaScript -------- --%>