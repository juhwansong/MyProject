<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*" %>

<link rel="stylesheet" href="/resources/each/css/channelChoice.css?${verQuery}" />

<%-- -------- JSP -------- --%>
<div>
	<div class="vm-content vm-channelChoice">

		<div class="vm-section">
			
			<div class="vm-channelChoice__detail-wrapper">
				
				<div class="vm-channelChoice__img-wrapper"> 
					<img class="vm-channelChoice__img" src="/resources/images/channel/메인2.jpg">
					<div class="vm-channelChoice__name">일절미</div>
				</div>
				<div class="vm-channelChoice__img-wrapper"> 
					<img class="vm-channelChoice__img" src="/resources/images/channel/메인3.jpg">
					<div class="vm-channelChoice__name">이절미</div>
				</div>
				<div class="vm-channelChoice__img-wrapper"> 
					<img class="vm-channelChoice__img" src="/resources/images/channel/메인4.jpg">
					<div class="vm-channelChoice__name">삼절미</div>
				</div>
				
			</div>
			
		</div>
	</div>
</div>

<%-- -------- //JSP -------- --%>


<style type="text/css">
.vm-channelChoice__another { font-weight: bold; font-size: 30px; margin-bottom: 20px; }
 .vm-channelChoice__img { width: 150px; border-radius: 50%;}
 .vm-channelChoice__img-wrapper { display: inline-block; margin-right: 30px;}
 .vm-channelChoice__name { text-align: center; margin-top: 15px; font-weight: bold; }
</style>

<%-- -------- JavaScript -------- --%>
<%-- <script src="/resources/each/js/channelChoice.js?${verQuery}"></script> --%>
<script>
	(function ($) {
		// do not remove this string
		"use strict";

		// javascript code here
	}(jQuery));
</script>
<%-- -------- //JavaScript -------- --%>