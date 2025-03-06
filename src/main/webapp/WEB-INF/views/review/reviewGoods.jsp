<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath}"  />
<html>
<head>
<link rel="stylesheet" href="${contextPath}/resources/css/defaultStyle.css">
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Google Fonts -->
<link 
    href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" 
    rel="stylesheet">
<title>리뷰 상품 조회</title>
   <script type="text/javascript">
        // 선택된 상품 정보를 부모 페이지로 전달하고 팝업 닫기
        function selectProduct(productName, goods_id,seq_order_id) {
    // 부모 창의 필드에 값 설정
    window.opener.setSelectedProduct(productName, goods_id,seq_order_id);
    
    // 팝업 창 닫기
    window.close();
}
    </script>
    <style type="text/css">
        body {
             font-family: 'Noto Sans KR', sans-serif; /* Noto Sans KR 적용 */
            background-color: #f9f9f9;
        }

        .container {
            margin-top: 50px;
        }

        table {
            width: 100%;
            margin-bottom: 20px;
            border-collapse: collapse;
            border-radius : 3px;
        }

        th, td {
            padding: 15px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius : 3px;
        }

        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }

            .btn-custom {
        display: inline-block;
        padding: 10px 20px;
        font-size: 14px;
        border: 1px solid #ddd;
        border-radius : 3px;
        background-color: #fff;
        color: #000;
        text-decoration: none;
        cursor: pointer;
        margin: 0 10px;
    }
    .btn-custom:hover {
        background-color: #f0f0f0;
        color: #000 !important;
        border-radius : 3px;
    }

        .table-hover tbody tr:hover {
            background-color: #f5f5f5;
        }

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #f9f9f9;
        }

        .table-striped tbody tr:nth-of-type(even) {
            background-color: #ffffff;
        }
     	a {
			    text-decoration: none; /* 밑줄 제거 */
			    color: #333; /* 기본 텍스트 색상 */
			}
			
			/* ✅ 마우스 호버 시 색상 변경 */
			a:hover {
			    color: #D2B48C; /* 원하는 색상으로 변경 (여기서는 탠 색상) */
			     font-size: 1rem; /* 글자 크기 키우기 */
			    transition: color 0.3s ease-in-out; /* 부드러운 색상 전환 효과 */
			}
			/* ✅ 방문한 링크 스타일 (선택사항) */
			a:visited {
			    color: #0056b3; /* 방문한 후에도 보기 좋게 파란색 계열 유지 */
			}
    </style>
</head>
<body>
	<div class="container">
		<table>
			<thead>
                    <tr>
                    <td scope="col">주문 번호</td>
			        <td scope="col">상품</td>
			        <td scope="col">주문개수</td>
			        <td scope="col">결제 금액</td>
			        <td scope="col">결제 수단</td>
			        <td scope="col">배송 주소</td>
                    <td scope="col">결제 날짜</td>
                    <td scope="col">완료 날짜</td>
                    <td scope="col">선택</td>
                    </tr>
			</thead>

			<tbody>
			<c:choose>
				<c:when test="${not empty reviewList}">
					<c:forEach var="order" items="${reviewList}">
					<tr>
						<td>
						<a href="${contextPath}/order/orderResult.do?order_id=${order.order_id}" target="_blank">${order.seq_order_id}</a>
						</td>
						<td>
						<a href="${contextPath}/goods/goodsDetail.do?goods_id=${order.goods_id}" target="_blank">${order.goods_name}</a>
						</td>
						<td>${order.order_goods_qty}</td>
						<td><fmt:formatNumber value="${order.final_total_price}" pattern="#,###"/>원</td>
						<td>${order.card_com_name}</td>
						<td>${order.delivery_address}</td>
						<td><fmt:formatDate value="${order.pay_order_time}" pattern="yyyy-MM-dd HH:mm" /></td>
						<td><fmt:formatDate value="${order.complete_time}" pattern="yyyy-MM-dd HH:mm" /></td>
						<td><button onclick="selectProduct('${order.goods_name}', '${order.goods_id}','${order.seq_order_id}')" class="btn-custom">선택</button></td>
					</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr >
						<td colspan="9">리뷰할 상품이 없습니다.</td>
					</tr>
				
				</c:otherwise>
			</c:choose>
			</tbody>

		</table>
	</div>
</body>
</html>