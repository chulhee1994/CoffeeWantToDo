<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%
    request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
	<style>
		body{
			height: 100%;
		}
		.container2 {
			padding: 10px 10px;
		}
		.container2 th {
			border-top: 1px solid gray;
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
		.table td, .table th {
                vertical-align: middle; /* 셀 내부 수직 중앙 정렬 */
                text-align: center; /* 셀 내부 수평 중앙 정렬 */
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
				.carousel-control-prev,
				.carousel-control-next {
				    top: 50% !important; /* Bootstrap 기본 스타일 덮어쓰기 */
				    transform: translateY(-50%) !important;
				    width: 30px; /* 버튼 크기 조정 */
				    height: 30px;
				    opacity: 0.8; /* 버튼 가시성 향상 */
				    position: absolute; /* 위치 고정 */
				}
				
				/* ✅ 슬라이더 버튼 아이콘 크기 및 스타일 */
				.carousel-control-prev-icon,
				.carousel-control-next-icon {
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    // select 값에 따라 delivery_state 변경
    function selectBoxChange_delivery_state(order_id, delivery_state) {
        if (confirm("배송상태를 변경 하시겠습니까?")) {
            $.ajax({
                url: "${contextPath}/admin/order/modDeliveryState.do",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({
                    "order_id": order_id,
                    "delivery_state": delivery_state
                }),
                success: function(data, textStatus, xhr) {
                    if (data.success) {
                        alert("변경 완료되었습니다.");
                        document.location.reload(true);
                    } else {
                        alert("변경 실패: " + data.message);
                    }
                    console.log(data);
                },
                error: function(xhr, status, error) {
                    console.log(error);
                    alert("변경 실패");
                }
            });
        } else {
            // 취소하면 아무 것도 하지 않음
        }
    }
</script>
<link rel="stylesheet" href="${contextPath}/resources/css/admin/mgmOrder/mgmOrder.css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<title>주문 관리 페이지</title>
</head>
<body>
    <div class="header">
        <%@ include file="../../common/header.jsp" %>
    </div>

    <div class="container">
    <br>
        <h2 class="ct2-title">주문 목록</h2>
        <div class="table-responsive">
            <table class="table table-striped">
                <thead style="background-color: #D2B48C;">
                    <tr>
                        <th class="text-center">번호</th>
                        <th class="text-center">주문번호</th>
                        <th class="text-center">상품 이미지</th>
                        <th class="text-center">상품명</th>
                        <th class="text-center">수량</th>
                        <th class="text-center">금액</th>
                        <th class="text-center">주문자</th>
                        <th class="text-center">수령인</th>
                        <th class="text-center">배송지</th>
                        <th class="text-center">배송 상태</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty ordersList}">
                            <h3 class="text-gray">조회된 주문 목록이 없습니다.</h3>
                        </c:when>
                        <c:otherwise>
                            <c:set var="printedOrders" value="" />

                            <c:forEach var="orders" items="${ordersList}" varStatus="status">
                                <c:if test="${not fn:contains(printedOrders, orders.order_id)}">
                                    <c:set var="totalQuantity" value="0" />
                                    <c:set var="totalPrice" value="0" />
                                    <c:set var="productCount" value="0" />
                                    <c:set var="firstProductName" value="" />
                                    <c:set var="imageList" value="" />

                                    <!-- 주문 번호에 해당하는 상품 리스트 계산 -->
                                    <c:forEach var="subOrder" items="${ordersList}">
                                        <c:if test="${subOrder.order_id eq orders.order_id}">
                                            <c:set var="totalQuantity" value="${totalQuantity + subOrder.order_goods_qty}" />
                                            <c:set var="totalPrice" value="${totalPrice + subOrder.final_total_price}" />
                                            <c:set var="productCount" value="${productCount + 1}" />
                                            <c:if test="${empty firstProductName}">
                                                <c:set var="firstProductName" value="${subOrder.goodsVO.goods_name}" />
                                            </c:if>
                                            <c:set var="imageList" value="${imageList},${subOrder.goods_id}:${subOrder.imageFileVO.fileName}" />
                                        </c:if>
                                    </c:forEach>

                                    <c:if test="${empty firstProductName}">
                                        <c:set var="firstProductName" value="상품 정보 없음" />
                                    </c:if>

                                    <tr>
                                        <td class="text-center">
                                            <strong>${status.index + 1}</strong>
                                        </td>
                                        <td class="text-center">
                                            <strong>${orders.order_id}</strong>
                                        </td>
                                        <td class="text-center">
                                            <!-- 캐러셀로 상품 이미지 출력 -->
                                            <c:if test="${productCount == 1}">
                                                <a href="${contextPath}/goods/goodsDetail.do?goods_id=${orders.goods_id}" class="goods-link">
                                                    <img src="${contextPath}/admin/order/image.do?goods_id=${orders.goods_id}&fileName=${orders.imageFileVO.fileName}" 
                                                         class="card-img-top" alt="${firstProductName}">
                                                </a>
                                            </c:if>

                                            <c:if test="${productCount > 1}">
                                                <div id="carousel${orders.order_id}" class="carousel slide" data-bs-ride="carousel">
                                                    <div class="carousel-inner">
                                                        <c:set var="first" value="true" />
                                                        <c:forEach var="image" items="${fn:split(imageList, ',')}">
                                                            <c:if test="${not empty image}">
                                                                <c:set var="imgData" value="${fn:split(image, ':')}" />
                                                                <div class="carousel-item ${first ? 'active' : ''}">
                                                                    <a href="${contextPath}/goods/goodsDetail.do?goods_id=${imgData[0]}" class="goods-link">
                                                                        <img src="${contextPath}/admin/order/image.do?goods_id=${imgData[0]}&fileName=${imgData[1]}" 
                                                                             class="d-block w-100 card-img-goods" alt="상품 이미지">
                                                                    </a>
                                                                </div>
                                                                <c:set var="first" value="false" />
                                                            </c:if>
                                                        </c:forEach>
                                                    </div>
                                                    <a class="carousel-control-prev" href="#carousel${orders.order_id}" role="button" data-bs-slide="prev">
                                                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                                        <span class="visually-hidden">Previous</span>
                                                    </a>
                                                    <a class="carousel-control-next" href="#carousel${orders.order_id}" role="button" data-bs-slide="next">
                                                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                                        <span class="visually-hidden">Next</span>
                                                    </a>
                                                </div>
                                            </c:if>
                                        </td>
                                        <td class="text-center">
                                            <strong>${firstProductName}
                                                <c:if test="${productCount > 1}"> 외 ${productCount - 1}개</c:if>
                                            </strong>
                                        </td>
                                        <td class="text-center"><strong>${totalQuantity}</strong></td>
                                        <td class="text-center"><strong><fmt:formatNumber value="${totalPrice}" pattern="#,###"/>원</strong></td>
                                        <td class="text-center"><strong>${orders.orderer_name}</strong></td>
                                        <td class="text-center"><strong>${orders.receiver_name}</strong></td>
                                        <td class="text-center"><strong>${orders.delivery_address}</strong></td> 
                                        <td class="text-center">
                                            <select name="delivery_state${orders.delivery_state}" id="delivery_state${orders.delivery_state}" onchange="selectBoxChange_delivery_state('${orders.order_id}',this.value);" style="text-align: center;">
                                                <option value="배송준비중" ${orders.delivery_state == '배송준비중' ? 'selected' : ''}>배송준비중</option>
                                                <option value="배송중" ${orders.delivery_state == '배송중' ? 'selected' : ''}>배송중</option>
                                                <option value="배송지연" ${orders.delivery_state == '배송지연' ? 'selected' : ''}>배송지연</option>
                                                <option value="배송완료" ${orders.delivery_state == '배송완료' ? 'selected' : ''}>배송완료</option>
                                            </select>
                                        </td>
                                    </tr>

                                    <c:set var="printedOrders" value="${printedOrders},${orders.order_id}" />
                                </c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <div class="footer">
        <%@ include file="../../common/footer.jsp" %>
    </div>
</body>
</html>
