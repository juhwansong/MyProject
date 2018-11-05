<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	request.setAttribute( "verQuery", "ver=" + Calendar.getInstance().get(Calendar.MILLISECOND) );
%>

<!DOCTYPE html>
<html class="vm-admin">
<head>
	<meta charset="UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
	<%-- <meta name="description" content="document" /> --%>
	<%-- <meta name="keywords" content="document" /> --%>
	<%-- <meta name="author" content="document" /> --%>

	<title>Welcom to Viewnimal !</title>

	<%-- --------------- Vendor CSS --------------- --%>
	<!-- Favicon -->
	<link href="/resources/common/images/dog_01.png" rel="icon" type="image/png">

	<!-- Bootstrap -->
	<link href="/resources/vendor/gentelella/vendors/bootstrap/dist/css/bootstrap.min.css?${verQuery}" rel="stylesheet">
	<!-- Font Awesome -->
	<link href="/resources/vendor/gentelella/vendors/font-awesome/css/font-awesome.min.css?${verQuery}" rel="stylesheet">
	<!-- NProgress -->
	<link href="/resources/vendor/gentelella/vendors/nprogress/nprogress.css?${verQuery}" rel="stylesheet">
	<%-- --------------- //Vendor CSS --------------- --%>

	<%-- Common CSS --%>
	<link rel="stylesheet" href="/resources/common/css/app.css?${verQuery}" />
</head>
<body class="">

<script>
	(function () {
		"use strict";

		var isSimpleAdminSideMenu = sessionStorage.getItem('isSimpleAdminSideMenu');

		// 처음 화면 로딩 시 세션 스토리지를 이용하여 처리
		if ( isSimpleAdminSideMenu === 'true' ) { document.body.classList.add('nav-sm'); }
		else 									{ document.body.classList.add('nav-md'); }
	}());
</script>