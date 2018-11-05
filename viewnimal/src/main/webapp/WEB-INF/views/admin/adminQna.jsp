<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${loginMemberDto.type ne 'ADMIN'}">
	<c:redirect url = "/" />
</c:if>

<c:import url="/WEB-INF/views/common/adminTop.jsp" />

<!-- Custom Theme Style -->
<link href="/resources/vendor/gentelella/build/css/custom.min.css?${verQuery}" rel="stylesheet">
<link rel="stylesheet" href="/resources/each/css/adminQna.css?${verQuery}" />

<%-- -------- JSP -------- --%>
<!-- page content -->
<div class="right_col vm-admin-content vm-adminQna" role="main">
	<div class="">
		<div class="page-title">
			<div class="title_left">
				<div class="title_left">
					<h3>QNA</h3>
				</div>
			</div>
		</div>
		<div class="clearfix"></div>
		<div class="row">
			<hr class="vm-adminQna__hr-top">
			
			<div class="vui-board">
				
				<%-- top --%>
				<div class="vui-board__box vui-board__box--t" style="margin-bottom: 1rem;">
					<div class="col text-right vm-adminQna__div-top">
						<div class="form-group" style="display: inline-block;">
							<select class="form-control" id="select-category">
								<option value="no">문의번호</option>
								<option value="title" selected>제목</option>
								<option value="content">내용</option>
								<option value="id">작성자</option>
								<option value="category">문의종류</option>
								<option value="state">처리상태</option>
							</select>
						</div>

						<div class="input-group" id="searching-div">
							<input class="form-control" placeholder="Search" type="text" id="search-keyword">
						</div>
						<button type="button" class="btn" id="searchBtn" onclick='searching(1);'>Search</button>
					</div>
				</div>
				<%-- //top --%>

				<%-- table --%>				
					<div class="table-responsive text-center">
					<table class="table jambo_table vm-adminQna__table">
		                <thead>
							<tr class="headings">
		                    	<th class="column-title" width="8%">No </th>
		                    	<th class="column-title" width="8%">문의 종류 </th>
		                    	<th class="column-title" width="*">문의 내용 </th>
		                    	<th class="column-title" width="15%">아이디 </th>
		                        <th class="column-title" width="10%">문의일 </th>
		                        <th class="column-title" width="10%">답변일 </th>
		                        <th class="column-title" width="8%">처리상태 </th>
		                  	</tr>
		                </thead>
		                <tbody id="ajax-tbody">
		                	<c:forEach items="${list}" var="qna">
		                      	<tr class="vm-adminQna__tr" onclick="toggle_fx('${qna.no}');">
		                            <td>${qna.no}</td>
		                            <td>${qna.category}</td>
		                            <td class=" text-left"><a href="javascript:void(0);">${qna.title}</a></td>
		                            <td>${qna.id}</td>
		                            <td>${qna.write_date}</td>
		                            <td>
		                            	<c:choose>
		                            		<c:when test="${!empty qna.answer_write_date}">
		                            			${qna.answer_write_date}
		                            		</c:when>
		                            		<c:otherwise>
		                            			-
		                            		</c:otherwise>
		                            	</c:choose>
		                            </td>
		                            <td class=" last">${qna.state}</td>
		                     	 </tr>

		                      <%-- 답변작성(관리자) --%>
								<tr class="vm-adminQna__content-section" style="display:none;">
									<td colspan="7" class="text-left"><%-- 내용 --%></td>
								</tr>	
							</c:forEach>
							
		                </tbody>
					</table>
				</div>
				<%-- //table --%>
							
				<%-- bottom --%>
				<div class="dataTables_paginate paging_simple_numbers">
					<ul class="pagination vm-adminQna__ul-margin" id="my-pagination">
						<li class="paginate_button previous">
							<c:choose>
								<c:when test="${currentPage <= 1}">
									<a href="javascript:void(0)">Previous</a>
								</c:when>
								<c:otherwise>
									<a href="javascript:void(0)" onclick='searching(1)'>Previous</a>
								</c:otherwise>
							</c:choose>
						</li>
						<c:forEach var="p" begin="${startPage}" end="${endPage}">
							<c:choose>
								<c:when test="${currentPage eq p}">
									<li class="paginate_button"><a href="javascript:void(0)">${p}</a></li>
								</c:when>
								<c:otherwise>
									<li class="paginate_button active"><a href="javascript:void(0)" onclick='searching("${p}")'>${p}</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<li class="paginate_button next" id="datatable_next">
							<c:choose>
								<c:when test="${currentPage >= maxPage}">
									<a href="javascript:void(0)">Next</a>
								</c:when>
								<c:otherwise>
									<a href="javascript:void(0)" onclick='searching("${endPage + 1}")'>Next</a>
								</c:otherwise>
							</c:choose>
						</li>
					</ul>
				</div>
				<input type="hidden" id="session-id" value="${loginMemberDto.id}">
				<%-- //bottom --%>
			</div>
		</div>
	</div>
</div>
<!-- //page content -->
<%-- -------- //JSP -------- --%>
<c:import url="/WEB-INF/views/common/adminBottom.jsp" />

<!-- Custom Theme Scripts -->
<script src="/resources/vendor/gentelella/build/js/custom.js?${verQuery}"></script>

<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/adminQna.js?${verQuery}"></script> --%>
<script>
	(function ($) {
		// do not remove this string
		"use strict";

		// javascript code here
		
		//카테고리 변경 이벤트
		$('#select-category').on('change', function(){
			var val = $('#searching-div').html();
			val = '';
			
			var sc = $('#select-category').val();
			
			if(sc === 'category'){
				categoryChange();
			}else if(sc === 'state'){
				stateChange();
			}else{
				val += '<input class="form-control" placeholder="Search" type="text" id="search-keyword">';
				$('#searching-div').html(val);
			}
			
			//엔터키
			$("#search-keyword").keypress(function(event){
			     if(event.which == 13){
			         $("#searchBtn").click();
			         return false;
			     }
			});
		});
		
		//엔터키
		$("#search-keyword").keypress(function(event){
		     if(event.which == 13){
		         $("#searchBtn").click();
		         return false;
		     }
		});
	}(jQuery));
	
	var obj = null;	//json 객체 저장용
	var val = '';	//카테고리 변경용 변수 선언
	
	//카테고리
	if('${kind}' === 'title' || '${kind}' === 'content' || '${kind}' === 'category'
			|| '${kind}' === 'id' || '${kind}' === 'state' || '${kind}' === 'no'){
		$("#select-category").val('${kind}');
	}
	
	//문의종류
	if('${category}' === '기타' || '${category}' === '입양' || '${category}' === '자원봉사'
		|| '${category}' === '쇼핑몰' || '${category}' === '건의' || '${category}' === '신고'){
		val = $('#searching-div').html();
		val = '';
		
		categoryChange();
		
		$("#select-category2").val('${category}');
	}
	
	//상태
	if('${state}' === '처리중' || '${state}' === '답변완료'){
		val = $('#searching-div').html();
		val = '';
		
		stateChange();
		
		$("#select-category3").val('${state}');
	}
	
	//키워드
	if('${keyword}'){
		$("#search-keyword").val('${keyword}');
	}
	
	
	//카테고리 변경 반영
	function categoryChange(){
		console.log('category change');
		val = '<div class="btn-group"><select class="form-control" id="select-category2" style="width:13.5rem;">'
			+ '<option value="기타" selected>기타</option><option value="입양">입양</option>'
			+ '<option value="자원봉사">자원봉사</option><option value="쇼핑몰">쇼핑몰</option>'
			+ '<option value="건의">건의</option><option value="신고">신고</option></select></div>';
		$('#searching-div').html(val);
	}
	
	//처리상태 변경 반영
	function stateChange(){
		console.log('state change...');
		val = '<select class="form-control" id="select-category3">'
			+ '<option value="처리중" selected>처리중</option><option value="답변완료">답변완료</option></select>';
		$('#searching-div').html(val);
	}


	function toggle_fx(no){
		var index = $(event.target).closest("tr").index() / 2;
		$(".vm-adminQna__content-section").eq(index).toggle(qna_detail(no));
		
	}


	function cancel(){
		var index = Math.floor($(event.target).closest("tr").index() / 2);
		$(".vm-adminQna__content-section").eq(index).empty();
		$(".vm-adminQna__content-section").eq(index).toggle();//토글 닫기
		
	}
	
	function qna_delete(no){
		if(confirm("게시글을 삭제하시겠습니까?")){
			var where = 'admin';
			$.ajax({
				url : 'qnaDelete',
				data : {no : no, where : where},
				type : 'POST',
				success : function(){
					location.href='AdminQna';
				}
			})//ajax close 
		}
	}
	
	function admin_qna_delete(no){
		if(confirm("답변을 삭제하시겠습니까?")){
			location.href='adminQnaDelete?no=' + no;
		}
	}
	
	//등록, 수정 공통
	function submit(no){
		var textval = $("textarea").val();
		var id = $("#session-id").val();
		
		if(confirm("답변을 등록하시겠습니까?")){
			
			if(textval.length > 100 || textval.length < 1){
				alert("내용은 최소 한 글자 이상 최대 100 글자 이하여야합니다.\n(현재 " + textval.length + " 자.)");
				return;
			}

			$.ajax({
				url : 'adminQnaWrite',
				data : {id : id, no : no, answer_content : textval},
				type : 'post',
				success : function(){
					window.location.reload();
				}
			})//ajax close 
		}
	}
	
	function admin_qna_modify(){
		var answer_contents = obj.qna.answer_content.replace('<br>', '\n\r');
		var value = $("#answer-section").val();
		value =''; 
		value += '<div class="vm-adminQna__div-inline"><div class="vm-adminQna__div-inner">'
				+'<span class="vm-adminQna__span-bold">A.&nbsp;&nbsp;&nbsp;&nbsp;[Re]:' + obj.qna.title + '</span></div></div>'
				+ '<div class="vm-adminQna__div-inline"><div class="vm-adminQna__div-inner">'
				+ '<textarea class="vm-adminQna__textarea form-control" id="exampleFormControlTextarea1" rows="7" style="width:97%;">' + answer_contents + '</textarea>'
				+ '</div></div><div class="vm-adminQna__div-inline"><div class="vm-adminQna__div-inner text-right">'
				+ '<button class="btn btn-default" type="button" onclick="submit(' + obj.qna.no + ');">등록</button>'
				+ '<button class="btn btn-default" type="button" onclick="cancel();">취소</button></div>';
	
		$("#answer-section").html(value);
	 }
	
	function searching(page){
		var category1 = $("#select-category").val();	//카테고리
		var category2 = (!$("#select-category2").val()) ? '' : $("#select-category2").val();	//문의종류
		var category3 = (!$("#select-category3").val()) ? '' : $("#select-category3").val();	//처리상태
		var keyword = (!$("#search-keyword").val()) ? '' : $("#search-keyword").val().trim();	//키워드
		$.ajax({
			url : 'AdminQna',
			data : {sc1 : category1, sc2 : category2, sc3 : category3, sk : keyword, where : 'admin', page : page},
			type : 'get',
			success : function(){
				location.href='AdminQna?sc1=' + category1 + '&sc2=' + category2 + '&sc3=' + category3
								+ '&sk=' + keyword + '&where=admin&page=' + page;
			}
		})//ajax close 
	}
	
	
	
	function qna_detail(no){
		
		var index = $(event.target).closest("tr").index() / 2;
		var value = $(".vm-adminQna__content-section").eq(index);
		
		$(".vm-adminQna__content-section").empty(); //비우기
		
		//다른 tr 닫기
		if(!$(".vm-adminQna__content-section").not(value).css('display', 'none')){
			$(".vm-adminQna__content-section").hide().not(value);
		}
		
		value='';
		$.ajax({
			url : 'qnaDetail',
			data : {no : no},
			type : 'post',
			dataType : 'json',
			success : function(data){
				var dataStr = JSON.stringify(data);
				obj = JSON.parse(dataStr);
				var contents = obj.qna.content.replace(/\n/g, '<br>');
				var answer_contents = obj.qna.answer_content.replace(/\n/g, '<br>');
				
				//문의 내용 상세보기
				value += '<td colspan="7" class="text-left"><div class="vm-adminQna__div-outline"><div class="vm-adminQna__div-inline"><div class="vm-adminQna__div-inner">'
					+ '<span class="vm-adminQna__span-bold">Q.&nbsp;&nbsp;&nbsp;&nbsp;' + obj.qna.title + '</span>&nbsp;&nbsp;&nbsp;'
					+ '<span class="vm-adminQna__span-small">' + obj.qna.write_date + '</span></div></div><div class="vm-adminQna__div-inline">'
					+ '<div class="vm-adminQna__div-inner"><span class="ml-5 vm-adminQna__span-content">' + contents + '</span></div></div>'
					+ '<div class="vm-adminQna__div-inline"><div class="vm-adminQna__div-inner text-right">'
					+ '<button class="btn btn-default" type="button" onclick="qna_delete(' + obj.qna.no + ');">삭제</button>'
					+ '</div></div></div><hr class="vm-adminQna__hr-margin"><div class="vm-adminQna__div-outline" id="answer-section">'
					+ '<div class="vm-adminQna__div-inline"><div class="vm-adminQna__div-inner">';
				
				//답변 없을 때
				if(!obj.qna.answer_content){
					value += '<span class="vm-adminQna__span-bold">A.&nbsp;&nbsp;&nbsp;&nbsp;[Re]:' + obj.qna.title + '</span></div></div>'
						+ '<div class="vm-adminQna__div-inline"><div class="vm-adminQna__div-inner">'
						+ '<textarea class="vm-adminQna__textarea form-control" id="exampleFormControlTextarea1" rows="7" style="width:97%;"></textarea>'
						+ '</div></div><div class="vm-adminQna__div-inline"><div class="vm-adminQna__div-inner text-right">'
						+ '<button class="btn btn-default" type="button" onclick="submit(' + obj.qna.no + ');">등록</button>'
						+ '<button class="btn btn-default" type="button" onclick="cancel();">취소</button></div></div></div></td>';
				
				//답변 있을 때
				}else{
					value += '<span class="vm-adminQna__span-bold">A.&nbsp;&nbsp;&nbsp;&nbsp;[Re]:' + obj.qna.title
						+ '</span>&nbsp;&nbsp;&nbsp;<span class="vm-adminQna__span-small">' + obj.qna.answer_write_date + '</span></div></div>'
						+ '<div class="vm-adminQna__div-inline"><div class="vm-adminQna__div-inner"><span class="vm-adminQna__span-content">'
						+ answer_contents + '</span></div></div><div class="vm-adminQna__div-inline"><div class="vm-adminQna__div-inner text-right">'
						+ '<button class="btn btn-default" type="button" onclick="admin_qna_modify();">수정</button>'
						+ '<button class="btn btn-default" type="button" onclick="admin_qna_delete(' + obj.qna.no + ');">삭제</button></div></div></div></td>'
				}
				$(".vm-adminQna__content-section").eq(index).html(value);
			}
		})//ajax close 

	}
	
</script>
<%-- -------- //JavaScript -------- --%>