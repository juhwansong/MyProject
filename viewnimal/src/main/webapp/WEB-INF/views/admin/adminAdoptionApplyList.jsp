<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- 세션에 계정 정보 없으면 메인으로 리다이렉트 --%>
<c:if test="${null == loginMemberDto || 'ADMIN' != loginMemberDto.type}">
	<c:redirect url = "/"/>
</c:if>

<c:import url="/WEB-INF/views/common/adminTop.jsp" />

<!-- Custom Theme Style -->
<link href="/resources/vendor/gentelella/build/css/custom.min.css?${verQuery}" rel="stylesheet">

<style>
	.vm-adminAdoptionApplyList__table,
	.vm-adminAdoptionApplyList__table thead tr th {
		 text-align: center; 
	}	
	.vm-adminAdoptionApplyList__table tbody tr td {
		vertical-align: middle;
	}
</style>

<%-- -------- JSP -------- --%>
<div class="right_col vm-admin-content vm-adminAdoptionApplyList" role="main">
	<div class="">
		<div class="page-title">
			<div class="title_left">
				<div class="title_left">
					<h3>입양 신청 관리</h3>
				</div>
			</div>
		</div>
		<div class="clearfix"></div>
		<div class="row">
			<hr class="vm-adminAdoptionApplyList__hr-top">				
			<br>
			<div class="vui-board">
				
				<%-- top --%>					
				<div class="vui-board__box vui-board__box--t row" style="margin-bottom: 1rem;">
					<div class="col vm-adminAdoptionApplyList__div-top1">
						<div class="form-group" style="display: inline-block;">
							<!-- <select class="form-control" id="limit">
								<option>모아보기</option>
								<option>5</option>
								<option>10</option>
								<option>20</option>
								<option>50</option>
							</select> -->
							<button type="button" class="btn" onclick="list;"><a href="/AdminAdoption">전체목록보기</a></button>
						</div>
					</div>
					<div class="col text-right vm-adminAdoptionApplyList__div-top2">
						<div class="form-group" style="display: inline-block;">
							<select class="form-control" id="adminSearch">
								<option>Category</option>
								<option>ID</option>
								<option>Name</option>
								<option>Pet</option>
								<option>State</option>
							</select>
						</div>
	
						<div class="input-group">
							<input id="searchContent" class="form-control" placeholder="Search" type="text">
						</div>
							<button type="button" class="btn" onclick="searchData();">Search</button>
					</div>
				</div>
				<%-- //top --%>
	
				<%-- table --%>		
				<div class="table-responsive text-center">
                     <table class="table jambo_table vm-adminAdoptionApplyList__table">
                       <thead>
                         <tr class="headings">
	                         <th class="column-title" width="8%">No </th>
	                         <th class="column-title" width="10%">ID </th>
	                         <th class="column-title" width="10%">이름 </th>
	                         <th class="column-title" width="10%">동물 </th>
	                         <th class="column-title" width="15%">연락처 </th>
	                         <th class="column-title" width="14%">신청일자 </th>
	                         <th class="column-title" width="15%">신청상태 </th>
	                         <th class="column-title" width="8%">후기작성 </th>
                         	 <th class="column-title" width="8%">삭제 </th>
                         </tr>
                       </thead>
					
                       <tbody class="vm-adminAdoptionApplyList_tbody">
                       <c:forEach items="${ applyList }" var="list">
                       <input type="hidden" value="${ list.no }" id="checkNo">
                       <tr class="even pointer">
                           <td class="seq">${ list.no }</td>
                           <td>${ list.id }</td>
                           <td>${ list.username }</td>
                           <td> 
                           		<c:set var="loop_flag" value="false" />                    	                          		
	                       		<c:forEach items="${ adoptedPet }" varStatus="status" var="adopted">
									<c:if test="${loop_flag == false}">	
										<c:if test="${ adopted == list.pet_id }">
											<span style="color: red;">${ list.name }</span>
											<c:set var="loop_flag" value="true"/>
										</c:if>
									</c:if>
									
									<c:if test="${loop_flag == false}">	
										<c:if test="${status.last}">
											${ list.name }
										</c:if>
									</c:if>
	                       		</c:forEach>
                           </td>
                           <td>${ list.phone }</td>
                           <td>${ list.request_date }</td>
                           <td>
                           <c:choose>
	                           	<c:when test="${ list.state eq '신청중' }">
	                           		<div class="col text-right vm-adminAdoptionApplyList__div">
		                           	<div class="form-group" style="display: inline-block;">
			                           	<select name="state" class="form-control option_state" id="state_${ list.no }">
			                           		<option value="신청중" selected>신청중</option>
			                           		<option value="처리">처리</option>
			                           		<option value="완료">완료</option>
			                           	</select>
	                           		</div>
	                           		<button type="button" class="vm-adminAdoptionApplyList__btn btn" onclick='stateBtn(" ${ list.no } ");'>변경</button>
                           			</div>
	                           	</c:when>
	                           	<c:when test="${ list.state eq '처리' }">
	                           		<div class="col text-right vm-adminAdoptionApplyList__div">
		                           	<div class="form-group" style="display: inline-block;">
			                           	<select name="state" class="form-control option_state" id="state_${ list.no }">
			                           		<option value="신청중">신청중</option>
			                           		<option value="처리" selected>처리</option>
			                           		<option value="완료">완료</option>
			                           	</select>
	                           		</div>
	                           		<button type="button" class="vm-adminAdoptionApplyList__btn btn" onclick='stateBtn(" ${ list.no } ");'>변경</button>
                           			</div>
	                           	</c:when>
	                           	<c:otherwise>
	                           		<div class="col text-right vm-adminAdoptionApplyList__div">
		                           	<div class="form-group" style="display: inline-block;">
			                           	<select name="state" class="form-control option_state" id="state_${ list.no }">
			                           		<option value="신청중">신청중</option>
			                           		<option value="처리">처리</option>
			                           		<option value="완료" selected>완료</option>
			                           	</select>
	                           		</div>
	                           		<button type="button" class="vm-adminAdoptionApplyList__btn btn" onclick='stateBtn(" ${ list.no } ");'>변경</button>
                           			</div>
	                           	</c:otherwise>
	                            </c:choose>
                           	
                            </td>
                            <td>
	                           	<c:if test="${ list.state ne '완료' }">
	                           		
	                           	</c:if>
	                           	<c:if test="${ list.state eq '완료' }">
	                            	<c:if test="${ list.review eq 'N'.charAt(0) }">
	                            		<a onclick="writeReview('${ list.name }','${ list.no }');">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;N</a>
	                            	</c:if>
	                            	<c:if test="${ list.review eq 'Y'.charAt(0) }">
	                            		<a onclick="updateReview('${ list.pet_id }');">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Y</a>
	                            	</c:if>
	                           	</c:if>
                            </td>
                            <td>
                            	<button type="button" class="vm-adminAdoptionApplyList__btn btn" onclick='deleteBtn(" ${ list.no } ");'>삭제</button>
                            </td>
                       </tr>
                       </c:forEach>  
                       </tbody>                       
                   </table>
                   </div>
				<br><br>
				<%-- //table --%>			
	
				<%-- bottom --%>
					<div class="col-sm-5">
						<div class="dataTables_info" id="datatable_info" role="status"
							aria-live="polite">Showing 1 to 10 of ${ listCount } entries</div>
					</div>
					<div class="col-sm-7">
						<div class="dataTables_paginate paging_simple_numbers" id="">
							<ul class="pagination vm-adminAdoptionApplyList__ul-margin">
							<c:if test="${ requestScope.prev }">
								<li class="paginate_button previous disabled" id=""><a href="javascript:page(${ currentPage - 1 });">Previous</a></li>
							</c:if>
							<c:forEach begin="${ startPage }" end="${ endPage }" var="pageIdx">
								<c:choose>
									<c:when test="${ currentPage eq pageIdx }">
										<li class="paginate_button active"><a href="javascript:page(${ pageIdx });">${ pageIdx }</a></li>
									</c:when>
									<c:otherwise>
										<li class="paginate_button "><a href="javascript:page(${ pageIdx });">${ pageIdx }</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if test="${ requestScope.next }">
								<c:if test="${ requestScope.totalPage eq requestScope.currentPage }">
									<li class="paginate_button next" id="datatable_next"><a href="#">Next</a></li>
								</c:if>
								<c:if test="${ requestScope.totalPage ne requestScope.currentPage }">
									<li class="paginate_button next" id="datatable_next"><a href="javascript:page(${ currentPage + 1 });">Next</a></li>
								</c:if>
							</c:if>
							</ul>
						</div>
					</div>
				<%-- //bottom --%>
				
			</div>
		</div>
	</div>
</div>

<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/adminBottom.jsp" />

<!-- Custom Theme Scripts -->
<script src="/resources/vendor/gentelella/build/js/custom.js?${verQuery}"></script>

<%-- -------- JavaScript -------- --%>
<script>

	// 후기 작성
	function writeReview(name, no){
		var message = confirm('후기가 등록되지 않았습니다.\n후기를 작성하시겠습니까?');
		
		if(message == true){
			location.href = "MoveReviewWrite?name="+name+"&no="+no;				
		}else{
			return false;
			exit;
		}	
	} //writeReview()
	
	
	function updateReview(pet_id){
		var message = confirm("후기를 수정하시겠습니까?");
		
		if(message == true){
			location.href = "MoveReviewUpdate?pet_id="+pet_id;
		}else{
			return false;
			exit;
		}
	} //updateReview()
	
	
	// 검색
	function searchData(){
		var category = $("#adminSearch option:selected").val();
		var content = $("#searchContent").val();
		console.log(category +","+content);
		
		if(category == "Category"){
			alert("카테고리를 선택해주세요!");
			return;
		}
			
		if(content == ""){
			alert("검색할 대상이 없습니다!");
			return;
		}
		
		$.ajax({
			url : "/AdminSearch",
			type : "get",
			data : {category : category, content : content},
			dataType : "json",
			success : function(data){
				var result = "";
					
					result = '<thead><tr class="headings">'
					 	+ '<th class="column-title" width="8%">No </th>'
	            		+ '<th class="column-title" width="10%">ID </th>'
	            		+ '<th class="column-title" width="10%">Name </th>'
	            		+ '<th class="column-title" width="10%">Pet </th>'
	            		+ '<th class="column-title" width="15%">Phone </th>'
	            		+ '<th class="column-title" width="14%">Date </th>'
	            		+ '<th class="column-title" width="15%">State </th>'
	            		+ '<th class="column-title" width="8%">Review </th></tr></thead>'
	            		+ '<tbody class="vm-adminAdoptionApplyList_tbody">';
	            		
					for(var i in data.list){
						console.log(data.list[i].no);
	                   			
						result += '<tr class="even pointer"><td class="seq">'
							   + data.list[i].no + '</td><td>' + data.list[i].id + '</td><td>'
							   + data.list[i].username + '</td><td>' + data.list[i].name + '</td><td>'
							   + data.list[i].phone + '</td><td>' + data.list[i].request_date + '</td><td>'
							   + data.list[i].state + '</td><td>' + data.list[i].review + '</td></tr>';
						
						result += '</tbody>';
				}
					
				$(".vm-adminAdoptionApplyList__table").html(result);
				$(".col-sm-7").hide();
				$(".col-sm-5").hide();
				
			},
			error : function(request, status, errorData){
				console("error code : " + request.status + "\n" +
						"message : " + request.responseText + "\n" +
						"error + " + errorData);
			}
		})
	}// searchData()
	
	
	// 상태 변경
	function stateBtn(no){
		var num = no * 1; // 파싱
		var state = $('#state_' + num + ' option:selected').val();
		
		$.ajax({
			url : "/UpdateState",
			type : "post",
			data : {no : no, state : state},
			success : function(data){
				if(data.result == 1){
					alert("상태가 변경되었습니다.");
					location.reload();
				}
			},
			error : function(request, status, errorData){
				console("error code : " + request.status + "\n" +
						"message : " + request.responseText + "\n" +
						"error + " + errorData);
			}
		})
		
	} // stateBtn()
	
	
	// 삭제
	function deleteBtn(no){
		var num = no * 1; //파싱
		var message = confirm(num + "번 글을 삭제하시겠습니까?");
		
		if(message == true){
			
			$.ajax({
				url : "/DeleteApply",
				data : {no : num},
				type : "post",
				success : function(data){
					alert("삭제되었습니다!");
					location.reload();
				},
				error : function(request, status, errorData){
					alert('에러발생~~~~');
				}
			})
		}else{
			return false;
			location.reload();
			exit;
		} 
	} //deleteBtn()
	
	
	function page(pageIdx){
		var nowPage = pageIdx;
		//var limit = $("#limit option:selected").val();
		
		location.href = "/AdminAdoptionPage?currentPage="+pageIdx+"&limit=10";	
	}; //page()
	
</script>
<%-- -------- //JavaScript -------- --%>