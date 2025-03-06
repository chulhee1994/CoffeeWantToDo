<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <script type="text/javascript">const contextPath = "${contextPath}";</script>
    <script src="${contextPath}/resources/js/chatio.js" type="text/javascript"></script>
<meta charset="UTF-8">
</head>
<body>
<h1>개인정보 동의내역 수정</h1>
<form action="${contextPath}/member/modInfo.do" method="post">
    <table>
    <tr><td><input type="hidden" name="mem_id" value="${member.mem_id}" /></td></tr>
        <tr class="dot_line">
            <td class="fixed_join">쇼핑몰에서 발송하는 SMS 소식 수신 동의</td>
            <td>
                <input type="radio" name="mem_telsts_yn" value="Y" /> 수신
                <input type="radio" name="mem_telsts_yn" value="N" /> 수신 안함
            </td>
        </tr>
        <tr class="dot_line">
            <td class="fixed_join">쇼핑몰에서 발송하는 이메일 소식 수신 동의</td>
            <td>
                <input type="radio" name="mem_emailsts_yn" value="Y" /> 수신
                <input type="radio" name="mem_emailsts_yn" value="N" /> 수신 안함
            </td>
        </tr>
        <tr class="dot_line">
            <td>
                <input type="submit" value="변경 하기"/>
            </td>
        </tr>
    </table>
</form>
</body>
</html>
