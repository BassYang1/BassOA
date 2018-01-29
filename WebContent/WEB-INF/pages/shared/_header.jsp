<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="com.bass.oa.core.Constant" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${pageTitle }</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/content/framework/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/content/framework/css/font-awesome.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/content/css/base.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/content/css/app.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/content/css/form.css" />
<script src="${pageContext.request.contextPath}/content/js/jquery-2.1.4.min.js"></script>
<script src="${pageContext.request.contextPath}/content/js/jquery.cookie.js"></script>
<script src="${pageContext.request.contextPath}/content/framework/js/bootstrap.min.js"></script>

<script>
	var appDomain = "${pageContext.request.contextPath}";
	var tokenCookie = "<%=Constant.COOKIE_USER_TOKEN%>";
</script>

<script
	src="${pageContext.request.contextPath}/content/js/app.js">	
	</script>
</head>
