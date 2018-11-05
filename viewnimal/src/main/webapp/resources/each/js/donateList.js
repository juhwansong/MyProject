(function ($) {
	"use strcit";

	var $searchForm 		= $('#donateSearchForm');
	var $content 			= $('.vm-donateList');
	var $targetList 		= $content.find('.vui-table tbody');
	var $targetPagination 	= $content.find('.vui-navigation .pagination');

	// 템플릿 세팅
	var listDataTemplate 			= _.template( $("#listDataTemplate").html(), 			{ variable: 'data' } );
	var listNoDataTemplate 			= _.template( $("#listNoDataTemplate").html(), 			{ variable: 'data' } );
	var paginationPrevTemplate 		= _.template( $("#paginationPrevTemplate").html(), 		{ variable: 'data' } );
	var paginationDataTemplate 		= _.template( $("#paginationDataTemplate").html(), 		{ variable: 'data' } );
	var paginationNoDataTemplate 	= _.template( $("#paginationNoDataTemplate").html(), 	{ variable: 'data' } );
	var paginationNextTemplate 		= _.template( $("#paginationNextTemplate").html(), 		{ variable: 'data' } );
	
	// donate/listSearch]
	$searchForm.on('submit', function (e) {
		e.preventDefault();
		$searchForm.formSubmit(false);
		App.loading.show();

		var serialObj = $searchForm.serializeObject();

		// 특수문자, 사이드 공백 모두 제거
		serialObj.keyword = serialObj.keyword
						.replace(/[\{\}\[\]\/\?\.\,\;\:\|\)\*\~\`\!\^\-\_\+\<\>\@\#\$\%\&\\\=\(\'\"]/gim , '')
						.trim()
					;

		$.ajax({
			  url 		: '/donate/listSearch'
			, type 		: 'post'
			, dataType 	: 'json'
			, data 		: $.param( serialObj )
			, success 	: function ( data, status, xhr ) {
				if ( data.category !== '' && data.keyword !== '' ) {
					data.searchParams = '&category=' + data.category + '&keyword=' + data.keyword;
				}
				else { data.searchParams = ''; }

				// ------------------------------------- List 업데이트
				$targetList.html( '' );

				if ( data.totalBoard > 0 ) {
					data.donateDtoList.forEach(function ( item, index, arr ) {
						$targetList.append( listDataTemplate( item ) );
					});
				}
				else { $targetList.html( listNoDataTemplate() ); }


				// ------------------------------------- Pagination 업데이트
				$targetPagination.html('');

				// Previous
				$targetPagination.append( paginationPrevTemplate( data ) );

				// Number
				if ( data.totalBoard > 0 ) {
					for ( let num = data.startPage; num <= data.endPage; num += 1 ) {
						data.num = num;

						$targetPagination.append( paginationDataTemplate( data ) );
					}
				}
				else { $targetPagination.append( paginationNoDataTemplate() ); }

				// Next
				$targetPagination.append( paginationNextTemplate( data ) );
			}
			, error 	: function ( xhr, status, error ) {
				alert('문제가 발생했습니다.\n다시 시도해주세요.');
			}
			, complete 	: function ( xhr, status ) {
				$searchForm.formSubmit(true);
				App.loading.hide();
			} 
		});
	});
}(jQuery));