<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="utf-8"
	isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />

<c:set var="cart" value="${cartList}" />
<c:set var="totalGoodsCount" value="0" />
<c:set var="totalGoodsPrice" value="0" />
<c:set var="totalDeliveryPrice" value="0" />
<c:set var="totalDiscount" value="0" />
<c:set var="totalPayment" value="0" />

<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${contextPath}/resources/css/defaultStyle.css">
<title>장바구니</title>

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">

<style>
	* { font-family: 'Noto Sans KR', sans-serif; }
    body { color: #333; }

    .container {
        max-width: 1000px; 
        margin: 50px auto; 
        background-color: #fff;
        padding: 40px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        border-radius : 3px;
    }
	
    .cart-top {
        text-align: center;
        font-size: 24px;
        font-weight: 700;
        color: #000;
        margin-bottom: 30px;
        position: relative;
        padding-bottom: 10px; 
    }
    .cart-top::after {
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

    .table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
        border-radius: 3px;
    }

    .table th, .table td {
        text-align: center;
        padding: 12px;
        border-bottom: 1px solid #ddd;
        border-radius: 3px;
    }

    .table th { background-color: #f4f4f4; font-weight: bold; }

    .table-group-divider { border-top: 2px solid #eee; border-radius: 3px; }

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
    .btn-custom:hover { background-color: #f0f0f0; }

    .inputQty {
        text-align: center;
        width: 60px;
        padding: 5px;
        border: 1px solid #ddd;
        border-radius: 3px;
        font-size: 14px;
    }

    .fs-3 { font-size: 1.5rem; font-weight: bold; }
    .mt-3 { margin-top: 1rem; }
    .mt-5 { margin-top: 3rem; }
    .w-75 { width: 75%; display: contents; }
    .text-center { text-align: center; }
    .inline-content { display: flex; align-items: center; gap: 10px; }
    .goods_id { text-decoration: none; color: black; }
    
    .buttonRow {
    text-align: center; /* ✅ 버튼을 가운데 정렬 */
    margin: 30px 0;
}
    input {
  border: none;
  outline: none;
  background-color: transparent;
}
   .goods-link { color: black; text-decoration: none; } /* ✅ 상품명 스타일 변경 */
   .goods-link:hover { color: #333; } /* ✅ 마우스 올렸을 때 색상 변경 */
   /* ✅ 이미지가 있는 td를 제외한 모든 td에 padding-top: 30px 적용 */
	/* ✅ 첫 번째 테이블의 tbody 내에서 이미지가 있는 td를 제외한 모든 td에 padding-top: 30px 적용 */
	.table:first-of-type tbody td:not(:nth-child(2)):not(:last-child) {
	    padding-top: 30px;
	}
	
	/* ✅ 첫 번째 테이블의 tbody 내에서 주문 삭제 버튼이 있는 마지막 td에만 padding-top: 20px 적용 */
	.table:first-of-type tbody td:last-child {
	    padding-top: 20px;
	}
	/* ✅ 선택 주문 / 전체 삭제 버튼을 오른쪽 정렬 */
.table tfoot th {
    text-align: right;  /* ✅ 버튼을 우측 정렬 */
    padding-right: 30px; /* ✅ 오른쪽 여백 추가 (필요에 따라 조정 가능) */
}

</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript">
$(document).ready(function () {

	    $("#selectAll").change(function () {
	        $(".cart-checkbox").prop("checked", $(this).prop("checked"));
	        updateCartSummary(); // ✅ 장바구니 합계 업데이트
	    });

	    $(".cart-checkbox").change(function () {
	        let totalCheckboxes = $(".cart-checkbox").length;
	        let checkedCheckboxes = $(".cart-checkbox:checked").length;
	        
	        $("#selectAll").prop("checked", totalCheckboxes === checkedCheckboxes);
	        updateCartSummary(); // ✅ 장바구니 합계 업데이트
	    });
	
    $(".cart-checkbox").change(function () {
        updateCartSummary();
    });

    $(".inputQty").on("input", function () {
        let $this = $(this);
        let availableStock = parseInt($this.attr("data-stock"), 10);
        let newQuantity = parseInt($this.val()) || 1;
        
        // 재고 초과 체크
        if(newQuantity > availableStock) {
            alert("재고 수량을 초과할 수 없습니다. 현재 재고: " + availableStock + "개 입니다.");
            $this.val(availableStock);
            newQuantity = availableStock;
        }
        
        let row = $this.closest("tr");
        let cartId = row.find("input[name='cart_id']").val();
        updateRowTotal(row); // 즉시 행 합계 업데이트
        updateCartSummary();  // 장바구니 전체 합계 업데이트

        $.ajax({
            type: "POST",
            url: "${contextPath}/cart/updateCart.do",
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            data: { cart_id: cartId, order_goods_qty: newQuantity },
            success: function (response) {
                if (response.status === "success") {
                    updateRowTotal(row);
                    updateCartSummary();
                } else {
                    alert("수량 변경 실패: " + response.message);
                }
            },
            error: function () {
                alert("서버와의 통신 중 오류가 발생했습니다.");
            }
        });
    });

	
    $(".btn-delete").click(function () {
        let row = $(this).closest("tr");
        let cartId = row.find("input[name='cart_id']").val();

        if (!confirm("장바구니의 상품을 삭제하시겠습니까?")) {
            return;
        }

        $.ajax({
            type: "POST",
            url: "${contextPath}/cart/deleteCart.do",
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            data: { cart_id: cartId },
            success: function (response) {
                console.log("🗑️ 삭제 완료:", response);

                if (response.status === "success") {
                    row.remove(); // ✅ 화면에서 해당 행 제거
                    updateCartSummary(); // ✅ 장바구니 합계 업데이트
                    alert("장바구니 상품을 삭제하였습니다.");
                    location.reload();
                } else {
                    alert("삭제 실패: " + response.message);
                }
            },
            error: function () {
                alert("삭제 중 오류가 발생했습니다.");
            }
        });
    });
    
   /*  $(".btn-order").click(function () {
        let row = $(this).closest("tr");

        let cartId = row.find("input[name='cart_id']").val();
        let goodsId = row.find("input[name='goods_id']").val();  // 🚨 여기서 문제 발생 가능
        let goodsName = row.find(".goods-link").text();
        let orderGoodsQty = row.find(".inputQty").val();
        let goodsSalesPrice = row.find("input[name='goods_sales_price']").val();
        let goodsPoint = row.find("input[name='goods_point']").val();
        let goodsDeliveryPrice = row.find("input[name='goods_delivery_price']").val();
        let totalOrderPrice = orderGoodsQty * goodsSalesPrice;

        // ✅ 콘솔로 값 확인 (F12 개발자 도구에서 콘솔 확인 가능)
        console.log("🔹 주문 데이터 확인!");
        console.log("goodsId:", goodsId);
        console.log("orderGoodsQty:", orderGoodsQty);
        console.log("goodsSalesPrice:", goodsSalesPrice);

        // 🚨 필수 값 검증 (빈 값이 있으면 경고창 띄우기)
        if (!goodsId || !orderGoodsQty || !goodsSalesPrice) {
            alert("주문 정보를 확인해주세요. (상품 ID, 수량, 가격이 비어 있습니다.)");
            return;
        }

        let form = $("<form>", {
            action: "${contextPath}/order/orderEachGoods.do",
            method: "POST"
        });

        form.append($("<input>", { type: "hidden", name: "cart_id", value: cartId || "" }));
        form.append($("<input>", { type: "hidden", name: "goods_id", value: goodsId || "" }));
        form.append($("<input>", { type: "hidden", name: "goods_name", value: goodsName || "" }));
        form.append($("<input>", { type: "hidden", name: "order_goods_qty", value: orderGoodsQty || "1" }));
        form.append($("<input>", { type: "hidden", name: "goods_sales_price", value: goodsSalesPrice || "0" }));
        form.append($("<input>", { type: "hidden", name: "goods_point", value: goodsPoint || "0" }));
        form.append($("<input>", { type: "hidden", name: "goods_delivery_price", value: goodsDeliveryPrice || "0" }));
        form.append($("<input>", { type: "hidden", name: "order_total_price", value: totalOrderPrice || "0" }));

        $("body").append(form);
        form.submit();
    }); */
	
 



});
function orderEachCartItem(cartIds) {
    if (cartIds.length === 0) {
        alert("주문할 상품을 선택해주세요.");
        return;
    }
    // ✅ 재고 체크 로직 추가
    let stockExceeded = false;
    $(".cart-checkbox:checked").each(function () {
        let row = $(this).closest("tr");
        let quantity = parseInt(row.find(".inputQty").val()) || 1;
        let availableStock = parseInt(row.find(".inputQty").attr("data-stock"), 10);

        if (quantity > availableStock) {
            alert("상품의 주문 수량이 재고를 초과했습니다.");
            stockExceeded = true;
        }
    });

    // 🚨 재고 초과 시 주문 차단
    if (stockExceeded) {
        return;
    }
    
    let form = $("<form>", {
        action: "${contextPath}/order/orderFromCart.do",
        method: "POST"
    });

    cartIds.forEach(cartId => {
        form.append($("<input>", { type: "hidden", name: "cart_id", value: cartId }));
    });

    $("body").append(form);
    form.submit();
}

function getSelectedCartIds() {
    let selectedIds = [];
    $(".cart-checkbox:checked").each(function () {
        selectedIds.push($(this).val());
    });
    return selectedIds;
}



function updateRowTotal(row) {
    let quantity = parseInt(row.find(".inputQty").val()) || 1;
    let price = parseInt(row.find("input[name='goods_sales_price']").val()) || 0;
    let basePoint = parseInt(row.find("input[name='goods_point']").val()) || 0;

    let total = quantity * price;
    let totalPoint = quantity * basePoint; // ✅ 정확한 계산

    console.log("🔹 updateRowTotal 실행됨! 수량:", quantity, "상품 포인트:", basePoint, "총 포인트:", totalPoint);

    row.find(".final_total_price").text(total.toLocaleString() + "원"); 
    row.find(".total_point").text(totalPoint.toLocaleString() + "P"); // ✅ 포인트 즉시 업데이트
}


function updateCartSummary() {
    let totalGoodsCount = 0, totalGoodsPrice = 0, totalDeliveryPrice = 0, totalDiscount = 0, totalPoint = 0, totalPayment = 0;

    $(".cart-checkbox:checked").each(function () {
        let row = $(this).closest("tr");
        let quantity = parseInt(row.find(".inputQty").val()) || 1;
        let price = parseInt(row.find("input[name='goods_sales_price']").val()) || 0;
        let deliveryPrice = parseInt(row.find("input[name='goods_delivery_price']").val()) || 0;
        let basePoint = parseInt(row.find("input[name='goods_point']").val()) || 0; // ✅ 상품 개별 포인트

        let totalRowPoint = quantity * basePoint; // ✅ 정확한 총 포인트 계산

        totalGoodsCount += quantity;
        totalGoodsPrice += quantity * price;
        totalDeliveryPrice += deliveryPrice;
        totalPoint += totalRowPoint; // ✅ 개별 상품 포인트 총합

        console.log("🔹 updateCartSummary 실행됨! 수량:", quantity, "상품 포인트:", basePoint, "총 포인트:", totalRowPoint);
    });

    totalPayment = totalGoodsPrice + totalDeliveryPrice - totalDiscount;

    $("#p_totalGoodsNum").text(totalGoodsCount + "개");
    $("#p_final_totalPrice").text(totalGoodsPrice.toLocaleString() + "원");
    $("#p_totalDeliveryPrice").text(totalDeliveryPrice.toLocaleString() + "원");
    $("#p_totalDiscount").text(totalDiscount.toLocaleString() + "원");
    $("#p_final_totalPayment").text(totalPayment.toLocaleString() + "원");
    $("#p_totalPoint").text(totalPoint.toLocaleString() + "P"); // ✅ 포인트 총합 업데이트
}

function deleteAllCart() {
    if (!confirm("장바구니의 모든 상품을 삭제하시겠습니까?")) {
        return;
    }

    $.ajax({
        type: "POST",
        url: "${contextPath}/cart/deleteAllCart.do", // 🔥 서버에서 전체 삭제 API 추가 필요
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        success: function (response) {
            console.log("🗑️ 전체 삭제 완료:", response);

            if (response.status === "success") {
                $(".table tbody").empty(); // ✅ 테이블에서 모든 상품 제거
                updateCartSummary(); // ✅ 장바구니 합계 업데이트
                alert("장바구니의 모든 상품을 삭제하였습니다.");
                location.reload();
            } else {
                alert("전체 삭제 실패: " + response.message);
            }
        },
        error: function () {
            alert("삭제 중 오류가 발생했습니다.");
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
    "pluginKey": 'a0ac98cf-93df-4eac-88ff-be0aaffa661f'
});
</script>


</head>
<body>
<div class="header">
    <%@ include file="../common/header.jsp" %>
</div>

<div class="container">
	<div class="text-center mt-5">
	   <div class="cart-top">CART</div>
	</div>

	<div class="tableContainer w-75">
		  <table class="table">
        <thead>
            <tr>
                <th>
                <input type="checkbox" id="selectAll">
                </th>
                <th>상품명</th>
                <th>정가</th>
                <th>판매가</th>
                <th>수량</th>
               <!--  <th>배송비</th> -->
                <th>포인트</th>
                <th>합계</th>
                <th>주문</th>
            </tr>
        </thead>
        <tbody>
            <c:if test="${not empty cartList}">
                <c:forEach var="cart" items="${cartList}">
                    <tr data-cart-id="${cart.cart_id}">
                        <td>
                            <input type="hidden" name="cart_id" value="${cart.cart_id}">
                               <input type="hidden" name="goods_id" value="${cart.goodsVO.goods_id}">
                            <input type="checkbox" class="cart-checkbox" value="${cart.cart_id}">
                        </td>
                        <td>
                                <a href="${contextPath}/goods/goodsDetail.do?goods_id=${cart.goods_id}" class="goods-link">
                                  <img style="width: 75px; height: 75px;" src="${contextPath}/image.do?goods_id=${cart.goods_id}&fileName=${cart.imageFileVO.fileName}" 
                                     class="card-img-top" alt="${cart.goodsVO.goods_name}">
                    				 ${cart.goodsVO.goods_name}
                            </a>
                        </td>
                        <td>
                         <fmt:formatNumber value="${cart.goodsVO.goods_price}" pattern="#,###"/>원
                        </td>
                        <td>
                            <input type="hidden" name="goods_sales_price" value="${cart.goodsVO.goods_sales_price}">
                           <fmt:formatNumber value="${cart.goodsVO.goods_sales_price}" pattern="#,###"/>원
                        </td>
                        <td>
						    <input type="number" class="inputQty" min="1" name="order_goods_qty" 
						           value="${cart.order_goods_qty}" data-stock="${cart.goodsVO.goods_stock}"> /${cart.goodsVO.goods_stock}개
						</td>
                      
                       <%--  <td>
                            <input type="hidden" name="goods_delivery_price" value="${cart.goodsVO.goods_delivery_price}">
                            ${cart.goodsVO.goods_delivery_price}원
                        </td> --%>

						<td>
						<input type="hidden" name="goods_point"	value="${cart.goodsVO.goods_point}"> <span class="total_point"> <fmt:formatNumber
											value="${cart.goodsVO.goods_point * cart.order_goods_qty}"
											pattern="#,###" />P
							</span></td>

								<td class="final_total_price">
   						 <fmt:formatNumber value="${cart.goodsVO.goods_sales_price * cart.order_goods_qty}" pattern="#,###"/>원
						</td>
                        <td>
							<a href="javascript:orderEachCartItem(['${cart.cart_id}'])" class="btn-custom btn-order">주문</a>
                            <a href="#" class="btn-custom btn-delete">삭제</a>
                        </td>
                    </tr>
                </c:forEach>
            </c:if>
            <c:if test="${empty cartList}">
                <tr>
                    <td colspan="9">장바구니에 상품이 없습니다.</td>
                </tr>
            </c:if>
        </tbody>
        
         <tfoot>
        	<tr>
			    <th colspan="9" style="border: none;">
			     <div style="display: inline-block;">
			            <button type="button" class="btn-custom btn-order" onclick="orderEachCartItem(getSelectedCartIds())"><strong>선택 주문</strong></button>
            			<button type="button" class="btn-custom" onclick="deleteAllCart()"><strong>전체 삭제</strong></button>
            		<!-- 	<a href="javascript:orderEachCartItem(getSelectedCartIds())" class="btn-custom btn-order">선택 주문</a>
               			 <a href="javascript:deleteAllCart()" class="btn-custom">전체 삭제</a> -->
               	</div>
       			 </th>         	
        	</tr>
        </tfoot>
    </table>

    <table class="table">
        <thead>
            <tr>
                <th>총 상품수</th>
                <th>총 상품 금액</th>
                <!-- <th>총 배송비</th> -->
                <th>최종 결제금액</th>
                <th>총 포인트</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td id="p_totalGoodsNum" class="fs-3">0개</td>
                <td id="p_final_totalPrice" class="fs-3">0원</td>
               <!--  <td id="p_totalDeliveryPrice" class="fs-3">0원</td> -->
<!--                 <td id="p_totalDiscount" class="fs-3">0원</td> -->
                <td id="p_final_totalPayment" class="fs-3">0원</td>
                <td id="p_totalPoint" class="fs-3">0P</td>
            </tr>
        </tbody>
        
       
        
    </table>
</div>


	<!-- ✅ buttonRow의 원래 위치 복원 -->
<div class="buttonRow">
    <a class="btn-custom" href="${contextPath}/goods/goodsListBean.do?goods_category=원두">쇼핑 계속하기</a>
</div>
</div> <!-- ✅ 이 닫는 태그도 원래대로 유지 -->

<div class="footer">
    <%@ include file="../common/footer.jsp" %>
</div>

</body>
</html>
