<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	request.setAttribute( "verQuery", "ver=" + Calendar.getInstance().get(Calendar.MILLISECOND) );
%>

<!DOCTYPE html>
<html class="vm-client">
<head>
	<meta charset="UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
	<meta name="google-signin-scope" content="profile email">
	<meta name="google-signin-client_id" content="510108413607-ev15i1rn6m6ealfk47md53qfavi5aiif.apps.googleusercontent.com">
	<%-- <meta name="description" content="document" /> --%>
	<%-- <meta name="keywords" content="document" /> --%>
	<%-- <meta name="author" content="document" /> --%>

	<title>Welcome to Viewnimal !</title>

	<%-- --------------- Vendor CSS --------------- --%>
	<!-- Favicon -->
	<link href="/resources/common/images/main_logo.png" rel="icon" type="image/png">
	<!-- Icons -->
	<link href="/resources/vendor/argon/assets/vendor/nucleo/css/nucleo.css?${verQuery}" rel="stylesheet">
	<link href="/resources/vendor/argon/assets/vendor/font-awesome/css/font-awesome.min.css?${verQuery}" rel="stylesheet">
	<!-- Argon CSS -->
	<link href="/resources/vendor/argon/assets/css/argon.min.css?${verQuery}" rel="stylesheet">
	<!-- Docs CSS -->
	<link href="/resources/vendor/argon/assets/css/docs.min.css?${verQuery}" rel="stylesheet">
	<!-- Summernote CSS -->
	<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/codemirror/3.20.0/codemirror.css?${verQuery}">
	<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/codemirror/3.20.0/theme/monokai.css?${verQuery}"> 
	<link rel="stylesheet" href="/resources/vendor/summernote/summernote.css?${verQuery}">
	<%-- --------------- //Vendor CSS --------------- --%>

	<%-- Common CSS --%>
	<link rel="stylesheet" href="/resources/common/css/app.css?${verQuery}" />
</head>
<body>