<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${null == loginMemberDto}">
	<c:redirect url = "/"/>
</c:if>
<c:import url="/WEB-INF/views/common/top.jsp" />


<link rel="stylesheet" href="/resources/each/css/qnaList.css?${verQuery}" />

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-qnaList-top">			
		<div class="vm-section">
			<div class="vui-headline">마이페이지</div>

			<div class="vui-my-submenu">
				<a href="/MyProfile" class="vui-my-submenu__link">
					<span class="vui-my-submenu__text">내 정보 수정</span>
				</a>
				<a href="/DonateList" class="vui-my-submenu__link">
					<span class="vui-my-submenu__text">후원내역</span>
				</a>
				<a class="vui-my-submenu__link on">
					<span class="vui-my-submenu__text">Q&amp;A</span>
				</a>
			</div>
			
			
			<div class="vm-qnaList__article">
			<div class="vui-board vm-qnaList">
				<%-- top --%>
				<div class="vui-board__box vui-board__box--t row">
					<form class="vm-qnaList__form form-inline" action="" method="post" name="qna_selectbox">
						<%-- <div class="form-group" style="width:62%;"></div> --%><%-- ㅡㅡ --%>
						<div class="btn-group">
							<select class="form-control" id="select-category">
								<option value="title" selected>Category</option>
								<option value="title">제목</option>
								<option value="content">내용</option>
								<option value="category">문의종류</option>
							</select>
						</div>
						<div class="input-group" id="search-group">
							<%-- <div class="input-group-prepend">
								<span class="input-group-text"><i class="ni ni-zoom-split-in"></i></span>
							</div> --%>
							<input class="form-control" placeholder="Search" type="text" id="search-keyword">
						</div>
						<button type="button" class="btn btn-outline-primary" id="searchBtn" onclick='searching(1);'>검색</button>
					</form>
				</div>
				<%-- //top --%>

				<%-- table --%>
				<div class="vui-table vm-qnaList__table">
					<table class="table table-hover text-center">
						<thead>
							<tr>
								<%-- <th width="8%">No</th> --%>
								<th width="12%">문의종류</th>
								<th width="*">문의내용</th>
								<th width="10%">문의일</th>
								<th width="10%">답변일</th>
								<th width="10%">처리상태</th>
							</tr>
						</thead>
						<tbody id="ajax-tbody">
							<c:forEach items="${list}" var="qna">
								<%-- list default --%>
								<tr onclick="toggle_fx('${qna.no}');">
									<%-- <td>${qna.no}</td> --%>
									<td>${qna.category}</td>
									<td class="text-left"><a href="javascript:void(0);">${qna.title}</a></td>
									<td>${qna.write_date}</td>
									<td>
										<c:choose>
											<c:when test="${!empty qna.answer_write_date }">
												${qna.answer_write_date}
											</c:when>
											<c:otherwise>
												-
											</c:otherwise>
										</c:choose>
									</td>
									<td>${qna.state}</td>
								</tr>
								<%--// list default --%>
								
								<%--toggle section --%>
								<tr class="vm-qnaList__content-section" style="display:none;">
									<td colspan="5" class="text-left"></td>
								</tr>
								<%--//toggle section --%>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<%-- //table --%>

				<%-- bottom --%>
				<div class="vui-board__box vui-board__box--b row mt-3">
					<div class="col"><%-- 칸맞추기용 --%></div>
					<div class="col">
						<nav class="vui-navigation" aria-label="Page navigation example">
							<ul class="pagination justify-content-center" id="my-pagination">
								<li class="page-item">
									<c:choose>
										<c:when test="${currentPage <= 1}">
											<a class="page-link disabled" href="javascript:void(0)"><i class="fa fa-angle-left"></i></a>
										</c:when>
										<c:otherwise>
											<a class="page-link" href="javascript:void(0)" onclick="searching(1)">
											<i class="fa fa-angle-left"></i></a>
										</c:otherwise>
									</c:choose>
								</li>
								<c:forEach var="p" begin="${startPage}" end="${endPage}">
									<c:choose>
										<c:when test="${currentPage eq p }">
											<li class="active page-item"><a class="page-link" href="javascript:void(0)">${p}</a></li>
										</c:when>
										<c:otherwise>
											<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="searching('${p}')">${p}</a></li>
										</c:otherwise>
									</c:choose>	
								</c:forEach>
								<li class="page-item">
									<c:choose>
										<c:when test="${currentPage >= maxPage}">
										<a class="page-link disabled" href="javascript:void(0)">
											<i class="fa fa-angle-right"></i></a>
										</c:when>
										<c:otherwise>
											<a class="page-link" href="javascript:void(0)" onclick="searching('${endPage + 1}')">
											<i class="fa fa-angle-right"></i></a>
										</c:otherwise>
									</c:choose>
								</li>								
							</ul>
						</nav>
					</div>
					<div class="col text-right">
						<button class="btn btn-primary" type="button" onclick="location.href='QnaWrite'">문의하기</button>
					</div>
				</div>
				<%-- //bottom --%>
			</div>
			</div>
		</div>
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/qnaList.js?${verQuery}"></script> --%>
<script>
	(function ($) {
		// do not remove this string
		"use strict";

		// javascript code here
		
		
		//카테고리 변경 이벤트
		$('#select-category').on('change', function(){
			val = $('#search-group').html();
			val = '';
			
			if($('#select-category').val() == 'category'){
				categoryFx();
			}else{
				/*val += '<div class="input-group-prepend"><span class="input-group-text"><i class="ni ni-zoom-split-in"></i></span>'
					+ '</div><input class="form-control" placeholder="Search" type="text" id="search-keyword">';*/
				val += '<input class="form-control" placeholder="Search" type="text" id="search-keyword">';
				$('#search-group').html(val);
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
	if('${kind}' === 'title' || '${kind}' === 'content' || '${kind}' === 'category'){
		$("#select-category").val('${kind}');
	}
	
	//문의종류
	if('${category}' === '기타' || '${category}' === '입양' || '${category}' === '자원봉사'
		|| '${category}' === '쇼핑몰' || '${category}' === '건의' || '${category}' === '신고'){
		val = $('#search-group').html();
		val = '';
		
		categoryFx();
		
		$("#select-category2").val('${category}');
	}
	
	//키워드
	if('${keyword}'){
		$("#search-keyword").val('${keyword}');
	}
	
	
	//카테고리 변경 반영
	function categoryFx(){
		val += '<div class="btn-group"><select class="form-control" id="select-category2" style="width:13.5rem;">'
			+ '<option value="기타" selected>기타</option><option value="입양">입양</option>'
			+ '<option value="자원봉사">자원봉사</option><option value="쇼핑몰">쇼핑몰</option>'
			+ '<option value="건의">건의</option><option value="신고">신고</option></select></div>';
		$('#search-group').html(val);
	}
	
	function toggle_fx(no){
		var index = $(event.target).closest("tr").index() / 2;
		$(".vm-qnaList__content-section").eq(index).toggle(qna_detail(no));
	}
	
	function cancel(){
		var index = Math.floor($(event.target).closest("tr").index() / 2);
		$(".vm-qnaList__content-section").eq(index).empty();
		$(".vm-qnaList__content-section").eq(index).toggle();
	}
	
	function qna_delete(no){
		if(confirm("정말 삭제하시겠습니까?")){
			var where = 'user';
			$.ajax({
				url : 'qnaDelete',
				data : {no : no, where : where},
				type : 'POST',
				success : function(){
					location.href='QnaList';
				}
			})//ajax close 
		}
	}
	
	function submit(no){
		var textval = $("textarea").val();
		
		if(confirm("수정한 내용을 등록하시겠습니까?")){
			
			if(textval.length > 100 || textval.length < 1){
				alert("내용은 최소 한 글자 이상 최대 100 글자 이하여야합니다.\n(현재 " + textval.length + " 자.)");
				return;
			}
			
			$.ajax({
				url : 'qnaModify',
				data : {no : no, content : textval},
				type : 'post',
				success : function(){
					location.href='QnaList';
				}
			})//ajax close 
		}
	}

	function qna_modify(){
		var contents = obj.qna.content.replace('<br>', '\n\r');
		
		var index = Math.floor($(event.target).closest("tr").index() / 2);
		var value = $(".vm-qnaList__content-section").eq(index);
		value =''; 
		value += '<td colspan="5" class="text-left"><div class="vm-qnaList__div-outline"><div class="vm-qnaList__div-inline">'
			+ '<div class="vm-qnaList__div-inner"><span class="vm-qnaList__span-bold">Q.&nbsp;&nbsp;&nbsp;&nbsp;' + obj.qna.title + '</span>'
			+ '</div></div><div class="vm-qnaList__div-inline"><div class="vm-qnaList__div-inner-magin">'
			+ '<textarea class="vm-qnaList__textarea form-control" rows="7">' + contents + '</textarea></div>'
			+ '</div><div class="vm-qnaList__div-inline"><div class="vm-qnaList__div-inner text-right">'
			+ '<button class="btn btn-primary" type="button"onclick="submit(\'' + obj.qna.no + '\');">수정</button>'
			+ '<button class="btn btn-primary" type="button" onclick="cancel();">취소</button></div></div></div></td>';
		
		$(".vm-qnaList__content-section").eq(index).html(value);
		console.log("modify run.....");
	 }

	
	function qna_detail(no){
		$(".vm-qnaList__content-section").empty(); //비우기. 안비우면 textarea 꼬임
		var index = $(event.target).closest("tr").index() / 2;
		var value = $(".vm-qnaList__content-section").eq(index);
		
		//다른 tr 닫기
		if(!$(".vm-qnaList__content-section").not(value).css('display', 'none')){
			$(".vm-qnaList__content-section").hide().not(value);
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
				
				value += '<td colspan="5" class="text-left"><div class="vm-qnaList__div-outline"><div class="vm-qnaList__div-inline"><div class="vm-qnaList__div-inner">'
					+ '<span class="vm-qnaList__span-bold">Q.&nbsp;&nbsp;&nbsp;&nbsp;' + obj.qna.title + '</span>&nbsp;&nbsp;&nbsp;<span class="vm-qnaList__span-small">' + obj.qna.write_date
					+ '</span></div></div><div class="vm-qnaList__div-inline"><div class="vm-qnaList__div-inner-magin"><span class="vm-qnaList-span-content">'
					+ contents + '</span></div></div><div class="vm-qnaList__div-inline"><div class="vm-qnaList__div-inner text-right">';
					
				value += (!obj.qna.answer_content) ? '<button class="btn btn-primary" type="button" onclick="qna_modify();">수정</button>' : '';
				value += '<button class="btn btn-primary" type="button" onclick="qna_delete(' + obj.qna.no + '); return false;">삭제</button></div></div></div>';
					
				if(obj.qna.answer_content){
					value += '<hr class="vm-qnaList__hr-margin"><div class="vm-qnaList__div-outline"><div class="vm-qnaList__div-inline">'
						  +'<div class="vm-qnaList__div-inner"><span class="vm-qnaList__span-bold">A.&nbsp;&nbsp;&nbsp;&nbsp;[Re]:'
						  + obj.qna.title + '</span>&nbsp;&nbsp;&nbsp;<span class="vm-qnaList__span-small">' + obj.qna.answer_write_date
						  + '</span></div></div><div class="vm-qnaList__div-inline"><div class="vm-qnaList__div-inner">'
						  + '<span class="ml-5 vm-qnaList-span-content">' + answer_contents + '</span></div></div></div></td>';
				}
				$(".vm-qnaList__content-section").eq(index).html(value);
					
			}
		})//ajax close 
	}
	
	function searching(page){
		var category1 = $("#select-category").val();	//카테고리
		var category2 = (!$("#select-category2").val()) ? '' : $("#select-category2").val();	//문의종류
		var keyword = (!$("#search-keyword").val()) ? '' : $("#search-keyword").val().trim();	//키워드
		
		$.ajax({
			url : 'QnaList',
			data : {sc1 : category1, sc2 : category2, sk : keyword, page : page, where : 'user'},
			type : 'GET',
			success : function(){
				location.href='QnaList?sc1=' + category1 + '&sc2=' + category2 + '&sk=' + keyword + '&where=user&page=' + page;
			}
		})//ajax close 
	}
</script>
<%-- -------- //JavaScript -------- --%>