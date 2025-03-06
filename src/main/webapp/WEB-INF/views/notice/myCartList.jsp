<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="utf-8"
	isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${contextPath}/resources/css/defaultStyle.css">
<title>장바구니</title>
<!-- Google Fonts -->
<link 
    href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" 
    rel="stylesheet">
<head>
<style>
	*{
		  font-family: 'Noto Sans KR', sans-serif;
	}
  body {
         color: #333;
    }

       /* 메인 컨테이너 */
    .container {
        max-width: 1000px; 
        margin: 50px auto; 
        background-color: #fff;
        padding: 40px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        border-radius : 3px;
    }
	
	 /* 상단 CART 텍스트 (가운데 정렬 + 밑줄) */
    .cart-top {
        text-align: center;
        font-size: 24px;
        font-weight: 700;
        color: #000;
        margin-bottom: 30px;
        position: relative;
        padding-bottom: 10px; 
    }
    .cart-top::after {
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
	
.table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
    border-radius : 3px;
}

.table th, .table td {
    text-align: center;
    padding: 12px;
    border-bottom: 1px solid #ddd;
    border-radius : 3px;
}

.table th {
    background-color: #f4f4f4;
    font-weight: bold;
}

.table-group-divider {
    border-top: 2px solid #eee;
    border-radius : 3px;
}

    /* 버튼 공통 스타일 (검정 글씨, 직선 모서리) */
    .btn-custom {
        display: inline-block;
        border: 1px solid #ddd;
       border-radius : 3px;
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
        border-radius : 3px;
    }

.btn-lg {
    padding: 12px 30px;
    font-size: 18px;
}

.buttonRow {
    text-align: center;
    margin: 30px 0;
}

.inputQty {
    text-align: center;
    width: 60px;
    padding: 5px;
    border: 1px solid #ddd;
    border-radius : 3px;
    font-family: 'Noto Sans', sans-serif; /* 고딕스러운 스타일 적용 */
    font-size: 14px;
}

.fs-3 {
    font-size: 1.5rem;
    font-weight: bold;
}

.mt-3 {
    margin-top: 1rem;
}

.mt-5 {
    margin-top: 3rem;
}

.w-75 {
    width: 75%;
    display: contents;
}

.clear {
    clear: both;
}

.text-center {
    text-align: center;
}

.inline-content {
    display: flex;
    align-items: center;
    justify-content: flex-start;
    gap: 10px;
}

.inline-content img {
    margin-right: 10px;
}

.goods_id{
	text-decoration: none;
	color: black;
}
</style>
<script type="text/javascript">

</script>
</head>
<body>
<div class="header">
    <%@ include file="../common/header.jsp" %>
</div>

<div class="container">

	<div class="text-center mt-5">
	   <div class="cart-top">CART</div>
	</div>

	<div class="tableContainer w-75">
		<table class="table">
			<thead>
				<tr>
					<th>구분</th>
					<th>상품명</th>
					<th>정가</th>
					<th>판매가</th>
					<th>수량</th>
					<th>배송비</th>
					<th>포인트</th>
					<th>합계</th>
					<th>주문</th>
				</tr>
			</thead>
			<tbody class="table-group-divider">
			<form name="frm_order_all_cart">
				<td>
					<input type="checkbox">
				</td>

				<td>
					<div class="inline-content">
						<img width="75" alt="" src="${contextPath}/resources/images/다크블루.png" />
						<a href="${contextPath}/goods/goodsDetail.do?goods_id=#" class="goods_id">다크 블루</a>
					</div>
				</td>
				
				<td><span>11000원</span></td>
				<td><span>10000원</span></td>
				
				<td><input type="number" class="inputQty" min="1" value="1"></td>
				
				<td>2500원</td>
				<td>10P</td>
				<td>10000원</td>
				
				<td>
					<a href="#" class="btn-custom">주문</a>
					<a href="#" class="btn-custom">삭제</a>
				</td>
			</form>
			</tbody>
		</table>
	</div>

	<div class="tableContainer2 w-75 mt-3 ">
		<table class="table">
			<thead>
				<tr>
					<th>총 상품수</th>
					<th>총 상품 금액</th>
					<th>총 배송비</th>
					<th>총 할인 금액</th>
					<th>최종 결제금액</th>
				</tr>
			</thead>
			<tbody class="table-group-divider">
				<tr>
					<td id="p_totalGoodsNum" class="fs-3">1개</td>
					<td id="p_final_totalPrice" class="fs-3">10000원</td>
					<td id="p_totalDeliveryPrice" class="fs-3">2500원</td>
					<td id="p_final_totalPrice" class="fs-3">10000원</td>
					<td id="p_final_totalPrice" class="fs-3">10000원</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="buttonRow">
		<a  class="btn-custom" href="${contextPath}/goods/goodsList.do">쇼핑 계속하기</a>
		<a  class="btn-custom" href="${contextPath}/order/orderAllCartGoods.do">주문하기</a>
		
	</div>
</div>
<!-- 푸터 include -->
<div class="footer">
    <%@ include file="../common/footer.jsp" %>
</div>

</body>
