<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/WEB-INF/views/common/top.jsp" />

<style>
	.vm-error-404 .vm-section { margin: auto; padding-top: 10px; text-align: center; }
	.vm-error-404__img-box { position: relative; }
	.vm-error-404__img {
		width: 440px;
		padding: 20px 20px 40px;
		border: 1px solid #ddd;
		background-color: #fff;
	}
	.vm-error-404__img--01 {
		position: relative;
		z-index: 1;
		margin: 0 auto;
		transform: rotateZ(6deg) translateX(40%);
	}
	.vm-error-404__img--02 {
		position: absolute;
		left: 50%;
		top: 0;
		transform: translateX(-80%);
	}
	.vm-error-404__img img { width: 100%; }
	.vm-error-404__title {
		display: inline-block;
		margin-top: 70px;
		color: #f3437d;
		font-size: 30px;
		line-height: 1.4em;
		font-weight: 600;
	}
	.vm-error-404__message { margin-top: 30px; color: #666; }
	.vm-error-404__link { display: inline-block; margin-top: 20px; text-decoration: underline; }
	.vm-error-404__link:hover{ text-decoration: underline; }
</style>

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-error-404">
		<div class="vm-section">
			<div class="vm-error-404__img-box">
				<div class="vm-error-404__img vm-error-404__img--01">
					<img src="/resources/common/images/dog_03.jpg" alt="">
				</div>

				<div class="vm-error-404__img vm-error-404__img--02">
					<img src="/resources/common/images/dog_04.jpg" alt="">
				</div>
			</div>

			<div class="vm-error-404__title">원하시는 페이지를 찾을 수가 없습니다.</div>

			<div class="vm-error-404__message">
				방문하시려는 페이지의 주소가 잘못 입력되었거나,<br>
				페이지의 주소가 변경 혹은 삭제되어 요청하신 페이지를 찾을 수 없습니다.<br>
				<div style="height: 20px"></div>
				입력하신 주소가 정확한지 다시 한번 확인해 주시기 바랍니다.
			</div>

			<a class="vm-error-404__link" href="/">메인으로 이동하기</a>
		</div>
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />