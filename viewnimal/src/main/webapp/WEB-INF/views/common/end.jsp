<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- Lib JS (단독) --%>
<script src="/resources/vendor/jquery/jquery.min.js?${verQuery}"></script>
<script src="/resources/vendor/underscore/underscore.min.js?${verQuery}"></script>
<script src="/resources/vendor/hangul/hangul.min.js?${verQuery}"></script>
<script src="//apis.google.com/js/platform.js?${verQuery}"></script>

<%-- Dependency JS (의존성) --%>
<script src="/resources/vendor/jquery-lazyload/jquery-lazyload.min.js?${verQuery}"></script>
<script src="/resources/vendor/summernote/summernote.js?${verQuery}"></script> 
<!-- Summernote JS -->
<script src="//cdnjs.cloudflare.com/ajax/libs/codemirror/3.20.0/codemirror.js?${verQuery}"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/codemirror/3.20.0/mode/xml/xml.js?${verQuery}"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/codemirror/2.36.0/formatting.js?${verQuery}"></script>

<%-- --------------- Theme JS --------------- --%>
<!-- Core -->
<script src="/resources/vendor/argon/assets/vendor/popper/popper.min.js?${verQuery}"></script>
<script src="/resources/vendor/argon/assets/vendor/bootstrap/bootstrap.min.js?${verQuery}"></script>
<script src="/resources/vendor/argon/assets/vendor/headroom/headroom.min.js?${verQuery}"></script>
<!-- Optional JS -->
<script src="/resources/vendor/argon/assets/vendor/onscreen/onscreen.min.js?${verQuery}"></script>
<script src="/resources/vendor/argon/assets/vendor/nouislider/js/nouislider.min.js?${verQuery}"></script>
<script src="/resources/vendor/argon/assets/vendor/bootstrap-datepicker/js/bootstrap-datepicker.min.js?${verQuery}"></script>
<!-- Argon JS -->
<script src="/resources/vendor/argon/assets/js/argon.js?${verQuery}"></script>
<%-- --------------- //Theme JS --------------- --%>

<%-- Common JS --%>
<script src="/resources/common/js/app.js?${verQuery}"></script>

<script>
	App.init();
	App.clientInit();

	(function ($) {
		"use strict";

	}(jQuery));
</script>

<%-- 새 비밀번호 발급 메일로 통해 넘어온 경우 --%>
<c:if test="${ null != isUpdatePassword }">
	<c:choose>
		<c:when test="${isUpdatePassword}">
			<script>
				App.messagePop.show('비밀번호가 성공적으로 변경되었습니다.', {
					duration : 3500
				});
				$('#modal-login').modal('show');
			</script>
		</c:when>

		<c:otherwise>
			<script>
				App.messagePop.show('비밀번호 변경을 실패하였습니다.<br>다시 시도해주세요', {
					duration : 3500
				})
				$('#modal-login').modal('show');
				$('#modal-new-pw').modal('show');
			</script>
		</c:otherwise>
	</c:choose>
</c:if>
<%-- //새 비밀번호 발급 메일로 통해 넘어온 경우 --%>

</body>
</html>