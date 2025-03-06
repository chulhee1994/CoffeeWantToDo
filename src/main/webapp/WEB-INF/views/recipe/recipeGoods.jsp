<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>상품 목록</title>
<style>
table {
    width: 100%;
    border-collapse: collapse; /* ✅ 이중 보더 제거 */
    margin-top: 20px;
    border: 1px solid #ddd; /* 테이블 전체 보더 추가 */
}

th, td {
    border: 1px solid #ddd; /* ✅ 단일 보더 유지 */
    padding: 10px;
    text-align: center;
}

th {
    background-color: #f8f8f8;
}
.btn-select {
	cursor: pointer;
	padding: 5px 10px;
	background: #007bff;
	color: white;
	border: none;
}

.product-cell {
    display: flex;
    align-items: center; /* 이미지와 텍스트를 세로 중앙 정렬 */
    gap: 10px; /* 이미지와 텍스트 사이 여백 */
    justify-content: flex-start; /* 왼쪽 정렬 (기본) */
    border: none; /* ✅ 개별적인 테두리 제거 */
}

td.product-cell {
    border-bottom: 1px solid #ddd; /* ✅ 옆의 보더 유지 */
}


.image-thumbnail {
	width: 75px;
	height: 75px;
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
	border-radius: 3px;
}
</style>
<script>
function selectProduct(goodsId, goodsName) {
    opener.setSelectedProduct(goodsName, goodsId); // 부모창으로 값 전달
    window.close(); // 팝업창 닫기
}
</script>
</head>
<body>

<h2>상품 목록 (${role == 'admin' ? '전체 상품' : '내 상품'})</h2>

<table>
    <thead>
        <tr>
            <th>상품 ID</th>
            <th>상품</th>
            <th>재고</th>
            <th>정가</th>
            <th>할인가격</th>
            <th>선택</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="goods" items="${goodsList}">
            <tr>
                <td>${goods.goods_id}</td>
                <td class="product-cell">
                <img src="${contextPath}/image.do?goods_id=${goods.goods_id}&fileName=${goods.fileName}" class="image-thumbnail">
                <span>${goods.goods_name}</span>
                </td>
                
                <td>
                <fmt:formatNumber value="${goods.goods_stock}" pattern="#,###"/>개
                </td>
                
                <td>
                <fmt:formatNumber value="${goods.goods_price}" pattern="#,###"/>원
                </td>
                <td>
                <fmt:formatNumber value="${goods.goods_sales_price}" pattern="#,###"/>원
                </td>
                <td>
                    <button class="btn-custom" onclick="selectProduct('${goods.goods_id}', '${goods.goods_name}')">선택</button>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

</body>
</html>
