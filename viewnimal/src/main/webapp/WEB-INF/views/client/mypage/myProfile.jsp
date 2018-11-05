<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- 세션에 계정 정보 없으면 메인으로 리다이렉트 --%>
<c:if test="${null == loginMemberDto}">
	<c:redirect url = "/"/>
</c:if>

<c:import url="/WEB-INF/views/common/top.jsp" />

<link rel="stylesheet" href="/resources/each/css/myProfile.css?${verQuery}" />

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-myProfile">

		<div class="vm-section">
			<div class="vui-headline">마이페이지</div>

			<div class="vui-my-submenu">
				<a class="vui-my-submenu__link on">
					<span class="vui-my-submenu__text">내 정보 수정</span>
				</a>
				<a href="/DonateList" class="vui-my-submenu__link">
					<span class="vui-my-submenu__text">후원내역</span>
				</a>
				<a href="/QnaList" class="vui-my-submenu__link">
					<span class="vui-my-submenu__text">Q&amp;A</span>
				</a>
			</div>

			<div class="vm-myProfile__article">
				<form id="myForm" class="vm-myProfile__form" role="form">
					<div class="vm-myProfile__form__input">
						<div class="vm-myProfile__form__input__item vm-myProfile__form__input__item--off">
							<div class="input-group input-group-alternative">
								<div class="input-group-prepend">
									<span class="input-group-text"><i class="ni ni-email-83"></i></span>
								</div>
								<c:choose>
									<c:when test="${loginMemberDto.id_type != 'NORMAL'}">
										<c:choose>
											<c:when test="${loginMemberDto.id_type == 'GOOGLE'}">
												<c:set var="varId" value="Google Account" />
											</c:when>
										</c:choose>
									</c:when>

									<c:otherwise>
										<c:set var="varId" value="${loginMemberDto.id}" />
									</c:otherwise>
								</c:choose>

								<input class="form-control" type="email" autocomplete="off" disabled="" 
									value="${varId}" />
							</div>
							<div class="vm-myProfile__form__input__message"></div>
						</div>

						<c:if test="${loginMemberDto.id_type == 'NORMAL'}">
							<div class="vm-myProfile__form__input__item">
								<div class="vm-myProfile__form__check">
									<div class="vm-myProfile__form__check__text">
										<strong>비밀번호 변경</strong>
									</div>
									<label class="custom-toggle">
										<input type="checkbox" />
										<span class="custom-toggle-slider rounded-circle"></span>
									</label>
								</div>

								<div class="input-group input-group-alternative">
									<div class="input-group-prepend">
										<span class="input-group-text"><i class="ni ni-lock-circle-open"></i></span>
									</div>
									<input class="form-control" required placeholder="현재 비밀번호" type="password" minlength="5" autocomplete="off" name="password" />
								</div>
							</div>

							<div class="vm-myProfile__form__input__item vm-myProfile__form__input__item--new-password" style="display: none;">
								<div class="vm-myProfile__form__input__case">
									<div class="input-group input-group-alternative">
										<div class="input-group-prepend">
											<span class="input-group-text"><i class="ni ni-lock-circle-open"></i></span>
										</div>
										<input class="form-control" placeholder="새 비밀번호" type="password" minlength="5" autocomplete="off" name="newPassword" />
									</div>
								</div>

								<div class="vm-myProfile__form__input__case">
									<div class="input-group input-group-alternative">
										<div class="input-group-prepend">
											<span class="input-group-text"><i class="ni ni-lock-circle-open"></i></span>
										</div>
										<input class="form-control" placeholder="새 비밀번호 확인" type="password" minlength="5" autocomplete="off" />
									</div>
									<div class="vm-myProfile__form__input__message"></div>
								</div>
							</div>

						</c:if>

						<div class="vm-myProfile__form__input__item">
							<div class="input-group input-group-alternative">
								<div class="input-group-prepend">
									<span class="input-group-text"><i class="ni ni-email-83"></i></span>
								</div>
								<input class="form-control" required placeholder="이메일" type="email" autocomplete="off" name="email"
									pattern="^[A-Za-z0-9_\.\-\+]+@[A-Za-z0-9\-]+\.[A-Za-z]+$"
									value="${loginMemberDto.email}" />
							</div>
						</div>

						<div class="vm-myProfile__form__input__item">
							<div class="input-group input-group-alternative">
								<div class="input-group-prepend">
									<span class="input-group-text"><i class="ni ni-circle-08"></i></span>
								</div>
								<input class="form-control" required placeholder="닉네임" type="text" name="nickname"
									value="${loginMemberDto.nickname}" />
							</div>
							<div class="vm-myProfile__form__input__message"></div>
						</div>

						<div class="vm-myProfile__form__input__item">
							<div class="input-group input-group-alternative">
								<div class="input-group-prepend">
									<span class="input-group-text"><i class="ni ni-mobile-button"></i></span>
								</div>

								<c:set var="varPhone" value="${loginMemberDto.phone}" />
								<c:choose>
									<c:when test="${ 10 == fn:length(varPhone) }">
										<c:set var="varPhone" value="${fn:substring(varPhone, 0, 3)}-${fn:substring(varPhone, 3, 6)}-${fn:substring(varPhone, 6, 10)}" />
									</c:when>

									<c:otherwise>
										<c:set var="varPhone" value="${fn:substring(varPhone, 0, 3)}-${fn:substring(varPhone, 3, 7)}-${fn:substring(varPhone, 7, 11)}" />
									</c:otherwise>
								</c:choose>

								<input class="form-control" required placeholder="휴대폰 번호" type="tel" name="phone" 
									pattern="^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$"
									value="${varPhone}" />
							</div>
							<div class="vm-myProfile__form__input__guide">ex) 010-1234-5678</div>
						</div>
					</div>
				
					<div class="text-center">
						<button type="submit" class="vm-myProfile__form__submit btn btn-primary btn-block">변경하기</button>
					</div>
				</form>

				<div class="vm-myProfile__poster">
					<fmt:parseNumber var="randomNum" value="${ Math.floor( Math.random() * (2 - 1 + 1) ) + 1 }" integerOnly="true" />
					<img src="/resources/images/mypage/poster_0${randomNum}.jpg" alt="">
				</div>
			</div>
		</div>
		
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<script src="/resources/each/js/myProfile.js?${verQuery}"></script>
<%-- -------- //JavaScript -------- --%>