(function ($) {
	"use strcit";

	var $content 	= $('.vm-searchAll');
	var $item 		= $content.find('.vm-searchAll__item');
	var millisecond = 100;

	$item.each(function ( index, el ) {
		setTimeout(function () {

			$(el).addClass('on');
			
		}, index * millisecond);
	});
}(jQuery));