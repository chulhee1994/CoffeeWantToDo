<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="com.inicis.std.util.SignatureUtil" %>


<c:set var="singleOrder" value="${sessionScope.singleOrder}" />
<c:set var="selectedOrderList" value="${sessionScope.selectedOrderList}" />
<c:set var="addressList" value="${sessionScope.addressList}"/>
<c:set var="member" value="${sessionScope.member}"/>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!-- 주문자 휴대폰 번호 -->
<c:set var="orderer_hp" value="" />
<!-- 최종 결제 금액 -->
<c:set var="final_total_order_price" value="0" />

<!-- 총주문 금액 -->
<c:set var="total_order_price" value="0" />
<!-- 총 상품수 -->
<c:set var="total_order_goods_qty" value="0" />
<!-- 총할인금액 -->
<c:set var="total_discount_price" value="0" />
<!-- 총 배송비 -->
<c:set var="total_delivery_price" value="0" />
<!-- 총 포인트 -->
<c:set var="total_Point" value="0" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>주문 정보</title>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
	rel="stylesheet">
<!-- Bootstrap CSS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<head>
<style>
* {
	font-family: 'Noto Sans KR', sans-serif;
}

body {
	background-color: #f4f4f4;
	margin: 0;
	padding: 0;
	color: ECE6E6;
}

.container {
	max-width: 1000px;
	margin: 50px auto;
	background-color: #fff;
	padding: 40px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
	border-radius: 3px;
}

table {
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
a{
	color: black !important;
	text-decoration: none !important;
}
h2 {
	text-align: center;
	font-size: 18px;
	font-weight: 700;
	color: #333;
}
/* 주문 요약 정보 */
.order-summary {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
	margin-bottom: 20px;
	table-layout: fixed;
	border-radius: 3px;
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
/* 주문 요약 정보 */

/* 디테일 테이블*/
.detail_table {
	width: 100%;
	border-collapse: collapse;
	margin: 20px 0;
	text-align: center;
	justify-content: center;
	display: flex;
	border: none; /* 테두리 제거 */
}

.detail_table th, .detail_table td {
	padding: 10px;
	font-size: 14px;
	background-color: #fff;
	text-align: center;
}

/* 디테일 테이블*/
/*포인트 사용 테이블*/
.point-table {
	width: 100%;
	margin: 20px 0;
	display: flex;
	justify-content: center;
	align-items: center;
	border: none; /* 테두리 제거 */
}

.point-table tr {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 100%;
}

.point-table th, .point-table td {
	flex: 1; /* 동일 비율로 넓이 설정 */
	text-align: center;
	vertical-align: middle;
	background: none; /* 배경 제거 */
	padding: 0 10px;
}

.point-table input {
	width: 100%;
	max-width: 200px;
	margin: auto;
	text-align: center;
}

.point-table button {
	display: inline-block;
	padding: 5px 10px;
	margin: auto;
}
/* 포인트 요약 정보 */
.point-summary {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
	margin-bottom: 20px;
	table-layout: fixed;
	border-radius: 3px;
}

.point-summary tr td p {
	margin-top: 30px;
}

.point-summary th {
	border-bottom: 1px solid #ddd;
}

.point-summary th, .point-summary td {
	text-align: center;
	vertical-align: middle;
	padding: 12px;
	font-size: 14px;
	word-wrap: break-word;
}

.point-summary th {
	background-color: #f9f9f9;
	font-weight: 700;
	color: #333;
}

.point-summary td {
	background-color: #fff;
	border-bottom: 1px solid #ddd;
}
/* 하단 선 구분*/
.divider {
	margin: 40px 0;
	border-top: 1px solid #ccc;
}
/* 하단 선 구분*/
/* 포인트 요약 정보 */
.detail_table {
	width: 100%;
	border-collapse: collapse;
	margin: 20px 0;
	text-align: center;
	justify-content: center;
	display: flex;
}

.detail_table th, .detail_table td {
	padding: 10px;
	border: 1px solid #ddd;
	font-size: 14px;
	background-color: #fff;
}

.detail_table th {
	background-color: #f9f9f9;
	font-weight: 700;
}

/* 정렬 개선된 결제정보 테이블 */
.detail_table input, .detail_table select {
	margin: 5px 0;
	padding: 5px;
	width: auto;
}

.detail_table tr {
	vertical-align: middle;
}

.detail_table td {
	text-align: center;
}

#layer {
	z-index: 2;
	position: absolute;
	top: 0px;
	left: 0px;
	width: 100%;
	/* background-color:rgba(0,0,0,0.8); */
}

#popup_order_detail {
	z-index: 3;
	position: fixed;
	text-align: center;
	left: 10%;
	top: 0%;
	width: 60%;
	height: 100%;
	background-color: #ccff99;
	border: 2px solid #0000ff;
}

#close {
	z-index: 4;
	float: right;
}
/* 버튼 영역 */
.btn-container {
	text-align: center;
	margin-top: 30px;
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
/* 버튼 공통 스타일 */

/*결제 정보*/
.Payment-information {
	display: flex;
	justify-content: center;
}

.Payment-information th td {
	border: none;
}

.payment-options {
    display: flex;
    justify-content: center;
    gap: 20px;
    margin-top: 20px;
}

.payment-btn {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 150px;
    height: 100px;
    border: 2px solid #ddd;
    border-radius: 10px;
    background-color: #fff;
    cursor: pointer;
    transition: all 0.3s ease;
    position: relative;
    text-align: center;
}

/* ✅ 기본 스타일 */
.payment-btn img {
    width: 60px;
    height: 60px;
    margin-bottom: 5px;
}

.payment-btn span {
    font-size: 14px;
    font-weight: bold;
    color: #333;
}

/* ✅ 기본 라디오 버튼 숨김 */
.payment-btn input[type="radio"] {
    display: none;
}

/* ✅ 선택된 버튼 스타일 */
.payment-btn input[type="radio"]:checked + img {
    filter: brightness(1.2);
}

.payment-btn input[type="radio"]:checked + span {
    color: #007bff; /* 선택된 버튼의 글씨 색 변경 */
}

/* ✅ 선택된 버튼 강조 효과 (테두리 + 배경색 변경) */
.payment-btn input[type="radio"]:checked ~ span {
    color: #007bff;
}

.payment-btn input[type="radio"]:checked ~ img {
    filter: brightness(1.2);
}

/* ✅ 선택된 버튼 강조 (테두리 색 변경) */
.payment-btn input[type="radio"]:checked + img,
.payment-btn input[type="radio"]:checked ~ span {
    background-color: #f0f8ff;
}

.payment-btn:has(input[type="radio"]:checked) {
    border-color: #007bff;
    box-shadow: 0 0 8px rgba(0, 123, 255, 0.5);
}

/* ✅ 호버 효과 추가 */
.payment-btn:hover {
    border-color: #007bff;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}
/*결제 정보*/

.delivery-container {
        display: flex;
        align-items: center; /* 수직 정렬 */
        justify-content: center; /* 수평 정렬 */
    }

    .delivery-container label,
    .delivery-container select {
        margin-right: 20px; /* 간격을 조정 */
    }
</style>
    <link rel="stylesheet" href="${contextPath}/resources/css/media.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/defaultStyle.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- 결제 -->
<!--테스트 JS-->
<script language="javascript" type="text/javascript" 
  src="https://stgstdpay.inicis.com/stdjs/INIStdPay.js" 
  charset="UTF-8"></script>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

<!-- 결제 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            console.log("다음 API 데이터:", data); // 콘솔에서 데이터 확인

            var fullRoadAddr = data.roadAddress; // 도로명 주소
            var extraRoadAddr = ''; // 도로명 조합형 주소

            // 법정동명이 있을 경우 추가 (법정리는 제외)
            if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고 공동주택일 경우 추가
            if (data.buildingName !== '' && data.apartment === 'Y') {
                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 최종적으로 조합한 도로명 주소
            if (extraRoadAddr !== '') {
                fullRoadAddr += ' (' + extraRoadAddr + ')';
            }

            // HTML 요소에 값 할당
            document.getElementById('zipcode').value = data.zonecode; // 우편번호
            document.getElementById('add1').value = fullRoadAddr; // 도로명 주소
            document.getElementById('add2').value = data.jibunAddress; // 지번 주소 (optional)

            // 예상 주소 정보
            if (data.autoRoadAddress) {
                document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + data.autoRoadAddress + ')';
            } else if (data.autoJibunAddress) {
                document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + data.autoJibunAddress + ')';
            } else {
                document.getElementById('guide').innerHTML = '';
            }
        }
    }).open();
}

function fn_point() {
	
	var warn_text = document.getElementById("warn_text");
	warn_text.innerHTML=" ";
	var point = Retention_points.value;
	var havePoint = $('#havePoint').val();
	var finalPrice = h_totalPrice.value;
	var warning = document.getElementById("warning");
	var warningtxt;
	
	
	if (point > Number(havePoint)){
		warningtxt ="<span id='warningtxt' style='color:#B91A4D; font-size:12px;'>&nbsp;&nbsp;포인트가 부족합니다!</span>";
		warn_text.innerHTML=warningtxt;
	}else if(Number(point)<0||Number(point)>Number(finalPrice)){
		warningtxt ="<span id='warningtxt' style='color:#B91A4D; font-size:12px;'>&nbsp;&nbsp;다시 입력해주세요!</span>";
		warn_text.innerHTML=warningtxt;
	}else{
	del(p_totalSalesPrice);
	del(total_sales_price);
	del(final_total_Price);
	del(p_final_totalPrice);
	

	var html = '';
	var html2 = '';
	var new_p_totalSalesPrice = document.getElementById("usePoint");
	if(Number(point)==0){
		point=Number(0);
	}
	
	html += "<p id='p_totalSalesPrice' >" + point + "P</p>";
	html += "<input id='total_sales_price' type='hidden' value='"+point+"' />";
	new_p_totalSalesPrice.innerHTML = html;
	var new_finalPrice = document.getElementById("finalPrice");
	html2 += "<p id='p_final_totalPrice' >"
			+ (finalPrice - point) + "원 </p>";
	html2 += "<input id='final_total_Price' type='hidden' value='"
			+ (finalPrice - point) + "' />";
	new_finalPrice.innerHTML = html2;}

	console.log("보유포인트: " +havePoint);
	console.log("최종가격 : "+final_total_Price.value);
	console.log("포인트" + total_sales_price.value);
	
}
function del(elementId) {
	var element = document.getElementById(elementId);
	if (element) {
		element.remove();
	}
}

console.log(window.IMP);


function fn_process_pay_order() {

    var pay_method = $('input[name=pay_method]:checked').val();
    var receiver_name = $('#receiver_name').val().trim();
    var receiver_hp1 = $('#receiver_tel1').val();
    var receiver_hp2 = $('#receiver_tel2').val().trim();
    var receiver_hp3 = $('#receiver_tel3').val().trim();
    var delivery_address = $('#zipcode').val() + " " + $('#add1').val() + " " + $('#add3').val();
    var delivery_message = $('#delivery_message').val();
    var final_price = $('#final_total_Price').val();
    var usePoint = $('#total_sales_price').val();
    var total_point = $('#total_point').val();
    var orderer_hp1 = "${orderer.mem_tel1}" || ''; 
    var orderer_hp2 = "${orderer.mem_tel2}" || ''; 
    var orderer_hp3 = "${orderer.mem_tel3}" || ''; 
    var orderer_name = "${orderer.mem_name}" || ''; 
    var pay_orderer_hp_num = orderer_hp1 + "-" + orderer_hp2 + "-" + orderer_hp3;
	
    //배송지 주소 확인
    var zipcode = $('#zipcode').val().trim();
    var add1 = $('#add1').val().trim();
    var add2 = $('#add2').val().trim();
    var add3 = $('#add3').val().trim();
    
    if (receiver_name === "" || receiver_hp2 === "" || receiver_hp3 === "" || 
    	add1 === "" || add2 === "" || add3 === "") {
        alert("🚨 배송지 정보를 모두 입력해주세요.");
        return; // 🚫 결제 진행 중단
    }
    console.log("주문자 연락처 확인: " + pay_orderer_hp_num); 

    // ⚠️ 추가된 항목
    var gift_wrapping = $('input[name=gift_wrapping]:checked').val() || "no"; // 기본값 'no'
    if (!pay_method) {
        alert("결제 방법을 선택하세요.");
        return;
    }

    console.log("결제 방법: ", pay_method);
    console.log("수령인 연락처: ", receiver_hp1, receiver_hp2, receiver_hp3);
    console.log("주문자 연락처:", "${orderer.mem_tel1}-${orderer.mem_tel2}-${orderer.mem_tel3}");
    console.log("결제 금액: ", final_price);
	
    
    
    
    var IMP = window.IMP;
    
 // ✅ 상품명 가져오기
    var orderNames = [];

    <c:choose>
        <%-- 단일 상품 주문 --%>
        <c:when test="${not empty singleOrder}">
            orderNames.push("${singleOrder.goods_name}");
        </c:when>

        <%-- 여러 개 상품 주문 --%>
        <c:when test="${not empty selectedOrderList}">
            <c:forEach var="order" items="${selectedOrderList}">
                orderNames.push("${order.goodsVO.goods_name}");
            </c:forEach>
        </c:when> 
    </c:choose>

    // ✅ 상품명이 여러 개일 경우 첫 번째 상품명 + "외 X개" 형식으로 표시
    var orderName = orderNames.length > 1 ? orderNames[0] + " 외 " + (orderNames.length - 1) + "개" : orderNames[0];

    console.log("🛒 주문 상품명:", orderName);

    
    
/*
 *실제 구현 할떄는 amount : final_price로 수정해서 실행 
 */
    
    if (pay_method === "카카오페이(간편결제)") {
        IMP.init('imp64286002'); // 카카오페이 PG사 코드
        IMP.request_pay({
            pg: "kakaopay.TC0ONETIME",
            pay_method: "card",
            merchant_uid: "order_" + new Date().getTime(),
            name: orderName,
            amount: final_price,
            buyer_name: "${orderer.mem_name}", // ✅ 로그인된 회원 정보 적용
            buyer_tel: "${orderer.mem_tel1}-${orderer.mem_tel2}-${orderer.mem_tel3}", // ✅ 로그인된 회원 전화번호 적용
            buyer_addr: "${orderer.mem_add1}", // ✅ 로그인된 회원 주소 적용
            buyer_email : "${orderer.mem_email1}"+"@"+"${orderer.mem_email2}"
        }, function (rsp) {
            if (rsp.success) {
                alert("결제가 완료되었습니다.");
                sendOrderData(rsp);
            } else {
                alert("결제 실패: " + rsp.error_msg);
            }
        });
    } else if (pay_method === "이니시스(카드결제)") {
        IMP.init('imp19424728'); // 이니시스 PG사 코드
        IMP.request_pay({
            pg: "html5_inicis.INIpayTest",
            pay_method: "card",
            merchant_uid: "order_" + new Date().getTime(),
            name: orderName,
            amount: final_price,
            buyer_name: "${orderer.mem_name}", // ✅ 로그인된 회원 정보 적용
            buyer_tel: "${orderer.mem_tel1}-${orderer.mem_tel2}-${orderer.mem_tel3}", // ✅ 로그인된 회원 전화번호 적용
            buyer_addr: "${orderer.mem_add1}", // ✅ 로그인된 회원 주소 적용
            buyer_email : "${orderer.mem_email1}"+"@"+"${orderer.mem_email2}"
        }, function (rsp) {
            if (rsp.success) {
                alert("결제가 완료되었습니다.");
                sendOrderData(rsp);
            } else {
                alert("결제 실패: " + rsp.error_msg);
            }
        });
    }
}

// 🚀 결제 성공 후 서버에 데이터 전송하는 함수 추가
function sendOrderData(rsp) {
    
	var _card_com_name = rsp.card_name ? "[" + rsp.card_name + "] " + (rsp.card_number || "카드 번호 미제공") : rsp.pg_provider;
	var _card_pay_month = rsp.card_quota !== null ? rsp.card_quota : "일시불";
    var selectedGoods = [];
    <c:forEach var="order" items="${selectedOrderList}">
    selectedGoods.push({
        goods_id: "${order.goods_id}",
        goods_name: "${order.goodsVO.goods_name}",
        goods_sales_price: "${order.goodsVO.goods_sales_price}",
        order_goods_qty: "${order.order_goods_qty}",
        order_total_price: "${order.order_total_price}",
        goods_fileName: "${order.imageFileVO.fileName}",
        goods_stock : "${order.goodsVO.goods_stock}",
        goods_point : "${order.goodsVO.goods_point}"
    });
    </c:forEach>
   	
    var requestData = {
    	
			t_id : rsp.t_id,
			pg_tid : rsp.pg_tid,
			imp_uid : rsp.imp_uid,
			merchant_uid : rsp.merchant_uid,
			t_id : rsp.pg_tid,
			/*receiverMap으로 보내줄 데이터*/
			imp_uid : rsp.imp_uid,
			merchant_uid : rsp.merchant_uid,
			amount : rsp.paid_amount,
			pay_method : $('input[name=pay_method]:checked').val(),
			receiver_name : $('#receiver_name').val(),
			receiver_tel1 : $('#receiver_tel1').val(),
			receiver_tel2 : $('#receiver_tel2').val(),
			receiver_tel3 : $('#receiver_tel3').val(),
			delivery_method : $('input[name=delivery_method]:checked').val(),
			delivery_address : $('#zipcode').val() + " " + $('#add1').val()
					+ " " + $('#add3').val(),
			delivery_message : $('#delivery_message').val(),
			gift_wrapping : $('input[name=gift_wrapping]:checked').val()
					|| "no",
			orderer_name : "${orderer.mem_name}",
			orderer_hp1 : "${orderer.mem_tel1}",
			orderer_hp2 : "${orderer.mem_tel2}",
			orderer_hp3 : "${orderer.mem_tel3}",
			pay_orderer_hp_num : orderer_hp1 + "-" + orderer_hp2 + "-"
					+ orderer_hp3,
			usePoint : $('#total_sales_price').val(),
			total_point : $('#total_point').val(),
			card_com_name : _card_com_name, // 카드사 이름 + 카드번호
			card_pay_month : _card_pay_month, // 할부 개월 수
			buyer_email : "${orderer.mem_email1}" + "@"
					+ "${orderer.mem_email2}",
			selectedOrderList : JSON.stringify(selectedGoods)
		// JSON으로 변환하여 서버로 전송
		};
		console.log("🛠 서버로 전송할 데이터:", requestData);

		$
				.ajax({
					url : "${contextPath}/order/payToOrderGoods.do",
					type : "POST",
					data : requestData,
					dataType : "json",
					success : function(response) {
						console.log("✅ 서버 응답:", response);

						if (response.success) {
							console.log("✅ 주문 저장 완료, order_id:",
									response.order_id);
							window.location.href = "${contextPath}/order/orderResult.do?order_id="
									+ response.order_id;
						} else {
							console.error("❌ 주문 저장 실패:", response.error);
							alert("주문 처리 중 오류가 발생했습니다: " + response.error);
						}
					},
					error : function(error) {
						console.error("❌ 서버 요청 중 오류 발생:", error);
						alert("서버 통신 중 오류가 발생했습니다.");
					}
				});
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
		"pluginKey" : 'a0ac98cf-93df-4eac-88ff-be0aaffa661f'
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
			<script>
		    // 세션에서 가져온 주문자 연락처 (EL 표현식 활용)
		    var orderer_hp1 = "${orderer.mem_tel1}" ? "${orderer.mem_tel1}" : '';
		    var orderer_hp2 = "${orderer.mem_tel2}" ? "${orderer.mem_tel2}" : '';
		    var orderer_hp3 = "${orderer.mem_tel3}" ? "${orderer.mem_tel3}" : '';
			var orderer_name ="${orderer.mem_name}" ? "${orderer.mem_name}" : '';
		    // 주문자 연락처 조합
		    var pay_orderer_hp_num = orderer_hp1 + "-" + orderer_hp2 + "-" + orderer_hp3;

		</script>
		
		
		<form name="form_order">
			<table class="order-summary">
				<tbody align=center>
					<tr style="background: #33ff00">
						<th colspan=2 class="fixed">주문상품명</th>
						<th>수량</th>
						<th>주문금액</th>
						<th>예상적립금</th>
						<th>주문금액합계</th>
					</tr>
					<tr>
	<c:choose>
    <c:when test="${not empty singleOrder}">
        <tr>

									<td colspan="2">
									<a
										href="${contextPath}/goods/goodsDetail.do?goods_id=${singleOrder.goods_id}"
										class="goods-link"> <img
											style="width: 75px; height: 75px;"
											src="${contextPath}/image.do?goods_id=${singleOrder.goods_id}&fileName=${singleOrder.goods_fileName}"
											class="card-img-top" alt=" ${singleOrder.goods_name}">
											  ${singleOrder.goods_name}
									</a>
									</td>
            <td>${singleOrder.order_goods_qty}개</td>
            <td>${singleOrder.goods_sales_price}원</td>
            <td>${singleOrder.goodsVO.goods_point* singleOrder.order_goods_qty}P</td>
<td><fmt:formatNumber value="${singleOrder.order_total_price}" pattern="#,###"/>원</td>
        </tr>
    </c:when>

 <c:when test="${not empty selectedOrderList}">
        <c:forEach var="order" items="${selectedOrderList}">
            <tr>
                <td colspan="2">
                    <a href="${contextPath}/goods/goodsDetail.do?goods_id=${order.goods_id}" class="goods-link">
                        <img style="width: 75px; height: 75px;"
                            src="${contextPath}/image.do?goods_id=${order.goods_id}&fileName=${order.imageFileVO.fileName}"
                            class="card-img-top" alt="${order.imageFileVO.fileName}">
                        ${order.goodsVO.goods_name}
                    </a>
                </td>
                <td>${order.order_goods_qty}개</td>
                <td><fmt:formatNumber value="${order.goodsVO.goods_sales_price}" pattern="#,###"/>원</td>
                <td>${order.goodsVO.goods_point*order.order_goods_qty}P</td>
                <td><fmt:formatNumber value="${order.order_total_price}" pattern="#,###"/>원</td>
            </tr>
        </c:forEach>
    </c:when>

    <c:otherwise>
        <tr>
            <td colspan="6">주문할 상품이 없습니다.</td>
        </tr>
    </c:otherwise>
</c:choose>



				</tbody>
			</table>

			<div class="divider"></div>
			<h2>배송지 정보</h2>
			<DIV class="detail_table">
				<table>
					<tbody>
						<tr class="dot_line">
            <th class="fixed_join">배송방법</th>
            <td>
                <input type="radio" id="delivery_method1" name="delivery_method" value="일반택배" checked>
                <label for="delivery_method1">일반택배</label>
                &nbsp;&nbsp;&nbsp;
                <input type="radio" id="delivery_method2" name="delivery_method" value="편의점택배">
                <label for="delivery_method2">편의점택배</label>
                &nbsp;&nbsp;&nbsp;
                <input type="radio" id="delivery_method3" name="delivery_method" value="해외배송">
                <label for="delivery_method3">해외배송</label>
                &nbsp;&nbsp;&nbsp;
            </td>
        </tr>
        <tr class="dot_line">
            <th class="fixed_join">배송지 선택</th>
            <td>
                <!-- 기본 배송지 라디오 버튼 -->
                <div class="delivery-container">
                <input type="radio" id="delivery_place1" name="delivery_place" value="기본배송지">
                <label for="delivery_place1">기본배송지</label>
                <c:set var="addressList" value="${sessionScope.addressList}" />

                &nbsp;&nbsp;&nbsp;

                <!-- 추가 배송지 라디오 버튼 -->
                <input type="radio" id="delivery_place2" name="delivery_place" value="추가배송지">
                <label for="delivery_place2">추가배송지</label>						
                <br><br>

                <!-- 배송지 목록 선택 -->
                <select id="addressSelect" name="address">
                    <c:choose>
                        <c:when test="${empty addressList}">
                            <option value="">등록한 추가배송지가 없습니다.</option>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="address" items="${addressList}">
                                <option value="${address.address_id}" 
                                        data-mem_zipcode="${address.mem_zipcode}" 
                                        data-mem_add1="${address.mem_add1}" 
                                        data-mem_add2="${address.mem_add2}" 
                                        data-mem_add3="${address.mem_add3}">
                                    ${address.address_name}
                                </option>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>    
                </select>
                
                &nbsp;&nbsp;&nbsp;
				
				<input type="radio" id="delivery_place3" name="delivery_place" value="새로입력">
				<label for="delivery_place3">새로입력</label>
				
                </div>
            </td>
        </tr>
						<tr class="dot_line">
							<th class="fixed_join">수령인</th>
							<td>
							<input id="receiver_name" name="receiver_name" type="text" size="40" required /> 
						
						</tr>
						<tr class="dot_line">
							<th class="fixed_join">휴대폰번호</th>
							<td><select id="receiver_tel1" name="receiver_tel1">
									<option value="010" selected>010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
							</select> - <input size="10px" type="text" id="receiver_tel2"
								name="receiver_tel2" required >
								- <input size="10px" type="text" id="receiver_tel3"
								name="receiver_tel3" required > 
								
								
						</tr>

						<tr class="dot_line">
							<th class="fixed_join">주소</th>
							<td>
								<p>
									우편 번호 <input type="text" id="zipcode" name="mem_zipcode" size="5"
										required> <a
										href="javascript:execDaumPostcode()">우편번호검색</a>
								</p>
								<p>
									&nbsp;지번 주소 <input type="text" id="add1"
										name="add1" size="50" required readonly/>
								</p>
								<p>
									도로명 주소<input type="text" id="add2" name="add2"
										size="50" required readonly/>
								</p>
								<p>
									나머지 주소 <input type="text" id="add3"
										name="add3" size="50"
										 />
								</p>

							</td>
						</tr>
						<tr class="dot_line">
							<th class="fixed_join">배송 메시지</th>
							<td><input id="delivery_message" name="delivery_message"
								type="text" size="40" placeholder="택배 기사님께 전달할 메시지를 남겨주세요." />
							</td>
						</tr>
						<tr class="dot_line">
							<th class="fixed_join">선물 포장</th>
							<td><input type="radio" id="gift_wrapping_yes"
								name="gift_wrapping" value="yes"> <label
								for="gift_wrapping_yes">예</label> &nbsp;&nbsp;&nbsp; <input
								type="radio" id="gift_wrapping_no" name="gift_wrapping"
								value="no" checked> <label for="gift_wrapping_no">아니요</label>
							</td>
						</tr>
						</tboby>
				</table>
			</div>

			<div class="divider"></div>


			<h2>할인 정보</h2>
			<div class="point-table">
				<table>
					<tbody>
					
						<tr>
							<th>보유 포인트</th>

							<td>
								<!--  <p class="fs-6 mt-5">포인트</p>  -->
								${orderer.mem_point} <input id="havePoint" type="hidden"
								value="${orderer.mem_point}" />
							</td>

							<td id="warning"><input id="Retention_points" type="text"
								name="discount_juklip" class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-sm"
								oninput="this.value = this.value.replace(/[^0-9.]/g, '')"
								placeholder="숫자만 입력 가능합니다."></td>
							<td>
								<button type="button" class="btn-custom" onclick="fn_point()">포인트사용</button>
							</td>
						<tr>
							<td colspan="4">
								 <p id="warn_text"></p> 
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<table class="point-summary">
				<tbody>
					<tr align=center class="fixed">
						<th class="fixed">총 상품수</th>
						<th>총 상품금액</th>
						<th>포인트 할인</th>
						<th>최종 결제금액</th>
					</tr>
					<tr cellpadding=40 align=center>
					
			   <c:choose>
            <%-- 단일 상품 주문일 때 --%>
            <c:when test="${not empty singleOrder}">
                <tr align=center>
                    <td>
                        <p id="p_totalNum">${singleOrder.order_goods_qty}개</p>
                        <input id="h_total_order_goods_qty" type="hidden" value="${singleOrder.order_goods_qty}" />
                    </td>
                    <td>
                        <p id="p_totalPrice">${singleOrder.order_total_price}원</p>
                        <input id="h_totalPrice" type="hidden" value="${singleOrder.order_total_price}" />
                    </td>
                    <td id="usePoint">
                        <p id="p_totalSalesPrice">0P</p>
                        <input id="total_sales_price" type="hidden" value="0" />
                    </td>
                    <td id="finalPrice">
                        <p id="p_final_totalPrice"><font>${singleOrder.order_total_price}원</font></p>
                        <input id="final_total_Price" type="hidden" value="${singleOrder.order_total_price}" />
                    </td>
                </tr>
            </c:when>

            <%-- 여러 상품 주문일 때 --%>
            <c:when test="${not empty selectedOrderList}">
                <c:set var="totalQty" value="0" />
                <c:set var="totalPrice" value="0" />
                <c:set var="totalDiscount" value="0" />
                <c:set var="finalPrice" value="0" />

                <c:forEach var="order" items="${selectedOrderList}">
                    <c:set var="totalQty" value="${totalQty + order.order_goods_qty}" />
                    <c:set var="totalPrice" value="${totalPrice + order.order_total_price}" />
                    <c:set var="totalDiscount" value="${totalDiscount}" />
                </c:forEach>

                <c:set var="finalPrice" value="${totalPrice - totalDiscount}" />

                <tr align=center>
                    <td>
                        <p id="p_totalNum">${totalQty}개</p>
                        <input id="h_total_order_goods_qty" type="hidden" value="${totalQty}" />
                    </td>
                    <td>
                        <p id="p_totalPrice">${totalPrice}원</p>
                        <input id="h_totalPrice" type="hidden" value="${totalPrice}" />
                    </td>
                    <td id="usePoint">
                        <p id="p_totalSalesPrice">0P</p>
                        <input id="total_sales_price" type="hidden" value="0" />
                    </td>
                    <td id="finalPrice">
                        <p id="p_final_totalPrice"><font>${finalPrice}원</font></p>
                        <input id="final_total_Price" type="hidden" value="${finalPrice}" />
                    </td>
                </tr>
            </c:when>

            <%-- 주문 정보가 없을 때 --%>
            <c:otherwise>
                <tr align=center>
                    <td colspan="4">장바구니에 상품이 없습니다.</td>
                </tr>
            </c:otherwise>
        </c:choose>
			</table>
			<div class="divider"></div>
			<h2>결제정보</h2>
			<div class="Payment-information">
				<table>
					<tbody>
				
				
				<div class="payment-options">
    <label class="payment-btn">
        <input type="radio" name="pay_method" value="카카오페이(간편결제)" id="pay_method_kakao" name="pay_method"> 
        <img src="${contextPath}/resources/images/kakaoPay.png" alt="카카오페이">
        <span>카카오페이(간편결제)</span>
    </label>

    <label class="payment-btn">
        <input type="radio" name="pay_method" value="이니시스(카드결제)" id="pay_method_inicis"  name="pay_method" checked>
        <img src="https://image.inicis.com/mkt/certmark/inipay/inipay_74x74_color.png" alt="이니시스">
        <span>이니시스 카드결제</span>
    </label>
</div>
					</tbody>
				</table>
			</div>
		</form>
		<div class="divider"></div>
		<div class="btn-container">
			<a href="${contextPath}/main/main.do" class="btn-custom"> 취소 </a> 
				<input type="button" name="btn_process_pay_order" type="button" onClick="fn_process_pay_order()" value="결제" class="btn-custom">
		</div>
		
		
		






	</div>
	<!-- 푸터 include -->
	<div class="footer">
		<%@ include file="../common/footer.jsp"%>
	</div>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			
			//기본 배송지
			// 기본 배송지 선택 시 주소 정보 자동 입력
			document.getElementById("delivery_place1").addEventListener("click", function() {
				//정보 초기화
				clearAddressFields();
				// member 변수에서 주소 정보 가져오기
				var mem_zipcode = "${member.mem_zipcode}";
				var mem_add1 = "${member.mem_add1}";
				var mem_add2 = "${member.mem_add2}";
				var mem_add3 = "${member.mem_add3}";
		
				// 각 input 필드에 값 채우기
				document.getElementById("zipcode").value = mem_zipcode;
				document.getElementById("add1").value = mem_add1;
				document.getElementById("add2").value = mem_add2;
				document.getElementById("add3").value = mem_add3;
		
				// 각 주소 입력 필드를 readonly로 설정
				document.getElementById("zipcode").readOnly = true;
				document.getElementById("add1").readOnly = true;
				document.getElementById("add2").readOnly = true;
				document.getElementById("add3").readOnly = true;
		
				// "기본배송지" 라디오 버튼 클릭 시, 추가배송지의 입력을 비활성화       
				removeAddressSelectListener();  // 기본배송지 선택 시 change 이벤트 리스너 제거
			});
		
			// 추가배송지 선택 시, 주소 입력 필드를 초기화하고 addressSelect 활성화
			document.getElementById("delivery_place2").addEventListener("click", function() {
				clearAddressFields();
				enableAddressSelect();  // 추가배송지 선택 시 addressSelect 활성화
				var addressSelect = document.getElementById("addressSelect");
				if (addressSelect) {
					// change 이벤트 강제 실행
					addressSelect.dispatchEvent(new Event("change"));
				}
			});
		
			// 주소 필드를 초기화하는 함수
			function clearAddressFields() {
				document.getElementById("zipcode").value = "";
				document.getElementById("add1").value = "";
				document.getElementById("add2").value = "";
				document.getElementById("add3").value = "";
		
				// 주소 필드 읽기 전용 해제
				document.getElementById("zipcode").readOnly = false;
				document.getElementById("add1").readOnly = false;
				document.getElementById("add2").readOnly = false;
				document.getElementById("add3").readOnly = false;
			}
		
			//추가 배송지
			// addressSelect에 change 이벤트 리스너 추가
			function enableAddressSelect() {
				var addressSelect = document.getElementById("addressSelect");
		
				if (addressSelect) {
					addressSelect.addEventListener("change", function() {
						var selectedOption = this.options[this.selectedIndex];
		
						console.log("Selected Option:", selectedOption);
						var mem_zipcode = selectedOption.getAttribute("data-mem_zipcode");
						var mem_add1 = selectedOption.getAttribute("data-mem_add1");
						var mem_add2 = selectedOption.getAttribute("data-mem_add2");
						var mem_add3 = selectedOption.getAttribute("data-mem_add3");
		
						// 각 input 필드에 값 채우기
						document.getElementById("zipcode").value = mem_zipcode;
						document.getElementById("add1").value = mem_add1;
						document.getElementById("add2").value = mem_add2;
						document.getElementById("add3").value = mem_add3;
		
						// 각 주소 입력 필드를 readonly로 설정
						document.getElementById("zipcode").readOnly = true;
						document.getElementById("add1").readOnly = true;
						document.getElementById("add2").readOnly = true;
						document.getElementById("add3").readOnly = true;
					});
				} else {
					console.log("addressSelect 요소를 찾을 수 없습니다.");
				}
			}
			
			//새로입력
			document.getElementById("delivery_place3").addEventListener("click", function() {
				clearAddressFields();  // 필드 초기화
			});
		
			// addressSelect의 change 이벤트 리스너 제거
			function removeAddressSelectListener() {
				var addressSelect = document.getElementById("addressSelect");
				if (addressSelect) {
					var newAddressSelect = addressSelect.cloneNode(true);
					addressSelect.parentNode.replaceChild(newAddressSelect, addressSelect);
				}
			}
		});
		
		</script>
</body>
</html>
