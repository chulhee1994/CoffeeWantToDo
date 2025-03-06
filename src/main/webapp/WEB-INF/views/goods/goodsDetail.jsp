<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL core 태그 라이브러리 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- JSTL fmt 태그 라이브러리 -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 컨텍스트 경로 및 기타 공통 변수 설정 -->
<c:set var="goods" value="${goodsDetail}" />
<c:set var="includeCommonPath" value="/WEB-INF/views/common" />
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!-- 리뷰 맵 -->
<c:set var="reviewList" value="${reviewsMap.reviewList}" />
<c:set var="review_section" value="${reviewsMap.review_section}" />
<c:set var="review_pageNum" value="${reviewsMap.review_pageNum}" />
<c:set var="getToReviews"
	value="${not empty reviewsMap.getToReviews ? reviewsMap.getToReviews : 0}" />
<!-- 리뷰 맵 -->

<!-- 레피시 맵 -->
<c:set var="recipeList" value="${recipesMap.recipesList}" />
<c:set var="recipe_section" value="${recipesMap.recipe_section}" />
<c:set var="recipe_pageNum" value="${recipesMap.recipe_pageNum}" />
<c:set var="getToRecipes"
	value="${not empty recipesMap.getToRecipes ? recipesMap.getToRecipes : 0}" />
<!-- 레피시 맵 -->
<%
pageContext.setAttribute("crcn", "\n"); // 개행 문자 설정
pageContext.setAttribute("br", "<br/>"); // <br> 태그 설정
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<style type="text/css">
/* 탭 활성화 상태 스타일 */
#tabs div.active {
	font-weight: bold;
	cursor: pointer;
}

.tab-content {
	display: none; /* 기본적으로 모든 탭 내용 숨기기 */
}

.tab-content.active {
	display: block; /* 'active' 클래스가 있으면 해당 탭 내용 표시 */
}

.image-container {
	text-align: center; /* 이미지 중앙 정렬 */
}

#outer_wrap {
	display: flex;
	justify-content: center; /* 자식 요소인 #wrap을 가로로 중앙 정렬 */
}

#wrap {
	width: 100%; /* 기본 크기 100%로 설정 */
	max-width: 1200px; /* 원하는 최대 너비 지정, 필요에 따라 수정 */
}

body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background-color: #f8f9fa;
	color: #333;
}

#layer {
	z-index: 2;
	position: absolute;
	top: 0px;
	left: 0px;
	width: 100%;
}

#popup {
	z-index: 3;
	position: fixed;
	text-align: center;
	left: 50%;
	top: 45%;
	width: 300px;
	height: 200px;
	background-color: #f1f1f1;
	border: 3px solid #87cb42;
	border-radius: 8px;
	box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);
	padding: 20px;
	transform: translateX(-50%);
}

#close {
	z-index: 4;
	float: right;
	cursor: pointer;
}

#goods_container {
	display: flex;
	justify-content: flex-start;
	align-items: flex-start;
	padding: 40px 10%;
	gap: 40px; /* 항목 간 여백 */
}

#goods_name {
	font-size: 20px;
}

#goods_image {
	display: flex; /* 플렉스를 활성화하여 자식 요소(이미지)를 쉽게 배치 */
	justify-content: center; /* 수평 중앙 정렬 */
	align-items: center; /* 수직 중앙 정렬 */
}

#goods_image img {
	width: 300px; /* 이미지 너비 고정 (300px) */
	height: 300px; /* 이미지 높이 고정 (300px) */
	object-fit: cover; /* 이미지 비율 유지하며 크기 맞추기 (자르지 않음) */
}

.btn-custom {
	display: inline-block;
	border: 1px solid #ddd;
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
}

#detail_table {
	flex: 1;
	max-width: 500px;
	padding: 20px;
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
}

#detail_table table {
	width: 100%;
	border-collapse: collapse;
}

.product-info-row {
	padding: 12px 0;
	font-size: 16px;
	color: #555;
}

.product-info-row:last-child {
	border-bottom: none;
}

.product-info-label {
	font-weight: bold;
	color: #333;
}

.product-info-value {
	padding-left: 10px;
	color: #444;
}

.price-row {
	display: flex;
	align-items: center;
	gap: 10px;
	font-size: 18px;
	font-weight: bold;
	color: #e60000;
}

.price-row .original-price {
	text-decoration: line-through;
	color: #aaa;
	font-size: 16px;
}

.price-row .discounted-price {
	font-size: 20px;
	color: #28a745;
}

.product-title-row {
	margin-top: 20px;
	padding-bottom: 20px;
	border-bottom: 2px solid #333;
	font-size: 24px;
	font-weight: bold;
	color: #333;
}

select {
	width: 80px;
	padding: 8px;
	font-size: 14px;
	border-radius: 5px;
	border: 1px solid #ddd;
	background-color: #f1f1f1;
}

.btn {
	padding: 12px 20px;
	font-size: 16px;
	border-radius: 6px;
	cursor: pointer;
	transition: all 0.3s ease;
	text-decoration: none;
	display: inline-block;
	margin-right: 15px;
}

.btn-primary {
	background: linear-gradient(145deg, #007bff, #0056b3);
	color: white;
	border: none;
}

.btn-primary:hover {
	background: linear-gradient(145deg, #0056b3, #003c7b);
	transform: translateY(-2px);
}

.btn-success {
	background: linear-gradient(145deg, #28a745, #218838);
	color: white;
	border: none;
}

.btn-success:hover {
	background: linear-gradient(145deg, #218838, #1e7e34);
	transform: translateY(-2px);
}

.mt-3 {
	margin-top: 25px;
}

.product-info-row td {
	padding: 10px;
}

.button-container {
	display: flex;
	justify-content: flex-start;
	gap: 10px;
	margin-top: 20px;
}

.button-container .btn {
	width: 48%;
}

@media ( max-width : 768px) {
	.button-container {
		flex-direction: column;
	}
	.button-container .btn {
		width: 100%;
		margin-bottom: 10px;
	}
}

#tabs {
	display: flex;
	justify-content: space-evenly;
	margin-top: 20px;
	border-bottom: 2px solid #ddd;
}

#tabs div {
	padding: 10px;
	cursor: pointer;
	font-weight: bold;
	color: #333;
}

#tabs .active {
	border-bottom: 3px solid #8b5c32;
	color: #8b5c32;
}

.tab-content {
	display: none;
	margin-top: 20px;
	padding: 20px;
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
}

.tab-content.active {
	display: block;
}
/*페이징 */
.pagination {
	margin-top: 30px;
	justify-content: center;
}

.pagination .page-item .page-link {
	color: #000;
	border-radius: 3px;
	margin: 0 5px;
	border: none;
}

.pagination .page-item.active .page-link {
	background-color: #333;
	color: #fff;
	border-radius: 3px;
	border: none;
}

  /* 페이지네이션 */

.review-grid {
	display: grid;
	grid-template-columns: repeat(4, 1fr); /* 한 줄에 5개 */
	grid-template-rows: repeat(2, auto); /* 두 줄 */
	gap: 15px;
}

.review-item {
	background-color: #fff;
	padding: 15px;
	border: 1px solid #ddd;
	border-radius: 3px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	text-align: center;
}

.review-item img {
	width: 100%;
	height: 200px;
	object-fit: contain;
	border-radius: 3px;
	margin-bottom: 10px;
}

.review-title {
	font-size: 1.2rem;
	font-weight: bold;
	margin-bottom: 5px;
}

.review-image {
	position: relative; /* 하트 아이콘 위치 기준 */
	width: 100%;
}

.heart-container {
	position: absolute;
	bottom: 10px; /* 하단 여백 */
	right: 5px; /* 우측 여백 */
	display: flex;
	align-items: center; /* 아이콘과 숫자 정렬 */
	background: rgba(255, 255, 255, 0.8); /* 반투명 배경 */
	padding: 5px 10px;
	border-radius: 20px;
}

.heart-container svg {
	cursor: pointer;
	margin-right: 5px; /* 숫자와 간격 */
	transition: transform 0.2s ease-in-out;
}

.heart-container svg:hover {
	transform: scale(1.2); /* 하트 클릭 시 확대 효과 */
}

.review-meta {
	font-size: 0.9rem;
	color: #555;
	margin-bottom: 10px;
}

.review-rating {
	font-size: 1rem;
	color: #f5c518;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
	margin-bottom: 20px;
	border-radius: 3px;
}

th, td {
	border-bottom: 1px solid #e9e9e9; /* 옅은 선 */
	padding: 12px;
	text-align: left;
	font-size: 14px;
	color: #444;
}

th {
	background-color: #f9f9f9;
	font-weight: 700;
	color: #000;
}

td a {
	color: #333;
	text-decoration: none;
}

td a:hover {
	color: #333;
	text-decoration: none;
}

.strong {
	display: block;
	margin-bottom: 15px;
	line-height: 25px;
	font-size: 22px;
	color: #000;
}

.content-top {
	background-color: #f9f9f9; /* 연한 배경 */
	padding: 20px; /* 여백 추가 */
	border-radius: 8px; /* 모서리 둥글게 */
	border-left: 5px solid #8b5c32; /* 좌측 테두리 강조 */
	box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
	margin-bottom: 20px; /* 아래 여백 추가 */
}

.content-top .strong {
	font-size: 24px; /* 크기 키우기 */
	font-weight: bold;
	color: #333;
}

.content-top p {
	font-weight: bold;
	font-size: 15px; /* 설명 글자 크기 */ color : #555; /* 글자 색상 */
	margin-top: 5px;
	color: #555; /* 위 간격 조정 */
}
</style>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"
	integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript">const contextPath = "${contextPath}";</script>
<script src="${contextPath}/resources/js/chatio.js"
	type="text/javascript"></script>
<script type="text/javascript">
         $(document).ready(function(){
        	    // ✅ 수량 선택 드롭다운에서 0 선택 방지
        	    $("#order_goods_qty").change(function(){
        	        var selectedQty = parseInt($(this).val()); // 선택된 수량
        	        var stock = parseInt("${goods.goods_stock}"); // 재고 수량

        	        // 🚀 0개 선택 시 기본값 1로 변경
        	        if (selectedQty <= 0 || isNaN(selectedQty)) {
        	            alert("최소 1개 이상 선택해야 합니다.");
        	            $(this).val(1);
        	        }

        	        // 🚀 재고 초과 방지
        	        if (selectedQty > stock) {
        	            alert("재고 수량을 초과했습니다. 현재 재고: " + stock + "개");
        	            $(this).val(stock);
        	        }
        	    });
        	});
         function addToCart() {
        	    const orderGoodsQty = $("#order_goods_qty").val(); // 선택된 수량
        	    const goodsId = '${goods.goods_id}';  // JSP에서 상품 ID 가져오기
        	    const memId = '${member.mem_id}';     // JSP에서 사용자 ID 가져오기
        	    const stock = parseInt("${goods.goods_stock}");

        	    if (orderGoodsQty <= 0 || isNaN(orderGoodsQty)) {
        	        alert("최소 1개 이상 선택해야 합니다.");
        	        return;
        	    }
        	    if (orderGoodsQty > stock) {
        	        alert("재고 수량을 초과할 수 없습니다. 현재 재고: " + stock + "개");
        	        return;
        	    }

        	    $.ajax({
        	        url: "/WantToDo/cart/addCart.do",
        	        type: "POST",
        	        data: JSON.stringify({
        	            goods_id: goodsId,
        	            mem_id: memId,
        	            order_goods_qty: orderGoodsQty
        	        }),
        	        contentType: "application/json; charset=UTF-8",
        	        dataType: "json",
        	        success: function (data) {
        	            if (!data.success) {
        	                if (data.message === "로그인이 필요한 서비스입니다.") {
        	                    // 🚀 로그인 필요 메시지 후 로그인 페이지로 이동
        	                    alert(data.message);
        	                    window.location.href = "${contextPath}/member/loginForm.do";
        	                } else {
        	                    // 🚀 이미 장바구니에 담긴 상품 메시지
        	                    alert(data.message);
        	                }
        	            } else {
        	                // 🚀 장바구니 추가 성공 시 팝업 표시
        	                showCartPopup(data.message);
        	            }
        	        },
        	        error: function (xhr, status, error) {
        	            console.error("AJAX Error: ", error);
        	            alert("장바구니 추가 중 오류가 발생했습니다.");
        	        }
        	    });
        	}

        	// ✅ 장바구니 추가 성공 시 표시될 팝업
        	function showCartPopup(message) {
        	    $("#cart-popup-message").text(message);
        	    $("#cart-popup").fadeIn();
	        	}

        	// ✅ 팝업 닫기
        	function closeCartPopup() {
        	    $("#cart-popup").fadeOut();        
        	}
	

        	
        	function fn_order_each_goods() {

        	    const orderGoodsQty = parseInt($("#order_goods_qty").val()); // 선택된 수량
        	    const stock = parseInt("${goods.goods_stock}");

        	    if (orderGoodsQty <= 0 || isNaN(orderGoodsQty)) {
        	        alert("최소 1개 이상 선택해야 합니다.");
        	        return;
        	    }
        	    if (orderGoodsQty > stock) {
        	        alert("재고 수량을 초과할 수 없습니다. 현재 재고: " + stock + "개");
        	        return;
        	    }
        		
        		

            var goodsData = {
                goods_id: '${goods.goods_id}',
                goods_name: '${goods.goods_name}',
                goods_price: '${goods.goods_price}',
                goods_sales_price: '${goods.goods_sales_price}',
                goods_point: '${goods.goods_point}',	
                goods_delivery_price: '${goods.goods_delivery_price}',
                goods_category: '${goods.goods_category}',
                goods_c_note: '${goods.goods_c_note}',
                goods_origin1: '${goods.goods_origin1}',
                goods_origin2: '${goods.goods_origin2}',
                goods_origin3: '${goods.goods_origin3}',
                goods_c_gram: '${goods.goods_c_gram}',
                goods_fileName : '${goodsDetail.mainImage}'
            };
        	    var order_goods_qty = $("#order_goods_qty").val(); // 사용자가 선택한 수량
        	    var total_price = (parseInt(goodsData.goods_sales_price, 10) * order_goods_qty) + parseInt(goodsData.goods_delivery_price, 10);

        	    var formObj = document.createElement("form");
        	    formObj.method = "post";
        	    formObj.action = "${contextPath}/order/orderEachGoods.do";

        	    for (var key in goodsData) {
        	        formObj.appendChild(createHiddenInput(key, goodsData[key]));
        	    }
        	    formObj.appendChild(createHiddenInput("order_goods_qty", order_goods_qty));
        	    formObj.appendChild(createHiddenInput("order_total_price", goodsData.goods_sales_price * order_goods_qty));
        	    formObj.appendChild(createHiddenInput("final_order_total_price", total_price));

        	    document.body.appendChild(formObj);
        	    formObj.submit();
        	}

        	function createHiddenInput(name, value) {
        	    var input = document.createElement("input");
        	    input.type = "hidden";
        	    input.name = name;
        	    input.value = value || ""; // ✅ 값이 없을 경우 빈 문자열 처리
        	    return input;
        	}
        	
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
        	    
        	  //개수 증가 로직
        	    $(document).ready(function(){
        	        $("#order_goods_qty").change(function(){
        	            var selectedQty = parseInt($(this).val());
        	            var stock = parseInt("${goods.goods_stock}");
        	            if(selectedQty > stock) {
        	                alert("재고 수량을 초과했습니다. 현재 재고: " + stock + "개");
        	                $(this).val(stock);
        	            }
        	        });
        	    });
    </script>
</head>
<body>
	<div class="header">
		<%@ include file="../common/header.jsp"%>
		<!-- 공통 헤더 포함 -->
	</div>

	<!-- 상품 상세 정보 영역 -->
	<div id="outer_wrap">
		<div id="wrap">
			<article>
				<div id="goods_container">
					<!-- 왼쪽: 상품 이미지 -->
					<div id="goods_image">
						<figure>
							<img
								src="${contextPath}/image.do?goods_id=${goods.goods_id}&fileName=${goodsDetail.mainImage}">
						</figure>
					</div>
					<!-- 오른쪽: 상품 상세 정보 -->
					<div id="detail_table">
						<table>
							<tbody>
								<!-- 상품 이름 -->
								<tr class="product-info-row product-title-row">
									<td class="product-info-label" colspan="2" id="goods_name">${goods.goods_name}</td>
								</tr>
								<!-- 가격 -->
								<tr class="product-info-row">
									<td class="product-info-value">
										<div class="price-row">
											<span class="original-price"> <fmt:formatNumber
													value="${goods.goods_price}" pattern="#,###" />원
											</span> <span class="discounted-price"> <fmt:formatNumber
													value="${goods.goods_sales_price}" pattern="#,###" />원
											</span>
										</div>
									</td>
								</tr>
								<!-- 포인트 적립 -->
								<tr class="product-info-row line-light-bottom">
									<td class="product-info-label">포인트적립</td>
									<td class="product-info-value"><fmt:parseNumber
											var="parsePoint" value="${goods.goods_point}" type="number" />
										<fmt:formatNumber value="${parsePoint}" pattern="#,####" />P</td>
								</tr>

								<!-- 상품 카테고리 별 정보 -->
								<c:choose>
									<c:when test="${goods.goods_category == '원두'}">
										<tr class="product-info-row product-info-title line-strong">
											<td colspan="2">원두 정보</td>
										</tr>
									</c:when>
									<c:when test="${goods.goods_category == '베이커리'}">
										<tr class="product-info-row product-info-title line-strong">
											<td colspan="2">베이커리</td>
										</tr>
									</c:when>
									<c:when test="${goods.goods_category == '커피용품'}">
										<!-- 커피용품은 해당 항목을 표시하지 않음 -->
									</c:when>
								</c:choose>

								<!-- 상품 노트 정보 -->
								<c:if test="${not empty goods.goods_c_note}">
									<tr class="product-info-row">
										<td class="product-info-label">노트</td>
										<td class="product-info-value">${goods.goods_c_note}</td>
									</tr>
								</c:if>

								<!-- 원산지 정보 -->
								<c:if
									test="${not empty goods.goods_origin1 or not empty goods.goods_origin2 or not empty goods.goods_origin3}">
									<tr class="product-info-row">
										<td class="product-info-label">원산지</td>
										<td class="product-info-value"><c:if
												test="${not empty goods.goods_origin1}">
                                                    ${goods.goods_origin1}
                                                </c:if> <c:if
												test="${not empty goods.goods_origin2}">
												<c:if test="${not empty goods.goods_origin1}">, </c:if>
                                                    ${goods.goods_origin2}
                                                </c:if> <c:if
												test="${not empty goods.goods_origin3}">
												<c:if
													test="${not empty goods.goods_origin1 or not empty goods.goods_origin2}">, </c:if>
                                                    ${goods.goods_origin3}
                                                </c:if></td>
									</tr>
								</c:if>

								<!-- 그램 정보 -->
								<c:if test="${not empty goods.goods_c_gram}">
									<tr class="product-info-row line-light-bottom">
										<td class="product-info-label">그램</td>
										<td class="product-info-value">
										<fmt:formatNumber value="${goods.goods_c_gram}" pattern="#,####"/>g
										</td>
									</tr>
								</c:if>

								<!-- 수량 선택 -->
								<tr class="product-info-row">
									<td class="product-info-label">수량</td>
									<td class="product-info-value"><select
										id="order_goods_qty">
											<option>1</option>
											<option>2</option>
											<option>3</option>
											<option>4</option>
											<option>5</option>
									</select> /${goods.goods_stock}개</td>
								</tr>
							</tbody>
						</table>

						<!-- 버튼들 -->
						<div class="button-container">
							<button onclick="addToCart()" class="btn-custom">장바구니</button>
							<a href="javascript:fn_order_each_goods();" class="btn-custom">주문하기</a>
						</div>
					</div>
				</div>

				<div id="cart-popup"
					style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 300px; height: 150px; background-color: #fff; border: 2px solid #87cb42; border-radius: 10px; box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.2); text-align: center; padding: 20px; z-index: 1000;">
					<p id="cart-popup-message"></p>
					<button onclick="closeCartPopup()">확인</button>
					<button
						onclick="window.location.href='${contextPath}/cart/myCartList.do'">장바구니
						이동</button>
				</div>

				<!-- 탭 네비게이션 -->
				<div id="tabs">
					<div id="tab_detail" class="active" onclick="showTab('detail')">상세정보</div>
					<div id="tab_review" onclick="showTab('review')">리뷰</div>
					<div id="tab_recipe" onclick="showTab('recipe')">레시피</div>
				</div>

				<!-- 탭 내용 -->
				<div class="tab-content active" id="detail_content">
					<c:if test="${not empty goodsDetail.detailImage1}">
						<div class="image-container">
							<img
								src="${contextPath}/image.do?goods_id=${goodsDetail.goods_id}&fileName=${goodsDetail.detailImage1}"
								alt="상세 이미지 1">
						</div>
					</c:if>
					<c:if test="${empty goodsDetail.detailImage1}">
						<span style="display: flex; justify-content: center;">상품
							이미지가 없습니다.</span>
					</c:if>
				</div>

				<!-- 리뷰 페이징과 리뷰 출력 -->
				<div class="tab-content" id="review_content">

					<div class="content-top">
						<strong class="strong">상품 리뷰</strong>
						<p>
							상품을 구매하신 분들이 작성하신 리뷰입니다.이미지 리뷰 작성시 <span
								style="color: #28a745; font-weight: bold;">500P</span>가 적립됩니다.
						</p>
						<p>상품마다 적립포인트가 다를 수 있으니 구매 전 상품상세 적립포인트를 확인해 주세요.</p>
					</div>

					<c:choose>

						<c:when test="${not empty reviewList}">
							<div class="review-grid">

								<c:forEach var="review" varStatus="reviewNum"
									items="${reviewList}">
									<div class="review-item">

										<div class="review-image">
											<c:set var="reviewNoPath"
												value="${reviewNoList[reviewNum.index]}" />
											<img
												src="${contextPath}/base/getImage.do?fileName=${review.fileName}&filePath=${reviewNoPath}"
												alt="${review.fileName}"
												onerror="this.onerror=null; this.src='${contextPath}/resources/images/no_image.png';">


											<!-- 하트 & 좋아요 수 -->
											<div class="heart-container">
												<svg xmlns="http://www.w3.org/2000/svg" width="16"
													height="16" fill="red" class="bi bi-heart-fill"
													viewBox="0 0 16 16" onclick="incrementLike()">
				            <path fill-rule="evenodd"
														d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314" />
				        </svg>
												<span>${review.goods_like}</span>
											</div>

										</div>
										<c:set var="maxLength" value="15" />
										<!-- 원하는 최대 글자수 설정 -->


										<div class="review-title">
											<a
												href="${contextPath}/review/viewReview.do?review_no=${review.review_no}"
												class="text-dark" style="text-decoration: none;"> <c:choose>
													<c:when
														test="${fn:length(review.review_title) > maxLength}">
			                ${fn:substring(review.review_title, 0, maxLength)}...
			            </c:when>
													<c:otherwise>
			                ${review.review_title}
			            </c:otherwise>
												</c:choose>
											</a>
										</div>


										<div class="review-meta">
											<p style="display: block; margin-right: 10px;">${review.mem_id}</p>
											<p style="display: block; margin-right: 10px;">
												<fmt:formatDate value="${review.review_writedate}"
													pattern="yyyy-MM-dd HH:mm" />
											</p>
											<p>조회 : ${review.views}</p>
										</div>


										<div class="review-rating">
											<c:forEach var="i" begin="1" end="${review.review_star}">
   				 ★
				</c:forEach>
										</div>

									</div>
								</c:forEach>
							</div>



						</c:when>
						<c:otherwise>
							<div class="no-reviews">작성된 리뷰글이 없습니다.</div>
						</c:otherwise>
					</c:choose>

					<c:if test="${getToReviews > 0}">
						<nav aria-label="Page navigation">
							<c:set var="reviewTotalPages"
								value="${(getToReviews + 9) div 10}" />
							<c:set var="startPage" value="${(review_section - 1) * 10 + 1}" />
							<c:set var="endPage" value="${review_section * 10}" />

							<ul class="pagination">
								<c:if test="${getToReviews > 0 && reviewTotalPages > 1}">
									<!-- 이전 페이지 버튼 (첫 번째 섹션이 아닐 경우에만 표시) -->
									<c:if test="${review_section > 1}">
										<li class="page-item"><a class="page-link"
											href="${contextPath}/goods/goodsDetail.do?goods_id=${goods.goods_id}&review_section=${review_section-1}&review_pageNum=${startPage-10}">&laquo;</a>
										</li>
									</c:if>

									<!-- 페이지 번호 -->
									<c:forEach var="page" begin="${startPage}" end="${endPage}"
										step="1">
										<c:if test="${page <= reviewTotalPages}">
											<li
												class="page-item ${review_pageNum == page ? 'active' : ''}">
												<a class="page-link"
												href="${contextPath}/goods/goodsDetail.do?goods_id=${goods.goods_id}&review_section=${review_section}&review_pageNum=${page}">
													${page} </a>
											</li>
										</c:if>
									</c:forEach>

									<!-- 다음 페이지 버튼 (현재 섹션의 마지막 페이지가 전체 페이지보다 적을 경우만 표시) -->
									<c:if test="${endPage < reviewTotalPages}">
										<li class="page-item"><a class="page-link"
											href="${contextPath}/goods/goodsDetail.do?goods_id=${goods.goods_id}&review_section=${review_section+1}&review_pageNum=${endPage+1}">&raquo;</a>
										</li>
									</c:if>
								</c:if>
							</ul>
						</nav>
					</c:if>

				</div>
				<div class="tab-content" id="recipe_content">

					<div class="content-top">
						<strong class="strong">상품 레시피</strong>
						<p>원두커피를 더욱 맛있게 즐기는 다양한 레시피를 확인해 보세요.</p>
						<p>
							커피 추출 방법과 조합 레시피를 통해 <span
								style="color: #28a745; font-weight: bold;">새로운 커피 경험</span>을
							만나보세요.
						</p>
					</div>




					<!-- 게시판 테이블 -->
					<table>
						<thead>
							<tr>
								<th style="width: 2%;">번호</th>
								<th style="width: 20%;">제목</th>
								<th style="width: 5%;">작성자</th>
								<th style="width: 2%;">등록일</th>
								<th style="width: 3%;">조회수</th>
							</tr>
						</thead>
						<tbody>

							<c:choose>
								<c:when test="${not empty recipeList}">
									<c:forEach var="recipe" varStatus="recipeNum"
										items="${recipeList}">
										<tr>
											<td>${recipe.recipe_no}</td>
											<td><a
												href="${contextPath}/recipe/viewRecipe.do?recipe_no=${recipe.recipe_no}">${recipe.recipe_title}</a></td>
											<td>${recipe.mem_id}</td>
											<td>${recipe.recipe_writedate}</td>
											<td>${recipe.views}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="6"
											style="text-align: center; padding: 20px; font-size: 16px; color: #888;">
											작성된 글이 없습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>

					<!-- ✅ 검색 결과에 맞는 페이징 적용 -->
				<c:if test="${getToRecipes > 0}">
					<nav aria-label="Page navigation">
						<ul class="pagination">
								<!-- 이전 페이지 버튼 -->
								<c:if test="${recipe_section > 1}">
									<li class="page-item"><a class="page-link"
										href="${contextPath}/goods/goodsDetail.do?goods_id=${goods.goods_id}&recipe_section=${recipe_section-1}&recipe_pageNum=${Math.max(1, (recipe_section-1)*10 + 1)}">&laquo;</a>
									</li>
								</c:if>

								<!-- 페이지 번호 -->
								<c:set var="totalPages" value="${(getToRecipes + 9) / 10}" />
								<c:forEach var="page" begin="1"
									end="${totalPages < 10 ? totalPages : 10}" step="1">
									<c:set var="pageNumber" value="${(recipe_section-1)*10 + page}" />
									<c:if test="${pageNumber <= totalPages}">
										<li class="page-item"><a class="page-link"
											href="${contextPath}/goods/goodsDetail.do?goods_id=${goods.goods_id}&recipe_section=${recipe_section}&recipe_pageNum=${pageNumber}">
												${pageNumber} </a></li>
									</c:if>
								</c:forEach>

								<!-- 다음 페이지 버튼 -->
								<c:if test="${(recipe_section * 10) < getToRecipes}">
									<li class="page-item"><a class="page-link"
										href="${contextPath}/goods/goodsDetail.do?goods_id=${goods.goods_id}&recipe_section=${recipe_section+1}&recipe_pageNum=${recipe_section*10+1}">&raquo;</a>
									</li>
								</c:if>
						</ul>
					</nav>
				</c:if>
				</div>

				<script>
                        // 탭 전환 함수
                        function showTab(tabName) {
                            const tabs = document.querySelectorAll('#tabs div');
                            const tabContents = document.querySelectorAll('.tab-content');

                            // 모든 탭과 탭 내용을 비활성화
                            tabs.forEach(tab => tab.classList.remove('active'));
                            tabContents.forEach(content => content.classList.remove('active'));

                            // 클릭된 탭 활성화
                            document.getElementById('tab_' + tabName).classList.add('active');
                            document.getElementById(tabName + '_content').classList.add('active');
                        }
                    </script>
			</article>
		</div>
	</div>

	<div class="footer">
		<%@ include file="../common/footer.jsp"%>
		<!-- 공통 푸터 포함 -->
	</div>
</body>
</html>
