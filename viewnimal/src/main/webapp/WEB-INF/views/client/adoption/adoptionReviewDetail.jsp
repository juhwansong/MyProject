<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>
	.vm-adoptionReviewDetail .form-control .form-control-alternative {
		width: 100%;
		height: 80px;		
		padding: 15px;		
	}	
	.vm-adoptionReviewDetail__reply-btn { 
		position: relative;
		top: -37px;
		color: #fff;		
		width: 100%; 
		height: 80px;
		text-align: center;
		border-radius: 5px;
		font-size: 20px;
		font-weight: bold;
		letter-spacing: 5px; 
		cursor: pointer;
	}	
	.vm-adoptionReviewDetail__reply-id {
		width: 85%;
		font-size: 13px;
	}	
	.vm-adoptionReviewDetail__reply-date {
		width: 14%;
		font-size: 13px;
	}	
	.vm-adoptionReviewDetail__reply-content {
		font-size: 22px;
		width: 85%;
		word-break: break-all;
	}	
	.vm-adoptionReviewDetail__reply-delete {
		width: 12%;
	}
	.vm-adoptionReviewDetail__reply-table {
		width: 100%;
	}
	.vm-adoptionReviewDetail__reply-count {
		font-size: 20px;
		font-weight: bold;
	}
	.vm-adoptionReviewDetail__reply-write {
		display: inline-block;
		width: 90%;
	}
	.vm-adoptionReviewDetail__textarea {
		width: 100%; 
		height: 80px;
		resize: none;
		box-sizing: border-box;
		padding: 15px;
	}
	.vm-adoptionReviewDetail__reply-btn-div {
		display: inline-block;
		width: 9%;
	} 	
</style>


<c:import url="/WEB-INF/views/common/top.jsp" />

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-section">
	
		<div class="vm-content vm-adoptionReviewDetail pb-3">
			<div class="vui-headline">
				입양 후기&nbsp;
				<span style="font-size: 19px;"> ${ requestScope.pet.name } 책임분양</span>
			</div>
			<span style="font-size : 16px; color: #777; float:right;">
				<i class="fa fa-calendar-o" aria-hidden="true"></i> 
				${ petReview.write_date }&nbsp;&nbsp;
				<i class="fa fa-eye" aria-hidden="true"></i> ${ petReview.count }
			</span>
			
		</div>

		<hr class="mt-3">
		
			<div class="vui-board">
			<input type="hidden" value="${ requestScope.pet.pet_id }" id="pet_id">
			<input type="hidden" value="${ requestScope.petReview.no }" id="no">
			
			<%-- table --%>
			<div class="vui-table">
				<table class="table" style="text-align: center;">						
					<tr>
						<td>이름</td>
						<td>${ requestScope.pet.name }</td>
						<td>견종/묘종</td>
						<td>${ requestScope.pet.bdetail }</td>													
					</tr>					
					<tr>
						<td>성별</td>
						<td>
							<c:choose>
				  				<c:when test="${ pet.gender eq 'F'.charAt(0) }">
				  					여아
				  				</c:when>
				  				<c:otherwise>
				  					남아
				  				</c:otherwise>
				  			</c:choose><br>
						</td>
						<td>몸무게</td>
						<td>${ requestScope.pet.weight }kg</td>					
					</tr>
					<tr>
						<td>나이</td>
						<td>
							<c:choose>
					   			<c:when test="${ pet.age >= 0 && pet.age < 1}">
					   				<fmt:parseNumber var="ages" value="${ pet.age * 10}" integerOnly="true"/>${ ages }개월
					   			</c:when>
					   			<c:when test="${ pet.age >=1 }">
					   				<fmt:parseNumber var="ages" value="${ pet.age }" integerOnly="true"/>${ ages }세
					   			</c:when>
					   		</c:choose><br>
						</td>
						<td>중성화</td>
						<td>${ requestScope.pet.neuter }</td>						
					</tr>
					<tr>
						<td>입양자</td>
						<td>${ requestScope.petReview.username }</td>
						<td>입양처</td>
						<td>${ requestScope.petReview.address }</td>							
					</tr>						
				</table>
			</div>
			<%-- //table --%>
			
			
		
			<br><br><br>
			
			<div style="text-align:center;">
				<div>
					<img src="resources/images/adoption/${ requestScope.petReview.image }" style="width: 500px;"><p>
				</div>
				<div><b><h5>
				안녕하세요 !<br> Viewnimal입니다.<br>
				${ requestScope.pet.bdetail } ${ requestScope.pet.name }를<br>
				책임분양으로 맞이해주셨어요.
				</h5></b></div>
			</div>
		
			<br><br><br><br><br>
			
			<!-- 댓글 -->
			<form id="insertReply">
				<input type="hidden" name="origin_no" value="${ requestScope.petReview.no }">
				<input type="hidden" name="writer" value="${ sessionScope.loginMemberDto.nickname }" id="nickname">
				
				<div class="vm-adoptionReviewDetail__reply">	
					<div class="vm-adoptionReviewDetail__reply-count">
						<h6>댓글 ${ requestScope.replyCount }</h6>
					</div>
					<div class="vm-adoptionReviewDetail__reply-write">
						<textarea class="form-control form-control-alternative vm-adoptionReviewDetail__textarea" name="content" rows="3"></textarea>
					</div>
					<div class="vm-adoptionReviewDetail__reply-btn-div">
						<button type="button" class="vm-adoptionReviewDetail__reply-btn btn btn-primary" onclick="reply();">등록</button>
					</div>	
				</div>
			</form>
			
			<!-- 댓글후기 -->
			<div class="vm-adoptionReviewDetail__reply-div">


			</div>
			<br><br><br>

			<hr class="mt-0 mb-0">
			
			<%-- bottom buttons --%>
			<div class="vui-board__box vui-adoptionDetail__box--b row mt-3">
				<div class="col">
					<button class="btn btn-primary" type="button" onclick="location.href='AdoptionReview'">목록</button>
				</div>

				<div class="col text-right">
				
				</div>
			</div>
			<%-- //bottom buttons --%>
				
			<!-- up/down title
			<div class="vm-noticeDetail__bottom-div mt-4 mb-5">
							
				<div class="vui-board__box vui-board__box--b row mt-0">					
						
					<div class="ml-3" style="width:10%;">
						<a href="#"><i class="fa fa-chevron-up"></i>&nbsp;윗글</a>
					</div>
					<div class="col text-truncate">
						<a href="#"></a>
					</div>
					<div class="col text-right mr-2">
						2018-10-11
					</div>
					
				</div>
					
					<hr class="mt-1 mb-1">
					
				<div class="vui-board__box vui-board__box--b row mt-0">					
						
					<div class="ml-3" style="width:10%;">
						<a href="#"><i class="fa fa-chevron-down"></i>&nbsp;아래글</a>
					</div>
					<div class="col text-truncate">
						<a href="#">아래글 제목임~</a>
					</div>
					<div class="col text-right mr-2">
						2018-10-11
					</div>					
				</div>					
					
			</div> -->
			<br><br><br>
		</div>	
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<script>
	$(".table td:nth-child(2n+1)").css("background-color", "#e0e0e0").css("width", "100px");
	$(".table td:nth-child(2n)").css("width", "200px");
	
	
	listReply();

	
	function reply(){
		if($("#nickname").val() == ""){
			alert("로그인 후 사용가능합니다!");
			return false;
		}
		
		var insertData = $("#insertReply").serialize();
		console.log("읽은값: " + insertData);
		insertReply(insertData);
	} // replyBtn
		

	function listReply(){
		var no = $('[name="origin_no"]').val();
		var username = $("#nickname").val();
		console.log("글번호 는" + no);

		$.ajax({
			url : "/ListReply",
			type : "post",
			data : { no : no },
			dataType : "json",
			success : function(data){				
				var result = "";
				
				 for(var i in data.list){						
					if(username == data.list[i].writer){	   
					   result += "<table class='vm-adoptionReviewDetail__reply-table'><tr><td class='vm-adoptionReviewDetail__reply-id'><h6>"
						   + data.list[i].writer + "</h6></td>"
						   + "<td class='vm-adoptionReviewDetail__reply-date'>" + data.list[i].write_date
						   + "</td></tr><tr><td class='vm-adoptionReviewDetail__reply-content' id='replyContent_" + data.list[i].no + "'><TT>" + data.list[i].content
						   + "</TT></td><td class='vm-adoptionReviewDetail__reply-delete'>&nbsp;&nbsp;&nbsp;&nbsp;"
						   + "<a onclick='updateReplyForm(" + data.list[i].no + ",\"" + data.list[i].content + "\");'><i class='ni ni-chat-round'></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
						   + "<a onclick='deleteReply(" + data.list[i].no + ");'><i class='ni ni-fat-remove'></i></a></td></tr></table><br><br>";
					
						   
							$(".vm-adoptionReviewDetail__reply-div").html( result );
					}else{
						result += "<table class='vm-adoptionReviewDetail__reply-table'><tr><td class='vm-adoptionReviewDetail__reply-id'><h6>"
							   + data.list[i].writer + "</h6></td>"
							   + "<td class='vm-adoptionReviewDetail__reply-date'>" + data.list[i].write_date
							   + "</td></tr><tr><td class='vm-adoptionReviewDetail__reply-content' id='replyContent_" + data.list[i].no + "'><TT>" + data.list[i].content
							   + "</TT></td><td class='vm-adoptionReviewDetail__reply-delete'>&nbsp;&nbsp;&nbsp;&nbsp;"
							   + "</td></tr></table><br><br>";
						
							   $(".vm-adoptionReviewDetail__reply-div").html( result );
					}
				}
			},
			error : function(request, status, errorData){
				console("error code : " + request.status + "\n" +
						"message : " + request.responseText + "\n" +
						"error + " + errorData);
			}
		})
	}; //listReply()
	
	
	function insertReply(insertData){
		if($('[name="content"]').val() == ""){
			alert("내용을 입력해주세요!");
		}
		
		$.ajax({
			url : "/InsertReply",
			type : "post",
			data : insertData,
			dataType : "json",
			success : function(data){
				if(data.result == 1){
					listReply();
					$('[name=content]').val("");
					location.reload();
					//$(".vm-adoptionReviewDetail__reply-count").text("<h5>댓글 " + data.count + "</h5>");
				}
			}
		}) //ajax close
	} //insertReply()
	
	
	function updateReplyForm(no, content){
		
		var result = "";

		result += '<div class="input-group">';
		result += '<input type="text" class="form-control" name="content_' + no + '" value = "' + content + '"/>';
		result += '<span class="input-group-btn"><button class="btn btn-default" type="button" onclick="updateReply(' + no + ');">수정</button></span>';
		result += '</div>';
		
		$("#replyContent_" + no).html(result); 
			   
	} //updateReplyForm()
	
	
	function updateReply(no){
		var updateContent = $('[name=content_' + no + ']').val();
		$.ajax({
			url : "/UpdateReply",
			type : "post",
			data : {content : updateContent, no : no},
			success : function(data){
				if(data.result == 1){
					alert("수정되었습니다.");
					listReply();
				}
			},
			error : function(request, status, errorData){
				console("error code : " + request.status + "\n" +
						"message : " + request.responseText + "\n" +
						"error + " + errorData);
			}
		})
	
	}

	
	function deleteReply(no){
		
		$.ajax({
			url : "/DeleteReply",
			type : "get",
			data : {no : no},
			success : function(data){
				alert("삭제되었습니다!");
				listReply();
				location.reload(); //이거 맘에 안듦 ㅡㅡ
			},
			error : function(request, status, errorData){
				console("error code : " + request.status + "\n" +
						"message : " + request.responseText + "\n" +
						"error + " + errorData);
			}
		})
	} //deleteReply()

</script>
<%-- -------- //JavaScript -------- --%>