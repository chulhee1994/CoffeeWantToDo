<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<style>
body {
	height: 100%;
}

.container {
	padding: 0 30px 20px 30px;
}

.container1 {
	text-align: center;
}

.container2 {
	padding: 10px 10px;
}

.container2 th {
	border-top: 1px solid gray;
}

.container3 {
	padding: 10px 50px;
	text-align: center;
}

.ct2-title {
	margin-bottom: 20px;
}

ct2-title-pay {
	margin-bottom: 20px;
	text-align: center;
	font-weight: bolder;
}

/* 탭 디자인 */
#tabs {
	display: flex;
	justify-content: space-evenly;
	border-bottom: 2px solid #ddd;
	align-items: center;
	height: 140px;
	padding: 0 0 10px 0;
}

#tabs div {
	display: flex;
	flex-direction: column;
	text-align: center;
	padding: 10px;
	cursor: pointer;
	font-weight: bold;
	color: #333;
}

#tabs img {
	width: 60px;
	height: 60px;
	margin-bottom: 5px;
	margin-top: 15px;
}

#tabs .active {
	background-color: gray;
	color: white;
}

.tab-content {
	display: none;
	margin-top: 20px;
	padding: 20px;
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
}

.tabs-list {
	weight: 100px;
	height: 125px;
}

.tab-content.active {
	display: block;
}

.small-text {
	color: gray;
	font-size: 14px;
}

.vertical-line {
	width: 1px; /* 세로선의 두께 */
	height: 140px; /* 세로선의 길이 */
	background-color: black; /* 세로선의 색상 */
	border: none; /* 기본 hr 스타일을 제거 */
	margin: 0 30px; /* 기본 여백을 제거 */
}

.bold-text {
	font-size: 1.3rem;
	font-weight: 800;
	margin: 0;
}

.big-text-center {
	text-align: center;
}

.big-text {
	font-size: 1.3rem;
}

.signout-btn {
	text-algin: center;
	width: 60%;
	height: 60%;
}

/* 테이블 셀 내부 중앙 정렬 */
.table td, .table th {
	vertical-align: middle; /* 셀 내부 수직 중앙 정렬 */
	text-align: center; /* 셀 내부 수평 중앙 정렬 */
}

.name_list {
	vertical-align: middle; /* 셀 내부 수직 중앙 정렬 */
	text-align: center; /* 셀 내부 수평 중앙 정렬 */
}

.card-img-top {
	width: 50px;
	height: 150px;
}

.card-img-goods {
	height: 70px;
	width: 70px;
}

.review-title-a {
	text-decoration: none;
	color: black;
}

.review-title-a:hover {
	color: gray;
}
/* ✅ 기본 이미지 크기 조정 */
.card-img-goods {
	width: 100px; /* 기본 크기 */
	height: 100px;
	object-fit: cover;
}
/* ✅ 슬라이더 크기 고정 */
.carousel {
	max-width: 100px;
	height: 100px;
	margin: auto;
}
/* ✅ 슬라이더 내부 아이템 높이 고정 */
.carousel-inner {
	width: 100%;
	height: 100px; /* 고정 높이 설정 (원하는 크기로 조정 가능) */
}
/* ✅ 개별 슬라이드 아이템 크기 고정 */
/* ✅ 슬라이더 내부 아이템 크기 조정 */
.carousel-item {
	display: flex;
	justify-content: center;
	align-items: center;
}

/* ✅ 주문이 하나일 때 이미지 크기 고정 */
.single-item-img {
	width: 100px !important;
	height: 100px !important;
	object-fit: cover;
}

/* ✅ 슬라이더 버튼 중앙 정렬 */
.carousel-control-prev, .carousel-control-next {
	top: 50% !important; /* Bootstrap 기본 스타일 덮어쓰기 */
	transform: translateY(-50%) !important;
	width: 30px; /* 버튼 크기 조정 */
	height: 30px;
	opacity: 0.8; /* 버튼 가시성 향상 */
	position: absolute; /* 위치 고정 */
}

/* ✅ 슬라이더 버튼 아이콘 크기 및 스타일 */
.carousel-control-prev-icon, .carousel-control-next-icon {
	background-color: rgba(0, 0, 0, 0.6); /* 버튼 배경 색 추가 */
	border-radius: 50%; /* 버튼을 원형으로 만들기 */
	width: 20px !important;
	height: 20px !important;
}
/* ✅ 기본 상태: 밑줄 제거 & 기본 색상 */
.order_id {
	text-decoration: none; /* 밑줄 제거 */
	color: #333; /* 기본 텍스트 색상 */
	font-weight: bold; /* 글자를 강조 */
}

/* ✅ 마우스 호버 시 색상 변경 */
.order_id:hover {
	color: #D2B48C; /* 원하는 색상으로 변경 (여기서는 탠 색상) */
	font-size: 1.1rem; /* 글자 크기 키우기 */
	transition: color 0.3s ease-in-out; /* 부드러운 색상 전환 효과 */
}
/* ✅ 방문한 링크 스타일 (선택사항) */
.order_id:visited {
	color: #0056b3; /* 방문한 후에도 보기 좋게 파란색 계열 유지 */
}
</style>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script language="javascript" type="text/javascript"
	src="https://stgstdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function deleteAddress(addressId) {
        if (confirm("정말 삭제하시겠습니까?")) {
            // AJAX 요청
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "${contextPath}/address/delAddress.do", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            // 서버로 보내는 데이터 (주소 ID 포함)
            xhr.send("address_id=" + addressId);

            // 요청이 완료되면 처리
            xhr.onload = function () {
                if (xhr.status === 200) {
                    // 요청이 성공하면 주소 리스트를 다시 가져와서 갱신 (예시: 페이지 리다이렉트)
                    window.location.href = "${contextPath}/address/addressList.do";
                } else {
                    alert("삭제에 실패했습니다. 다시 시도해주세요.");
                }
            };
        }
    }
 	
    
//결제 취소
    $(document).ready(function() {
        $(".refund-all-btn").click(function() {
            var tid = $(this).data("tid");  // ✅ 이니시스 거래 ID
            var price = $(this).data("price");  // ✅ 전체 취소할 금액
            var orderId = $(this).data("order-id");  // ✅ 주문 번호 추가
            
            var width = 400;
            var height = 350;

            // 화면의 가운데 위치 계산
            var left = (window.innerWidth / 2) - (width / 2);
            var top = (window.innerHeight / 2) - (height / 2);
            
            // 팝업을 열고 reason 값을 받아오기
            var popup = window.open(
                contextPath + "/order/popupRefund.do",
                "refundPopup",
                "width="+width+",height="+height+",top="+top+",left="+left
            );

            // 📌 부모 창에서 팝업에서 받은 값을 처리하는 함수 정의
            window.receiveRefundReason = function(reason) {
                console.log("📌 팝업에서 받은 환불 사유:", reason);

                if (!reason) {
                    alert("❌ 환불 사유를 입력해야 합니다.");
                    return;
                }

                console.log("📌 전체 취소 요청 - tid:", tid);
                console.log("📌 취소 금액:", price);

                // 📌 팝업에서 값을 받은 후 AJAX 요청 실행
                $.ajax({
                    url: contextPath + "/order/refundOrder.do",
                    type: "POST",
                    contentType: "application/json; charset=UTF-8",
                    dataType: "json",
                    data: JSON.stringify({
                        "t_id": tid,
                        "price": parseInt(price),
                        "reason": reason,  // ✅ 팝업에서 받은 reason 값 사용
                        "order_id": orderId // ✅ 주문 ID 추가
                    }),
                    success: function(response) {
                        console.log("✅ 환불 API 응답:", response);
                        if (response.success === true) {
                            alert(response.message);
                            location.reload();
                        } else {
                            alert("❌ 환불 실패: " + (response.error || "알 수 없는 오류"));
                            console.log("❌ 환불 실패: ", response);
                        }
                    },
                    error: function(xhr) {
                        console.error("❌ 환불 요청 중 오류 발생:", xhr);
                        alert("❌ 서버 오류 발생: " + xhr.responseText);
                    }
                });
            };
        });
    });
    

</script>
<script type="text/javascript">const contextPath = "${contextPath}";</script>
<script src="${contextPath}/resources/js/chatio.js"
	type="text/javascript"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지</title>
<link
	href="https://fonts.googleapis.com/css2?family=Merriweather:ital,wght@0,300;0,400;0,700;0,900&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="${contextPath}/resources/css/media.css">
<link rel="stylesheet"
	href="${contextPath}/resources/css/defaultStyle.css">
</head>
<body>
	<div class="header">
		<%@ include file="../common/header.jsp"%>
	</div>
	<p:choose>
		<p:when
			test="${member.mem_grade == 'common' || member.mem_grade == 'kakao'}">
			<div class="container">
				<div id="tabs">
					<div class="tabs-list" id="tab_profile" class="active"
						onclick="showTab('profile')">
						<img src="${contextPath}/resources/images/profile.png" alt="프로필">
						<p>프로필</p>
					</div>
					<div class="tabs-list" id="tab_orderList"
						onclick="showTab('orderList')">
						<img src="${contextPath}/resources/images/orderList.png"
							alt="주문내역">
						<p>주문·배송</p>
					</div>
					<div class="tabs-list" id="tab_address"
						onclick="showTab('address')">
						<img src="${contextPath}/resources/images/address.png" alt="주소">
						<p>주소</p>
					</div>
					<div class="tabs-list" id="tab_myaddresses"
						onclick="showTab('myaddresses')">
						<img src="${contextPath}/resources/images/myaddresses.png"
							alt="배송지">
						<p>배송지</p>
					</div>
					<div class="tabs-list" id="tab_point" onclick="showTab('point')">
						<img src="${contextPath}/resources/images/point.png" alt="포인트">
						<p>포인트</p>
					</div>

					<div class="tabs-list" id="tab_signout"
						onclick="redirectToSignoutPage()">
						<img src="${contextPath}/resources/images/signout.png" alt="회원탈퇴">
						<p>회원탈퇴</p>
					</div>
				</div>

				<!-- 탭 내용 -->
				<div class="tab-content" id="profile_content">
					<div class="container1">
						<div class="user-text">
							<h3 class="big-text">
								<strong>${member.mem_name}</strong> 고객님,
							</h3>
							<h3 class="big-text">
								<br> <strong>원두 Want To Do</strong>에 오신걸 환영합니다.
							</h3>
							<p:choose>
								<p:when test="${member.mem_grade == 'common' }">
									<a href="${contextPath}/member/modMemberForm.do"><input
										type="button" class="btn-custom" value="회원정보 수정" /></a>
								</p:when>
							</p:choose>
						</div>
					</div>
					<br> <br>
					<hr class="bold">
					<div class="container2">
						<h2 class="ct2-title">최근 주문 내역</h2>
						<div class="table-responsive">
							<table class="table table-striped">
								<thead style="background-color: #D2B48C;">
									<tr>
										<th class="text-center">주문번호</th>
										<th class="text-center">이미지</th>
										<th class="text-center">상품명</th>
										<th class="text-center">수량</th>
										<th class="text-center">금액</th>
										<th class="text-center">수령인</th>
										<th class="text-center">배송날짜</th>
										<th class="text-center">배송지</th>
										<th class="text-center">&nbsp;&nbsp;배송상태&nbsp;&nbsp;</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${empty ordersList}">
											<td colspan="10" class="text-center">조회된 주문 목록이 없습니다.</td>
										</c:when>
										<c:otherwise>
											<c:forEach var="orders" items="${ordersList}"
												varStatus="status">
												<c:if
													test="${not fn:contains(printedOrders, orders.order_id)}">
													<c:set var="totalQuantity" value="0" />
													<c:set var="totalPrice" value="0" />
													<c:set var="productCount" value="0" />
													<c:set var="firstProductName" value="" />

													<%-- ✅ 주문번호가 같은 상품 개수를 세고 첫 번째 상품명 가져오기 --%>
													<c:set var="imageList" value="" />
													<c:forEach var="subOrder" items="${ordersList}">
														<c:if test="${subOrder.order_id eq orders.order_id}">
															<c:set var="totalQuantity"
																value="${totalQuantity + subOrder.order_goods_qty}" />
															<c:set var="totalPrice"
																value="${totalPrice + subOrder.final_total_price}" />
															<c:set var="productCount" value="${productCount + 1}" />

															<%-- 첫 번째 상품명 설정 --%>
															<c:if test="${empty firstProductName}">
																<c:set var="firstProductName"
																	value="${subOrder.goodsVO.goods_name}" />
															</c:if>

															<%-- 이미지 리스트 저장 (슬라이더용) --%>
															<c:set var="imageList"
																value="${imageList},${subOrder.goods_id}:${subOrder.imageFileVO.fileName}" />
														</c:if>
													</c:forEach>

													<%-- ✅ 상품명이 없을 경우 기본값 설정 --%>
													<c:if test="${empty firstProductName}">
														<c:set var="firstProductName" value="상품 정보 없음" />
													</c:if>

													<tr>

														<td class="text-center"><a
															href="${contextPath}/order/orderResult.do?order_id=${orders.order_id}"
															class="order_id"> <strong>${orders.order_id}</strong>
														</a></td>

														<%-- ✅ 상품이 1개면 단일 이미지 표시 --%>
														<td class="text-center"><c:if
																test="${productCount == 1}">
																<a
																	href="${contextPath}/goods/goodsDetail.do?goods_id=${orders.goods_id}"
																	class="goods-link"> <img
																	src="${contextPath}/admin/order/image.do?goods_id=${orders.goods_id}&fileName=${orders.imageFileVO.fileName}"
																	class="card-img-goods" alt="${firstProductName}">
																</a>
															</c:if> <%-- ✅ 상품이 2개 이상이면 슬라이더 표시 --%> <c:if
																test="${productCount > 1}">
																<div id="carousel_orderList_${orders.order_id}"
																	class="carousel slide" data-bs-ride="carousel">
																	<div class="carousel-inner">
																		<c:set var="first" value="true" />
																		<c:forEach var="image"
																			items="${fn:split(imageList, ',')}">
																			<c:if test="${not empty image}">
																				<c:set var="imgData" value="${fn:split(image, ':')}" />
																				<div class="carousel-item ${first ? 'active' : ''}">
																					<a
																						href="${contextPath}/goods/goodsDetail.do?goods_id=${imgData[0]}"
																						class="goods-link"> <img
																						src="${contextPath}/admin/order/image.do?goods_id=${imgData[0]}&fileName=${imgData[1]}"
																						class="d-block w-100 card-img-goods" alt="상품 이미지">
																					</a>
																				</div>
																				<c:set var="first" value="false" />
																			</c:if>
																		</c:forEach>
																	</div>
																	<a class="carousel-control-prev"
																		href="#carousel_orderList_${orders.order_id}"
																		role="button" data-bs-slide="prev"> <span
																		class="carousel-control-prev-icon" aria-hidden="true"></span>
																		<span class="visually-hidden">Previous</span>
																	</a> <a class="carousel-control-next"
																		href="#carousel_orderList_${orders.order_id}"
																		role="button" data-bs-slide="next"> <span
																		class="carousel-control-next-icon" aria-hidden="true"></span>
																		<span class="visually-hidden">Next</span>
																	</a>
																</div>
															</c:if></td>

														<td class="text-center"><strong>${firstProductName}
																<c:if test="${productCount > 1}"> 외 ${productCount - 1}개</c:if>
														</strong></td>
														<td class="text-center"><strong>${totalQuantity}</strong></td>
														<td class="text-center"><strong><fmt:formatNumber
																	value="${totalPrice}" pattern="#,###" />원</strong></td>
														<td class="text-center"><strong>${orders.receiver_name}</strong></td>
														<td class="text-center"><strong><fmt:formatDate
																	value="${orders.complete_time}"
																	pattern="yyyy-MM-dd HH:mm" /></strong></td>
														<td class="text-center"><strong>${orders.delivery_address}</strong></td>
														<td class="text-center"><strong>${orders.delivery_state}</strong></td>
													</tr>

													<%-- ✅ 표시한 order_id를 저장하여 중복 출력 방지 --%>
													<c:set var="printedOrders"
														value="${printedOrders},${orders.order_id}" />
												</c:if>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
					</div>
					<hr class="bold">
					<div class="container2">
						<h2 class="ct2-title">개인 정보</h2>
						<br>
						<p class="big-text">이메일</p>
						<p class="small-text">${member.mem_email1}@${member.mem_email2}</p>
						<br>
						<hr>
						<br>
						<p class="big-text">기본 주소</p>
						<p class="small-text">${member.mem_zipcode}</p>
						<p class="small-text">${member.mem_add1}</p>
						<p class="small-text">${member.mem_add2}</p>
						<p class="small-text">${member.mem_add3}</p>
						<br>
					</div>
					<hr>
					<br>
					<div class="container2">
						<h3 class="big-text">추가 배송지</h3>
						<c:if test="${not empty addressList}">
							<div class="table-responsive">
								<table class="table table-striped">
									<thead style="background-color: #D2B48C;">
										<tr>
											<th class="text-center">번호</th>
											<th class="text-center">주소 이름</th>
											<th class="text-center">주소 정보</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="address" items="${addressList}">
											<tr>
												<td class="text-center">${address.address_id}</td>
												<td class="text-center">${address.address_name}</td>
												<td class="text-left">${address.mem_zipcode}<br>
													${address.mem_add1}<br> ${address.mem_add2}<br>
													${address.mem_add3}
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</c:if>

						<c:if test="${empty addressList}">
							<h2 class="small-text">추가된 배송지가 없습니다.</h2>
						</c:if>
					</div>
					<hr>
					<br> <br>
					<div class="container2">
						<h3 class="big-text">개인정보 동의 내역</h3>
						<p class="small-text">SMS 수신 동의 : ${member.mem_telsts_yn}</p>
						<p class="small-text">E-MAIL 수신 동의 : ${member.mem_emailsts_yn}</p>
						<a
							href="${contextPath}/member/modInfoForm.do?mem_id=${member.mem_id}"><input
							type="button" class="btn-custom" value="개인정보 수정" /></a>
					</div>
				</div>
				<div class="tab-content" id="orderList_content">
					<div class="container2">
						<h2 class="ct2-title">주문 내역</h2>
						<div class="table-responsive">
							<table class="table table-striped">
								<thead style="background-color: #D2B48C;">
									<tr>
										<th class="text-center">주문번호</th>
										<th class="text-center">이미지</th>
										<th class="text-center">상품명</th>
										<th class="text-center">수량</th>
										<th class="text-center">금액</th>
										<th class="text-center">수령인</th>
										<th class="text-center">주문날짜</th>
										<th class="text-center">배송지</th>
										<th class="text-center">배송상태</th>
										<th class="text-center">취소</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${empty ordersList}">
											<td colspan="10" class="text-center">조회된 주문 목록이 없습니다.</td>
										</c:when>
										<c:otherwise>



											<c:set var="printedOrders" value="" />
											<%-- 이미 출력한 order_id 저장용 변수 --%>


											<c:forEach var="orders" items="${ordersList}"
												varStatus="status">
												<c:if
													test="${not fn:contains(printedOrders, orders.order_id)}">
													<c:set var="totalQuantity" value="0" />
													<c:set var="totalPrice" value="0" />
													<c:set var="productCount" value="0" />
													<c:set var="firstProductName" value="" />

													<%-- ✅ 주문번호가 같은 상품 개수를 세고 첫 번째 상품명 가져오기 --%>
													<c:set var="imageList" value="" />
													<c:forEach var="subOrder" items="${ordersList}">
														<c:if test="${subOrder.order_id eq orders.order_id}">
															<c:set var="totalQuantity"
																value="${totalQuantity + subOrder.order_goods_qty}" />
															<c:set var="totalPrice"
																value="${totalPrice + subOrder.final_total_price}" />
															<c:set var="productCount" value="${productCount + 1}" />

															<%-- 첫 번째 상품명 설정 --%>
															<c:if test="${empty firstProductName}">
																<c:set var="firstProductName"
																	value="${subOrder.goodsVO.goods_name}" />
															</c:if>

															<%-- 이미지 리스트 저장 (슬라이더용) --%>
															<c:set var="imageList"
																value="${imageList},${subOrder.goods_id}:${subOrder.imageFileVO.fileName}" />
														</c:if>
													</c:forEach>

													<%-- ✅ 상품명이 없을 경우 기본값 설정 --%>
													<c:if test="${empty firstProductName}">
														<c:set var="firstProductName" value="상품 정보 없음" />
													</c:if>

													<tr>

														<td class="text-center"><a
															href="${contextPath}/order/orderResult.do?order_id=${orders.order_id}"
															class="order_id"> <strong>${orders.order_id}</strong>
														</a></td>

														<td class="text-center"><c:if
																test="${productCount == 1}">
																<!-- ✅ 주문이 한 개일 때 (크기 조정) -->
																<a
																	href="${contextPath}/goods/goodsDetail.do?goods_id=${orders.goods_id}"
																	class="goods-link"> <img
																	src="${contextPath}/admin/order/image.do?goods_id=${orders.goods_id}&fileName=${orders.imageFileVO.fileName}"
																	class="single-item-img" alt="${firstProductName}">
																</a>
															</c:if> <c:if test="${productCount > 1}">
																<!-- ✅ 주문이 여러 개일 때 (슬라이더 적용) -->
																<div id="carousel${orders.order_id}"
																	class="carousel slide" data-bs-ride="carousel">
																	<div class="carousel-inner">
																		<c:set var="first" value="true" />
																		<c:forEach var="image"
																			items="${fn:split(imageList, ',')}">
																			<c:if test="${not empty image}">
																				<c:set var="imgData" value="${fn:split(image, ':')}" />
																				<div class="carousel-item ${first ? 'active' : ''}">
																					<a
																						href="${contextPath}/goods/goodsDetail.do?goods_id=${imgData[0]}"
																						class="goods-link"> <img
																						src="${contextPath}/admin/order/image.do?goods_id=${imgData[0]}&fileName=${imgData[1]}"
																						class="d-block w-100 card-img-goods" alt="상품 이미지">
																					</a>
																				</div>
																				<c:set var="first" value="false" />
																			</c:if>
																		</c:forEach>
																	</div>
																	<a class="carousel-control-prev"
																		href="#carousel${orders.order_id}" role="button"
																		data-bs-slide="prev"> <span
																		class="carousel-control-prev-icon" aria-hidden="true"></span>
																		<span class="visually-hidden">Previous</span>
																	</a> <a class="carousel-control-next"
																		href="#carousel${orders.order_id}" role="button"
																		data-bs-slide="next"> <span
																		class="carousel-control-next-icon" aria-hidden="true"></span>
																		<span class="visually-hidden">Next</span>
																	</a>
																</div>

															</c:if></td>
														<td class="text-center"><strong>${firstProductName}
																<c:if test="${productCount > 1}"> 외 ${productCount - 1}개</c:if>
														</strong></td>
														<td class="text-center"><strong>${totalQuantity}</strong></td>
														<td class="text-center"><strong><fmt:formatNumber
																	value="${totalPrice}" pattern="#,###" />원</strong></td>
														<td class="text-center"><strong>${orders.receiver_name}</strong></td>
														<td class="text-center"><strong><fmt:formatDate
																	value="${orders.pay_order_time}"
																	pattern="yyyy-MM-dd HH:mm" /></strong></td>
														<td class="text-center"><strong>${orders.delivery_address}</strong></td>
														<td class="text-center"><strong>${orders.delivery_state}</strong></td>
														<td class="text-center">
															<button class="btn-custom refund-all-btn"
																data-tid="${orders.t_id}" data-price="${totalPrice}"
																data-order-id="${orders.order_id}">취소</button>
														</td>
													</tr>

													<%-- ✅ 표시한 order_id를 저장하여 중복 출력 방지 --%>
													<c:set var="printedOrders"
														value="${printedOrders},${orders.order_id}" />
												</c:if>
											</c:forEach>





										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
						<br>
						<hr>
						<br>
						<h2>배송 내역</h2>
						<div class="table-responsive">
							<table class="table table-striped">
								<thead style="background-color: #D2B48C;">
									<tr>
										<th class="text-center">주문번호</th>
										<th class="text-center">상품이미지</th>
										<th class="text-center">상품명</th>
										<th class="text-center">수량</th>
										<th class="text-center">금액</th>
										<th class="text-center">수령자</th>
										<th class="text-center">배송날짜</th>
										<th class="text-center">배송지</th>
										<th class="text-center">배송상태</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${empty ordersList_done}">
											<td colspan="10" class="text-center">배송 완료된 주문 목록이 없습니다.</td>
										</c:when>
										<c:otherwise>
											<c:forEach var="orders" items="${ordersList_done}"
												varStatus="status">
												<c:if
													test="${not fn:contains(printedOrders, orders.order_id)}">
													<c:set var="totalQuantity" value="0" />
													<c:set var="totalPrice" value="0" />
													<c:set var="productCount" value="0" />
													<c:set var="firstProductName" value="" />
													<c:set var="imageList" value="" />
													<%-- ✅ 주문번호가 같은 상품 개수를 세고 첫 번째 상품명 가져오기 --%>
													<c:if
														test="${not fn:contains(imageList, subOrder.goods_id)}">
														<c:set var="imageList"
															value="${imageList},${subOrder.goods_id}:${subOrder.imageFileVO.fileName}" />
													</c:if>
													<c:forEach var="subOrder" items="${ordersList_done}">
														<c:if test="${subOrder.order_id eq orders.order_id}">
															<c:set var="totalQuantity"
																value="${totalQuantity + subOrder.order_goods_qty}" />
															<c:set var="totalPrice"
																value="${totalPrice + subOrder.final_total_price}" />
															<c:set var="productCount" value="${productCount + 1}" />

															<%-- 첫 번째 상품명 설정 --%>
															<c:if test="${empty firstProductName}">
																<c:set var="firstProductName"
																	value="${subOrder.goodsVO.goods_name}" />
															</c:if>

															<%-- 이미지 리스트 저장 (슬라이더용) --%>
															<c:set var="imageList"
																value="${imageList},${subOrder.goods_id}:${subOrder.imageFileVO.fileName}" />
														</c:if>
													</c:forEach>

													<%-- ✅ 상품명이 없을 경우 기본값 설정 --%>
													<c:if test="${empty firstProductName}">
														<c:set var="firstProductName" value="상품 정보 없음" />
													</c:if>

													<tr>

														<td class="text-center"><a
															href="${contextPath}/order/orderResult.do?order_id=${orders.order_id}"
															class="order_id"> <strong>${orders.order_id}</strong>
														</a></td>

														<td class="text-center"><c:if
																test="${productCount == 1}">
																<!-- ✅ 주문이 한 개일 때 (크기 조정) -->
																<a
																	href="${contextPath}/goods/goodsDetail.do?goods_id=${orders.goods_id}"
																	class="goods-link"> <img
																	src="${contextPath}/admin/order/image.do?goods_id=${orders.goods_id}&fileName=${orders.imageFileVO.fileName}"
																	class="single-item-img" alt="${firstProductName}">
																</a>
															</c:if> <c:if test="${productCount > 1}">
																<!-- ✅ 주문이 여러 개일 때 (슬라이더 적용) -->
																<div id="carousel${orders.order_id}"
																	class="carousel slide" data-bs-ride="carousel">
																	<div class="carousel-inner">
																		<c:set var="first" value="true" />
																		<c:forEach var="image"
																			items="${fn:split(imageList, ',')}">
																			<c:if test="${not empty image}">
																				<c:set var="imgData" value="${fn:split(image, ':')}" />
																				<div class="carousel-item ${first ? 'active' : ''}">
																					<a
																						href="${contextPath}/goods/goodsDetail.do?goods_id=${imgData[0]}"
																						class="goods-link"> <img
																						src="${contextPath}/admin/order/image.do?goods_id=${imgData[0]}&fileName=${imgData[1]}"
																						class="d-block w-100 card-img-goods" alt="상품 이미지">
																					</a>
																				</div>
																				<c:set var="first" value="false" />
																			</c:if>
																		</c:forEach>
																	</div>
																	<a class="carousel-control-prev"
																		href="#carousel${orders.order_id}" role="button"
																		data-bs-slide="prev"> <span
																		class="carousel-control-prev-icon" aria-hidden="true"></span>
																		<span class="visually-hidden">Previous</span>
																	</a> <a class="carousel-control-next"
																		href="#carousel${orders.order_id}" role="button"
																		data-bs-slide="next"> <span
																		class="carousel-control-next-icon" aria-hidden="true"></span>
																		<span class="visually-hidden">Next</span>
																	</a>
																</div>

															</c:if></td>
														<td class="text-center"><strong>${firstProductName}
																<c:if test="${productCount > 1}"> 외 ${productCount - 1}개</c:if>
														</strong></td>
														<td class="text-center"><strong>${totalQuantity}</strong></td>
														<td class="text-center"><strong><fmt:formatNumber
																	value="${totalPrice}" pattern="#,###" />원</strong></td>
														<td class="text-center"><strong>${orders.receiver_name}</strong></td>
														<td class="text-center"><strong><fmt:formatDate
																	value="${orders.complete_time}"
																	pattern="yyyy-MM-dd HH:mm" /></strong></td>
														<td class="text-center"><strong>${orders.delivery_address}</strong></td>
														<td class="text-center"><strong>${orders.delivery_state}</strong></td>
													</tr>

													<%-- ✅ 표시한 order_id를 저장하여 중복 출력 방지 --%>
													<c:set var="printedOrders"
														value="${printedOrders},${orders.order_id}" />
												</c:if>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
						<br>
						<hr>
						<br>
						<h2>취소 내역</h2>
						<div class="table-responsive">
							<table class="table table-striped">
								<thead style="background-color: #D2B48C;">
									<tr>
										<th class="text-center">주문번호</th>
										<th class="text-center">상품이미지</th>
										<th class="text-center">상품명</th>
										<th class="text-center">수량</th>
										<th class="text-center">금액</th>
										<th class="text-center">수령자</th>
										<th class="text-center">취소날짜</th>
										<th class="text-center">배송지</th>
										<th class="text-center">배송상태</th>
									</tr>
								</thead>

								<tbody>
									<c:choose>
										<c:when test="${empty ordersList_cancel}">
											<td colspan="10" class="text-center">취소 완료된 주문 목록이 없습니다.</td>
										</c:when>
										<c:otherwise>
											<c:forEach var="orders" items="${ordersList_cancel}"
												varStatus="status">
												<c:if
													test="${not fn:contains(printedOrders, orders.order_id)}">
													<c:set var="totalQuantity" value="0" />
													<c:set var="totalPrice" value="0" />
													<c:set var="productCount" value="0" />
													<c:set var="firstProductName" value="" />
													<%-- ✅ 주문번호가 같은 상품 개수를 세고 첫 번째 상품명 가져오기 --%>
													<c:if
														test="${not fn:contains(imageList, subOrder.goods_id)}">
														<c:set var="imageList"
															value="${imageList},${subOrder.goods_id}:${subOrder.imageFileVO.fileName}" />
													</c:if>
													<c:set var="imageList" value="" />
													<c:forEach var="subOrder" items="${ordersList_cancel}">
														<c:if test="${subOrder.order_id eq orders.order_id}">
															<c:set var="totalQuantity"
																value="${totalQuantity + subOrder.order_goods_qty}" />
															<c:set var="totalPrice"
																value="${totalPrice + subOrder.final_total_price}" />
															<c:set var="productCount" value="${productCount + 1}" />

															<%-- 첫 번째 상품명 설정 --%>
															<c:if test="${empty firstProductName}">
																<c:set var="firstProductName"
																	value="${subOrder.goodsVO.goods_name}" />
															</c:if>

															<%-- 이미지 리스트 저장 (슬라이더용) --%>
															<c:set var="imageList"
																value="${imageList},${subOrder.goods_id}:${subOrder.imageFileVO.fileName}" />
														</c:if>
													</c:forEach>

													<%-- ✅ 상품명이 없을 경우 기본값 설정 --%>
													<c:if test="${empty firstProductName}">
														<c:set var="firstProductName" value="상품 정보 없음" />
													</c:if>

													<tr>

														<td class="text-center"><a
															href="${contextPath}/order/orderResult.do?order_id=${orders.order_id}"
															class="order_id"> <strong>${orders.order_id}</strong>
														</a></td>

														<td class="text-center"><c:if
																test="${productCount == 1}">
																<!-- ✅ 주문이 한 개일 때 (크기 조정) -->
																<a
																	href="${contextPath}/goods/goodsDetail.do?goods_id=${orders.goods_id}"
																	class="goods-link"> <img
																	src="${contextPath}/admin/order/image.do?goods_id=${orders.goods_id}&fileName=${orders.imageFileVO.fileName}"
																	class="card-img-top" alt="${firstProductName}">
																</a>
															</c:if> <c:if test="${productCount > 1}">
																<!-- ✅ 주문이 여러 개일 때 (슬라이더 적용) -->
																<div id="carousel${orders.order_id}"
																	class="carousel slide" data-bs-ride="carousel">
																	<div class="carousel-inner">
																		<c:set var="first" value="true" />
																		<c:forEach var="image"
																			items="${fn:split(imageList, ',')}">
																			<c:if test="${not empty image}">
																				<c:set var="imgData" value="${fn:split(image, ':')}" />
																				<div class="carousel-item ${first ? 'active' : ''}">
																					<a
																						href="${contextPath}/goods/goodsDetail.do?goods_id=${imgData[0]}"
																						class="goods-link"> <img
																						src="${contextPath}/admin/order/image.do?goods_id=${imgData[0]}&fileName=${imgData[1]}"
																						class="d-block w-100 card-img-goods" alt="상품 이미지">
																					</a>
																				</div>
																				<c:set var="first" value="false" />
																			</c:if>
																		</c:forEach>
																	</div>
																	<a class="carousel-control-prev"
																		href="#carousel${orders.order_id}" role="button"
																		data-bs-slide="prev"> <span
																		class="carousel-control-prev-icon" aria-hidden="true"></span>
																		<span class="visually-hidden">Previous</span>
																	</a> <a class="carousel-control-next"
																		href="#carousel${orders.order_id}" role="button"
																		data-bs-slide="next"> <span
																		class="carousel-control-next-icon" aria-hidden="true"></span>
																		<span class="visually-hidden">Next</span>
																	</a>
																</div>

															</c:if></td>
														<td class="text-center"><strong>${firstProductName}
																<c:if test="${productCount > 1}"> 외 ${productCount - 1}개</c:if>
														</strong></td>
														<td class="text-center"><strong>${totalQuantity}</strong></td>
														<td class="text-center"><strong><fmt:formatNumber
																	value="${totalPrice}" pattern="#,###" />원</strong></td>
														<td class="text-center"><strong>${orders.receiver_name}</strong></td>
														<td class="text-center"><strong><fmt:formatDate
																	value="${orders.complete_time}"
																	pattern="yyyy-MM-dd HH:mm" /></strong></td>
														<td class="text-center"><strong>${orders.delivery_address}</strong></td>
														<td class="text-center"><strong>${orders.delivery_state}</strong></td>
													</tr>

													<%-- ✅ 표시한 order_id를 저장하여 중복 출력 방지 --%>
													<c:set var="printedOrders"
														value="${printedOrders},${orders.order_id}" />
												</c:if>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</tbody>

							</table>
						</div>
					</div>
				</div>
				<div class="tab-content" id="address_content">
					<div class="user-address-info">
						<h3 class="big-text">현재 기본 주소</h3>
						<br>
						<p class="small-text">${member.mem_zipcode}</p>
						<p class="small-text">${member.mem_add1}</p>
						<p class="small-text">${member.mem_add2}</p>
						<p class="small-text">${member.mem_add3 }</p>
						<a href="${contextPath}/member/modMemberAdd.do"><input
							type="button" class="btn-custom" value="주소 수정" /></a> <br>
						<hr>
						<br>
					</div>
				</div>
				<div class="tab-content" id="myaddresses_content">
					<div class="container2">
						<h3 class="big-text">추가 배송지</h3>
						<c:if test="${not empty addressList}">
							<div class="table-responsive">
								<table class="table table-striped">
									<thead style="background-color: #D2B48C;">
										<tr>
											<th class="text-center">번호</th>
											<th class="text-center">주소 이름</th>
											<th class="text-center">주소 정보</th>
											<th class="text-center">수정</th>
											<th class="text-center">삭제</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="address" items="${addressList}">
											<tr>
												<td class="text-center">${address.address_id}</td>
												<td class="text-center">${address.address_name}</td>
												<td class="text-left">${address.mem_zipcode}<br>
													${address.mem_add1}<br> ${address.mem_add2}<br>
													${address.mem_add3}
												</td>
												<td><a
													href="${contextPath}/address/modAddressForm.do?address_id=${address.address_id}"><input
														type="button" class="btn-custom" value="배송지 수정" /></a></td>
												<td><a href="javascript:void(0);" class="btn-custom"
													onclick="deleteAddress(${address.address_id});">배송지 삭제</a></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<!-- 추가 -->
								<a href="${contextPath}/address/addAddressForm.do"><input
									type="button" class="btn-custom" value="배송지 추가" /></a>
							</div>
						</c:if>

						<c:if test="${empty addressList}">
							<h2 class="small-text">추가된 배송지가 없습니다.</h2>
							<a href="${contextPath}/address/addAddressForm.do"><input
								type="button" class="btn-custom" value="배송지 추가" /></a>
						</c:if>
					</div>
				</div>
				<div class="tab-content" id="point_content">
					<div class="container2">
						<h2 class="ct2-title">포인트 적립 내역</h2>
						<div class="table-responsive">
							<h4>상품 구매</h4>
							<table class="table table-striped">
								<thead style="background-color: #D2B48C;">
									<tr>
										<th class="text-center">번호</th>
										<th class="text-center">주문 상품</th>
										<th class="text-center">상품 가격</th>
										<th class="text-center">적립 방법</th>
										<th class="text-center">적립 날짜</th>
										<th class="text-center">포인트 수량</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${empty pointsList_get}">
											<tr>
												<td colspan="6" class="text-center"><strong>조회된
														포인트 적립 내역이 없습니다.</strong></td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach var="points_get" items="${pointsList_get}"
												varStatus="status">
												<c:set var="goodsNames"
													value="${fn:split(points_get.goods_names, ', ')}" />
												<c:set var="finalPrices"
													value="${fn:split(points_get.final_total_price, ', ')}" />

												<tr>
													<!-- 번호 -->
													<td class="text-center"><strong>${status.index + 1}</strong></td>

													<!-- 주문 상품 (리스트 형태) -->
													<td class="text-center">
														<ul
															style="padding-left: 0; margin-bottom: 0; list-style: none; text-align: center; vertical-align: middle;">
															<c:forEach var="goods" items="${goodsNames}">
																<li class="name_list"><strong>${goods}</strong></li>
															</c:forEach>
														</ul>
													</td>

													<!-- 상품 가격 (리스트 형태) -->
													<td class="text-center"><strong><fmt:formatNumber
																value="${points_get.final_total_price}"
																pattern="###,###" />원</strong></td>
													<!-- 적립 타입 -->
													<td class="text-center"><strong>${points_get.action_type}</strong></td>

													<!-- 적립 날짜 -->
													<td class="text-center"><strong><fmt:formatDate
																value="${points_get.action_date}" pattern="yyyy-MM-dd" /></strong></td>

													<!-- 포인트 수량 -->
													<td class="text-center"><strong>${points_get.point_amount}</strong></td>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>

								</tbody>
							</table>
						</div>
						<br>
						<hr>
						<br>
						<div class="table-responsive">
							<h4>리뷰 작성</h4>
							<table class="table table-striped">
								<thead style="background-color: #D2B48C;">
									<tr>
										<th class="text-center">번호</th>
										<th class="text-center">적립 방법</th>
										<th class="text-center">적립 날짜</th>
										<th class="text-center">포인트 수량</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${empty pointsList_get_review}">
											<tr>
												<td colspan="4" class="text-center"><strong>조회된
														포인트 적립 내역이 없습니다.</strong></td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach var="points_get_review"
												items="${pointsList_get_review}" varStatus="status">
												<tr>
													<!-- 번호 -->
													<td class="text-center"><strong>${status.index + 1}</strong></td>
													<!-- 적립 타입 -->
													<td class="text-center"><strong>${points_get_review.action_type}</strong></td>
													<!-- 적립 날짜 -->
													<td class="text-center"><strong><fmt:formatDate
																value="${points_get_review.action_date}"
																pattern="yyyy-MM-dd" /></strong></td>
													<!-- 포인트 수량 -->
													<td class="text-center"><strong>${points_get_review.point_amount}</strong></td>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>

								</tbody>
							</table>
						</div>
					</div>
					<br>
					<hr>
					<br>
					<div class="container2">
						<h2 class="ct2-title">포인트 사용 내역</h2>
						<div class="table-responsive">
							<table class="table table-striped">
								<thead style="background-color: #D2B48C;">
									<tr>
										<th class="text-center">번호</th>
										<th class="text-center">주문 상품</th>
										<th class="text-center">상품 가격</th>
										<th class="text-center">적립 방법</th>
										<th class="text-center">사용 날짜</th>
										<th class="text-center">포인트 수량</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${empty pointsList_use}">
											<tr>
												<td colspan="6" class="text-center"><strong>조회된
														포인트 사용 내역이 없습니다.</strong></td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach var="points_use" items="${pointsList_use}"
												varStatus="status">
												<c:set var="goodsNames"
													value="${fn:split(points_use.goods_names, ', ')}" />
												<c:set var="finalPrices"
													value="${fn:split(points_use.final_total_price, ', ')}" />

												<tr>
													<!-- 번호 -->
													<td class="text-center"><strong>${status.index + 1}</strong></td>

													<!-- 주문 상품 (리스트 형태) -->
													<td class="text-center">
														<ul
															style="list-style: none; margin-bottom: 0; text-align: center; vertical-align: middle;">
															<c:forEach var="goods" items="${goodsNames}">
																<li class="name_list"
																	style="display: block; margin-bottom: 5px;"><strong>${goods}</strong></li>
															</c:forEach>
														</ul>
													</td>


													<!-- 상품 가격 (리스트 형태) -->
													<td class="text-center"><strong><fmt:formatNumber
																value="${points_use.final_total_price}"
																pattern="###,###" />원</strong></td>

													<!-- 적립 타입 -->
													<td class="text-center"><strong>${points_use.action_type}</strong></td>

													<!-- 적립 날짜 -->
													<td class="text-center"><strong><fmt:formatDate
																value="${points_use.action_date}" pattern="yyyy-MM-dd" /></strong></td>

													<!-- 포인트 수량 -->
													<td class="text-center"><strong>${points_use.point_amount}</strong></td>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>

								</tbody>
							</table>
						</div>
					</div>
				</div>

			</div>
		</p:when>
	</p:choose>

	<div class="footer">
		<%@ include file="../common/footer.jsp"%>
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
            
            // 회원탈퇴를 누르면 바로 회원탈퇴 페이지로 리다이렉트
            function redirectToSignoutPage() {
                // 회원탈퇴 페이지로 리다이렉트
                window.location.href = "${contextPath}/mypage/SignOutForm.do"; // 회원탈퇴 페이지의 URL
            }
        </script>
</body>
</html>
