<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="imgPath" value="/resources/common/images" />
<c:set var="pageMainTypeB" value="${ pageMainType == 'shop' ? true : false }" />

<%-- 메시지 팝업 --%>
<div class="vui-message-pop">
	<span class="vui-message-pop__text"></span>
</div>
<%-- //메시지 팝업 --%>

<%-- 로딩 창 --%>
<div class="vui-loading-window" style="display: none;">
	<span class="vui-loading-icon">
		<i class="fa fa-spinner" aria-hidden="true"></i>
	</span>
</div>
<%-- //로딩 창 --%>

<%-- 검색박스 --%>
<div class="vui-search">
	<div class="vm-section">
		<div class="vui-search__title">검색어를 입력해주세요</div>

		<form id="searchAllForm" class="vui-search__box vm-flex-row">
			<div class="vui-search__input-text">
				<input type="text" name="keyword" />
			</div>
			<button type="submit" class="vui-search__search-btn">
				<img src="${imgPath}/zoom-2_purple.svg" alt="">
			</button>
		</form>

		<!-- underscore template -->
		<script id="auto-complete-list" type="text/template">
			<a href="" class="vui-search__item">
				<span class="vui-search__item__text"><@= data @></span>
			</a>
		</script>
		<div class="vui-search__list"></div>
	</div>
</div>

<div class="vui-dim"></div>
<%-- //검색박스 --%>

<%-- header --%>
<div class="vm-header">
	<%-- vm-header__head --%>
	<div class="vm-header__head">
		<div class="vm-section vm-flex-row">

			<%-- vui-my-menu --%>
			<div class="vui-my-menu">
				<c:if test="${'ADMIN' == loginMemberDto.type}">
					<a href="/AdminMain" class="btn btn-1" style="background: #26B99A; color: #fff;">관리자 페이지</a>
				</c:if>
				<a href="/MyProfile" class="btn btn-1 btn-neutral">내 정보 수정</a>
				<a href="/DonateList" class="btn btn-1 btn-neutral">후원내역</a>
				<a href="/QnaList" class="btn btn-1 btn-neutral">Q&amp;A</a>
				<a href="/SelectCart" class="btn btn-1 btn-neutral">장바구니</a>
				<%-- <a href="" class="btn btn-1 btn-neutral">물품 구매내역</a> --%>
				<a id="removeSession" href="" class="btn btn-1 btn-primary">로그아웃</a>
			</div>
			<%-- //vui-my-menu --%>

			<div class="vm-header__head__item vm-header__head__item--l">
				<a href="/" 			class="${ pageMainTypeB ? '' : 'on' } vm-header__head__main-btn">메인</a>
				<a href="/ProductList?productList=1" 	class="${ pageMainTypeB ? 'on' : '' } vm-header__head__main-btn">쇼핑몰</a>
			</div>

			<div class="vm-header__head__item vm-header__head__item--c">
				<a href="/" class="vm-header__logo">
					<img src="${imgPath}/main_logo.png" alt="" />
					<span class="vm-header__logo__text">VIEWNIM@L</span>
				</a>
			</div>

			<div class="vm-header__head__item vm-header__head__item--r">
				<a class="vm-header__search">
					<img src="${imgPath}/zoom-2.svg" alt="">
				</a>
				<c:choose>
					<c:when test="${ null == loginMemberDto }">
						<a class="vm-header__profile-login" data-toggle="modal" data-target="#modal-login">로그인</a>
					</c:when>

					<c:otherwise>
						<a class="vm-header__my-menu">
							<img src="${imgPath}/profile_01.png" alt="">
						</a>
					</c:otherwise>
				</c:choose>
			</div>

		</div>
	</div>
	<%-- //vm-header__head --%>

	<%-- vm-header__nav --%>
	<div class="vm-header__nav">
		<div class="vm-section vm-flex-row">
			<c:choose>
				<c:when test="${ ! pageMainTypeB }">
					<%-- <a href="/" 						class="vm-header__nav__link ${ pageSubType == 'Main' ? 'on' : '' }">홈</a> --%>
					<a href="/ChannelList" 				class="vm-header__nav__link ${ pageSubType == 'ChannelList' ? 'on' : '' }">채널</a>
					<a href="/Streaming" 				class="vm-header__nav__link ${ pageSubType == 'Streaming' ? 'on' : '' }">스트리밍</a>
					<a href="/Lab" 						class="vm-header__nav__link ${ pageSubType == 'Lab' ? 'on' : '' }">연구소</a>
					<a href="/VolunteerApplyList" 		class="vm-header__nav__link ${ pageSubType == 'VolunteerApplyList' ? 'on' : '' }">봉사</a>
					<a href="/VolunteerEpilogueList" 	class="vm-header__nav__link ${ pageSubType == 'VolunteerEpilogueList' ? 'on' : '' }">봉사후기</a>
					<a href="/Adoption" 				class="vm-header__nav__link ${ pageSubType == 'Adoption' ? 'on' : '' }">입양 </a>
					<a href="/AdoptionReview" 			class="vm-header__nav__link ${ pageSubType == 'AdoptionReview' ? 'on' : '' }">입양후기</a>
					<a href="/FreeBoardList" 			class="vm-header__nav__link ${ pageSubType == 'FreeBoardList' ? 'on' : '' }">자유</a>
					<a href="/NoticeList" 				class="vm-header__nav__link ${ pageSubType == 'NoticeList' ? 'on' : '' }">공지</a>
					<%-- <a href="/InfoBoard" 				class="vm-header__nav__link ${ pageSubType == 'InfoBoard' ? 'on' : '' }">생정</a> --%>
				</c:when>

				<c:otherwise>
					<a href="/ProductList?productList=1" 				class="${ category == '전체' ? 'on' : '' } vm-header__nav__link">상품 리스트</a>
					<a href="/ProductList?category=사료&productList=1" 	class="${ category == '사료' ? 'on' : '' } vm-header__nav__link">사료</a>
					<a href="/ProductList?category=간식&productList=1" 	class="${ category == '간식' ? 'on' : '' } vm-header__nav__link">간식</a>
					<a href="/ProductList?category=용품&productList=1" 	class="${ category == '용품' ? 'on' : '' } vm-header__nav__link">용품</a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<%-- //vm-header__nav --%>
</div>
<%-- //header --%>

<c:choose>
	<c:when test="${ null == loginMemberDto }">
			
		<%-- 로그인 팝업 --%>
		<div class="vui-pop vui-pop-login modal fade" id="modal-login" tabindex="-1" role="dialog" aria-labelledby="modal-login" aria-hidden="true">
			<div class="modal-dialog modal- modal-dialog-centered modal-sm" role="document">
				<div class="modal-content">
					<div class="modal-body p-0">
						<div class="card bg-secondary shadow border-0">
							<div class="card-header bg-white">
								<div class="vui-pop__title text-muted text-center">
									<img src="${imgPath}/main_logo.png" alt="" />
									<span class="vui-pop__title__text">로그인</span>
								</div>

								<div class="btn-wrapper text-center">
									<%-- <a href="#" class="btn btn-neutral btn-icon">
										<span class="btn-inner--icon"><img src="/resources/vendor/argon/assets/img/icons/common/github.svg"></span>
										<span class="btn-inner--text">Github</span>
									</a> --%>
									<a id="googleLoginBtn" class="btn btn-neutral btn-icon">
										<span class="btn-inner--icon"><img src="/resources/vendor/argon/assets/img/icons/common/google.svg"></span>
										<span class="btn-inner--text">Google</span>
									</a>
									<%-- <a id="snsFacebook" class="btn btn-neutral btn-icon">
										<span class="btn-inner--icon"><img src="${imgPath}/facebook_logo.png"></span>
										<span class="btn-inner--text">Facebook(준비중)</span>
									</a> --%>
									<%-- <hr> --%>
									<%-- 테스트용 --%>
									<%-- <h6>테스트용</h6>
									<a id="tempUserLogin" class="btn btn-neutral btn-icon">
										<span class="btn-inner--text">user1 로그인</span>
									</a>
									<a id="tempUserAdminLogin" class="btn btn-neutral btn-icon">
										<span class="btn-inner--text">admin1 로그인</span>
									</a> --%>
									<%-- //테스트용 --%>
								</div>
							</div>
							<div class="card-body px-lg-5 py-lg-5">
								<form id="loginForm" role="form">
									<div class="form-group mb-3">
										<div class="input-group input-group-alternative">
											<div class="input-group-prepend">
												<span class="input-group-text"><i class="ni ni-email-83"></i></span>
											</div>
											<input class="form-control" required placeholder="아이디 입력 (Email)" name="id" type="email" autocomplete="off"
												pattern="^[A-Za-z0-9_\.\-\+]+@[A-Za-z0-9\-]+\.[A-Za-z\.]+$" />
										</div>
									</div>
									<div class="form-group">
										<div class="input-group input-group-alternative">
											<div class="input-group-prepend">
												<span class="input-group-text"><i class="ni ni-lock-circle-open"></i></span>
											</div>
											<input class="form-control" required placeholder="비밀번호 입력" name="password" type="password" minlength="5" autocomplete="off" />
										</div>
									</div>
									<%-- <div class="custom-control custom-control-alternative custom-checkbox">
										<input class="custom-control-input" id=" customCheckLogin" type="checkbox">
										<label class="custom-control-label" for=" customCheckLogin"><span>Remember me</span></label>
									</div> --%>
									<div class="text-center">
										<button type="submit" class="btn btn-primary btn-block my-4">로그인</button>
									</div>

									<div class="vui-pop-login__footer">
										<div class="vui-pop-login__link text-center text-muted">
											<div class="vui-pop-login__link__text">아직 Viewnimal 회원이 아니시라면</div>
											<a data-toggle="modal" data-target="#modal-join" class="btn btn-link text-primary">회원가입하러 가기</a>
										</div>
										<div class="vui-pop-login__link text-center text-muted">
											<div class="vui-pop-login__link__text">비밀번호를 잊어버리셨나요?</div>
											<a data-toggle="modal" data-target="#modal-new-pw" class="btn btn-link text-primary">비밀번호 찾기</a>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%-- //로그인 팝업 --%>

		<%-- 일반 회원가입 팝업 --%>
		<div class="vui-pop vui-pop-join modal fade" id="modal-join" tabindex="-1" role="dialog" aria-labelledby="modal-join" aria-hidden="true">
			<div class="modal-dialog modal- modal-dialog-centered modal-sm" role="document">
				<div class="modal-content">
					<div class="modal-body p-0">
						<div class="card bg-secondary shadow border-0">
							<div class="card-header bg-white">
								<div class="vui-pop__title text-muted text-center">
									<img src="${imgPath}/main_logo.png" alt="" />
									<span class="vui-pop__title__text">회원가입</span>
								</div>
							</div>
							<div class="card-body">
								<form id="joinForm" class="vui-pop-join__form" role="form">
									<div class="vui-pop-join__form__input">
										<div class="vui-pop-join__form__input__item">
											<div class="input-group input-group-alternative">
												<div class="input-group-prepend">
													<span class="input-group-text"><i class="ni ni-email-83"></i></span>
												</div>
												<input class="form-control" required placeholder="아이디 (Email)" type="email" autocomplete="off" name="id"
													pattern="^[A-Za-z0-9_\.\-\+]+@[A-Za-z0-9\-]+\.[A-Za-z\.]+$" />
											</div>
											<div class="vui-pop-join__form__input__message"></div>
										</div>

										<div class="vui-pop-join__form__input__item">
											<div class="input-group input-group-alternative">
												<div class="input-group-prepend">
													<span class="input-group-text"><i class="ni ni-lock-circle-open"></i></span>
												</div>
												<input class="form-control" required placeholder="비밀번호" type="password" minlength="5" autocomplete="off" name="password" />
											</div>
										</div>

										<div class="vui-pop-join__form__input__item">
											<div class="input-group input-group-alternative">
												<div class="input-group-prepend">
													<span class="input-group-text"><i class="ni ni-lock-circle-open"></i></span>
												</div>
												<input class="form-control" required placeholder="비밀번호 확인" type="password" minlength="5" autocomplete="off" />
											</div>
											<div class="vui-pop-join__form__input__message"></div>
										</div>

										<div class="vui-pop-join__form__input__item">
											<div class="input-group input-group-alternative">
												<div class="input-group-prepend">
													<span class="input-group-text"><i class="ni ni-email-83"></i></span>
												</div>
												<input class="form-control" required placeholder="이메일" type="email" autocomplete="off" name="email"
													pattern="^[A-Za-z0-9_\.\-\+]+@[A-Za-z0-9\-]+\.[A-Za-z\.]+$" />
											</div>
										</div>

										<div class="vui-pop-join__form__input__item">
											<div class="input-group input-group-alternative">
												<div class="input-group-prepend">
													<span class="input-group-text"><i class="ni ni-circle-08"></i></span>
												</div>
												<input class="form-control" required placeholder="닉네임" type="text" name="nickname" />
											</div>
											<div class="vui-pop-join__form__input__message"></div>
										</div>

										<div class="vui-pop-join__form__input__item">
											<div class="input-group input-group-alternative">
												<div class="input-group-prepend">
													<span class="input-group-text"><i class="ni ni-mobile-button"></i></span>
												</div>
												<input class="form-control" required placeholder="휴대폰 번호" type="tel" name="phone" 
													pattern="^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$" />
											</div>
											<div class="vui-pop-join__form__input__guide">ex) 010-1234-5678</div>
										</div>
									</div>

									<div class="vui-pop-join__form__term">
										<div class="vui-pop-join__form__term__item vui-pop-join__form__term__item--all">
											<div class="vui-pop-join__form__term__text">
												<strong>전체 이용 약관에 동의합니다.</strong>
											</div>
											<label class="custom-toggle">
												<input type="checkbox" />
												<span class="custom-toggle-slider rounded-circle"></span>
											</label>
										</div>
										<div class="vui-pop-join__form__term__item">
											<div class="vui-pop-join__form__term__text">
												<strong>이용약관</strong>에 동의합니다. (필수)
											</div>
											<label class="custom-toggle">
												<input type="checkbox" required />
												<span class="custom-toggle-slider rounded-circle"></span>
											</label>
										</div>
										<div class="vui-pop-join__form__term__item">
											<div class="vui-pop-join__form__term__text">
												<strong>개인정보취급방침</strong>에 동의합니다. (필수)
											</div>
											<label class="custom-toggle">
												<input type="checkbox" required />
												<span class="custom-toggle-slider rounded-circle"></span>
											</label>
										</div>
										<div class="vui-pop-join__form__term__item">
											<div class="vui-pop-join__form__term__text">마케팅 활용에 동의합니다. (선택)</div>
											<label class="custom-toggle">
												<input type="checkbox" />
												<span class="custom-toggle-slider rounded-circle"></span>
											</label>
										</div>
									</div>
								
									<div class="text-center">
										<button type="submit" class="vui-pop-join__form__submit btn btn-primary btn-block">가입하기</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%-- //일반 회원가입 팝업 --%>

		<%-- 소셜 회원가입 팝업 --%>
		<div class="vui-pop vui-pop-join modal fade" id="modal-social" tabindex="-1" role="dialog" aria-labelledby="modal-social" aria-hidden="true">
			<div class="modal-dialog modal- modal-dialog-centered modal-sm" role="document">
				<div class="modal-content">
					<div class="modal-body p-0">
						<div class="card bg-secondary shadow border-0">
							<div class="card-header bg-white">
								<div class="vui-pop__title text-muted text-center">
									<img src="${imgPath}/main_logo.png" alt="" />
									<span class="vui-pop__title__text">소셜 회원가입</span>
								</div>
							</div>
							<div class="card-body">
								<form id="socialForm" class="vui-pop-join__form" role="form">
									<div class="vui-pop-join__form__input">
										<div class="vui-pop-join__form__input__item">
											<div class="input-group input-group-alternative">
												<div class="input-group-prepend">
													<span class="input-group-text"><i class="ni ni-email-83"></i></span>
												</div>
												<input class="form-control" required placeholder="이메일" type="email" autocomplete="off" name="email"
													pattern="^[A-Za-z0-9_\.\-\+]+@[A-Za-z0-9\-]+\.[A-Za-z\.]+$" />
											</div>
										</div>

										<div class="vui-pop-join__form__input__item">
											<div class="input-group input-group-alternative">
												<div class="input-group-prepend">
													<span class="input-group-text"><i class="ni ni-circle-08"></i></span>
												</div>
												<input class="form-control" required placeholder="닉네임" type="text" name="nickname" />
											</div>
											<div class="vui-pop-join__form__input__message"></div>
										</div>

										<div class="vui-pop-join__form__input__item">
											<div class="input-group input-group-alternative">
												<div class="input-group-prepend">
													<span class="input-group-text"><i class="ni ni-mobile-button"></i></span>
												</div>
												<input class="form-control" required placeholder="휴대폰 번호" type="tel" name="phone"
													pattern="^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$" />
											</div>
											<div class="vui-pop-join__form__input__guide">ex) 010-1234-5678</div>
										</div>
									</div>

									<div class="vui-pop-join__form__term">
										<div class="vui-pop-join__form__term__item vui-pop-join__form__term__item--all">
											<div class="vui-pop-join__form__term__text">
												<strong>전체 이용 약관에 동의합니다.</strong>
											</div>
											<label class="custom-toggle">
												<input type="checkbox" />
												<span class="custom-toggle-slider rounded-circle"></span>
											</label>
										</div>
										<div class="vui-pop-join__form__term__item">
											<div class="vui-pop-join__form__term__text">
												<strong>이용약관</strong>에 동의합니다. (필수)
											</div>
											<label class="custom-toggle">
												<input type="checkbox" required />
												<span class="custom-toggle-slider rounded-circle"></span>
											</label>
										</div>
										<div class="vui-pop-join__form__term__item">
											<div class="vui-pop-join__form__term__text">
												<strong>개인정보취급방침</strong>에 동의합니다. (필수)
											</div>
											<label class="custom-toggle">
												<input type="checkbox" required />
												<span class="custom-toggle-slider rounded-circle"></span>
											</label>
										</div>
										<div class="vui-pop-join__form__term__item">
											<div class="vui-pop-join__form__term__text">마케팅 활용에 동의합니다. (선택)</div>
											<label class="custom-toggle">
												<input type="checkbox" />
												<span class="custom-toggle-slider rounded-circle"></span>
											</label>
										</div>
									</div>
								
									<div class="text-center">
										<button type="submit" class="vui-pop-join__form__submit btn btn-primary btn-block">가입하기</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%-- //소셜 회원가입 팝업 --%>

		<%-- 비밀번호 찾기 팝업 --%>
		<div class="vui-pop vui-pop-new-pw modal fade" id="modal-new-pw" tabindex="-1" role="dialog" aria-labelledby="modal-new-pw" aria-hidden="true">
			<div class="modal-dialog modal- modal-dialog-centered modal-sm" role="document">
				<div class="modal-content">
					<div class="modal-body p-0">
						<div class="card bg-secondary shadow border-0">
							<div class="card-header bg-white">
								<div class="vui-pop__title text-muted text-center">
									<img src="${imgPath}/main_logo.png" alt="" />
									<span class="vui-pop__title__text">새 비밀번호 발급</span>
								</div>
							</div>
							<div class="card-body px-lg-5 py-lg-5">
								<form role="form" id="newPwForm">
									<div class="form-group">
										<div class="input-group input-group-alternative">
											<div class="input-group-prepend">
												<span class="input-group-text"><i class="ni ni-email-83"></i></span>
											</div>
											<input class="form-control" required placeholder="아이디 입력 (Email)" type="email" autocomplete="off" name="id"
												pattern="^[A-Za-z0-9_\.\-\+]+@[A-Za-z0-9\-]+\.[A-Za-z\.]+$" />
										</div>
									</div>

									<div class="form-group">
										<div class="input-group input-group-alternative">
											<div class="input-group-prepend">
												<span class="input-group-text"><i class="ni ni-email-83"></i></span>
											</div>
											<input class="form-control" required placeholder="이메일" type="email" autocomplete="off" name="email"
												pattern="^[A-Za-z0-9_\.\-\+]+@[A-Za-z0-9\-]+\.[A-Za-z\.]+$" />
										</div>
									</div>

									<div class="form-group">
										<div class="input-group input-group-alternative">
											<div class="input-group-prepend">
												<span class="input-group-text"><i class="ni ni-mobile-button"></i></span>
											</div>
											<input class="form-control" required placeholder="휴대폰 번호 입력" type="tel" name="phone"
												pattern="^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$" />
										</div>
										<div class="vui-pop-join__form__input__guide">ex) 010-1234-5678</div>
									</div>

									<div class="vui-pop-new-pw__message">
										회원님의 <strong>아이디(Email)</strong>와 <strong>이메일</strong> 및<br />
										<strong>휴대폰 번호</strong>를 입력해주세요.<br />
										등록하신 <strong style="text-decoration: underline;">이메일</strong>로 새 비밀번호를 전송해드립니다.
									</div>

									<div class="text-center">
										<button type="submit" class="btn btn-primary btn-block my-4">새 비밀번호 발급받기</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%-- //로그인 팝업 --%>

	</c:when>
</c:choose>