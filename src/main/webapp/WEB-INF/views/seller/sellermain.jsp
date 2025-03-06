<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
  request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>4등분 레이아웃</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style>
        /* 본문 크기 원래대로 돌리고 좌우 여백만 줄이기 */
body {
    line-height: 1.5;
}

.header {
    margin-bottom: 30px;
}

.container-fluid {
    padding-left: 10% !important;
    padding-right: 10% !important;
}

/* 카드에 a 태그를 감쌌을 때, 카드 전체가 링크처럼 보이게 하기 위한 스타일 */
.card {
    position: relative;
    overflow: hidden;
    width: 100%; /* 카드가 부모 요소의 너비에 맞게 확장되도록 */
    min-height: 270px; /* 최소 카드 높이 설정 */
    display: flex;
    flex-direction: column;
    height: 200px; /* 카드 높이를 자동으로 설정 */
}

/* .a-link 클래스로 a 태그 스타일 변경 */
.a-link {
    color: #4bc0c0 !important;
    text-decoration: none !important;
}

.a-link:hover {
    color: #36a29f !important;
    text-decoration: underline !important;
}

/* 카드 이미지 및 본문에 스타일 추가 */
.card-img-top {
    width: 100%; /* 이미지를 카드 너비에 맞게 확장 */
    height: 150px; /* 이미지 높이를 고정 (이 값은 필요에 맞게 조정 가능) */
    object-fit: cover;
}

/* 카드 본문 스타일 */
.card-body {
    padding: 15px;
    flex-grow: 1;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

/* 상품 설명만 검은색으로 설정 */
.card-body p {
    color: black;
}

/* 테이블의 모서리 반경 설정 */
table {
    border-radius: 3px;
    overflow: hidden;
}

table th,
table td {
}

/* 캐러셀 관련 스타일 조정 */
.carousel-inner {
    display: flex;
    flex-direction: row;
    overflow: hidden;
}

/* 기존 카드 스타일을 5개씩 보이도록 변경 */
.carousel-item {
    display: block;
    width: 100%;
    display: flex;
    flex-direction: row; /* 가로로 정렬 */
    justify-content: space-between; /* 항목들 사이에 공간 추가 */
    height: 390px;
}

.carousel-item .col-2 {
    width: 18%; /* 5개의 항목을 넣기 위해 18%로 너비 설정 */
}

.carousel-item .book {
    width: 100%; /* 카드의 너비를 부모 요소에 맞게 설정 */
}


/* 상품이 없을 때의 텍스트 스타일 */
.carousel-item .card-body p {
    font-size: 1.2rem;
    color: #888;
    text-align: center;
    margin-top: 50px;
    height: 100px;
}

/* 빈 캐러셀 아이템의 스타일 */
.carousel-item.empty {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 400px; /* 빈 캐러셀에도 일정 높이 유지 */
    height: 400px; /* 고정 높이 추가 */
}

.carousel-item.empty .card-body {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 300px;
    text-align: center;
    padding: 20px; /* 여백 추가 */
}

.carousel-item.empty .card-body p {
    color: #aaa;
    font-size: 1.2rem;
    margin-top: 0; /* 기본 여백 제거 */
}

/* 캐러셀 제어 버튼 스타일 (좌우 화살표 버튼) */
.carousel-control-prev,
.carousel-control-next {
    z-index: 10;
}

.carousel-control-prev-icon,
.carousel-control-next-icon {
    background-color: rgba(0, 0, 0, 0.5);
}

#productSectionBeans , #productSectionBakery , #productSectionCoffee {
    width: 100%;  /* 넓이를 100%로 설정 */
}

#Brow {
    margin-left: 90px;
}

    .review-rating {
        font-size: 1rem;
        color: #f5c518;
    }
    .review_title {
	text-decoration: none; 
	color: #333; 
	font-weight: bold;
}


.review_title:hover {
	color: #0056b3; 
	transition: color 0.3s ease-in-out; 
}
    
    
    </style>
</head>
<body>
  <div class="header">
    <%@ include file="../common/header.jsp" %>
  </div>

  <div class="container-fluid">
    <div class="row">
    
      <!-- 왼쪽 위 (상품 목록) -->
<div class="col-md-6 mb-5">

               <div>
                <h3 class="mb-3">월 매출</h3>
                <canvas id="monthlySalesChart"></canvas>
                <div id="monthlySalesData" 
data-months="${monthlySalesData[0].month},${monthlySalesData[1].month},${monthlySalesData[2].month},${monthlySalesData[3].month},${monthlySalesData[4].month},${monthlySalesData[5].month}" 
data-sales="${monthlySalesData[0].totalSales},${monthlySalesData[1].totalSales},${monthlySalesData[2].totalSales},${monthlySalesData[3].totalSales},${monthlySalesData[4].totalSales},${monthlySalesData[5].totalSales}"></div>

                </div>
 

</div>





      <!-- 오른쪽 위 (일 매출 그래프) -->
      <!-- 일 매출 및 월 매출 차트 -->
            <div class="col-md-6 mb-5">
                <div>
                <h3 class="mb-3">일 매출</h3>

                <canvas id="dailySalesChart"></canvas>
                <div id="salesData" 
                     data-dates="${dailySalesData[6].orderDate},${dailySalesData[5].orderDate},${dailySalesData[4].orderDate},${dailySalesData[3].orderDate},${dailySalesData[2].orderDate},${dailySalesData[1].orderDate},${dailySalesData[0].orderDate}" 
                     data-sales="${dailySalesData[6].totalSales},${dailySalesData[5].totalSales},${dailySalesData[4].totalSales},${dailySalesData[3].totalSales},${dailySalesData[2].totalSales},${dailySalesData[1].totalSales},${dailySalesData[0].totalSales}"></div>
                <div class="mb-3">
                    <label for="startDate">시작 날짜:</label>
                    <input type="date" id="startDate" class="form-control">
                </div>
                </div>
  

        <script>
            // 일 매출 차트
            var salesDataElement = document.getElementById('salesData');
            var dates = salesDataElement.getAttribute('data-dates').split(',');
            var sales = salesDataElement.getAttribute('data-sales').split(',');
            var salesDataMap = {};

            for (var i = 0; i < dates.length; i++) {
                salesDataMap[dates[i]] = sales[i];
            }

            var dailyCtx = document.getElementById('dailySalesChart').getContext('2d');
            var dailySalesChart = new Chart(dailyCtx, {
                type: 'line',
                data: {
                    labels: [],
                    datasets: [{
                        label: '일 매출',
                        data: [],
                        borderColor: 'rgba(75, 192, 192, 1)',
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        fill: false
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        x: { title: { display: true, text: '날짜' } },
                        y: { title: { display: true, text: '매출 (원)' } }
                    }
                }
            });

            document.getElementById('startDate').addEventListener('change', function() {
                var startDate = new Date(this.value);
                var endDate = new Date(startDate);
                endDate.setDate(startDate.getDate() + 6);
                updateDailyChart(startDate.toISOString().split('T')[0], endDate.toISOString().split('T')[0]);
            });

            function updateDailyChart(startDate, endDate) {
                if (startDate && endDate) {
                    var filteredDates = [];
                    var filteredSales = [];
                    var currentDate = new Date(startDate);
                    var lastDate = new Date(endDate);

                    while (currentDate <= lastDate) {
                        var formattedDate = currentDate.toISOString().split('T')[0];
                        filteredDates.push(formattedDate);

                        if (salesDataMap[formattedDate]) {
                            filteredSales.push(salesDataMap[formattedDate]);
                        } else {
                            filteredSales.push(0);
                        }

                        currentDate.setDate(currentDate.getDate() + 1);
                    }

                    dailySalesChart.data.labels = filteredDates;
                    dailySalesChart.data.datasets[0].data = filteredSales;
                    dailySalesChart.update();
                }
            }

            // 월 매출 차트
            var monthlySalesDataElement = document.getElementById('monthlySalesData');
            var monthlyMonths = monthlySalesDataElement.getAttribute('data-months').split(',');
            var monthlySales = monthlySalesDataElement.getAttribute('data-sales').split(',');

            var monthlyCtx = document.getElementById('monthlySalesChart').getContext('2d');
            var monthlySalesChart = new Chart(monthlyCtx, {
                type: 'bar',
                data: {
                    labels: monthlyMonths,
                    datasets: [{
                        label: '월 매출',
                        data: monthlySales,
                        backgroundColor: 'rgba(255, 99, 132, 0.2)',
                        borderColor: 'rgba(255, 99, 132, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        x: { title: { display: true, text: '월' } },
                        y: { title: { display: true, text: '매출 (원)' } }
                    }
                }
            });
        </script>
        </div>
        </div> <!-- row end -->

    <div class="row">
    <!-- 왼쪽 아래 (리뷰 게시판) -->
    <h3 class="mb-4">리뷰 게시판</h3>
    <!-- 리뷰 목록 출력 -->
<table border="1">
        <thead style="background-color: #D2B48C;">
            <tr>
                <th class="text-center">번호</th>
                <th class="text-center">제목</th>
                <th class="text-center">내용</th>
                <th class="text-center">작성일</th>
                <th class="text-center">별점</th>
            </tr>
        </thead>
        <tbody>
        <c:choose>
        	<c:when test="${empty reviewList }">
        		<td class="text-center" style="text-align: center; margin-top: 10px; " colspan="4">작성된 리뷰글이 없습니다. </td>
        	</c:when>
  			<c:otherwise>
            <c:forEach var="review" items="${reviewList}">
                <tr>
                    <td class="text-center">${review.review_no}</td>
                    <td class="text-center">
                    <a class="review_title" href="${contextPath}/review/viewReview.do?review_no=${review.review_no}">
                    
                  <c:choose>
				    <c:when test="${fn:length(review.review_title) > 20}">
				        ${fn:substring(review.review_title, 0, 20)}...
				    </c:when>
				    <c:otherwise>
				        ${review.review_title}
				    </c:otherwise>
				</c:choose>
                     </a>
                    </td>
                    
                    
                    <td class="text-center">
					    <c:choose>
					        <c:when test="${fn:length(review.review_content) > 20}">
					            ${fn:substring(review.review_content, 0, 20)}...
					        </c:when>
					        <c:otherwise>
					            ${review.review_content}
					        </c:otherwise>
					    </c:choose>
					</td>

                    
                    
                    <td class="text-center"> <fmt:formatDate value="${review.review_writedate}" pattern="yyyy-MM-dd HH:mm"/></td>
                    
                    <td class="text-center">
                    <div class="review-rating">
				<c:forEach var="i" begin="1" end="${review.review_star}">
   				 ★
				</c:forEach>
				</div>
                    
                    </td>
                </tr>
            </c:forEach>
  			</c:otherwise>      
        </c:choose>
      
        </tbody>
    </table>
</div>

  
  
  
</div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
  <div class="footer">
    <%@ include file="../common/footer.jsp" %>
  </div>
</body>
</html>

