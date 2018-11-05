<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("rn", "\r\n"); %>

<c:if test="${loginMemberDto.type ne 'ADMIN'}">
	<c:redirect url = "/NoticeList"/>
</c:if>
<c:import url="/WEB-INF/views/common/top.jsp" />

<link rel="stylesheet" href="/resources/each/css/noticeModify.css?${verQuery}" />

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-noticeModify">
		<div class="vm-section">
			<div class="vui-headline">
			공지사항 수정
			</div>
			<div class="vui-board">
				<table class="table vm-noticeModify__table mb-0">
					<tbody>
						<tr>
							<td colspan="2"><input type="text" class="form-control" id="title" value="${notice.title}"></td>
						</tr>
					
						<tr>
							<td colspan="2">
								<textarea rows="18" class="form-control" id="content">${fn:replace(notice.content, "<br>", rn)}</textarea>
							</td>
						</tr>
						<tr class="text-center" height="150">
							<td class="align-middle" width=10%>첨부 파일&nbsp;<i class="fa fa-file"></i></td>
							<td class="align-middle" id="fileTableTbody">
								<form action="multifileup" name="uploadForm" id="uploadForm" enctype="multipart/form-data" method="post">
							
									<div class="vm-noticeModify__div" id="dropZone">
										 
										 Drag & Drop<br>
										 
										<c:if test="${!empty notice.original_file_name}">	 
											<c:forEach items="${orifile}" var="ofile" varStatus="ost">
												<div id='saveFiles' class='text-left' style='width:100%'>
													${ofile}&nbsp;&nbsp;<a href='javascript:void(0)' onclick='deleteSaveFiles("${ost.index}", "${ofile}", "${rfile}"); return false;'>삭제</a>
												</div>
											</c:forEach>
										</c:if>
									</div>
							   </form>				
									
							</td>
						</tr>
						<tr>
							<td colspan="2" class="text-right">
								파일 1개당 최대 첨부용량은 10MB입니다.&nbsp;&nbsp;
								<div class="vm-noticeModify__filebox" style="float:right"><label for="multiup">파일 첨부</label>
           						<input type="file" id="multiup" class="vm-noticeModify__upload-hidden" multiple="multiple" name="file"></div>
							</td>
						</tr>
					</tbody>
				</table>
				<%-- //table --%>
				<hr class="mt-0 mb-1">
				<%-- bottom buttons --%>
				<div class="vui-board__box vui-board__box--b row mt-3 mb-3">
					<div class="col text-center">
						<c:if test="${loginMemberDto.type eq 'ADMIN'}">
							<button class="btn btn-secondary" type="button" onclick="uploadFile(); return false;">수정</button>
							<button class="btn btn-secondary" type="button" onclick="location.href='NoticeList'">취소</button>
						</c:if>
					</div>
				</div>
				<%-- //bottom buttons --%>
			
			</div>
		</div>
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/noticeModify.js?${verQuery}"></script> --%>
<script>
	(function ($) {
		// do not remove this string
		"use strict";

		// javascript code here
		
      fileDropDown();
        
      var fileTarget = $('.vm-noticeModify__upload-hidden'); 
      fileTarget.on('change', function(){
      	selectFile(null);
      	return false;
      });
      
	}(jQuery));
	
    var originFiles = '${notice.original_file_name}';	//기존 origin 파일명
    var renameFiles = '${notice.rename_file_name}';		//기존 rename 파일명
    var deleteRenameFiles = '';							//디렉토리에서 지울 목록
    var leftOriginFiles = new Array();					//origin 파일명 배열
    var leftRenameFiles = new Array();					//rename 파일명 배열

    
    if(originFiles){
    	leftOriginFiles = originFiles.split(', ');
        leftRenameFiles = renameFiles.split(', ');
    }
    
    var oriFileCnt = leftOriginFiles.length;			//기존 파일 개수 확인용
    
	function deleteSaveFiles(index){
		//console.log("기존파일 삭제 index : " + index);
		$("#dropZone #saveFiles").eq(index).hide();			//목록 숨기기
		deleteRenameFiles += leftRenameFiles[index] + ',';	//삭제할 파일명 저장
		delete leftOriginFiles[index];						//배열에서 삭제
		delete leftRenameFiles[index];
		oriFileCnt -= 1;
	}
    
	function submit(){
		var no = ${notice.no};
		var title = $('#title').val();
		var content = $('#content').val().replace(/\n/g, '<br>');
		var ori = '', re = '';
		
		//기존 파일 있을 시
		if(leftOriginFiles){
			for(var i = 0; i < leftOriginFiles.length; i++){
				if(leftOriginFiles[i] != null && leftOriginFiles[i] != undefined){
					ori += leftOriginFiles[i] + ', ';
					re += leftRenameFiles[i] + ', ';
				}
			}
		}
		
		
		//파일 추가 시
		if(ofn){
			ori += ofn;
			re += rfn;	
		}
		
		$.ajax({
			url : 'noticeModify',
			data : {no: no, title : title, content : content, deleteRenameFiles : deleteRenameFiles,
					original_file_name : ori.replace(/,\s*$/g, ''), rename_file_name : re.replace(/,\s*$/g, '')},
			type : 'post',
			success : function(){
				location.href='NoticeDetail?no=' + no;
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
            e.stopPropagation();
            e.preventDefault();
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
        }else{
            files = $('#multiup')[0].files;
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
	        
	        if($('#title').val().length > 30 || $('#title').val().length < 1){
				alert("제목은 최소 한 글자 이상 최대 30 글자 이하여야합니다.");
				return;
			}else if($('#content').val().length > 100 || $('#content').val().length < 1){
				alert("내용은 최소 한 글자 이상 최대 100 글자 이하여야합니다.");
				return;
			}else if((uploadFileList.length + oriFileCnt) > 5){
				//console.log("새로 등록 : " + uploadFileList.length + "\n기존파일 : " + oriFileCnt)
				alert("파일첨부는 최대 5개까지 가능합니다.");
				return;
			}else if(totalFileSize > maxUploadSize){
	            alert("총 용량 초과\n총 업로드 가능 용량 : " + maxUploadSize + " MB");
	            return;
	        }
	            
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