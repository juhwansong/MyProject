<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- 세션에 계정 정보 없으면 메인으로 리다이렉트 --%>
<c:if test="${null == loginMemberDto || 'ADMIN' != loginMemberDto.type}">
	<c:redirect url = "/"/>
</c:if>

<c:import url="/WEB-INF/views/common/adminTop.jsp" />

<!-- iCheck -->
<link href="/resources/vendor/gentelella/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
<!-- Datatables -->
<link href="/resources/vendor/gentelella/vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
<link href="/resources/vendor/gentelella/vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
<link href="/resources/vendor/gentelella/vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
<link href="/resources/vendor/gentelella/vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
<link href="/resources/vendor/gentelella/vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">
<!-- Switchery -->
<link href="/resources/vendor/gentelella/vendors/switchery/dist/switchery.min.css" rel="stylesheet">
<!-- Custom Theme Style -->
<link href="/resources/vendor/gentelella/build/css/custom.min.css?${verQuery}" rel="stylesheet">

<link rel="stylesheet" href="/resources/each/css/adminMember.css?${verQuery}" />

<%-- -------- JSP -------- --%>
<div class="right_col vm-admin-content vm-adminMember" role="main">
	<div class="">
		<div class="page-title">
			<div class="title_left">
				<h3>회원관리</h3>
			</div>
		</div>
		<div class="clearfix"></div>
		<div class="row" style="margin-top: 20px;">
			<div class="col-md-12 col-sm-12 col-xs-12">
				<div class="x_panel">
					<div class="x_content">
						<div class="vm-adminMember__submit-box">
							<a id="updateUserBtn" class="btn btn-success">회원정보 수정</a>
						</div>

						<table id="datatable-buttons" class="table table-striped table-bordered">
							<thead>
								<tr>
									<td>No</td>
									<td>아이디</td>
									<td>닉네임</td>
									<td>이메일</td>
									<td>휴대폰 번호</td>
									<td>회원타입</td>
									<td>계정상태</td>
									<td>계정타입</td>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="${memberDtoList}" varStatus="status">
									<tr>
										<td>${item.rnum}</td>
										<td>
											<input type="hidden" name="id" value="${item.id}" />
											${item.id}
										</td>
										<td>${item.nickname}</td>
										<td>
											<div class="vm-adminMember__hide-text">${item.email}</div>
											<input type="text" class="form-control" name="email" value="${item.email}" data-original="${item.email}" />
											<div class="vm-adminMember__original-value"></div>
										</td>
										<td>
											<c:set var="varPhone" value="${item.phone}" />
											<c:choose>
												<c:when test="${ 10 == fn:length(varPhone) }">
													<c:set var="varPhone" value="${fn:substring(varPhone, 0, 3)}-${fn:substring(varPhone, 3, 6)}-${fn:substring(varPhone, 6, 10)}" />
												</c:when>

												<c:otherwise>
													<c:set var="varPhone" value="${fn:substring(varPhone, 0, 3)}-${fn:substring(varPhone, 3, 7)}-${fn:substring(varPhone, 7, 11)}" />
												</c:otherwise>
											</c:choose>

											<div class="vm-adminMember__hide-text">${varPhone}</div>
											<input type="text" class="form-control" name="phone" value="${varPhone}" data-original="${varPhone}" />
											<div class="vm-adminMember__original-value"></div>
										</td>
										<td>${item.type}</td>
										<td>
											<div class="vm-adminMember__hide-text">${item.state}</div>
											<select name="state" class="form-control" data-original="${item.state}">
												<option ${ '정상' == item.state ? 'selected' : '' } value="정상">정상</option>
												<option ${ '정지' == item.state ? 'selected' : '' } value="정지">정지</option>
												<option ${ '탈퇴' == item.state ? 'selected' : '' } value="탈퇴">탈퇴</option>
											</select>
											<div class="vm-adminMember__original-value"></div>
										</td>
										<td>${item.id_type}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/adminBottom.jsp" />

<!-- iCheck -->
<script src="/resources/vendor/gentelella/vendors/iCheck/icheck.min.js"></script>
<!-- Datatables -->
<script src="/resources/vendor/gentelella/vendors/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="/resources/vendor/gentelella/vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
<script src="/resources/vendor/gentelella/vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
<script src="/resources/vendor/gentelella/vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
<script src="/resources/vendor/gentelella/vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
<script src="/resources/vendor/gentelella/vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
<script src="/resources/vendor/gentelella/vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
<script src="/resources/vendor/gentelella/vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
<script src="/resources/vendor/gentelella/vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
<script src="/resources/vendor/gentelella/vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
<script src="/resources/vendor/gentelella/vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
<script src="/resources/vendor/gentelella/vendors/datatables.net-scroller/js/dataTables.scroller.min.js"></script>
<script src="/resources/vendor/gentelella/vendors/jszip/dist/jszip.min.js"></script>
<script src="/resources/vendor/gentelella/vendors/pdfmake/build/pdfmake.min.js"></script>
<script src="/resources/vendor/gentelella/vendors/pdfmake/build/vfs_fonts.js"></script>
<!-- Switchery -->
<script src="/resources/vendor/gentelella/vendors/switchery/dist/switchery.min.js"></script>
<!-- Custom Theme Scripts -->
<script src="/resources/vendor/gentelella/build/js/custom.js?${verQuery}"></script>

<%-- -------- JavaScript -------- --%>
<script src="/resources/each/js/adminMember.js?${verQuery}"></script>
<%-- -------- //JavaScript -------- --%>