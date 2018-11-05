<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />

	<title>document</title>

	<script src="/resources/vendor/jquery/jquery.min.js?${verQuery}"></script>
	<script src="/resources/vendor/underscore/underscore.min.js?${verQuery}"></script>
	<script src="/resources/common/js/app.js?${verQuery}"></script>
	<script>
		App.init();
	</script>
</head>

<body>
	<% boolean bool = true; %>

	<% if (bool) { %>
		<div>treu입니다)))))).</div>
	<% } else { %>
		<div>false입니다)))))).</div>
	<% } %>

	<h1>언더스코어 템플릿 예제</h1>
	<p>비동기 작업으로 DOM 추가 시 사용</p>

	<button style="padding: 40px 20px;" type="button" id="testBtn">Underscore Template</button>
	<ul id="list"></ul>

	<%-- underscore template --%>
	<script id="template" type="text/template">
		<@ if ( data.bool ) { @>
			<li style="color: red;"><@= data.title @></li>
		<@ } else { @>
			<li><@= data.title @></li>
		<@ } @>
	</script>

	<script>
		(function ($) {
			"use strict";
			var bool = false;

			$('#testBtn').on('click', function () {

				var titleList 	= ['JAVA', 'JavaScript', 'SQL', 'HTML', 'CSS', 'Spring'];
				var $list 		= $('#list');

				var tempStr = $("#template").html();
				var tempFun = _.template(tempStr, { variable: 'data' });

				titleList.forEach(function ( item, index, arr ) {
					bool = ! bool;

					$list.append(
						tempFun({
							  title : item
							, bool : bool
						})
					);
				});

			});
		}(jQuery));
	</script>
</body>
</html>