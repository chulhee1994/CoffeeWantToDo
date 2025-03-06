<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
  request.setCharacterEncoding("UTF-8");
%>
<c:set var="`"  value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 대시보드</title>
    <!-- Bootstrap 4 or 5 CSS 포함 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Chart.js CSS 포함 -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .dashboard-card {
            height: 150px;
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            border-radius: 10px;
        }

        /* 그래프 컨테이너 */
        .graph-container {
            margin-top: 30px;
            display: flex;
            justify-content: center; /* 가로 중앙 정렬 */
            align-items: center; /* 세로 중앙 정렬 */
            width: 100%;
        }

        /* 그래프 */
        #monthlyChart {
            width: 100%;  /* 가로 크기를 100%로 설정 */
            height: 60%; /* 세로는 고정 높이로 설정 */
        }

        /* 구역을 나눈 div 스타일 */
        .section-div {
            height: 250px;
            background-color: transparent; /* 카드처럼 보이는 배경색 제거 */
            border: none; /* 테두리 없앰 */
            border-radius: 0; /* 모서리 둥글게 하지 않음 */
            display: block; /* 중앙 정렬 스타일을 없앴음 */
            text-align: left; /* 텍스트를 왼쪽 정렬로 설정 */
        }

        /* 대시보드 제목 스타일 */
        .dashboard-header {
            font-size: 2rem;
            font-weight: bold;
            color: #343a40;
            margin-bottom: 30px;
        }

        /* 캐러셀 크기 및 스타일 수정 */
        #productCarouselBeans {
            width: 100%;
            height: 100%;
            overflow-y: auto; /* 세로 스크롤 가능 */
            margin-top: 30px; /* 캐러셀 위쪽 여백 */
            margin-bottom: 30px; /* 캐러셀 아래쪽 여백 */
        }

        .carousel-item {
            display: flex;
            flex-direction: row;
            justify-content: center;
            text-align: center;
            height: auto;
        }

        .carousel-item img {
            width: 100%; /* 이미지 가로 크기 100%로 설정 */
            height: 250px; /* 이미지 높이 설정 */
            object-fit: cover; /* 이미지 비율에 맞게 자르기 */
        }

        .carousel-item .card-body {
            margin-top: 10px;
        }

        .carousel-item .card-body h5 {
            font-size: 1.1rem;
            margin: 5px 0;
        }

        .carousel-item .card-body .old-price {
            text-decoration: line-through;
            color: gray;
        }

        .carousel-item .card-body .new-price {
            color: #e74c3c;
            font-weight: bold;
        }

        .carousel-item .col-3 {
            padding: 15px; /* 상품 간 간격 추가 */
        }

        /* 캐러셀 제어 버튼 */
        .carousel-control-prev, .carousel-control-next {
            top: 50%;
            transform: translateY(-50%);
        }

        /* 추가된 위 아래 공간 */
        .additional-space {
            height: 50px;  /* 원하는 공간의 높이 */
        }

        /* 미디어 쿼리 - 반응형 디자인 적용 */
        @media (max-width: 1200px) {
            .dashboard-header {
                font-size: 1.8rem;
            }

            .carousel-item img {
                height: 200px; /* 화면 크기가 작을 경우 이미지 크기 조정 */
            }

            .dashboard-card {
                height: 120px;
            }
        }

        @media (max-width: 768px) {
            .carousel-item img {
                height: 200px; /* 모바일 크기일 때 이미지 크기 조정 */
            }

            .dashboard-header {
                font-size: 1.6rem;
            }

            .dashboard-card {
                height: 100px;
            }

            .row-custom {
                flex-direction: column;
            }

            #productCarouselBeans .carousel-item {
                flex-direction: row;
                flex-wrap: wrap;
                justify-content: center;
            }

            .additional-space {
                height: 30px;  /* 모바일에서는 공간을 좀 더 적게 할 수 있음 */
            }
        }

        @media (max-width: 576px) {
            .dashboard-header {
                font-size: 1.4rem;
            }

            .carousel-item img {
                height: 150px; /* 모바일 작은 화면에서 이미지 크기 조정 */
            }

            .dashboard-card {
                height: 80px;
            }

            .carousel-item .card-body h5 {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <%@ include file="../common/header.jsp" %>
    </div>
    <div class="container mt-5">
        <!-- 대시보드 제목 -->
        <div class="dashboard-header">
            WTD DashBoard
        </div>

        <!-- 카드 영역 -->
        <div class="row mb-4">
            <div class="col-md-4 col-sm-12">
                <div class="dashboard-card">
                    <div>
                        <h5 class="card-title">WTD 월 매출</h5>
                       <p id="monthly-sales">
						    ₩<fmt:formatNumber value="${monthlySalesData[0].totalSales}" pattern="#,###" />
						</p></div>
                </div>
            </div>
            <div class="col-md-4 col-sm-12">
                <div class="dashboard-card">
                    <div>
                        <h5 class="card-title">WTD 회원수</h5>
                        <p id="total-members">${commonUserCount}명</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-sm-12">
                <div class="dashboard-card">
                    <div>
                        <h5 class="card-title">WTD 월 주문상품수</h5>
                        <p id="monthly-orders">${monthlyOrderCount[0]['MONTH']} 월 주문수 ${monthlyOrderCount[0]['ORDER_COUNT']}건</p>
                   
                    </div>
                </div>
            </div>
        </div>

        <!-- 월 매출 그래프 -->
		<h2>업체별 월 매출</h2>
		<label for="seller">회사명:</label>
        <select id="seller"> 
        	<option>업체명을 선택하세요</option>
            <c:forEach items="${sellerList}" var="itm">
                <option value="${itm.mem_id}">${itm.mem_cmp_name}</option>
            </c:forEach>
        
        </select>
        <!-- 월매출 차트 start -->
        <div class="graph-container">
		    <canvas id="monthlyChart"></canvas>
		</div>

    <!-- 상품 캐러셀 -->
<div class="row-custom mb-4">
    <div class="col-custom">
        <h5 class="card-title">새로 등록된 원두</h5>
        
        <!-- goodsList가 null이거나 비어있을 경우 메시지 출력 -->
        <c:if test="${empty goodsList}">
            <p>현재 등록된 원두 상품이 없습니다.</p>
        </c:if>
        
        <c:if test="${not empty goodsList}">
            <div id="productCarouselBeans" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <!-- 상품을 4개씩 보여주는 페이지로 분할 -->
                    <c:forEach var="i" begin="0" end="${fn:length(goodsList)/4 - 1}">
                        <div class="carousel-item ${i == 0 ? 'active' : ''}">
                            <div class="row justify-content-center">
                                <!-- 상품 4개씩 보이게 (0~3, 4~7, ...) -->
                                <c:forEach var="goods" items="${goodsList}" begin="${i*4}" end="${i*4+3}">
                                    <c:if test="${goods.goods_category == '원두'}">
                                        <div class="col-12 col-md-3">
                                            <div class="book card h-100">
                                                <a href="${contextPath}/admin/goods/modGoodsForm.do?goods_id=${goods.goods_id}">
                                                    <img src="${contextPath}/image.do?goods_id=${goods.goods_id}&fileName=${goods.fileName}" 
                                                         class="card-img-top product-img" alt="${goods.goods_name}">
                                                </a>
                                                <div class="card-body">
                                                    <h5 class="card-title">${goods.goods_name}</h5>
                                                    <p class="card-text">
                                                        
                                                       <span class="new-price">
                                                            <fmt:formatNumber value="${goods.goods_sales_price}" pattern="#,###원" />
                                                        </span>
                                                         <a href="${contextPath}/admin/goods/modGoodsN.do?goods_id=${goods.goods_id}" class="btn btn-custom mr-2">등록</a>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- 캐러셀 제어 버튼 -->
                <button class="carousel-control-prev" type="button" data-bs-target="#productCarouselBeans" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#productCarouselBeans" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
        </c:if>
    </div>
</div>


        <!-- 위 아래 여백 추가 -->
    <!-- 일 매출 및 월 매출을 가로로 배치 -->
<div class="row mb-5">
    <!-- 일 매출 -->
    <div class="col-md-6">
        <h3 class="mb-3">WTD 일 매출</h3>
 
        <canvas id="dailySalesChart"></canvas>
        <div id="salesData" 
             data-dates="${dailySalesData[6].orderDate},${dailySalesData[5].orderDate},${dailySalesData[4].orderDate},${dailySalesData[3].orderDate},${dailySalesData[2].orderDate},${dailySalesData[1].orderDate},${dailySalesData[0].orderDate}" 
             data-sales="${dailySalesData[6].totalSales},${dailySalesData[5].totalSales},${dailySalesData[4].totalSales},${dailySalesData[3].totalSales},${dailySalesData[2].totalSales},${dailySalesData[1].totalSales},${dailySalesData[0].totalSales}"></div>
           <div class="mb-3">
            <label for="startDate">시작 날짜:</label>
            <input type="date" id="startDate" class="form-control">
        </div>
    </div>
    
    <!-- 월 매출 -->
    <div class="col-md-6">
        <h3 class="mb-3">WTD 월 매출</h3>
        <canvas id="monthlySalesChart"></canvas>
        <div id="monthlySalesData" 
             data-months="${monthlySalesData[5].month},${monthlySalesData[4].month},${monthlySalesData[3].month},${monthlySalesData[2].month},${monthlySalesData[1].month},${monthlySalesData[0].month}" 
             data-sales="${monthlySalesData[5].totalSales},${monthlySalesData[4].totalSales},${monthlySalesData[3].totalSales},${monthlySalesData[2].totalSales},${monthlySalesData[1].totalSales},${monthlySalesData[0].totalSales}"></div>
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
        </div> <!-- 캐러셀 위 여백 -->
        
        <div class="additional-space">
        </div> <!-- 캐러셀 아래 여백 -->
    </div>

    <!-- jQuery, Bootstrap JS 포함 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 차트에 사용할 데이터 샘플
        const ctx = document.getElementById('salesGraph').getContext('2d');
        const salesGraph = new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['01', '02', '03', '04', '05', '06', '07'], // 월별 데이터
                datasets: [{
                    label: '월 매출',
                    data: [120000, 150000, 180000, 200000, 160000, 180000, 210000], // 매출 데이터
                    borderColor: '#4CAF50',
                    backgroundColor: 'rgba(76, 175, 80, 0.2)',
                    fill: true,
                    tension: 0.1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    tooltip: {
                        mode: 'index',
                        intersect: false,
                    }
                },
                scales: {
                    x: {
                        beginAtZero: true
                    },
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

    </script>



<!-- 월매출 차트 생성 start -->
<script type="text/javascript">
	var monthlyLabelArr = new Array();
	var monthlyDataArr = new Array();
	$(document).ready(function(){
		var mem_idArr = new Array();
		var total_salesArr = new Array();
		var datas;
		<c:forEach var="itm" items="${monthlysellerSalesData}">
			monthlyLabelArr.push('${itm.month}');
			monthlyDataArr.push('${itm.totalSales}');
		</c:forEach>
		

		var monthlyChart = new Chart(document.getElementById("monthlyChart"), {
		    type: 'line',
		    data: {
		      labels: monthlyLabelArr,
		      datasets: [
		        {
		          label: "총매출",
		          backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
		          data: monthlyDataArr
		        }
		      ]
		    },
		    options: {
		      legend: { display: false },
		      title: {
		        display: true,
		        text: 'Predicted world population (millions) in 2050'
		      }
		    }
		});
		$('#seller').on('change',function(){

		    $.ajax({
	            type : 'POST',
	            url : '${contextPath}/admin/adminGetMonthlySales.do',
	            data : {"mem_id" : this.value},
	            dataType : 'json',
	            success : function(result){
	            	if(result != undefined && result != null && result != ''){
	            		let datas = result.datas;
		            	if(datas != undefined && datas != null && datas != ''){
		            		monthlyDataArr = new Array();
		            		$.each(datas,function(idx,itm){
		            			monthlyDataArr.push(itm.totalSales);
		            		});
		            		if(monthlyDataArr.length>0){
		            			monthlyChart.destroy();
		            			monthlyChart = new Chart(document.getElementById("monthlyChart"), {
		            			    type: 'line',
		            			    data: {
		            			      labels: monthlyLabelArr,
		            			      datasets: [
		            			        {
		            			          label: "총매출",
		            			          backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
		            			          data: monthlyDataArr
		            			        }
		            			      ]
		            			    },
		            			    options: {
		            			      legend: { display: false },
		            			      title: {
		            			        display: true,
		            			        text: 'Predicted world population (millions) in 2050'
		            			      }
		            			    }
		            			});
		            		}
		            	}
	            	}
	            }, // success
	            error: function(xhr, status, error){
	                console.error("조회에 실패했습니다." + error);
	            }
	        }) // ajax
		});
	});
</script>
<!-- 월매출 차트 생성 done -->


    <footer class="footer mt-5">
        <%@ include file="../common/footer.jsp" %>
    </footer>
</body>
</html>
