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
<!-- bootstrap-daterangepicker -->
<link href="/resources/vendor/gentelella/vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">
<!-- bootstrap-datetimepicker -->
<link href="/resources/vendor/gentelella/vendors/bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.css" rel="stylesheet">
<!-- Switchery -->
<link href="/resources/vendor/gentelella/vendors/switchery/dist/switchery.min.css" rel="stylesheet">
<!-- Custom Theme Style -->
<link href="/resources/vendor/gentelella/build/css/custom.min.css?${verQuery}" rel="stylesheet">

<link rel="stylesheet" href="/resources/each/css/adminDonationList.css?${verQuery}" />

<%-- -------- JSP -------- --%>
<div class="right_col vm-admin-content vm-adminDonationList" role="main">
	<div class="">
		<div class="page-title">
			<div class="title_left">
				<h3>후원내역</h3>
			</div>
		</div>
		<div class="clearfix"></div>
		<div class="row" style="margin-top: 20px;">
			<div class="col-md-12 col-sm-12 col-xs-12">
				<div class="x_panel">
					<div class="x_content">
						<div class="vm-adminDonationList__submit-box">
							<a id="addInsertRowBtn" class="btn btn-info">후원내역 추가</a>
							<a id="updateDonateBtn" class="btn btn-success">후원내역 수정</a>
							<a id="deleteDonateBtn" class="btn btn-danger">후원내역 삭제</a>
						</div>

						<%-- ==================================== 등록 ==================================== --%>
						<script id="doanteRowTemplate" type="text/template">
							<tr>
								<td><input required type="text" class="form-control" name="account_no" /></td>
								<td><input required type="text" class="form-control" name="account_host" /></td>
								<td><input required type="text" class="form-control" name="bank" /></td>
								<td><input required type="text" class="form-control" name="donation" /></td>
								<td>
									<div class="col-md-11 xdisplay_inputx form-group has-feedback" style="width: 100%;">
										<input required name="donate_date" type="text" class="single_cal2 form-control has-feedback-left" 
											placeholder="First Name" aria-describedby="inputSuccess2Status2">
										<span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
										<span id="inputSuccess2Status2" class="sr-only">(success)</span>
									</div>
								</td>
								<td><input required type="text" class="form-control" name="supporter_id" /></td>
								<td>
									<a class="vm-adminDonationList__delete-btn btn btn-danger btn-xs">
										<i class="fa fa-trash-o"></i> Delete
									</a>
								</td>
							</tr>
						</script>

						<form class="vm-adminDonationList__insert-form" style="display: none;">
							<input type="hidden" name="writer" value="${loginMemberDto.id}" />

							<table class="table table-hover table-bordered">
								<thead>
									<tr>
										<th>계좌번호</th>
										<th>예금주</th>
										<th>은행</th>
										<th>금액</th>
										<th>입금날짜</th>
										<th>입금자 ID</th>
										<th>삭제</th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>

							<button id="insertDonateBtn" class="btn" type="submit">전송</button>
						</form>
						<%-- ==================================== //등록 ==================================== --%>

						<%-- ==================================== 수정 및 삭제 ==================================== --%>
						<div class="vm-adminDonationList__info-table">
							<table id="datatable-buttons" class="table table-striped table-bordered">
								<thead>
									<tr>
										<td>No</td>
										<td>작성자</td>
										<td>계좌번호</td>
										<td>예금주</td>
										<td>은행</td>
										<td>금액</td>
										<td>입금날짜</td>
										<td>입금자 ID</td>
										<td>삭제</td>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="item" items="${donateDtoList}" varStatus="status">
										<tr>
											<td>
												<input type="hidden" name="no" value="${item.no}" />
												${item.rnum}
											</td>
											<td>${item.writer}</td>
											<td>
												<div class="vm-adminDonationList__hide-text">${item.account_no}</div>
												<input type="text" class="form-control" name="account_no" value="${item.account_no}" data-original="${item.account_no}" />
												<div class="vm-adminDonationList__original-value"></div>
											</td>
											<td>
												<div class="vm-adminDonationList__hide-text">${item.account_host}</div>
												<input type="text" class="form-control" name="account_host" value="${item.account_host}" data-original="${item.account_host}" />
												<div class="vm-adminDonationList__original-value"></div>
											</td>
											<td>
												<div class="vm-adminDonationList__hide-text">${item.bank}</div>
												<input type="text" class="form-control" name="bank" value="${item.bank}" data-original="${item.bank}" />
												<div class="vm-adminDonationList__original-value"></div>
											</td>
											<td>
												<div class="vm-adminDonationList__hide-text">${item.donation}</div>
												<input type="text" class="form-control" name="donation" value="${item.donation}" data-original="${item.donation}" />
												<div class="vm-adminDonationList__original-value"></div>
											</td>
											<td>
												<div class="vm-adminDonationList__hide-text">${item.donate_date}</div>
												<div class="col-md-11 xdisplay_inputx form-group has-feedback" style="width: 100%;">
													<input name="donate_date" value="${item.donate_date}" data-original="${item.donate_date}" type="text" class="single_cal2 form-control has-feedback-left" 
														placeholder="First Name" aria-describedby="inputSuccess2Status2">
													<span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
													<span id="inputSuccess2Status2" class="sr-only">(success)</span>
												</div>
												<div class="vm-adminDonationList__original-value"></div>
											</td>
											<td>
												<div class="vm-adminDonationList__hide-text">${item.supporter_id}</div>
												<input type="text" class="form-control" name="supporter_id" value="${item.supporter_id}" data-original="${item.supporter_id}" />
												<div class="vm-adminDonationList__original-value"></div>
											</td>
											<td><input type="checkbox" class="js-switch" data-color="#d9534f" /></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<%-- ==================================== //수정 및 삭제 ==================================== --%>
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
<!-- bootstrap-daterangepicker -->
<script src="/resources/vendor/gentelella/vendors/moment/min/moment.min.js"></script>
<script src="/resources/vendor/gentelella/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
<!-- bootstrap-datetimepicker -->    
<script src="/resources/vendor/gentelella/vendors/bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
<!-- Switchery -->
<script src="/resources/vendor/gentelella/vendors/switchery/dist/switchery.min.js"></script>
<!-- Custom Theme Scripts -->
<script src="/resources/vendor/gentelella/build/js/custom.js?${verQuery}"></script>

<%-- -------- JavaScript -------- --%>
<script src="/resources/each/js/adminDonationList.js?${verQuery}"></script>
<%-- -------- //JavaScript -------- --%>