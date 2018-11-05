<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("rn", "\r\n"); %>

<c:import url="/WEB-INF/views/common/top.jsp" />

<link rel="stylesheet" href="/resources/each/css/noticeDetail.css?ver6" />

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-noticeDetail">		
		<div class="vm-section">
			<div class="vui-headline">
				공지사항
			</div>
			<div class="vui-board">
				<%-- table --%>
				<input type="hidden" name="no" id="no" value="${notice.no}">
				<table class="table vm-noticeDetail__table">
					<tbody>
						<tr class="text-center"><!-- info -->
							<td width="5%">No.${notice.no}</td>
							<th class="text-left" width="*">${notice.title}</th>
							<td width="10%">${notice.nickname}</td>
							<td width="10%">${notice.write_date}</td>
							<td width="8%">${notice.read_count }</td>
						</tr>
						
						<%-- 첨부파일 있을 때 --%>
						<c:if test="${!empty notice.original_file_name}">
						<tr class="text-right">
							<td colspan="5">
								<div class="vm-noticeDetail__file-div">
										<c:forEach items="${orifile}" var="ofile" varStatus="ost">
										<c:forEach items="${refile}" var="rfile" varStatus="rst">
											<c:if test="${ost.index eq rst.index}">	
												<c:url var="mfdown" value="mfdown">
													<c:param name="ofile" value="${ofile}"/>
													<c:param name="rfile" value="${rfile}"/>
												</c:url>
												<a href="${mfdown}"><i class="fa fa-file"></i>&nbsp;${orifile[ost.index]}</a><br>
											</c:if>
										</c:forEach>
										</c:forEach>
								</div>
							</td>
						</tr>
						</c:if>

						<%-- //첨부파일 있을 때 --%>
						<tr>
							<td class="vm-noticeDetail__content" colspan="5" height="350">
								${fn:replace(notice.content, rn, "<br>")}
							</td>
						</tr>
					</tbody>
				</table>
				<%-- //table --%>
				<hr class="mt-0 mb-0">
				<%-- bottom buttons --%>
				<div class="vui-board__box vui-board__box--b row mt-3">
					<div class="col">
						<button class="btn btn-primary" type="button" onclick="location.href='NoticeList'">목록</button>
					</div>

					<div class="col text-right">
						<c:if test="${loginMemberDto.type eq 'ADMIN'}">
							<button class="btn btn-secondary" type="button" onclick="location.href='NoticeModify?no=${notice.no}'">수정</button>
							<button class="btn btn-secondary" type="button" onclick="deleteCheck();">삭제</button>
						</c:if>
					</div>
				</div>
				<%-- //bottom buttons --%>
				
				
				<%-- upper lower title --%>
				<div class="vm-noticeDetail__bottom-div mt-4 mb-5">
				
				
					<div class="vui-board__box vui-board__box--b row mt-0">
						<c:if test="${0 ne notice.next_no}">
							<c:url var="NoticeDetail" value="NoticeDetail">
								<c:param name="no" value="${notice.next_no}"></c:param>
							</c:url>
							
							<div class="ml-3" style="width:10%;">
								<a href="${NoticeDetail}"><i class="fa fa-chevron-up"></i>&nbsp;윗글</a>
							</div>
							<div class="col text-truncate">
								<a href="${NoticeDetail}">${notice.next_title}</a>
							</div>
							<div class="col text-right mr-2">
								${notice.next_write_date}
							</div>
						</c:if>
					</div>
					
					<hr class="mt-1 mb-1">
					
					<div class="vui-board__box vui-board__box--b row mt-0">
						<c:if test="${0 ne notice.pre_no}">
							<c:url var="NoticeDetail" value="NoticeDetail">
								<c:param name="no" value="${notice.pre_no}"></c:param>
							</c:url>
							
							<div class="ml-3" style="width:10%;">
								<a href="${NoticeDetail}"><i class="fa fa-chevron-down"></i>&nbsp;아래글</a>
							</div>
							<div class="col text-truncate">
								<a href="${NoticeDetail}">${notice.pre_title}</a>
							</div>
							<div class="col text-right mr-2">
								${notice.pre_write_date}
							</div>
						</c:if>
					</div>
					
					
				</div>
				<%-- //upper lower title --%>
				
				
			</div>
		</div>
		
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/noticeDetail.js?${verQuery}"></script> --%>
<script>
	(function ($) {
		// do not remove this string
		"use strict";

		// javascript code here
	}(jQuery));
	
	
    function deleteCheck(){
    	if(confirm("정말 삭제 하시겠습니까?")){
	        var no = $("#no").val();
	        
	        $.ajax({
	            url: 'noticeDelete',
	            data: {no : no},
	            type:'POST',
	            success:function(){
	            	location.href='NoticeList'
	            }
	        });//ajax close
    	}
    }
	
	
</script>
<%-- -------- //JavaScript -------- --%>