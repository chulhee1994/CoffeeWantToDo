<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>주문 완료</title>
    <script type="text/javascript">const contextPath = "${contextPath}";</script>
    <script src="${contextPath}/resources/js/chatio.js" type="text/javascript"></script>
<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
	rel="stylesheet">
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
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
	background-color: #fff;
	padding: 40px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
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

.divider {
	margin: 40px 0;
	border-top: 1px solid #ccc;
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
	vertical-align: middle;
	padding: 12px;
	font-size: 14px;
	word-wrap: break-word;
}

.detailed-table th {
	text-align: center;
	background-color: #f9f9f9;
	font-weight: 700;
	color: #333;
	width: 15%;
}
.detailed-table td{
	text-align: left;
	width: 50%;

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
	border-radius: 3px;
}

.btn-area {
	text-align: center;
	margin-top: 30px;
}
.order-id-container {
    text-align: center;  /* 중앙 정렬 */
    margin: 20px 0;  /* 위아래 여백 */
}

.order-id {
    font-size: 15px;  /* 글자 크기 */
    font-weight: bold; /* 글자 굵기 */
    color: #333; /* 글자 색상 */
    background-color: #f9f9f9; /* 배경색 */
    padding: 10px 20px; /* 패딩 */
    display: inline-block; /* 박스 형태로 출력 */
    border-radius: 10px; /* 모서리 둥글게 */
    border: 2px solid #ddd; /* 테두리 */
}
</style>
<script type="text/javascript">
(function() {
    var w = window;
    if (w.ChannelIO) {
        return w.console.error("ChannelIO script included twice.");
    }
    var ch = function() {
        ch.c(arguments);
    };
    ch.q = [];
    ch.c = function(args) {
        ch.q.push(args);
    };
    w.ChannelIO = ch;

    function l() {
        if (w.ChannelIOInitialized) {
            return;
        }
        w.ChannelIOInitialized = true;
        var s = document.createElement("script");
        s.type = "text/javascript";
        s.async = true;
        s.src = "https://cdn.channel.io/plugin/ch-plugin-web.js";
        var x = document.getElementsByTagName("script")[0];
        if (x.parentNode) {
            x.parentNode.insertBefore(s, x);
        }
    }
    if (document.readyState === "complete") {
        l();
    } else {
        w.addEventListener("DOMContentLoaded", l);
        w.addEventListener("load", l);
    }
})();

ChannelIO('boot', {
    "pluginKey": 'a0ac98cf-93df-4eac-88ff-be0aaffa661f'
});



</script>


</head>
<body>
	<!-- 헤더 include -->
	<div class="header">
		<%@ include file="../common/header.jsp"%>
	</div>
	<div class="container">
		<div class="order-top">ORDER</div>

		<!-- 최종 주문 내역서 -->
		<h2>최종 주문 내역서</h2>
		<div class="order-id-container">
	  	  <p class="order-id">주문 아이디 : ${firstOrder.t_id}</p>
		</div>
		<table class="order-summary">
		
			<thead>
				<tr>
					<th>주문번호</th>
					<th>상품명</th>
					<th>수량</th>
					<th>금액</th>
					<th>적립금</th>
					<th>합계</th>
				</tr>
			</thead>
			<tbody>
			<c:set var="totalSalesPrice" value="0" />
			<c:set var="totalPoints" value="0" />
			<c:forEach var="order" items="${orderList}">
					<tr>
			  <td>${order.seq_order_id}</td>
            <td>${order.goodsVO.goods_name}</td>
            <td>${order.order_goods_qty}개</td>
            <td><fmt:formatNumber value="${order.goodsVO.goods_sales_price}" pattern="#,###"/>원</td>
            <td><fmt:formatNumber value="${order.goodsVO.goods_point}" pattern="#,###"/>P</td>
            <td><fmt:formatNumber value="${order.order_total_price}" pattern="#,###"/>원</td>
					</tr>
					

								   <%-- ✅ 총합 계산 (각 상품의 가격 * 수량) --%>
			    <c:set var="totalSalesPrice" value="${totalSalesPrice + (order.order_goods_qty * order.goodsVO.goods_sales_price)}" />
			    <c:set var="t_id" value="${order.t_id}" />
			    
			    <%-- ✅ 총 적립금 계산 --%>
			     <c:set var="totalPoints" value="${totalPoints + (order.order_goods_qty * order.goodsVO.goods_point)}" />
							</c:forEach>	

					
					<tr>
						<th colspan="3">총 합계</th>
						<th colspan="3">총 적립금</th>
					</tr>
					
					<tr>
				    <td colspan="3"><fmt:formatNumber value="${totalSalesPrice}" pattern="#,###"/>원</td>
       				<td colspan="3"><fmt:formatNumber value="${totalPoints}" pattern="#,###"/>P</td>
					</tr>				
			</tbody>
		</table>
		
		<div class="divider"></div>
	
		<!-- 배송지 정보 -->
		<h2>배송지 정보</h2>
		<table class="detailed-table">
			<tbody>
				<tr>
					<th>받으실 분</th>
					  <td>${firstOrder.receiver_name}</td>
				</tr>
				<tr>
					<th>휴대폰번호</th>
					<td>${firstOrder.receiver_tel1}-${firstOrder.receiver_tel2}-${firstOrder.receiver_tel3}</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>${firstOrder.delivery_address}</td>
				</tr>
				<tr>
					<th>배송 메시지</th>
					<td>${firstOrder.delivery_message != null ? firstOrder.delivery_message : '배송 메세지 없음'}</td>
				</tr>
				<tr>
					<th>선물 포장</th>
					<td>
						<c:choose>
							<c:when test="${firstOrder.gift_wrapping == 'Y'}">포장</c:when>
							<c:otherwise>포장 안함</c:otherwise>
						</c:choose>
						</td>
				</tr>
			</tbody>
		</table>

		<div class="divider"></div>
		<!-- 주문 고객 정보 -->
		<h2>주문 고객 정보</h2>
		<table class="detailed-table">
			<tbody>
				<tr>
					<th>이름</th>
					 <td>${firstOrder.orderer_name}</td>
				</tr>
				<tr>
					<th>핸드폰</th>
  					<td>${firstOrder.pay_orderer_hp_num}</td>
				</tr>
				<tr>
					<th>이메일</th>
 					<td>${firstOrder.memberVO.mem_email1}@${firstOrder.memberVO.mem_email2}</td> 
				</tr>
			</tbody>
		</table>

		<div class="divider"></div>
		<!-- 결제 정보 -->
		<h2>결제 정보</h2>
		<table class="detailed-table">
			<tbody>
				<tr>
					<th>결제방법</th>
					<td>${firstOrder.pay_method}</td>
				</tr>
				
				
	

<c:set var="cardInfo" value="${firstOrder.card_com_name}" />

<!-- 카드사 정보 추출 -->
<c:set var="startIdx" value="${fn:indexOf(cardInfo, '[') + 1}" />
<c:set var="endIdx" value="${fn:indexOf(cardInfo, ']')}" />
<c:set var="cardCompany" value="${fn:substring(cardInfo, startIdx, endIdx)}" />

<!-- 카드번호 정보 추출 -->
<c:set var="cardNumberStart" value="${fn:indexOf(cardInfo, ']') + 2}" />
<c:set var="cardNumber" value="${fn:substring(cardInfo, cardNumberStart, fn:length(cardInfo))}" />

<tr>
    <th>결제카드</th>
    <td>${cardCompany}</td>
</tr>
<tr>
    <th>카드번호</th>
    <td>${cardNumber}</td>
</tr>

				
				<tr>
					<th>할부기간</th>
					<td>
 <c:choose>
        <c:when test="${not empty firstOrder.card_pay_month and firstOrder.card_pay_month != '0'}">
            ${firstOrder.card_pay_month}개월
        </c:when>
        <c:otherwise>
            일시불
        </c:otherwise>
    </c:choose></td>
    
				</tr>
			</tbody>
		</table>

		<div class="divider"></div>
		<!-- 버튼 영역 -->
		<div class="btn-area">
			<a href="${contextPath}/goods/goodsListBean.do?goods_category=원두" class="btn-custom">쇼핑 계속하기</a>
			 <a href="${contextPath}/mypage/myPageUsers.do" class="btn-custom">주문 내역</a>
		</div>
	</div>

	<!-- 푸터 include -->
	<div class="footer">
		<%@ include file="../common/footer.jsp"%>
	</div>
</body>
</html>
