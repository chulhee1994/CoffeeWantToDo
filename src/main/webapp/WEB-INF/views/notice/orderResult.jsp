<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet" href="${contextPath}/resources/css/defaultStyle.css">
<meta charset="UTF-8">
<title>주문 완료</title>
<!-- Google Fonts -->
<link 
    href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" 
    rel="stylesheet">
<!-- Bootstrap CSS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
    * {
        font-family: 'Noto Sans KR', sans-serif;
    }
    body {
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
        color: #333;
    }
    .container {
        max-width: 1000px; 
        margin: 50px auto;
        background-color: #ECE6E6;
        padding: 40px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        border-radius: 3px;
    }
    .order-top {
        text-align: center;
        font-size: 24px;
        font-weight: 700;
        color: #000;
        margin-bottom: 30px;
        position: relative;
        padding-bottom: 10px; 
    }
    .order-top::after {
        content: "";
        display: block;
        width: 60px;
        height: 2px;
        background-color: #000;
        margin: 0 auto;
        position: absolute;
        left: 50%;
        transform: translateX(-50%);
        bottom: 0;
    }
    h2 {
        text-align: center;
        font-size: 18px;
        font-weight: 700;
        margin-top: 30px;
        color: #333;
    }
    .order-summary th, .order-summary td {
        text-align: center;
        vertical-align: middle;
        padding: 12px;
        font-size: 14px;
        word-wrap: break-word;
        border-bottom: 1px solid #e9e9e9;
    }
    .order-summary th {
        background-color: #f9f9f9;
        font-weight: 700;
        color: #333;
    }
    .order-summary td {
        background-color: #fff;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        margin-bottom: 20px;
        table-layout: fixed;
         border-radius: 3px;
    }
    .detailed-table th, .detailed-table td {
        border: 1px solid #e9e9e9;
        text-align: center;
        vertical-align: middle;
        padding: 12px;
        font-size: 14px;
        word-wrap: break-word;
    }
    .detailed-table th {
        background-color: #f9f9f9;
        font-weight: 700;
        color: #333;
    }
    .detailed-table td {
        background-color: #fff;
    }
     /* 버튼 공통 스타일 */
    .btn-custom {
        display: inline-block;
        border: 0.3px solid #ddd;
        border-radius: 3px;
        background-color: #fff;
        color: #000;
        font-size: 14px;
        padding: 10px 20px;
        text-decoration: none;
        cursor: pointer;
    }
    .btn-custom:hover {
        background-color: #f0f0f0;
        color: #000 !important;
        text-decoration: none;
        box-shadow: 0px 0px 1px 0px #fff; 
        border-radius : 3px;
    }
    .btn-area {
        text-align: center;
        margin-top: 30px;
    }
</style>
</head>
<body>
<!-- 헤더 include -->
<div class="header">
    <%@ include file="../common/header.jsp" %>
</div>
<div class="container">
    <div class="order-top">ORDER</div>

    <!-- 최종 주문 내역서 -->
    <h2>최종 주문 내역서</h2>
    <table class="order-summary">
        <thead>
            <tr>
                <th>주문번호</th>
                <th>상품명</th>
                <th>수량</th>
                <th>금액</th>
                <th>배송비</th>
                <th>적립금</th>
                <th>합계</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" begin="1" end="3">
                <tr>
                    <td>33</td>
                    <td>디카페인</td>
                    <td>1</td>
                    <td>220000</td>
                    <td>2500</td>
                    <td>200p</td>
                    <td>20,000</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- 배송지 정보 -->
  <h2>배송지 정보</h2>
<table class="detailed-table">
    <tbody>
        <tr>
            <th>받으실 분</th>
            <td>${deliveryInfo.recipientName != null ? deliveryInfo.recipientName : '정보 없음'}</td>
        </tr>
        <tr>
            <th>휴대폰번호</th>
            <td>${deliveryInfo.phoneNumber != null ? deliveryInfo.phoneNumber : '정보 없음'}</td>
        </tr>
        <tr>
            <th>주소</th>
            <td>${deliveryInfo.address != null ? deliveryInfo.address : '정보 없음'}</td>
        </tr>
        <tr>
            <th>배송 메시지</th>
            <td>${deliveryInfo.message != null ? deliveryInfo.message : '정보 없음'}</td>
        </tr>
        <tr>
            <th>선물 포장</th>
            <td>${deliveryInfo.giftWrap ? '포장함' : '포장 안 함'}</td>
        </tr>
    </tbody>
</table>


    <!-- 주문 고객 정보 -->
<h2>주문 고객 정보</h2>
<table class="detailed-table">
    <tbody>
        <tr>
            <th>이름</th>
            <td>${customerInfo.name != null ? customerInfo.name : '정보 없음'}</td>
        </tr>
        <tr>
            <th>핸드폰</th>
            <td>${customerInfo.mobile != null ? customerInfo.mobile : '정보 없음'}</td>
        </tr>
        <tr>
            <th>이메일</th>
            <td>${customerInfo.email != null ? customerInfo.email : '정보 없음'}</td>
        </tr>
    </tbody>
</table>

    <!-- 결제 정보 -->
<h2>결제 정보</h2>
<table class="detailed-table">
    <tbody>
        <tr>
            <th>결제방법</th>
            <td>${paymentInfo.method != null ? paymentInfo.method : '정보 없음'}</td>
        </tr>
        <tr>
            <th>결제카드</th>
            <td>${paymentInfo.cardName != null ? paymentInfo.cardName : '정보 없음'}</td>
        </tr>
        <tr>
            <th>카드번호</th>
            <td>${paymentInfo.cardNumber != null ? paymentInfo.cardNumber : '정보 없음'}</td>
        </tr>
        <tr>
            <th>할부기간</th>
            <td>${paymentInfo.installment != null ? paymentInfo.installment : '정보 없음'}</td>
        </tr>
    </tbody>
</table>

    <!-- 버튼 영역 -->
    <div class="btn-area">
        <a href="${contextPath}/main" class="btn-custom">쇼핑 계속하기</a>
        <a href="${contextPath}/order/confirmation" class="btn-custom">주문 확인하기</a>
    </div>
</div>

<!-- 푸터 include -->
<div class="footer">
    <%@ include file="../common/footer.jsp" %>
</div>
</body>
</html>
