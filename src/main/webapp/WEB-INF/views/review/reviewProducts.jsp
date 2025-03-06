<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        function selectProduct(productName, goods_id) {
    // 부모 창의 필드에 값 설정
    window.opener.setSelectedProduct(productName, goods_id);
    
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
    </style>
</head>
<body>
	<div class="container">
		<table>
			<thead>
                    <tr>
                    <td scope="col">주문 번호</td>
			        <td scope="col">이미지</td>
                    <td scope="col">상품명</td>
                    <td scope="col">주문 날짜</td>
                    <td scope="col">선택</td>
                    </tr>
			</thead>

			<tbody>
				 <tr>
					<td>1</td>
					<td><img src="${contextPath}/resources/images/coffee1.jpg" alt="상품 1" style="width: 50px; height: 50px;"></td>
					<td>딜라이트 블랜드</td>
					<td>2025-01-09</td>
					<td><button onclick="selectProduct('딜라이트 블랜드', '101')" class="btn-custom">선택</button></td>
				</tr>

				 <tr>
					<td>2</td>
					<td><img src="${contextPath}/resources/images/coffee2.jpg" alt="상품 2" style="width: 50px; height: 50px;"></td>
					<td>딜라이트 라이트</td>
					<td>2025-01-08</td>
					<td><button onclick="selectProduct('딜라이트 라이트', '102')" class="btn-custom">선택</button></td>
				</tr>
			</tbody>

		</table>
	</div>
</body>
</html>