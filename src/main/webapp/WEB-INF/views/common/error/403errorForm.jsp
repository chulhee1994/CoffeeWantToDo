<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="p" uri="http://java.sun.com/jsp/jstl/core" %>
<p:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>Error</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .error-container {
            text-align: center;
            margin: 100px auto;
            max-width: 800px;
        }
        .error-title {
            font-size: 48px;
            font-weight: bold;
            color: #dc3545;
        }
        .error-message {
            font-size: 18px;
            margin-top: 10px;
            font-weight: bold;
        }
        .error-image {
            width: 100%;
            max-width: 500px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
   <div class="container error-container">
        <img src="${contextPath}/resources/images/403error.png" alt="403 Error" class="error-image">
        <h1 class="error-title">관리자 권한이 필요합니다.</h1>
        <p class="error-message">죄송합니다! 해당 페이지에 접근하려면 관리자 권한이 필요합니다.<br><br>
        만약 이 문제가 지속된다면 관리자에게 문의해 주세요.</p>
        <a href="${contextPath}/" class="btn btn-dark">홈으로 돌아가기</a>     
    </div>
</body>
</html>