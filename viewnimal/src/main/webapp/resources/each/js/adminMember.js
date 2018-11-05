(function ($) {
	"use strcit";

	var $content 		= $('.vm-adminMember');
	var $updateUserBtn 	= $('#updateUserBtn');
	var $table 			= $content.find('table');
	var $tbody 			= $table.find('tbody');

	// ----------------------------------------------------------- [실행]
	bindShowOriginal();
	bindUpdateSubmit();

	// ----------------------------------------------------------- [선언]
	// 값이 변경되었을 때 원본 값을 표시해줌
	function bindShowOriginal() {
		$tbody.find('[name="email"], [name="phone"]').on('keyup', function (e) {
			checkChangeValue(this);
		});
		$tbody.find('[name="state"]').on('change', function (e) {
			checkChangeValue(this);
		});

		function checkChangeValue( that ) {
			var $that 			= $(that);
			var $tr 			= $that.parents('tr');
			var $td 			= $that.parents('td');
			var $originalValBox = $td.find('.vm-adminMember__original-value');
			var currentVal 		= $that.val();
			var originalVal 	= $that.data('original');
			var isChangeEl 		= false;
			
			if ( currentVal !== originalVal ) {
				$td.css('background-color', '#26b99a');
				$originalValBox.html(originalVal);
				$that.data('isChange', true);
			}
			else {
				$td.css('background-color', '');
				$originalValBox.html('');
				$that.data('isChange', false);
			}

			$tr.find('[name="email"], [name="phone"], [name="state"]').each(function (index, el) {
				var isChange = $(el).data('isChange');

				isChangeEl |= (isChange === undefined ? false : isChange);
			});

			Boolean(isChangeEl) ? $tr.addClass( 'on-change-el' ) : $tr.removeClass( 'on-change-el' ) ;
		}
	}

	// 회원정보 업데이트 ajax
	function bindUpdateSubmit() {
		$updateUserBtn.on('click', function (e) {
			e.preventDefault();

			var $checkedTr = $tbody.find('.on-change-el');
			var length 		= $checkedTr.length;

			if ( length < 1 ) {
				alert('수정한 정보가 없습니다.');
				return;
			}
			if ( ! confirm(length + ' 개의 정보를 수정하시겠습니까?') ) { return; }

			var dataArr = [];

			$checkedTr.each(function (index, el) {
				var $tr = $(el);
				var data = {
					  id 	: $tr.find('[name="id"]').val()
					, email : $tr.find('[name="email"]').val().trim()
					, phone : $tr.find('[name="phone"]').val().replace(/[- ]/gim, '')
					, state : $tr.find('[name="state"]').val()
				};

				dataArr.push( data );
			});

			$.ajax({
				  url 		: '/member/updateList'
				, type 		: 'post'
				, dataType 	: 'json'
				, data 		: {
					memberList : JSON.stringify(dataArr)
				}
				, success 	: function ( data, status, xhr ) {
					if ( data.result > 0 ) {
						alert('회원정보 업데이트 성공 !');
						location.reload();
					}
					else { alert('문제가 발생했습니다.\n다시 시도해주세요.'); }
				}
				, error 	: function ( xhr, status, error ) {
					alert('문제가 발생했습니다.\n다시 시도해주세요.');
				}
				, complete 	: function ( xhr, status ) {}
			});
		});
	}
}(jQuery));