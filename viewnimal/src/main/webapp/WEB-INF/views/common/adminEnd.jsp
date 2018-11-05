<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- Lib JS (단독) --%>
<script src="/resources/vendor/jquery/jquery.min.js?${verQuery}"></script>
<script src="/resources/vendor/underscore/underscore.min.js?${verQuery}"></script>
<script src="/resources/vendor/hangul/hangul.min.js?${verQuery}"></script>

<%-- Dependency JS (의존성) --%>
<script src="/resources/vendor/jquery-lazyload/jquery-lazyload.min.js?${verQuery}"></script>

<%-- --------------- Theme JS --------------- --%>
<!-- Bootstrap -->
<script src="/resources/vendor/gentelella/vendors/bootstrap/dist/js/bootstrap.min.js?${verQuery}"></script>
<!-- FastClick -->
<script src="/resources/vendor/gentelella/vendors/fastclick/lib/fastclick.js?${verQuery}"></script>
<!-- NProgress -->
<script src="/resources/vendor/gentelella/vendors/nprogress/nprogress.js?${verQuery}"></script>
<%-- --------------- //Theme JS --------------- --%>

<%-- Common JS --%>
<script src="/resources/common/js/app.js?${verQuery}"></script>

<script>
	App.init();
	App.adminInit();

	(function ($) {
		"use strict";
		
	}(jQuery));
</script>

</body>
</html>