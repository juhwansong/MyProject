(function ($) {
	"use strcit";

	// var $myForm = $('#myForm');

	// ----------------------------------------------------------- [실행]
	bindNewPasswordBtn();
	formValidate();
	formMyProfile();

	// ----------------------------------------------------------- [선언]
	// [비밀번호 변경 필드 show/hide]
	function bindNewPasswordBtn() {
		var $checkbox 		= $('.vm-myProfile__form__check').find('[type="checkbox"]');
		var $newPwBox 		= $('.vm-myProfile__form__input__item--new-password');
		var $newPwInputs 	= $newPwBox.find('[type="password"]');

		// init
		$checkbox.prop('checked', false);
		boxHide();

		$checkbox.on('change', function (e) {
			if ( $checkbox.prop('checked') ) 	{ boxShow(); }
			else 								{ boxHide(); }
		});

		function boxShow() {
			$newPwBox.show(0);
			$newPwInputs.attr('required', 'required');
		}
		function boxHide() {
			$newPwBox.hide(0);
			$newPwInputs.removeAttr('required');
			$newPwInputs.val('');
		}
	}

	// [유효성]
	function formValidate() {
		var $myForm 	= $('#myForm');

		validatePassword();
		validateNick();

		function validatePassword() {
			var $passwords 	= $myForm.find('[type="password"]');
			var $pass1 		= $passwords.eq(1);
			var $pass2 		= $passwords.eq(2);
			var $message 	= $pass2.parents('.vm-myProfile__form__input__item').find('.vm-myProfile__form__input__message');

			$passwords.on('blur', function () {
				var ifStatement = $pass2.val() !== '' && $pass1.val() !== $pass2.val();

				if ( ifStatement ) 	{ $message.addClass('on').html('새 비밀번호가 일치하지 않습니다.'); }
				else 				{ $message.removeClass('on'); }
			});
		}

		function validateNick() {
			var $nickInput 	= $myForm.find('[name="nickname"]');
			var $message 	= $nickInput.parents('.vm-myProfile__form__input__item').find('.vm-myProfile__form__input__message');
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
		}
	}

	// [회원정보 업데이트]
	function formMyProfile() {
		var $myForm 	= $('#myForm');

		$myForm.on('submit', function (e) {
			e.preventDefault();
			$myForm.formSubmit(false);

			var serialObj = $myForm.serializeObject();

			// 휴대폰 번호 Dashed(-) 및 공백 제거
			serialObj.phone = serialObj.phone.replace(/[- ]/gim, '');

			App.loading.show();

			$.ajax({
				  url 		: '/member/update'
				, type 		: 'post'
				, dataType 	: 'json'
				, data 		: $.param( serialObj )
				, success 	: function ( data, status, xhr ) {
					var ifStatement = data.result === 1;

					if ( ifStatement ) {
						alert('회원정보가 업데이트되었습니다.');
						location.reload();
					}
					else {
						alert('문제가 발생했습니다.\n다시 시도해주세요.');
					}
				}
				, error 	: function ( xhr, status, error ) {
					alert('문제가 발생했습니다.\n다시 시도해주세요.');
				}
				, complete 	: function ( xhr, status ) {
					$myForm.formSubmit(true);
					App.loading.hide();
				}
			});
		});
	}
}(jQuery));