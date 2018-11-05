(function ($) {
	"use strcit";

	var $content 			= $('.vm-adminDonationList');
	var $addInsertRowBtn 	= $('#addInsertRowBtn');
	var $insertDonateBtn 	= $('#insertDonateBtn');
	var $updateDonateBtn 	= $('#updateDonateBtn');
	var $deleteDonateBtn 	= $('#deleteDonateBtn');

	var $insertTableForm 	= $content.find('.vm-adminDonationList__insert-form');
	var $insertTbody 		= $insertTableForm.find('tbody');
	var doanteRowTemplate 	= _.template( $("#doanteRowTemplate").html(), { variable: 'data' } );

	var $infoTableBox 		= $content.find('.vm-adminDonationList__info-table');
	var $infoTbody 			= $infoTableBox.find('tbody');

	// ----------------------------------------------------------- [실행]
	daterangepicker();
	bindShowOriginal();
	bindDeleteBtn();
	bindAddInsertRow();
	bindRemoveInsertRow();
	bindInsertSubmit();
	bindUpdateSubmit();
	bindDeleteSubmit();
	
	// ----------------------------------------------------------- [선언]
	// 달력 ui
	function daterangepicker( inputNode ) {
		var $inputNode;

		if ( inputNode === undefined ) 	{ $inputNode = $('.single_cal2'); }
		else 							{ $inputNode = $(inputNode); }

		$inputNode.daterangepicker({
			  singleDatePicker 	: true
			, singleClasses 	: "picker_2"
			, locale 			: { format: 'YYYY-MM-DD' }
		}, function(start, end, label) {
			// console.log(start.toISOString(), end.toISOString(), label);
		});
	}

	// 값이 변경되었을 때 원본 값을 표시해줌
	function bindShowOriginal() {
		var selector = '[name="account_no"], [name="account_host"], [name="bank"], [name="donation"], [name="donate_date"], [name="supporter_id"]';

		$infoTbody.find(selector).on('keyup', function (e) {
			checkChangeValue(this);
		});
		$infoTbody.find('[name="donate_date"]').on('change', function (e) {
			checkChangeValue(this);
		});

		function checkChangeValue( that ) {
			var $that 			= $(that);
			var $tr 			= $that.parents('tr');
			var $td 			= $that.parents('td');
			var $originalValBox = $td.find('.vm-adminDonationList__original-value');
			var currentVal 		= $that.val();
			var originalVal 	= $that.data('original');
			var isChangeEl 		= false;

			if ( typeof originalVal === 'number' ) { originalVal = String(originalVal); }
			
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

			$tr.find('[name]').each(function (index, el) {
				var isChange = $(el).data('isChange');

				isChangeEl |= (isChange === undefined ? false : isChange);
			});

			Boolean(isChangeEl) ? $tr.addClass( 'on-change-el' ) : $tr.removeClass( 'on-change-el' ) ;
		}
	}

	// delete 버튼 이벤트
	function bindDeleteBtn() {
		// 버튼이 아닌 td 눌렀을 때 
		$infoTbody.find('tr td:last-child').on('click', function (e) {
			e.target === this && $(this).find('.js-switch').trigger('click');
		});

		// 값이 변경될 때 tr 클래스 처리
		$infoTbody.find('.js-switch').on('change', function () {
			var $this 	= $(this);
			var $tr 	= $this.parents('tr');

			$this.prop('checked') ? $tr.addClass('on-delete-el') : $tr.removeClass('on-delete-el');
		});
	}

	// insert row 추가
	function bindAddInsertRow() {
		$addInsertRowBtn.on('click', function (e) {
			$insertTableForm.show(0);

			if ( $insertTbody.find('tr').length < 10 ) {
				$insertTbody.append( doanteRowTemplate() );
				daterangepicker( $insertTbody.find('tr:last-child .single_cal2')[0] );
			}
			else { alert('한 번에 최대 10개 추가 가능합니다.'); }
		});
	}

	// insert row 삭제
	function bindRemoveInsertRow() {
		$insertTbody.on('click', '.vm-adminDonationList__delete-btn', function (e) {
			e.preventDefault();
			$(this).parents('tr').remove();

			if ( $insertTbody.find('tr').length === 0 ) {
				$insertTableForm.hide(0);
			}
		});
	}

	// 후원내역 등록 ajax
	function bindInsertSubmit() {
		$insertTableForm.on('submit', function (e) {
			e.preventDefault();

			var dataArr = [];
			var writer 	= $insertTableForm.find('[name="writer"]').val()

			$insertTbody.find('tr').each(function (index, el) {
				var $tr = $(el);
				var data = {
					  writer 		: writer
					, account_no 	: $tr.find('[name="account_no"]').val().replace(/[^0-9]/gim, '')
					, account_host 	: $tr.find('[name="account_host"]').val().trim()
					, bank 			: $tr.find('[name="bank"]').val().trim()
					, donation 		: Number( $tr.find('[name="donation"]').val().trim() )
					, donate_date 	: $tr.find('[name="donate_date"]').val().trim()
					, supporter_id 	: $tr.find('[name="supporter_id"]').val().trim()
				};

				dataArr.push( data );
			});

			$.ajax({
				  url 		: '/donate/insertList'
				, type 		: 'post'
				, dataType 	: 'json'
				, data 		: {
					donateList : JSON.stringify(dataArr)
				}
				, success 	: function ( data, status, xhr ) {
					if ( data.result > 0 ) {
						alert('후원내역 추가 성공 !');
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

	// 후원내역 업데이트 ajax
	function bindUpdateSubmit() {
		$updateDonateBtn.on('click', function (e) {
			e.preventDefault();

			var $checkedTr 	= $infoTbody.find('.on-change-el');
			var length 		= $checkedTr.length;

			if ( length < 1 ) {
				alert('수정한 정보가 없습니다.');
				return;
			}
			if ( ! confirm(length + ' 개의 정보를 수정하시겠습니까?\n삭제 버튼 체크 여부와 상관없이 정보만 수정됩니다.') ) {
				return;
			}

			var dataArr = [];

			$checkedTr.each(function (index, el) {
				var $tr = $(el);
				var data = {
					  no 			: Number( $tr.find('[name="no"]').val() )
					, account_no 	: $tr.find('[name="account_no"]').val().replace(/[^0-9]/gim, '')
					, account_host 	: $tr.find('[name="account_host"]').val().trim()
					, bank 			: $tr.find('[name="bank"]').val().trim()
					, donation 		: Number( $tr.find('[name="donation"]').val().trim() )
					, donate_date 	: $tr.find('[name="donate_date"]').val().trim()
					, supporter_id 	: $tr.find('[name="supporter_id"]').val().trim()
				};

				dataArr.push( data );
			});

			$.ajax({
				  url 		: '/donate/updateList'
				, type 		: 'post'
				, dataType 	: 'json'
				, data 		: {
					donateList : JSON.stringify(dataArr)
				}
				, success 	: function ( data, status, xhr ) {
					if ( data.result > 0 ) {
						alert('후원내역 업데이트 성공 !');
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

	// 후원내역 삭제 ajax
	function bindDeleteSubmit() {
		$deleteDonateBtn.on('click', function (e) {
			e.preventDefault();

			var $checkedTr 	= $infoTbody.find('.on-delete-el');
			var length 		= $checkedTr.length;

			if ( length < 1 ) {
				alert('선택한 정보가 없습니다.');
				return;
			}
			if ( ! confirm(length + ' 개의 정보를 삭제하시겠습니까?') ) { return; }

			var dataArr = [];

			$checkedTr.each(function (index, el) {
				var $tr = $(el);
				var data = {
					  no : Number( $tr.find('[name="no"]').val() )
				};

				dataArr.push( data );
			});

			$.ajax({
				  url 		: '/donate/deleteList'
				, type 		: 'post'
				, dataType 	: 'json'
				, data 		: {
					donateList : JSON.stringify(dataArr)
				}
				, success 	: function ( data, status, xhr ) {
					if ( data.result > 0 ) {
						alert('후원내역 삭제 성공 !');
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