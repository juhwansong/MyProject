<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/WEB-INF/views/common/top.jsp" />

<style>
	.vm-error-common .vm-section { margin: auto; padding-top: 10px; text-align: center; }
	.vm-error-common__box {
		overflow: hidden;
		width: 600px;
		margin: 0 auto;
		padding: 40px 40px 30px;
		border: 1px solid #ddd;
		border-radius: 4px;
		box-shadow: 2px 4px 10px 0 #999;
		background-color: #fff;
	}
	.vm-error-common__img { width: 100%; }
	.vm-error-common__img img { width: 100%; vertical-align: top; }
	.vm-error-common__title {
		display: inline-block;
		margin-top: 30px;
		padding-left: 60px;
		background: url(/resources/common/images/exclamation.png) no-repeat left center;
		background-size: contain;
		color: #f44336;
		font-size: 30px;
		line-height: 1.4em;
	}
	.vm-error-common__message {
		margin-top: 30px;
		color: #666;
	}
</style>

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-error-common">
		<div class="vm-section">
			<div class="vm-error-common__box">
				<div class="vm-error-common__img">
					<img src="/resources/common/images/dog_02.jpg" alt="">
				</div>

				<div class="vm-error-common__title">알 수 없는 문제가 발생했습니다 !</div>

				<div class="vm-error-common__message">
					진행 중인 작업이 있었다면 다시 시도해주세요.<br>
					죄송합니다.
				</div>
			</div>
		</div>
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />