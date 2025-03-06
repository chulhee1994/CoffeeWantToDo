<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Merriweather:ital,wght@0,300;0,400;0,700;0,900&display=swap" rel="stylesheet">
<script type="text/javascript">const contextPath = "${contextPath}";</script>
<script src="${contextPath}/resources/js/chatio.js" type="text/javascript"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" href="${contextPath}/resources/css/defaultStyle.css">
<title>Insert title here</title>
</head>
<body>
		<div class="header">
			<%@ include file="../common/header.jsp" %>
		</div>
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
				                  </tr>                  
				                  </thead>
                                <tbody>
                     <c:choose>
                     <c:when test="${empty SellerOrdersList}">
                     <td  colspan="10" class="text-center">조회된 주문 목록이 없습니다.</td>
                     </c:when>
                      <c:otherwise>
                         
                          
                          
                     <c:set var="printedOrders" value="" />  <%-- 이미 출력한 order_id 저장용 변수 --%>


				<c:forEach var="orders" items="${SellerOrdersList}" varStatus="status">   
				    <c:if test="${not fn:contains(printedOrders, orders.order_id)}">
				        <c:set var="totalQuantity" value="0"/>
				        <c:set var="totalPrice" value="0"/>
				        <c:set var="productCount" value="0"/>
				        <c:set var="firstProductName" value="" />
				
				        <%-- ✅ 주문번호가 같은 상품 개수를 세고 첫 번째 상품명 가져오기 --%>
				        <c:set var="imageList" value="" />
				        <c:forEach var="subOrder" items="${SellerOrdersList}">
				            <c:if test="${subOrder.order_id eq orders.order_id}">
				                <c:set var="totalQuantity" value="${totalQuantity + subOrder.order_goods_qty}" />
				                <c:set var="totalPrice" value="${totalPrice + subOrder.final_total_price}" />
				                <c:set var="productCount" value="${productCount + 1}" />
				
				                <%-- 첫 번째 상품명 설정 --%>
				                <c:if test="${empty firstProductName}">
				                    <c:set var="firstProductName" value="${subOrder.goodsVO.goods_name}" />
				                </c:if>
				
				                <%-- 이미지 리스트 저장 (슬라이더용) --%>
				                <c:set var="imageList" value="${imageList},${subOrder.goods_id}:${subOrder.imageFileVO.fileName}" />
				            </c:if>
				        </c:forEach>
				
				        <%-- ✅ 상품명이 없을 경우 기본값 설정 --%>
				        <c:if test="${empty firstProductName}">
				            <c:set var="firstProductName" value="상품 정보 없음" />
				        </c:if>
				
				        <tr>
				            
				            <td class="text-center"> 				                
				                    <strong>${orders.order_id}</strong>
				            </td>                            
				            
				            <td class="text-center">
    <c:if test="${productCount == 1}">
        <!-- ✅ 주문이 한 개일 때 (크기 조정) -->
        <a href="${contextPath}/goods/goodsDetail.do?goods_id=${orders.goods_id}" class="goods-link">
            <img src="${contextPath}/admin/order/image.do?goods_id=${orders.goods_id}&fileName=${orders.imageFileVO.fileName}" 
                 class="single-item-img" alt="${firstProductName}">
        </a>
    </c:if>

    <c:if test="${productCount > 1}">
        <!-- ✅ 주문이 여러 개일 때 (슬라이더 적용) -->
        <div id="carousel${orders.order_id}" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-inner">
        <c:set var="first" value="true"/>
        <c:forEach var="image" items="${fn:split(imageList, ',')}">
            <c:if test="${not empty image}">
                <c:set var="imgData" value="${fn:split(image, ':')}" />
                <div class="carousel-item ${first ? 'active' : ''}">
                    <a href="${contextPath}/goods/goodsDetail.do?goods_id=${imgData[0]}" class="goods-link">
                        <img src="${contextPath}/admin/order/image.do?goods_id=${imgData[0]}&fileName=${imgData[1]}" 
                             class="d-block w-100 card-img-goods" alt="상품 이미지">
                    </a>
                </div>
                <c:set var="first" value="false"/>
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
				            <td class="text-center"><strong>${orders.receiver_name}</strong></td>
				            <td class="text-center"><strong><fmt:formatDate value="${orders.pay_order_time}" pattern="yyyy-MM-dd HH:mm"/></strong></td>
				            <td class="text-center"><strong>${orders.delivery_address}</strong></td> 
				            <td class="text-center"><strong>${orders.delivery_state}</strong></td>
				        </tr>  
				
				        <%-- ✅ 표시한 order_id를 저장하여 중복 출력 방지 --%>
				        <c:set var="printedOrders" value="${printedOrders},${orders.order_id}" />
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
                     <c:when test="${empty SellerOrdersList_done}">
						<td  colspan="10" class="text-center">배송 완료된 주문 목록이 없습니다.</td>
                     </c:when>
                      <c:otherwise>
                         	<c:forEach var="sorders" items="${SellerOrdersList_done}"
												varStatus="status">
												<c:if
													test="${not fn:contains(printedOrders, sorders.order_id)}">
													<c:set var="totalQuantity" value="0" />
													<c:set var="totalPrice" value="0" />
													<c:set var="productCount" value="0" />
													<c:set var="firstProductName" value="" />
													<c:set var="imageList" value="" />
													<%-- ✅ 주문번호가 같은 상품 개수를 세고 첫 번째 상품명 가져오기 --%>
													<c:if test="${not fn:contains(imageList, subOrder.goods_id)}">
    <c:set var="imageList" value="${imageList},${subOrder.goods_id}:${subOrder.imageFileVO.fileName}" />
</c:if>
													<c:forEach var="subOrders" items="${SellerOrdersList_done}">
														<c:if test="${subOrders.order_id eq orders.order_id}">
															<c:set var="totalQuantity"
																value="${totalQuantity + subOrders.order_goods_qty}" />
															<c:set var="totalPrice"
																value="${totalPrice + subOrders.final_total_price}" />
															<c:set var="productCount" value="${productCount + 1}" />

															<%-- 첫 번째 상품명 설정 --%>
															<c:if test="${empty firstProductName}">
																<c:set var="firstProductName"
																	value="${subOrders.goodsVO.goods_name}" />
															</c:if>

															<%-- 이미지 리스트 저장 (슬라이더용) --%>
															<c:set var="imageList"
																value="${imageList},${subOrders.goods_id}:${subOrders.imageFileVO.fileName}" />
														</c:if>
													</c:forEach>

													<%-- ✅ 상품명이 없을 경우 기본값 설정 --%>
													<c:if test="${empty firstProductName}">
														<c:set var="firstProductName" value="상품 정보 없음" />
													</c:if>

													<tr>

														<td class="text-center">
														<strong>${sorders.order_id}</strong>
														</td>

														<td class="text-center"><c:if
																test="${productCount == 1}">
																<!-- ✅ 주문이 한 개일 때 (크기 조정) -->
																<a
																	href="${contextPath}/goods/goodsDetail.do?goods_id=${sorders.goods_id}"
																	class="goods-link"> <img
																	src="${contextPath}/admin/order/image.do?goods_id=${sorders.goods_id}&fileName=${sorders.imageFileVO.fileName}"
																	class="single-item-img" alt="${firstProductName}">
																</a>
															</c:if> <c:if test="${productCount > 1}">
																<!-- ✅ 주문이 여러 개일 때 (슬라이더 적용) -->
																<div id="carousel${sorders.order_id}"
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
																		href="#carousel${sorders.order_id}" role="button"
																		data-bs-slide="prev"> <span
																		class="carousel-control-prev-icon" aria-hidden="true"></span>
																		<span class="visually-hidden">Previous</span>
																	</a> <a class="carousel-control-next"
																		href="#carousel${sorders.order_id}" role="button"
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
														value="${printedOrders},${sorders.order_id}" />
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
										<td  colspan="10" class="text-center">취소 완료된 주문 목록이 없습니다.</td>
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
													<c:if test="${not fn:contains(imageList, subOrder.goods_id)}">
    <c:set var="imageList" value="${imageList},${subOrder.goods_id}:${subOrder.imageFileVO.fileName}" />
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

														<td class="text-center">
														<strong>${orders.order_id}</strong>
														</td>

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
                        </div>
</body>
</html>