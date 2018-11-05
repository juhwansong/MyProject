var App = (function ($) {
	"use strict";

	var $window 	= $(window);
	var $document 	= $(document);
	var $view 		= $('html, body');
	var $html 		= $('html');
	var $body 		= $('body');
	var $loadingWin = $('.vui-loading-window');

	return {
		// ---------------------------------------------------- [Common Init]
		init : function () {
			// underscore 세팅 ex) % -> @
			_.templateSettings = {
				interpolate: /\<\@\=(.+?)\@\>/gim,
				evaluate: /\<\@(.+?)\@\>/gim,
				escape: /\<\@\-(.+?)\@\>/gim
			};

			/**
			 * form 파라미터 값을 key : value 형태의 객체로 변환
			 * ex) { name : 'foo' }
			 * ajax 에 태우기 전에 값을 가공할 수 있다
			 */
			$.fn.serializeObject = function() {
				var that 	= this;
				var obj 	= {};

				try {
					if ( that[0].tagName && that[0].tagName.toLowerCase() === "form" ) {
						var arr = that.serializeArray();

						if (arr) {
							$.each(arr, function( index, item, arr ) {
								obj[item.name] = item.value;
							});
						}
					}
				}
				catch (e) { console.error( e.message ); }
				
				return obj;
			}

			// 중복 submit 방지를 위한 메서드
			$.fn.formSubmit = function ( able ) {
				if ( able ) { $(this).find(':submit').removeAttr('disabled'); }
				else 		{ $(this).find(':submit').attr('disabled', 'disabled'); }
			}

			$window.on('load', 		function () { $html.addClass('on-load'); });
			$document.on('ready', 	function () { $html.addClass('on-ready'); });
		}
		// ---------------------------------------------------- [Client Init]
		, clientInit : function () {
			App.bindUiMyMenu();
			App.bindUiSeach();
			App.bindUiModal();
			App.formLogin();
			App.formJoinValidate();
			App.formJoin();
			App.formNewPw();
			App.formGoogle();
			App.messagePop.init();
		}
		// ---------------------------------------------------- [Admin Init]
		, adminInit : function () {
			App.bindUiAdminMyMenu();
		}
		// ---------------------------------------------------- [Method]
		// [관리자 마이 메뉴 이벤트]
		, bindUiAdminMyMenu : function () {
			var $logoutBtn 		= $('#removeSession');

			$logoutBtn.on('click', function (e) {
				e.preventDefault();

				if ( confirm('로그아웃하시겠습니까?') ) {
					$.ajax({
						  url 		: '/common/removeSession'
						, type 		: 'get'
						, data 		: null
						, dataType 	: 'json'
						, success 	: function ( data, status, xhr ) {}
						, error 	: function ( xhr, status, error ) {}
						, complete 	: function () {
							location.reload();
						}
					});
				}
			});
		}
		// [메시지 팝업 이벤트]
		, messagePop : (function () {
			var checkSetTimeout;
			var $messagePop;
			var $messageBox;
			
			return {
				init : function () {
					$messagePop = $('.vui-message-pop');
					$messageBox = $messagePop.find('.vui-message-pop__text');
				}
				, show : function ( message, opt ) {
					opt = $.extend(true, {}, opt);

					var message 	= message;
					var callback 	= opt.callback !== undefined ? opt.callback : function (e) { $messagePop.removeClass('on'); };
					var duration 	= opt.duration !== undefined ? opt.duration : 2500;

					$messageBox.html(message);
					$messagePop.addClass('on');

					$messagePop.off('click').on('click', callback);

					clearTimeout(checkSetTimeout);
					checkSetTimeout = setTimeout(function () {
						$messagePop.removeClass('on');
					}, duration);
				}
				, hide : function () {
					$messagePop.removeClass('on');
				}
			};
		}())
		// [로딩 이벤트]
		, loading : {
			show : function ( callback ) {
				$loadingWin.addClass('on').show( 0, callback );
			}
			, hide : function ( callback ) {
				$loadingWin.removeClass('on').hide( 0, callback );
			}
		}
		// [my 메뉴 이벤트]
		, bindUiMyMenu : function () {
			var $myMenuShowBtn 	= $('.vm-header__my-menu');
			var $myMenuBox 		= $('.vui-my-menu');
			var $logoutBtn 		= $('#removeSession');

			// 메뉴 나타냄
			$myMenuShowBtn.on('click', function (e) {
				$myMenuBox.addClass('on');
			});

			// 메뉴 숨김
			$(document).on('click', function (e) {
				var $target 		= $(e.target);
				var $rootParent1 	= $target.parents('.vm-header__my-menu');
				var $rootParent2 	= $target.parents('.vui-my-menu');
				var ifStatement1 	= $target[0] === $myMenuShowBtn[0] || $rootParent1[0] === $myMenuShowBtn[0];
				var ifStatement2 	= $target[0] === $myMenuBox[0] || $rootParent2[0] === $myMenuBox[0];

				if ( ! (ifStatement1 || ifStatement2) ) {
					$myMenuBox.removeClass('on');
				}
			});

			$logoutBtn.on('click', function (e) {
				e.preventDefault();

				if ( confirm('로그아웃하시겠습니까?') ) {
					$.ajax({
						  url 		: '/common/removeSession'
						, type 		: 'get'
						, data 		: ''
						, dataType 	: 'json'
						, success 	: function ( data, status, xhr ) {}
						, error 	: function ( xhr, status, error ) {}
						, complete 	: function () {
							location.reload();
						}
					});
				}
			});
		}
		// [검색 입력 상자 이벤트]
		, bindUiSeach : function () {
			var $searchShowBtn 	= $('.vm-header__search');
			var $searchBox 		= $('.vui-search');
			var $searchList 	= $(".vui-search__list");
			var $searchForm 	= $('#searchAllForm');
			var $searchInput 	= $searchForm.find('[name="keyword"]');
			var tabIndex 		= -1;

			// 특수문자 -> {}[]/?.,;:|)*~`!^-_+<>@#$%&\=('"
			// 패턴에 반드시 특수문자를 []로 감싸줘야 문자 하나하나를 비교
			// 정규식 객체는 패턴 뒤에 Global 옵션을 넣지 않음 (이슈있음)
			// var regExp = /[\{\}\[\]\/\?\.\,\;\:\|\)\*\~\`\!\^\-\_\+\<\>\@\#\$\%\&\\\=\(\'\"]/;

			// ----------------------------------------------------------- [실행]
			// 통합검색 페이지에서 뒤로가기로 넘어온 경우를 대비
			$searchInput.val('');

			// css set
			$searchBox.css({ top : $('.vm-header__head').outerHeight() + 'px' });

			// 검색 박스 나타내기
			$searchShowBtn.on('click', function () {
				$html.addClass('on-search-mode');
				$searchInput.focus();
			});

			// 검색 필드 이벤트
			$searchForm.on('submit', function (e) {
				e.preventDefault();

				var value = $searchInput.val().trim();

				if ( value === '' ) {
					alert('검색어를 입력해주세요.');
					return;
				}

				linkSearchAll( $searchInput.val() );
			});

			// 자동완성 리스트 클릭 이벤트
			$searchList.on('click', '.vui-search__item', function (e) {
				e.preventDefault();
				linkSearchAll( $(this).text() );
			});

			bindInputKey();
			hideSearchBox();

			// ----------------------------------------------------------- [선언]
			// 통합검색 결과 페이지로 이동
			function linkSearchAll( keyword ) {
				location.href = '/SearchAll?keyword=' + encodeURIComponent( keyword );
			}

			// 검색박스 key 이벤트
			function bindInputKey() {
				var beforeVal = '';

				// keyup : 검색 담당
				$searchInput.on('keyup', function(e){
					// enter key 경우 submit 이벤트에서 발생하니 여기선 막아버림
					if ( e.keyCode === 13 ) { return; }

					var listLength 	= $searchList[0].children.length;
					var currentVal 	= $searchInput.val().trim();

					// 변경된 값일 경우
					if ( beforeVal !== currentVal ) {
						// 리스트가 없거나, 그렇지 않을 경우 필터 키를 누르지 않아야 함
						if ( listLength === 0 || ! isPressFilterKey(e) ) {
							beforeVal = currentVal;

							$.ajax({
								  url 		: '/autoComplete'
								, type 		: 'post'
								, dataType 	: 'json'
								, data 		: {'keword' : currentVal}
								// , async		: true
								, success 	: function ( data, status, xhr ) {
									tabIndex = -1;
									$searchList.empty(); //자동완성목록 초기화

									// 입력한 키워드와 일치하는 목록이 있으면
									if(data.autoKewordList !== undefined) {
										var autoCompleteList = $("#auto-complete-list").html();
										var autoCompleteListData = _.template(autoCompleteList, {variable : 'data'});
										var keywordLength = data.autoKewordList.length;

										for(var i=0; i < keywordLength; i++){
											data.autoKewordList[i] = Hangul.assemble(data.autoKewordList[i]); //hangle.js 정의된 코드를 이용하여 초성중성종성으로 나눠진 한글 합치기
											$searchList.append(autoCompleteListData(data.autoKewordList[i]));
										}

										$searchList.css('height', (30 * keywordLength) + 'px');
									}
									else {
										$searchList.css('height', 0);
									}
								}
								, error 	: function ( xhr, status, error ) {}
							});
						}
					}
				});

				// keydown : 접근성 담당
				$searchInput.on('keydown', function (e) {
					var listLength 	= $searchList[0].children.length;

					// 필터 키 누름
					if ( isPressFilterKey(e) ) {
						e.preventDefault();

						if ( listLength > 0 ) {
							let keyCode = e.keyCode;

							// 위로 이동
							if ( (keyCode === 38 || keyCode === 9 && e.shiftKey) && tabIndex > -1 ) {
								tabIndex -= 1;

								let $item = $('.vui-search__item');

								$item.removeClass('on');

								if ( tabIndex > -1 ) {
									$item.eq(tabIndex).addClass('on');
									$searchInput.val( $item.eq(tabIndex).text().trim() );
								}
							}
							// 아래로 이동
							else if ( (keyCode === 40 || keyCode === 9) && tabIndex < listLength - 1 ) {
								tabIndex += 1;

								let $item = $('.vui-search__item');

								$item.removeClass('on');
								$item.eq(tabIndex).addClass('on');
								
								$searchInput.val( $item.eq(tabIndex).text().trim() );
							}
						}
					}
				});

				// 필터 키 press 체크
				function isPressFilterKey( e ) {
					var keyCode 	= e.keyCode;
					var shiftKey 	= e.shiftKey;

					// 언탭 | 탭 | shift | 위 | 아래 키 누름 여부
					return (keyCode === 9 && shiftKey) || keyCode === 9 || keyCode === 16 || keyCode === 38 || keyCode === 40;
				}
			}

			// 검색박스 숨김
			function hideSearchBox() {
				$('.vui-dim').on('click', function (e) {
					$html.removeClass('on-search-mode');
					$searchList.css('height', 0);
					$searchInput.val('');
					$searchList.empty(); //자동완성 목록 사라지게
					tabIndex = -1;
				});
			}

		}
		// [modal 공통 이벤트]
		, bindUiModal : function () {
			var $pop = $('.vui-pop');

			if ( $pop.length < 1 ) { return; }

			$pop.on('show.bs.modal', function (e) {
				var $target = $(e.target);
			
				$target.css('padding-right', '15px');
			});

			$pop.on('hidden.bs.modal', function (e) {
				var $target = $(e.target);

				// 닫을 때 입력필드 초기화
				$target.find('input').val('');
				$target.find('input[type="checkbox"]').prop('checked', false);

				if ( $('.vui-pop.show').length > 0 ) {
					$body.addClass('modal-open');
					
					// 스크롤이 있는 페이지의 경우
					if ( document.documentElement.scrollHeight !== window.innerHeight ) {
						$body.css('padding-right', '15px')
					}
				}
			});
		}
		// [로그인]
		, formLogin : function () {
			var $loginForm = $('#loginForm');

			if ( $loginForm.length < 1 ) { return; }

			$loginForm.on('submit', function (e) {
				e.preventDefault();
				$loginForm.formSubmit(false);
				App.loading.show();

				$.ajax({
					  url 		: '/member/login'
					, type 		: 'post'
					, dataType 	: 'json'
					, data 		: $loginForm.serialize()
					, success 	: function ( data, status, xhr ) {
						var ifStatement = data.loginMemberDto !== undefined;

						if ( ifStatement ) {
							if ( data.loginMemberDto.type === 'ADMIN' && confirm('관리자 계정입니다.\n관리자 페이지로 이동하시겠습니까?') ) {
								location.href = '/AdminMain';
								return;
							}

							location.reload();
						}
						else { alert('일치하는 정보가 없습니다.\n다시 시도해주세요.'); }
					}
					, error 	: function ( xhr, status, error ) {
						alert('문제가 발생했습니다.\n다시 시도해주세요.');
					}
					, complete 	: function ( xhr, status ) {
						$loginForm.formSubmit(true);
						App.loading.hide();
					}
				});
			});

			// 테스트용
			/*var tempUserLogin = document.getElementById('tempUserLogin');
			var tempUserAdminLogin = document.getElementById('tempUserAdminLogin');
			var loginForm = document.querySelector('#loginForm');
			var inputId = loginForm.querySelector('[name="id"]');
			var inputPw = loginForm.querySelector('[name="password"]');

			tempUserLogin.addEventListener('click', function (e) {
				inputId.value = 'user1@gmail.com';
				inputPw.value = '@viewnimal';
				$loginForm.trigger('submit');
			}, false);
			tempUserAdminLogin.addEventListener('click', function (e) {
				inputId.value = 'admin1@viewnimal.com';
				inputPw.value = '@viewnimal';
				$loginForm.trigger('submit');
			}, false);*/

		}
		// [회원가입 유효성]
		, formJoinValidate : function () {
			var $joinPop 	= $('.vui-pop-join'); 	// 일반 및 소셜 전체
			var $joinForm 	= $('#joinForm'); 		// 일반

			if ( $joinPop.length < 1 ) { return; }

			validateId();
			validatePassword();
			validateNick();
			bindCheckbox();

			function validateId() {
				var checkSetTimeout;
				var $idInput 	= $joinForm.find('[name="id"]');
				var $emailInput = $joinForm.find('[name="email"]');
				var $message 	= $idInput.parents('.vui-pop-join__form__input__item').find('.vui-pop-join__form__input__message');

				$idInput.on('keyup', function (e) {
					$emailInput.val( $idInput.val() );

					clearTimeout(checkSetTimeout);
					checkSetTimeout = setTimeout(function () {
						$.ajax({
							  url 		: '/member/checkId'
							, type 		: 'post'
							, dataType 	: 'json'
							, data 		: { id : $idInput.val() }
							, success 	: function ( data, status, xhr ) {
								if ( data.result === 1 ) 	{ $message.addClass('on').html('가입된 아이디입니다.'); }
								else 						{ $message.removeClass('on'); }
							}
							, error 	: function ( xhr, status, error ) {
								$message.removeClass('on');
							}
						});
					}, 1000);
				});
			}

			function validatePassword() {
				var $passwords 	= $joinForm.find('[type="password"]');
				var $pass1 		= $passwords.eq(0);
				var $pass2 		= $passwords.eq(1);
				var $message 	= $pass2.parents('.vui-pop-join__form__input__item').find('.vui-pop-join__form__input__message');

				$passwords.on('blur', function () {
					var ifStatement = $pass2.val() !== '' && $pass1.val() !== $pass2.val();

					if ( ifStatement ) 	{ $message.addClass('on').html('비밀번호가 일치하지 않습니다.'); }
					else 				{ $message.removeClass('on'); }
				});
			}

			function validateNick() {
				$joinPop.each(function ( index, item, arr ) {
					var $pop 		= $(item);
					var $nickInput 	= $pop.find('[name="nickname"]');
					var $message 	= $nickInput.parents('.vui-pop-join__form__input__item').find('.vui-pop-join__form__input__message');
					var checkSetTimeout;

					$nickInput.on('keyup', function (e) {
						clearTimeout(checkSetTimeout);

						checkSetTimeout = setTimeout(function () {
							$.ajax({
								  url 		: '/member/checkNickname'
								, type 		: 'post'
								, dataType 	: 'json'
								, data 		: { nickname : $nickInput.val() }
								, success 	: function ( data, status, xhr ) {
									if ( data.result === 1 ) 	{ $message.addClass('on').html('등록된 닉네임입니다.'); }
									else 						{ $message.removeClass('on'); }
								}
								, error 	: function ( xhr, status, error ) {
									$message.removeClass('on');
								}
							});
						}, 1000);
					});
				});
			}

			function bindCheckbox() {
				$joinPop.each(function ( index, item, arr ) {
					var $pop 		= $(item);
					var $checks 	= $pop.find('[type="checkbox"]');
					var $allBtn 	= $checks.eq(0);
					var $btns 		= $checks.slice(1);
					var btnLength 	= $btns.length;

					$allBtn.on('change', function (e) {
						$btns.prop('checked', $allBtn.prop('checked'));
					});

					$btns.on('change', function (e) {
						var count = 0;

						$btns.each(function ( index, item ) {
							if ( item.checked === true ) { count += 1; }
						});

						if ( count === btnLength ) 	{ $allBtn.prop('checked', true); }
						else 						{ $allBtn.prop('checked', false); }
					});
				});
			}
		}
		// [일반 회원가입]
		, formJoin : function () {
			var $joinForm = $('#joinForm');

			$joinForm.on('submit', function (e) {
				e.preventDefault();
				$joinForm.formSubmit(false);

				var serialObj = $joinForm.serializeObject();

				// 휴대폰 번호 Dashed(-) 및 공백 제거
				serialObj.phone = serialObj.phone.replace(/[- ]/gim, '');

				App.loading.show();

				$.ajax({
					  url 		: '/member/join'
					, type 		: 'post'
					, dataType 	: 'json'
					, data 		: $.param( serialObj )
					, success 	: function ( data, status, xhr ) {
						var ifStatement = data.result === 1;

						if ( ifStatement ) {
							if ( confirm('회원가입되었습니다.\n가입된 아이디로 바로 로그인하시겠습니까?') ) {
								let $loginForm = $('#loginForm');

								$loginForm.find('[name="id"]').val( $joinForm.find('[name="id"]').val() );
								$loginForm.find('[name="password"]').val( $joinForm.find('[name="password"]').val() );
								$loginForm.trigger('submit');
							}
							else { $('#modal-join').modal('hide'); }
						}
						else { alert('문제가 발생했습니다.\n다시 시도해주세요.'); }
					}
					, error 	: function ( xhr, status, error ) {
						alert('문제가 발생했습니다.\n다시 시도해주세요.');
					}
					, complete 	: function ( xhr, status ) {
						$joinForm.formSubmit(true);
						App.loading.hide();
					} 
				});
			});
		}
		// [새 비밀번호 발급]
		, formNewPw : function () {
			var $newPwForm 			= $('#newPwForm');
			var $idInput 			= $newPwForm.find('[name="id"]');
			var $emailInput 		= $newPwForm.find('[name="email"]');

			// 아이디 입력 시 이메일 입력란에도 입력
			$idInput.on('keyup', function (e) { $emailInput.val( $idInput.val() ); });

			// 새 비밀번호 발급 요청
			$newPwForm.on('submit', function (e) {
				e.preventDefault();
				$newPwForm.formSubmit(false);

				var serialObj = $newPwForm.serializeObject();

				// 휴대폰 번호 Dashed(-) 및 공백 제거
				serialObj.phone = serialObj.phone.replace(/[- ]/gim, '');

				App.loading.show();

				$.ajax({
					  url 		: '/member/sendMailInitPw'
					, type 		: 'post'
					, dataType 	: 'json'
					, data 		: $.param( serialObj )
					, success 	: function ( data, status, xhr ) {
						var ifStatement = data.result !== null && data.isSend;

						if ( ifStatement ) {
							// 사용자 메일 정보에 따라 링크 이동 (없으면 말고)
							let backEmailAddr 		= $emailInput.val().split("@")[1];
							let isEmailInService 	= false;
							let serviceList 		= emailServiceList();

							loop : for ( let i = 0, ilen = serviceList.length; i < ilen; i += 1 ) {
								let emailObj = serviceList[i];

								for ( let k = 0, klen = emailObj.type.length; k < klen; k += 1 ) {
									let type = emailObj.type[k];

									if ( backEmailAddr.indexOf( type ) > -1 ) {
										if ( confirm( '새 비밀번호가 메일로 전송되었습니다.\n' + emailObj.company + ' 메일로 이동하시겠습니까?' ) ) {
											location.href = emailObj.url;
										}

										isEmailInService = true;

										break loop;
									}
								}
							}

							// 이메일 서비스에 해당하는 메일 주소가 아닐 때는 alert 만 띄움
							if ( ! isEmailInService ) { alert('새 비밀번호가 메일로 전송되었습니다.'); }

							// 메일 전송이 된 것이니 팝업창 닫아주자
							$('#modal-new-pw').modal('hide');
						}
						else { alert('일치하는 정보가 없습니다.\n다시 시도해주세요.'); }
					}
					, error 	: function ( xhr, status, error ) {
						alert('문제가 발생했습니다.\n다시 시도해주세요.');
					}
					, complete 	: function ( xhr, status ) {
						$newPwForm.formSubmit(true);
						App.loading.hide();
					}
				});
			});

			// 이메일 바로가기 서비스를 위한 배열을 리턴하는 함수
			function emailServiceList() {
				return [
					{
						  company 	: 'Google'
						, type 		: [ 'gmail' ]
						, url 		: 'http://mail.google.com'
					}
					, {
						  company 	: 'Naver'
						, type 		: [ 'naver' ]
						, url 		: 'http://mail.naver.com'
					}
					, {
						  company 	: 'Daum'
						, type 		: [ 'daum', 'hanmail' ]
						, url 		: 'http://mail.daum.net'
					}
					, {
						  company 	: 'Nate'
						, type 		: [ 'nate' ]
						, url 		: 'http://mail3.nate.com'
					}
					, {
						  company 	: 'Yahoo'
						, type 		: [ 'yahoo' ]
						, url 		: 'http://mail.yahoo.com'
					}
				];
			}
		}
		// [구글 로그인/회원가입]
		, formGoogle : function () {
			var gauth;

			formSocial();

			// Auth 생성 (init)
			gapi.load('auth2', function () {
				gauth = gapi.auth2.init({
					client_id : '510108413607-ev15i1rn6m6ealfk47md53qfavi5aiif.apps.googleusercontent.com'
				});

				// auth 생성 후 버튼에 이벤트 바인딩
				gauth.then(
					function () {
						console.log('googleAuth success');
						console.log( '현재 연결 상태 : ' + gauth.isSignedIn.get() );
						// 연결 여부와 상관없이 끊어버림
						gauth.signOut().then(function () {
							console.log('연결 끊었다');
						});

						bindGoogleBtn( gauth );
					}
					, function () { console.log('googleAuth fail'); }
				);
			});

			// 버튼 이벤트
			function bindGoogleBtn( gauth ) {
				$('#googleLoginBtn').on('click', function () {
					console.log( '현재 연결 상태 : ' + gauth.isSignedIn.get() );
					// 무조건 연결을 끊고 다시 연결 시도
					gauth.signOut().then(function () {
						console.log('연결 끊었다');
						gauth.signIn().then(
							function () {
								console.log('연결했다');
								checkIsMember();
							}
							, function () {
								console.log('연결 실패했다');
								alert('구글 계정에 접근할 수 없습니다.\n팝업이 차단되어 있다면 해제해주세요.');
							}
						);
					});
				});
			}

			// 가입여부 체크
			function checkIsMember() {
				var $formSocial = $('#modal-social');
				var profile 	= gauth.currentUser.get().getBasicProfile();

				App.loading.show();

				$.ajax({
					  url 		: '/member/checkId'
					, type 		: 'post'
					, dataType 	: 'json'
					, data 		: { id : profile.getId() }
					, success 	: function ( data, status, xhr ) {
						// 가입된 상태
						if ( data.result === 1 ) { loginGoogle( profile ); }
						// 미가입
						else {
							alert('미가입 회원입니다.\n추가 정보를 입력해주세요.');
							$formSocial.find('[name="email"]').val( profile.getEmail() );
							$formSocial.modal('show');
						}
					}
					, error 	: function ( xhr, status, error ) {
						alert('문제가 발생했습니다.\n다시 시도해주세요.');
						gauth.signOut();
					}
					, complete 	: function ( xhr, status ) {
						App.loading.hide();
					}
				});
			}

			// 구글 소셜 로그인
			function loginGoogle( profile ) {
				App.loading.show();

				$.ajax({
					  url 		: '/member/login'
					, type 		: 'post'
					, dataType 	: 'json'
					, data 		: {
						  id 		: profile.getId()
						, id_type 	: 'GOOGLE'
					}
					, success 	: function ( data, status, xhr ) {
						// auth 로그아웃 후 reload
						if ( data.loginMemberDto !== undefined ) {
							gauth.signOut();
							location.reload();
						}
						else { alert('문제가 발생했습니다.\n다시 시도해주세요.'); }
					}
					, error 	: function ( xhr, status, error ) {
						alert('문제가 발생했습니다.\n다시 시도해주세요.');
					}
					, complete 	: function ( xhr, status ) {
						App.loading.hide();
					}
				});
			}

			// 구글 소셜 회원가입
			function formSocial() {
				var $socialForm = $('#socialForm');

				$socialForm.on('submit', function (e) {
					e.preventDefault();
					$socialForm.formSubmit(false);

					var profile 	= gauth.currentUser.get().getBasicProfile();
					var serialObj 	= $socialForm.serializeObject();

					// 휴대폰 번호 Dashed(-) 및 공백 제거
					serialObj.phone = serialObj.phone.replace(/[- ]/gim, '');

					// 소셜 정보 추가
					serialObj.id = profile.getId();
					serialObj.id_type = 'GOOGLE';

					App.loading.show();

					$.ajax({
						  url 		: '/member/join'
						, type 		: 'post'
						, dataType 	: 'json'
						, data 		: $.param( serialObj )
						, success 	: function ( data, status, xhr ) {
							var ifStatement = data.result === 1;

							// 가입 성공
							if ( ifStatement ) {
								if ( confirm('회원가입되었습니다.\n가입된 아이디로 바로 로그인하시겠습니까?') ) {
									loginGoogle( profile );
								}
								else {
									$('#modal-social').modal('hide');
									gauth.signOut();
								}
							}
							// 가입 실패
							else { alert('문제가 발생했습니다.\n다시 시도해주세요.'); }
						}
						, error 	: function ( xhr, status, error ) {
							alert('문제가 발생했습니다.\n다시 시도해주세요.');
						}
						, complete 	: function ( xhr, status ) {
							$socialForm.formSubmit(true);
							App.loading.hide();
						}
					});
				});
			}
		}
	};
}(jQuery));