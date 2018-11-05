<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Index</title>
	<meta charset="UTF-8" />
</head>
<body>
<h1>
	<%-- JSP Action Tag --%>
	<jsp:forward page="/ChannelList" />

	<%
		// request.getRequestDispatcher("main").forward( request, response );
	%>
</h1>
</body>
</html>