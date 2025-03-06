<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <script type="text/javascript">const contextPath = "${contextPath}";</script>
    <script src="${contextPath}/resources/js/chatio.js" type="text/javascript"></script>    
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>날씨 기반 원두 추천</title>
    <!-- Bootstrap 4.5.2 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f7f7f7;
            font-family: 'Arial', sans-serif;
            background-image: url('https://example.com/background-image.jpg'); /* 배경 이미지 */
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        h2, h4 {
            color: #333;
        }
       /* 이미지 크기 고정 */
        .card-img-top {
            width: 200px;
            height: 200px;
            object-fit: cover;
            margin: 0 auto;
        }
        /* 카드 스타일 */
        .card {
            border-radius: 10px;
            border: none;
            background-color: #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px); /* 카드 hover 시 살짝 올라가도록 */
        }

        .card-body {
            padding: 30px;
            text-align: center;
        }

        .coffee-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 20px;
            border-bottom: 1px solid #e3e3e3;
            padding-bottom: 20px;
            transition: transform 0.3s ease; /* 카드 확대 효과 */
        }

        .coffee-item:hover {
            transform: scale(1.05); /* 카드 hover 시 확대 */
        }

        .coffee-item:last-child {
            border-bottom: none;
        }

        .coffee-item img {
            width: 90px;
            height: 90px;
            object-fit: cover;
            border-radius: 50%;
        }

        .coffee-info {
            flex-grow: 1;
            padding-left: 15px;
            text-align: left;
        }

        .coffee-info h5 {
            color: #75c0c0; /* 청록색으로 변경 */
            font-size: 18px;
            font-weight: bold;
        }

        .coffee-info p {
            color: #666;
            font-size: 14px;
            margin-top: 5px;
        }

        /* a 태그 스타일 */
        a {
            text-decoration: none; /* 밑줄 제거 */
            color: #75c0c0; /* 청록색 */
        }

        /* a 태그 호버 스타일 제거 */
        a:hover {
            color: #75c0c0; /* 호버 시에도 청록색 유지 */
        }

        .btn-buy {
            font-size: 14px;
            padding: 8px 15px;
            border: 2px solid #75c0c0;
            background-color: transparent;
            color: #75c0c0;
            border-radius: 30px;
            text-decoration: none;
            transition: all 0.3s;
        }

        .btn-buy:hover {
            background-color: #75c0c0;
            color: #fff;
            border-color: #75c0c0;
        }

        .btn-retry {
            font-size: 16px;
            padding: 10px 20px;
            border: 2px solid #000 !important;
            background-color: transparent;
            color: #000;
            border-radius: 30px;
            transition: all 0.3s;
        }

        .btn-retry:hover {
            background-color: transparent;
            color: #000;
            border-color: #000 !important;
            text-decoration: underline;
        }

        .section-title {
            margin-bottom: 30px;
        }

        /* 날짜 및 기온 등 텍스트 스타일 */
        .weather-info p {
            font-size: 18px;
            color: #333;
        }

        /* 미디어 쿼리: 화면 크기에 따라 레이아웃 조정 */
        @media (max-width: 767px) {
            .coffee-item {
                flex-direction: column;
                align-items: flex-start;
            }

            .coffee-info {
                padding-left: 0;
                margin-top: 10px;
            }
        }
    </style>

</head>
<body>

    <div class="header">
        <%@ include file="../common/header.jsp" %>
    </div>
    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow-lg">
                    <div class="card-body">
                        <h2 class="text-center section-title">날씨에 맞는 원두 추천</h2>

                        <!-- 날씨 정보 -->
                        <div class="weather-info text-center mb-4">
                             <div id="weather"></div>
                        </div>
                        <hr>

                        <h4>추천 원두:</h4>
                        <div class="row">
                            <!-- 카드 형식으로 상품 출력 -->
                            <c:forEach var="goods" items="${goodsList}">
                                <div class="col-md-4 mb-4">
                                    <div class="card">
                                        <img src="${contextPath}/image.do?goods_id=${goods.goods_id}&fileName=${goods.fileName}" class="card-img-top" alt="${goods.goods_name}">
                                        <div class="card-body">
                                            <h5 class="card-title">${goods.goods_name}</h5><span class="badge badge-primary">${goods.goods_c_note}</span> 
                                            <p class="card-text">${goods.goods_sales_price}원</p>
                                            <!-- 원두에 태그 추가 -->
                                            <a href="${contextPath}/goods/goodsDetail.do?goods_id=${goods.goods_id}" class="btn btn-custom">상세보기</a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.min.js"></script>
    <div class="footer">
        <%@ include file="../common/footer.jsp" %>
    </div>
</body>
</html>