(function ($) {
	"use strcit";

	var $content 	= $('.vm-adminMain');
	var $sec = $content.find('.vm-adminMain__sec');
	var millisecond = 200;

	$sec.each(function ( index, el ) {
		setTimeout(function () {

			$(el).addClass('on');
			
		}, index * millisecond);
	});

	var arr_data1 = [
		// [gd(2012, 1, 1), 17],
		// [gd(2012, 1, 2), 74],
		// [gd(2012, 1, 3), 6],
		// [gd(2012, 1, 4), 39],
		// [gd(2012, 1, 5), 20],
		// [gd(2012, 1, 6), 85],
		// [gd(2012, 1, 7), 7]
	];

	$('#volunteerApplyGraphList ul').each(function ( index, el ) {
		var $el 		= $(el);
		var count 		= $el.find('[data-count]').attr('data-count');
		var applyDate 	= $el.find('[data-apply-date]').attr('data-apply-date').replace(/\//gim, '');
		var year 		= Number( applyDate.substr(0, 4) );
		var month 		= Number( applyDate.substr(4, 2) );
		var day 		= Number( applyDate.substr(6, 2) );

		arr_data1.push( [gd(year, month, day), count] );
	});

	var chart_plot_01_settings = {
	  series: {
		lines: {
		  show: false,
		  fill: true
		},
		splines: {
		  show: true,
		  tension: 0.4,
		  lineWidth: 1,
		  fill: 0.4
		},
		points: {
		  radius: 4,
		  show: true
		},
		shadowSize: 2
	  },
	  grid: {
		verticalLines: true,
		hoverable: true,
		clickable: true,
		tickColor: "#d5d5d5",
		borderWidth: 1,
		color: '#fff'
	  },
	  colors: ["rgba(38, 185, 154, 0.38)", "rgba(3, 88, 106, 0.38)"],
	  xaxis: {
		tickColor: "rgba(51, 51, 51, 0.06)",
		mode: "time",
		tickSize: [1, "day"],
		//tickLength: 10,
		axisLabel: "Date",
		axisLabelUseCanvas: true,
		axisLabelFontSizePixels: 12,
		axisLabelFontFamily: 'Verdana, Arial',
		axisLabelPadding: 10
	  },
	  yaxis: {
		ticks: 1,
		tickColor: "rgba(51, 51, 51, 0.06)",
	  },
	  tooltip: true
	};

	$.plot( $("#chart_plot_custom"), [ arr_data1 ],  chart_plot_01_settings );

	
}(jQuery));