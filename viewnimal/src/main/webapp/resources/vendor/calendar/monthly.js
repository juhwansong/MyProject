/*
Monthly 2.2.2 by Kevin Thornbloom is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
*/
(function ($) {
	"use strict";
	$.fn.extend({
		monthly: function(customOptions) {

			// These are overridden by options declared in footer
			var defaults = {
				dataType: "json",
				disablePast: false,
				eventList: false,
				events: "",
				jsonUrl: "",
				linkCalendarToEventUrl: true,
				maxWidth: false,
				mode: "event",
				setWidth: false,
				showTrigger: "",
				startHidden: false,
				stylePast: false,
				target: "",
				targetYear: "",
				targetMonth: "",
				targetDate: "",
				childTarget: "",
				childTargetYear: "",
				childTargetMonth: "",
				childTargetDate: "",
				useIsoDateFormat: false,
				weekStart: 0,	// Sunday
				xmlUrl: "",
				pageType : ""
			};
				
			var	options = $.extend(defaults, customOptions),
				uniqueId = $(this).attr("id"),
				parent = "#" + uniqueId,
				currentDate = new Date(),
				currentMonth = currentDate.getMonth() + 1,
				currentYear = currentDate.getFullYear(),
				currentDay = currentDate.getDate(),
				locale = (options.locale || defaultLocale()).toLowerCase(),
				monthNameFormat = options.monthNameFormat || "short",
				weekdayNameFormat = options.weekdayNameFormat || "short",
				monthNames = options.monthNames || defaultMonthNames(),
				dayNames = options.dayNames || defaultDayNames(),
				markupBlankDay = '<div class="m-d monthly-day-blank"><div class="monthly-day-number"></div></div>',
				weekStartsOnMonday = options.weekStart === "Mon" || options.weekStart === 1 || options.weekStart === "1",
				primaryLanguageCode = locale.substring(0, 2).toLowerCase();
		
		if(options.mode === 'limit-picker'){		
			var limitDateFormat = String($("#" + options.limitDateId).val()),	
			limitDateArr = limitDateFormat.split("-"),
			limitYear = parseInt(limitDateArr[0], 10),
			limitMonth = parseInt(limitDateArr[1], 10),
			limitDay = parseInt(limitDateArr[2], 10);
		}	
	
		if (options.maxWidth !== false) {
			$(parent).css("maxWidth", options.maxWidth);
		}
		if (options.setWidth !== false) {
			$(parent).css("width", options.setWidth);
		}

		if (options.startHidden) {
			$(parent).addClass("monthly-pop").css({
				display: "none",
				position: "absolute"
			});
			$(document).on("click", String(options.showTrigger), function (event) {
				//  처음 실행할때가 아닌 클릭해서 달력을 보이게 할때 현재 년도, 월로 정보 갖고 옴
				setMonthly(currentMonth, currentYear);
				$(parent).show();
				event.preventDefault();
			});
			/*$(document).on("focus", String(options.showTrigger), function (event) {
				$(parent).show();
				event.preventDefault();
			});*/
			$(document).on("click", String(options.showTrigger) + ", .monthly-pop", function (event) {
				event.stopPropagation();
				event.preventDefault();
			});
	
			$(document).on("click", function (event) {
				if($(event.target).is("#limit-picker-btn") || $(event.target).is("#limit-picker-btn *")){
					return;
				}
				$(parent).hide();
			});
			
		}

		// Add Day Of Week Titles
		_appendDayNames(weekStartsOnMonday);

		// Add CSS classes for the primary language and the locale. This allows for CSS-driven
		// overrides of the language-specific header buttons. Lowercased because locale codes
		// are case-insensitive but CSS is not.
		$(parent).addClass("monthly-locale-" + primaryLanguageCode + " monthly-locale-" + locale);

		// Add Header & event list markup
		$(parent).prepend('<div class="monthly-header"><div class="monthly-header-title"><a href="#" class="monthly-header-title-date" onclick="return false"></a></div><a href="#" class="monthly-prev"></a><a href="#" class="monthly-next"></a></div>').append('<div class="monthly-event-list"></div>');

		// Set the calendar the first time
		setMonthly(currentMonth, currentYear);

		// How many days are in this month?
		function daysInMonth(month, year) {
			return month === 2 ? (year & 3) || (!(year % 25) && year & 15) ? 28 : 29 : 30 + (month + (month >> 3) & 1);
		}
		
		// Build the month
		function setMonthly(month, year) { //다른 달 목록 불러올 시
			$(parent).data("setMonth", month).data("setYear", year);
			
			//리밋 파커의 달력 목록을 가져올 때
			if(options.mode === 'limit-picker'){
				//limitDate를 피커에서 선택한 날짜 기준으로 다시 설정			
				var changedLimitDateFormat = String($("#" + options.limitDateId).val());	
				limitDateArr = changedLimitDateFormat.split("-");
				limitYear = parseInt(limitDateArr[0], 10);
				limitMonth = parseInt(limitDateArr[1], 10);
				limitDay = parseInt(limitDateArr[2], 10);
			}
			
			// Get number of days
			var index = 0,
				dayQty = daysInMonth(month, year),
				// Get day of the week the first day is
				mZeroed = month - 1,
				firstDay = new Date(year, mZeroed, 1, 0, 0, 0, 0).getDay(),
				settingCurrentMonth = month === currentMonth && year === currentYear;
			
			// Remove old days
			$(parent + " .monthly-day, " + parent + " .monthly-day-blank").remove();
			$(parent + " .monthly-event-list, " + parent + " .monthly-day-wrap").empty();
			// Print out the days
			for(var dayNumber = 1; dayNumber <= dayQty; dayNumber++) {
				// Check if it's a day in the past
				var isInPast = options.stylePast && (
					year < currentYear
					|| (year === currentYear && (
						month < currentMonth
						|| (month === currentMonth && dayNumber < currentDay)
					))),
					isInLimit = options.limitDateId && (
					year > limitYear
					|| (year === limitYear && (
							month > limitMonth
						|| (month === limitMonth && dayNumber >= limitDay)
					))),
					innerMarkup = '<div class="monthly-day-number">' + dayNumber + '</div><div class="monthly-indicator-wrap"></div>';
				if(options.mode === "event") {
					var thisDate = new Date(year, mZeroed, dayNumber, 0, 0, 0, 0);
					$(parent + " .monthly-day-wrap").append("<div"
						+ attr("class", "m-d monthly-day monthly-day-event"
							+ (isInPast ? " monthly-past-day" : "")
							+ " dt" + thisDate.toISOString().slice(0, 10)
							)
						+ attr("data-number", dayNumber)
						+ ">" + innerMarkup + "</div>");
					
					$(parent + " .monthly-event-list").append("<div"
						+ attr("class", "monthly-list-item")
						+ attr("id", uniqueId + "day" + dayNumber)
						+ attr("data-number", dayNumber)
						+ '><div class="monthly-event-list-date">' + dayNames[thisDate.getDay()] + "<br>" + dayNumber + "</div></div>");
								
					if(dayNames[thisDate.getDay()] === '토'){
						$(parent + ' *[data-number="' + dayNumber + '"]').addClass("monthly-saturday");
					}
					
					else if(dayNames[thisDate.getDay()] === '일'){
						$(parent + ' *[data-number="' + dayNumber + '"]').addClass("monthly-sunday");
					}
					
				} else {
					var thisDate = new Date(year, mZeroed, dayNumber, 0, 0, 0, 0);
					
					$(parent + " .monthly-day-wrap").append("<a"
						+ attr("href", "#")
						+ attr("class", "m-d monthly-day monthly-day-pick" + (isInPast ? " monthly-past-day" : "") + (isInLimit ? " monthly-limit-day" : ""))				
						+ attr("data-number", dayNumber)
						+ ">" + innerMarkup + "</a>");
								
					if(dayNames[thisDate.getDay()] === '토'){
						$(parent + " .monthly-day-wrap" + ' *[data-number="' + dayNumber + '"]').addClass("monthly-saturday");
					}
					
					else if(dayNames[thisDate.getDay()] === '일'){
						$(parent + ' *[data-number="' + dayNumber + '"]').addClass("monthly-sunday");
					}
				
				}
			}

			if (settingCurrentMonth) {
				
				$(parent + ' *[data-number="' + currentDay + '"]').addClass("monthly-today");
			}

			// Reset button
			$(parent + " .monthly-header-title").html('<a href="#" class="monthly-header-title-date" onclick="return false">' + monthNames[month - 1] + " " + year + "</a>" + (settingCurrentMonth && $(parent + " .monthly-event-list").hide() ? "" : '<a href="#" class="monthly-reset"></a>'));
			
			// Account for empty days at start
			if(weekStartsOnMonday) {
				if (firstDay === 0) {
					_prependBlankDays(6);
				} else if (firstDay !== 1) {
					_prependBlankDays(firstDay - 1);
				}
			} else if(firstDay !== 7) {
				_prependBlankDays(firstDay);
			}

			// Account for empty days at end
			var numdays = $(parent + " .monthly-day").length,
				numempty = $(parent + " .monthly-day-blank").length,
				totaldays = numdays + numempty,
				roundup = Math.ceil(totaldays / 7) * 7,
				daysdiff = roundup - totaldays;
			if(totaldays % 7 !== 0) {
				for(index = 0; index < daysdiff; index++) {
					$(parent + " .monthly-day-wrap").append(markupBlankDay);
				}
			}

			// Events
			if (options.mode === "event" || options.mode === "picker") {
				addEvents(month, year);
			}
			var divs = $(parent + " .m-d");
			for(index = 0; index < divs.length; index += 7) {
				divs.slice(index, index + 7).wrapAll('<div class="monthly-week"></div>');
			}
		}

		function addEvent(event, setMonth, setYear) {
			// Year [0]   Month [1]   Day [2]
			var fullStartDate = _getEventDetail(event, "volunteer_date"),
				fullEndDate = _getEventDetail(event, "enddate"),
				startArr = fullStartDate.split("-"),
				startYear = parseInt(startArr[0], 10),
				startMonth = parseInt(startArr[1], 10),
				startDay = parseInt(startArr[2], 10),
				startDayNumber = startDay,
				endDayNumber = startDay,
				showEventTitleOnDay = startDay,
				startsThisMonth = startMonth === setMonth && startYear === setYear,
				happensThisMonth = startsThisMonth;
			
			
			if(fullEndDate) {
				// If event has an end date, determine if the range overlaps this month
				var	endArr = fullEndDate.split("-"),
					endYear = parseInt(endArr[0], 10),
					endMonth = parseInt(endArr[1], 10),
					endDay = parseInt(endArr[2], 10),
					startsInPastMonth = startYear < setYear || (startMonth < setMonth && startYear === setYear),
					endsThisMonth = endMonth === setMonth && endYear === setYear,
					endsInFutureMonth = endYear > setYear || (endMonth > setMonth && endYear === setYear);
				if(startsThisMonth || endsThisMonth || (startsInPastMonth && endsInFutureMonth)) {
					happensThisMonth = true;
					startDayNumber = startsThisMonth ? startDay : 1;
					endDayNumber = endsThisMonth ? endDay : daysInMonth(setMonth, setYear);
					showEventTitleOnDay = startsThisMonth ? startDayNumber : 1;
				}
			}
			if(!happensThisMonth) {
				return;
			}
			
			var startTime = _getEventDetail(event, "starttime"),
				timeHtml = "",
				eventURL = _getEventDetail(event, "url"),
				eventTitle = _getEventDetail(event, "title"),
				eventThumnail = _getEventDetail(event, "thumbnail"),
				eventApplyMaxCount = _getEventDetail(event, "apply_max_count"),
				eventApplyCount = _getEventDetail(event, "apply_count"),
				eventApplyState = _getEventDetail(event, "apply_state"),
				eventClass = _getEventDetail(event, "class"),
				eventColor = _getEventDetail(event, "color"),
				eventId = _getEventDetail(event, "id"),
				customClass = eventClass ? " " + eventClass : "",
				dayStartTag = "<div",
				dayEndTags = "</span></div>";
			
			//모드가 피커일땐 스케줄 저장은 하지 않고 해당 날짜 요소에 이벤트가 등록됐는지 안됐는지의 구분자만 추가
			if(options.mode === 'picker'){
				// 달력 피커 해당 날짜 요소에 이벤트 등록된 날짜라는 것을 구분하기 위한 class 추가  
				if(eventId){
					$(parent + " .monthly-day-pick[data-number=" + startDayNumber + "]").addClass("monthly-scheduled-day");
				}
				return;
			}
			
			if(startTime) { //이벤트 입력된 날짜가 있다면			
				var endTime = _getEventDetail(event, "endtime");
				timeHtml = '<div><div class="monthly-list-time-start">' + formatTime(startTime) + "</div>"
					+ (endTime ? '<div class="monthly-list-time-end">' + formatTime(endTime) + "</div>" : "")
					+ "</div>";
			}

			if(options.linkCalendarToEventUrl && eventURL) {
				dayStartTag = "<a" + attr("href", eventURL);
				dayEndTags = "</span></a>";
			}

			var	markupDayStart = dayStartTag
					+ attr("data-eventid", eventId)
					+ attr("title", eventTitle)
					// BG and FG colors must match for left box shadow to create seamless link between dates
					+ (eventColor ? attr("style", "background:" + eventColor + ";color:" + eventColor) : ""),
				markupListEvent = "<a"
					+ attr("href", eventURL)
					+ attr("class", "listed-event" + customClass)
					+ attr("data-eventid", eventId)
					+ (eventColor ? attr("style", "background:" + eventColor) : "")
					+ attr("title", eventTitle)
					+ ">" + eventTitle + " " + timeHtml + "</a>";
			for(var index = startDayNumber; index <= endDayNumber; index++) { 
				var doShowTitle = index === showEventTitleOnDay;
				// Add to calendar view
				//달력에 썸네일 보이게
				$(parent + ' *[data-number="' + index + '"] .monthly-indicator-wrap').append(
						markupDayStart 
						+ attr("class", "monthly-event-blank-box" + customClass
							)
						+ "><img class='calender-thumnail' src='" + eventThumnail + "'>"
						+ dayEndTags);	
				//텍스트 박스
				$(parent + ' *[data-number="' + index + '"] .monthly-indicator-wrap').append("<div class='monthly-indicator-wrap__text-box'>");	
				//달력에 제목 보이게
				$(parent + ' *[data-number="' + index + '"] .monthly-indicator-wrap div').append(
						markupDayStart
						+ attr("class", "monthly-event-indicator" + customClass
							// Include a class marking if this event continues from the previous day
							+ (doShowTitle ? "" : " monthly-event-continued")
							)
						+ "><span>" + (doShowTitle ? "<font style='color:#f6f9fc;font-size:15px; font-weight:bold;'>" + eventTitle + "</font>" : "") 
						+ dayEndTags);
				//달력에 인원수 보이게
				var $applyCountAppendBox = $(parent + ' *[data-number="' + index + '"] .monthly-indicator-wrap div');
						
				var applyCountHtmlStr = markupDayStart + attr("class", "monthly-event-indicator" + customClass
							// Include a class marking if this event continues from the previous day
							+ (doShowTitle ? "" : " monthly-event-continued")) + "><span style='font-size:12px;font-weight:bold;'>" + "<font style='color:#f6f9fc;'>모집 인원</font> : ";
				
				if(eventApplyCount < eventApplyMaxCount){
					applyCountHtmlStr += "<font style='color:#f6f9fc;'>" + eventApplyCount;//현재인원
				}
				else{
					applyCountHtmlStr += "<font style='color:#f06199;'>" + eventApplyCount;//현재인원(최대일때)
				}
				applyCountHtmlStr += "</font>" + " / " + "<font style='color:#f6f9fc;'>" + eventApplyMaxCount + "</font>" + dayEndTags;
				$applyCountAppendBox.append(applyCountHtmlStr);
				
				//달력에 모집 상태 보이게
				var $stateAppendBox = $(parent + ' *[data-number="' + index + '"] .monthly-indicator-wrap div');
				var stateHtmlStr = markupDayStart + attr("class", "monthly-event-indicator" + customClass
							// Include a class marking if this event continues from the previous day
							+ (doShowTitle ? "" : " monthly-event-continued")) + "><span style='font-size:10.5px;font-weight:bold;'>";  
				      
				if(eventApplyState === '모집마감'){
					stateHtmlStr += "<font style='color:#f06199;'>" + eventApplyState; //applylist 모집마감 폰트 색깔 
				}
				else{
					stateHtmlStr += "<font style='color:#11cdef'>" + eventApplyState; //applylist 모집중 폰트 색깔
				}
				stateHtmlStr += "</font>" + dayEndTags + "</div>";
				
				$stateAppendBox.append(stateHtmlStr);
	
				// Add to event list
				$(parent + ' .monthly-list-item[data-number="' + index + '"]') //이벤트 리스트에 해당 날짜 이벤트 내용 추가
					.addClass("item-has-event")
					.append(markupListEvent);
			}
		}
		 
		//////////////////이 함수 안에서 ajax 처리//////////////////////////////////////////////
		function addEvents(month, year) {
			/*if(options.events) {*/// 직접 넣은 지역 이벤트일때
			// Prefer local events if provided
			var searchDateFormat = year + "-";
			if(String(month).charAt(1) === ""){
				searchDateFormat += "0" + month;
			}
			else{
				searchDateFormat += month;  
			}
			
			App.loading.show(); //로딩 띄우기
			//여기서 ajax처리 해당 년/월에 대한 데이터를 가져옴
			$.ajax({		  
				  url 		: '/selectVolunteerApplyList'
				, type 		: 'POST'	
				, data 		: {'selectedmonth' : searchDateFormat}
				, dataType 	: 'json'
				, async		: true
				, cache     : false
				, success 	: function ( data, status, xhr ) {
					addEventsFromString(data, month, year);
				}
				, error 	: function ( xhr, status, error ) {
					alert("게시글 정보를 불러오는데 실패했습니다.");
				},complete : function(xhr, status){
					App.loading.hide(); //로딩 끄기
				}
			});		
			
			
				
			/*} else {*/ //그 이외(파일 이벤트 등등)
				/*var remoteUrl = options.dataType === "xml" ? options.xmlUrl : options.jsonUrl;
				if(remoteUrl) {
					// Replace variables for month and year to load from dynamic sources
					var url = String(remoteUrl).replace("{month}", month).replace("{year}", year);
					$.get(url, {now: $.now()}, function(data) {
						addEventsFromString(data, month, year);
					}, options.dataType).fail(function() {
						console.error("Monthly.js failed to import " + remoteUrl + ". Please check for the correct path and " + options.dataType + " syntax.");
					});
				}*/
			/*}*/
		}

		function addEventsFromString(events, setMonth, setYear) {
			
			
			if (options.dataType === "xml") {
				$(events).find("event").each(function(index, event) {
					addEvent(event, setMonth, setYear);
				});			
			} else{ //xml 아닐때(datatype 안적었을때도) (이벤트 추가)
				$.each(events.monthly, function(index, event) {
					addEvent(event, setMonth, setYear);
				});			
			}
		}

		function attr(name, value) {
			var parseValue = String(value);
			var newValue = "";
			for(var index = 0; index < parseValue.length; index++) {
				switch(parseValue[index]) {
					case "'": newValue += "&#39;"; break;
					case "\"": newValue += "&quot;"; break;
					case "<": newValue += "&lt;"; break;
					case ">": newValue += "&gt;"; break;
					default: newValue += parseValue[index];
				}
			}
			return " " + name + "=\"" + newValue + "\"";
		}

		function _appendDayNames(startOnMonday) {
			var offset = startOnMonday ? 1 : 0,
				dayName = "",
				dayIndex = 0;
			for(dayIndex = 0; dayIndex < 6; dayIndex++) {
				dayName += "<div>" + dayNames[dayIndex + offset] + "</div>";
			}
			dayName += "<div>" + dayNames[startOnMonday ? 0 : 6] + "</div>";
			$(parent).append('<div class="monthly-day-title-wrap">' + dayName + '</div><div class="monthly-day-wrap"></div>');
		}

		// Detect the user's preferred language
		function defaultLocale() {
			if(navigator.languages && navigator.languages.length) {
				return navigator.languages[0];
			}
			return navigator.language || navigator.browserLanguage;
		}

		// Use the user's locale if possible to obtain a list of short month names, falling back on English
		function defaultMonthNames() {
			if(typeof Intl === "undefined") {
				return ["Jan", "Feb", "Mar", "Apr", "May", "June", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
			}
			var formatter = new Intl.DateTimeFormat(locale, {month: monthNameFormat});
			var names = [];
			for(var monthIndex = 0; monthIndex < 12; monthIndex++) {
				var sampleDate = new Date(2017, monthIndex, 1, 0, 0, 0);
				names[monthIndex] = formatter.format(sampleDate);
			}
			return names;
		}

		function formatDate(year, month, day) {
			if(options.useIsoDateFormat) {
				return new Date(year, month - 1, day, 0, 0, 0).toISOString().substring(0, 10);
			}
			if(typeof Intl === "undefined") {
				return month + "/" + day + "/" + year;
			}
			return new Intl.DateTimeFormat(locale).format(new Date(year, month - 1, day, 0, 0, 0));
		}

		// Use the user's locale if possible to obtain a list of short weekday names, falling back on English
		function defaultDayNames() {
			if(typeof Intl === "undefined") {
				return ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
			}
			var formatter = new Intl.DateTimeFormat(locale, {weekday: weekdayNameFormat}),
				names = [],
				dayIndex = 0,
				sampleDate = null;
			for(dayIndex = 0; dayIndex < 7; dayIndex++) {
				// 2017 starts on a Sunday, so use it to capture the locale's weekday names
				sampleDate = new Date(2017, 0, dayIndex + 1, 0, 0, 0);
				names[dayIndex] = formatter.format(sampleDate);
			}
			return names;
		}

		function _prependBlankDays(count) {
			var wrapperEl = $(parent + " .monthly-day-wrap"),
				index = 0;
			for(index = 0; index < count; index++) {
				wrapperEl.prepend(markupBlankDay);
			}
		}

		function _getEventDetail(event, nodeName) {
			return options.dataType === "xml" ? $(event).find(nodeName).text() : event[nodeName];
		}

		// Returns a 12-hour format hour/minute with period. Opportunity for future localization.
		function formatTime(value) {
			var timeSplit = value.split(":");
			var hour = parseInt(timeSplit[0], 10);
			var period = "AM";
			if(hour > 12) {
				hour -= 12;
				period = "PM";
			} else if (hour == 12) {
				period = "PM";
			} else if(hour === 0) {
				hour = 12;
			}
			return hour + ":" + String(timeSplit[1]) + " " + period;
		}

		function setNextMonth() {
			var	setMonth = $(parent).data("setMonth"),
				setYear = $(parent).data("setYear"),
				newMonth = setMonth === 12 ? 1 : setMonth + 1,
				newYear = setMonth === 12 ? setYear + 1 : setYear;
			setMonthly(newMonth, newYear);
			viewToggleButton();
		}

		function setPreviousMonth() {
			var setMonth = $(parent).data("setMonth"),
				setYear = $(parent).data("setYear"),
				newMonth = setMonth === 1 ? 12 : setMonth - 1,
				newYear = setMonth === 1 ? setYear - 1 : setYear;
			setMonthly(newMonth, newYear);
			viewToggleButton();
		}
		
		// Function to go back to the month view
		function viewToggleButton() {
			if($(parent + " .monthly-event-list").is(":visible")) {
				$(parent + " .monthly-cal").remove();
				$(parent + " .monthly-header-title").prepend('<a href="#" class="monthly-cal"></a>');
			}
		}
		
		
		////////////////////////////////////////////////////////////////////////////////////////////////
		//처음 페이지 로딩 시 카테고리 월을 가져오는 함수 실행(초기값) - 모집 리스트 페이지에서만
		if(options.pageType === 'select'){
			selectCategoryList($("select[name=selectpicker-year]").val());
		}
		
		//년 카테고리 변경 시
		$(document.body).on("change", "#selectpicker-year", function(){
			//월 옵션 제거
			$("select[name=selectpicker-month]").empty();
			//월 옵션 불러오는 함수
			selectCategoryList($("select[name=selectpicker-year]").val());
			
		});
	
		
		//apply-list 카테고리 검색버튼 클릭 시
		$(document.body).on("click", "#apply-list-search-date", function(){
			setMonthly(Number($("select[name=selectpicker-month]").val()), Number($("select[name=selectpicker-year]").val()));
		})
		
		//카테고리 목록 가져오는 함수
		function selectCategoryList(categoryYear){
			var currentCalendar = new Date();
			var beginYear = 2017; //최초 시작 년도 설정
			var beginYearMinMonth = 7; //최초 시작 년도의 시작 월 설정
			var minMonth = 1; 
			var maxYear = currentCalendar.getFullYear();
			var maxYearMaxMonth = 12; //최대 년도의 최대 달
			var maxMonth = 12; //지나간 년도는 12월이 최대
			var currentMonth = currentCalendar.getMonth()+1; //현재 달
			
			if(Number(categoryYear) === beginYear){
				minMonth = beginYearMinMonth;
				
			}
			if(Number(categoryYear) === maxYear){
				maxMonth = maxYearMaxMonth;
			}
			
			var monthFormat = "";
			for(var i = minMonth; i<= maxMonth; i++){		
				monthFormat = i;
				if(i < 10){
					monthFormat = "0" + i;
				}
				if(Number(categoryYear) === maxYear && i === currentMonth){
					$("#selectpicker-month").append('<option selected value="' + i + '">'+ monthFormat +'월</option>');
				}
				else if(Number(categoryYear) !== maxYear && i == 12){
					$("#selectpicker-month").append('<option selected value="' + i + '">'+ monthFormat +'월</option>');
				}
				else{
					$("#selectpicker-month").append('<option value="' + i + '">'+ monthFormat +'월</option>');
				}
			}
			$("#selectpicker-month").selectpicker("refresh"); //리플래쉬 해줘야 적용
		}
		////////////////////////////////////////////////////////////////////////////
		
		
		
		
		// Advance months
		$(document.body).on("click", parent + " .monthly-next", function (event) {
			setNextMonth();
			event.preventDefault();
		});

		// Go back in months
		$(document.body).on("click", parent + " .monthly-prev", function (event) {
			setPreviousMonth();
			event.preventDefault();
		});

		// Reset Month
		$(document.body).on("click", parent + " .monthly-reset", function (event) {
			$(this).remove();
			setMonthly(currentMonth, currentYear);
			viewToggleButton();
			event.preventDefault();
			event.stopPropagation();
		});

		// Back to month view
		$(document.body).on("click", parent + " .monthly-cal", function (event) {
			$(this).remove();
			$(parent + " .monthly-event-list").css("transform", "scale(0)");
			setTimeout(function() {
				$(parent + " .monthly-event-list").hide();
			}, 250);
			event.preventDefault();
		});
		
		
	
		// Click A Day
		$(document.body).on("click touchstart", parent + " .monthly-day", function (event) {
			// If events, show events list
			var whichDay = $(this).data("number");
			
			////////////////////////////수정한 부분/////////////////////////
			/*&& $(event.target).is(".monthly-event-indicator *") || $(event.target).is(".monthly-event-indicator")*/ 
			if(options.mode === "event" && options.eventList) {
				//해당 날짜에 추가한 경로로 이동
				//location.href=$("#mycalendarday" + dataNumber + " a").attr("href");
				
				///////////////////////////리스트 메뉴 보이게 display-on(필요없는 기능이니 주석 처리)//////
				/*var	theList = $(parent + " .monthly-event-list"),
					myElement = document.getElementById(uniqueId + "day" + whichDay),
					topPos = myElement.offsetTop;
				theList.show();
				theList.css("transform");
				theList.css("transform", "scale(1)");
				$(parent + ' .monthly-list-item[data-number="' + whichDay + '"]').show();
				theList.scrollTop(topPos);
				viewToggleButton();*/
				///////////////////////////////////////////////////////////////////////
				if(!options.linkCalendarToEventUrl) {
					event.preventDefault();
				}
			// If picker, pick date
			} else if (options.mode === "picker" || options.mode === "limit-picker") {
				var	setMonth = $(parent).data("setMonth"),
					setYear = $(parent).data("setYear");
				// Should days in the past be disabled?
				
				//해당 날짜 클릭 이벤트 시 if문일 경우 작동 안되게 (스케줄이 정해져있거나 이미 지난 날짜거나)
				if(($(this).hasClass("monthly-scheduled-day") || $(this).hasClass("monthly-past-day") || $(this).hasClass("monthly-limit-day")) && options.disablePast) {
					// If so, don't do anything.
					event.preventDefault();
				} else {
					// Otherwise, select the date ...
					$(String(options.targetYear)).val(setYear);
					if(String(setMonth).charAt(1) === ""){
						$(String(options.targetMonth)).val("0" + setMonth);
					}
					else{
						$(String(options.targetMonth)).val(setMonth);
					}
					if(String(whichDay).charAt(1) === ""){
						$(String(options.targetDate)).val("0" + whichDay);
					}
					else{
						$(String(options.targetDate)).val(whichDay);
					}
					
					var targetYearStr = $(String(options.targetYear)).val();
					var targetMonthStr = $(String(options.targetMonth)).val();
					var targetDateStr = $(String(options.targetDate)).val();
					var targetNumberDate = Number(targetYearStr + targetMonthStr + targetDateStr)
					$(String(options.target)).val(targetYearStr + "-" + targetMonthStr + "-" + targetDateStr);
					
					//자식 타겟 요소가 부모 타겟 요소의 값보다 클 때 - 모집기한이 봉사날짜와 같거나 클때 
					if(options.childTarget !== "" && targetNumberDate <= Number($(String(options.childTarget)).val().replace(/\-/g,''))){
						alert("모집기한이 등록일자보다 늦을 수 없습니다!\n모집기한을 다시 입력 해 주세요.");
						//자식 타켓 요소의 값 초기화
						$(String(options.childTargetYear)).val("");
						$(String(options.childTargetMonth)).val("");
						$(String(options.childTargetDate)).val("");
						$(String(options.childTarget)).val("");	
					}
					
					// ... and then hide the calendar if it started that way
					if(options.startHidden) {
						$(parent).hide();
					}
				}
				event.preventDefault();
			}
		});

		// Clicking an event within the list
		/*$(document.body).on("click", parent + " .listed-event", function (event) {
			var href = $(this).attr("href");
			 //If there isn't a link, don't go anywhere
			if(!href) {
				event.preventDefault();
			}
		});*/

	}
	
	});
	 
	
}(jQuery));
