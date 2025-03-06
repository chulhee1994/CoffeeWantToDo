<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FAQ</title>
    <!-- Google Fonts -->
<link 
    href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" 
    rel="stylesheet">
    <!-- 부트스트랩 CSS 추가 -->
    <link rel="stylesheet" href="${contextPath}/resources/css/defaultStyle.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
  <style type="text/css">
    * {
        font-family: 'Noto Sans KR', sans-serif;
    }

    /* 기본 스타일 초기화 */
    body {
        background-color: #f6f6f6;
        margin: 0;
        padding: 0;
        color: #333;
    }

    .container {
        max-width: 1000px;
        margin: 50px auto;
        background-color: #fff;
        padding: 30px;
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
        border: 1px solid #ddd;
        border-radius: 0 !important; /* ✅ 모든 모서리 둥글기 제거 */
    }

    .faq-top {
        text-align: center;
        font-size: 24px;
        font-weight: 700;
        color: #000;
        margin-bottom: 30px;
        position: relative;
        padding-bottom: 10px;
        border-radius: 0 !important; /* ✅ 모서리 제거 */
    }

    .faq-top::after {
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

    /* 기본 텍스트 및 제목 스타일 */
    h2 {
        color: #444;
        font-weight: bold;
        text-align: center;
        margin-bottom: 25px;
        text-transform: uppercase;
        border: 1px solid #ddd;
        border-radius: 0 !important;
    }

    /* ✅ 모든 list-group-item에서 radius 제거 */
    .list-group.mt-3 a.list-group-item,
    .tab-pane.fade a.list-group-item,
    .tab-pane.fade.active.show a.list-group-item {
        background-color: #fff;
        border: 1px solid #ddd !important;
        color: #444;
        margin-bottom: 8px;
        padding: 14px 18px;
        cursor: pointer;
        transition: background-color 0.2s ease, color 0.2s ease;
        display: block;
        border-radius: 0 !important; /* ✅ 모서리 제거 */
    }

    /* ✅ collapsed 상태에서도 border 유지 */
    .list-group.mt-3 a.list-group-item.collapsed,
    .tab-pane.fade a.list-group-item.collapsed {
        border: 1px solid #ddd !important;
        border-radius: 0 !important;
    }

    /* ✅ 클릭 가능 상태 (list-group-item-action)에도 border 유지 */
    .list-group.mt-3 a.list-group-item.list-group-item-action,
    .tab-pane.fade a.list-group-item.list-group-item-action {
        border: 1px solid #ddd !important;
        border-radius: 0 !important;
    }

    /* ✅ hover 및 focus 시에도 border 유지 */
    .list-group.mt-3 a.list-group-item.list-group-item-action:hover,
    .tab-pane.fade a.list-group-item.list-group-item-action:hover,
    .list-group.mt-3 a.list-group-item.list-group-item-action:focus,
    .tab-pane.fade a.list-group-item.list-group-item-action:focus {
        background-color: #f9f9f9;
        color: #000;
        border: 1px solid #ddd !important;
        border-radius: 0 !important;
    }

    /* 탭 스타일 */
    .faq-tabs {
        justify-content: center;
        border: none;
        border-radius: 0 !important;
    }

    .faq-item {
        margin: 0 5px;
        border-radius: 0 !important;
    }

    .faq-tabs .faq-link {
        color: #555;
        font-weight: bold;
        background-color: #fafafa;
        border: 1px solid #ddd;
        padding: 10px 18px;
        text-align: center;
        transition: color 0.2s ease, background-color 0.2s ease;
        border-radius: 0 !important; /* ✅ 탭 버튼에서도 모서리 제거 */
    }

    .faq-tabs .faq-link.active {
        background-color: #ddd;
        color: #333;
        border-radius: 0 !important;
    }

    /* 카드 스타일 */
    .card {
        border: 1px solid #ccc;
        box-shadow: none;
        margin-top: 15px;
        padding: 20px;
        border-radius: 0 !important; /* ✅ 카드에서도 radius 제거 */
    }

    .card-body {
        background-color: #fafafa;
        color: #444;
        padding: 18px;
        font-size: 15px;
        line-height: 1.8;
        border: 1px solid #ddd;
        border-radius: 0 !important; /* ✅ 카드 내부도 둥글지 않게 */
    }

    a {
        text-decoration: none !important;
    }

    @media (max-width: 768px) {
        .list-group.mt-3 a.list-group-item,
        .tab-pane.fade a.list-group-item {
            font-size: 14px;
            padding: 12px 15px;
        }

        a {
            padding: 6px 8px;
        }
    }
</style>






</head>
<body>
<!-- 헤더 include -->
<div class="header">
    <%@ include file="../common/header.jsp" %>
</div>
    <div class="container">
         <div class="faq-top">FAQ</div>

        <!-- 탭 메뉴 시작 -->
        <ul class="nav faq-tabs" id="faqTabs" role="tablist">
            <li class="faq-item">
                <a class="faq-link active" id="category1-tab" data-toggle="tab" href="#category1" role="tab" aria-controls="category1" aria-selected="true">자주 찾는 질문</a>
            </li>
            <li class="faq-item">
                <a class="faq-link" id="category2-tab" data-toggle="tab" href="#category2" role="tab" aria-controls="category2" aria-selected="false">제품 및 서비스</a>
            </li>
            <li class="faq-item">
                <a class="faq-link" id="category3-tab" data-toggle="tab" href="#category3" role="tab" aria-controls="category3" aria-selected="false">주문 및 배송</a>
            </li>
            <li class="faq-item">
                <a class="faq-link" id="category4-tab" data-toggle="tab" href="#category4" role="tab" aria-controls="category4" aria-selected="false">교환 및 반품</a>
            </li>
        </ul>

        <!-- 탭 내용 시작 -->
        <div class="tab-content" id="faqTabsContent">
            <!-- 카테고리 1 -->
            <div class="tab-pane fade show active" id="category1" role="tabpanel" aria-labelledby="category1-tab">
                <div class="list-group mt-3">
                    <a href="#question1" class="list-group-item list-group-item-action" data-toggle="collapse" aria-expanded="false" aria-controls="question1">
                    [주문] 주문이 여러건일 때, 합배송 적용이 가능할까요?
                    </a>
					<div id="question1" class="collapse">
						<div class="card card-body">
							<p>배송 준비중 상태에서 합배송 적용이 가능합니다.</p>
							<p>추가 주문 후, 배송 메세지에 '정기배송 또는 이전 주문과 합배송 요청'으로 메모 남겨주세요. 배송 진행
								후 이중 지불된 택배 비용은 적립금으로 반환됩니다. 보다 자세한 사항은 온라인 공식몰 대표번호로 문의하여 주시기
								바랍니다.</p>
							<p>T. 042-276-2111</p>
							<p>(PC)홈페이지 Q&A 문의</p>
						</div>
					</div>

					<a href="#question2" class="list-group-item list-group-item-action"
						data-toggle="collapse" aria-expanded="false"
						aria-controls="question2"> 마켓 상품은 언제 업로드 되나요? </a>
					<div id="question2" class="collapse">
						<div class="card card-body">
							<p>원두 want to do는 커피 원두 및 커피 기구, 굿즈 등을 일정 기간 동안 합리적인 가격으로
								소개하는 공동구매 프로그램입니다.</p>
							<p>매주 수요일 오전 12시 이전 새롭게 업데이트 되며, 일주일 동안의 사전 예약 후 매주 수요일 일괄
								발송됩니다.</p>
							<p>T. 042-276-2111</p>
							<p>(PC)홈페이지 Q&A 문의</p>
						</div>
					</div>

					<a href="#question3" class="list-group-item list-group-item-action"
						data-toggle="collapse" aria-expanded="false"
						aria-controls="question2">
						[상품]원두 want to do  상품패키지는 어떤 재질일까요?
						</a>
					<div id="question3" class="collapse">
						<div class="card card-body">
						
							<p>' 책임 있는 생산과 소비'</p>
							<p>지속가능한 스페셜티 커피의 위한 환경을 보호하고 만들어 나가기 위해 판매 되어지는 상품 포장 재질은 글로벌 산림 인증 시스템인 FSC 인증을 받은 종이와 함께 콩에서 추출한 식물성 소이 잉크를 사용하고 있습니다. </p>
							<p>탄소 배출량을 48%가량 절반으로 감소 시키고, 종이로 분리배출이 가능해 92%의 높은 재활용율을 가진 친환경 봉투와 종이 완충제를 사용함으로써 책임 있는 생산과 소비를 지향하고 우리의 유한한 자원을 지켜나가기 위한 더 나은 시도들을 전개 하고 있습니다.  </p>
						</div>
					</div>

					<a href="#question4" class="list-group-item list-group-item-action"
						data-toggle="collapse" aria-expanded="false"
						aria-controls="question2">
						[상품] 드립백 VER필터의 장점이 무엇일까요?
						</a>
					<div id="question4" class="collapse">
						<div class="card card-body">
							<p>원두 want to do는 영도 르스터리 앤 커피바에서 '드립백' 을 자체 생산하며 친환경 소재의 VER필터를 사용하고
								있습니다.</p>
							<p>VFR필터 드립백은 다양한 사이즈의 컵으로 즐길 수 있는 높은 호환성이 있는 필터로 동일한 물양을
								주입하였을 때 기존의 필터보다 상대적으로 많은 추출량을 얻을 수 있는 장점을 가지고 있습니다.</p>
							<p>드립백 앞쪽 PUSH 클립 중앙 1곳과 양쪽 날개 2곳을 컵에 고정해 주시고, 윗면 PUSH 표기 부분을
								안쪽으로 접어주시면 더욱 안정적인 추출이 가능합니다.</p>
							<p>T. 042-276-2111</p>
							<p>(PC)홈페이지 Q&A 문의</p>
						</div>
					</div>


				</div>
            </div>

            <!-- 카테고리 2 -->


			<div class="tab-pane fade" id="category2" role="tabpanel"
				aria-labelledby="category2-tab">
				<div class="list-group mt-3">

					<a href="#question1" class="list-group-item list-group-item-action"
						data-toggle="collapse" aria-expanded="false"
						aria-controls="question1"> [신선식품] 원두 보관 방법이 궁금해요. </a>
					<div id="question1" class="collapse">
						<div class="card card-body">
							<p>로스팅 원두는 디개싱(숙성) 기간을 통해, 일정 시간이 지남에 따라 커피의 향미 표현 및 추출 안정성이
								높아집니다.</p>
							<p>패키지 형태 그대로 보관하시거나, 가급적 공기와의 접촉을 최소화 시켜줄 진공 밀페용기에 담아서 보관 하실
								것을 권장 드립니다.</p>
							<p>더불어, 원두 패키지 사용 시에도 내부 공기를 제거 후 밀봉 하실 것을 권장 드리며, 햇빛이 들지 않는
								서늘한 곳에 상온 보관이 적합합니다.</p>
							<p>T. 042-276-2111</p>
							<p>(PC)홈페이지 Q&A 문의</p>
						</div>
					</div>
				</div>

				<a href="#question2" class="list-group-item list-group-item-action"
					data-toggle="collapse" aria-expanded="false"
					aria-controls="question2"> [신선식품] 드립백 소비기한은 언제일까요? </a>
				<div id="question2" class="collapse">
					<div class="card card-body">
						<p>- 소비기한 안내</p>
						<p>드립백: 제조일로부터 1년 이내 소비(제품 하단부 별도 표기)</p>
						<p>주문과 동시에 자사 물류창고에서 직접 배송 되는 상품으로, 각 창고 마다 보관된 제조 연월일이 상이합니다.
						</p>
						<p>직접 수령하실 상품의 정확한 일자 확인은 온라인 공식몰 대표 번호로 문의하여 주시기 바랍니다.</p>
						<p>T. 042-276-2111</p>
						<p>(PC)홈페이지 Q&A 문의</p>
					</div>
				</div>

				<a href="#question3" class="list-group-item list-group-item-action"
					data-toggle="collapse" aria-expanded="false"
					aria-controls="question3"> [신선식품] 원두 소비기한은 언제일까요? </a>
				<div id="question3" class="collapse">
					<div class="card card-body">
						<p>- 소비기한 안내</p>
						<p>원두: 제조일로부터 1년 이내 소비(제품 하단부 별도 표기)</p>

						<p>주문일로부터 1-3일 내 로스팅 된 상품으로, 제조연월일이 상이 합니다. 수령일로부터 최대 1-2개월 이내
							소비하실 것을 권장 드리며, 시간이 지남에 따라 향미 변화가 있을 수 있는 점 안내 드립니다. 보다 더 자세한 사항은
							온라인공식몰 대표 번호로 문의하여 주시기 바랍니다.</p>
						<p>T. 042-276-2111</p>
						<p>(PC)홈페이지 Q&A 문의</p>
					</div>
				</div>

				<a href="#question4" class="list-group-item list-group-item-action"
					data-toggle="collapse" aria-expanded="false"
					aria-controls="question4"> [신선식품] 콜드브루 소비기한은 언제일까요? </a>
				<div id="question4" class="collapse">
					<div class="card card-body">
						<p>- 소비기한 안내</p>
						<p>콜드브루 rtd: 제조일로부터 4개월 이내 소비(제품 하단부 별도 표기)</p>
						<p>콜드브루 원액: 제조일로부터 6개월 이내 소비(제품 하단부 별도 표기)</p>

						<p>주문과 동시에 자사 물류창고에서 직접 배송 되는 상품으로, 각 창고 마다 보관된 상품의 제조 연월일이
							상이합니다.</p>
						<p>직접 수령하실 상품의 정확한 일자 확인은 온라인 공식몰 대표번호로 문의하여 주시기 바랍니다.</p>

						<p>T. 042-276-2111</p>
						<p>(PC)홈페이지 Q&A 문의</p>
					</div>
				</div>
			</div>
			<!-- 카테고리 2 -->
			
			<!-- 카테고리 3 -->
			<div class="tab-pane fade" id="category3" role="tabpanel" aria-labelledby="category3-tab">
                <div class="list-group mt-3">
                
                    <a href="#question1" class="list-group-item list-group-item-action" data-toggle="collapse" aria-expanded="false" aria-controls="question1">
                    [주문] 공식 온라인몰 주문 시간이 궁금해요.
                    </a>
                    <div id="question1" class="collapse">
                        <div class="card card-body">
                        	<p>커피 want to do ONLINESHOP</p>
							<p>온라인 택배 발송은 당일 오전 8시 이전 주문완료 시 당일 발송을 원칙으로 하고 있으나, 로스터리 내부
								사정에 따라 1일 정도 연기 될 수 있습니다. 상품의 평균 배송기간은 입금 확인 후 1~3일이며, 상품도착일은
								택배사 내규에 따라 주문 시점에 따른 유동성이 발생할 수도 있습니다.</p>
							<p>T. 042-276-2111</p>
							<p>(PC)홈페이지 Q&A 문의</p>
						</div>
                    </div>
                </div>
                
                    <a href="#question2" class="list-group-item list-group-item-action" data-toggle="collapse" aria-expanded="false" aria-controls="question2">
                    [주문] 배송 옵션과 배송비 기준이 궁금해요.
                    </a>
                    <div id="question2" class="collapse">
					<div class="card card-body">

						<p>배송사는 '우체국 택배' 로 발송하며, 구매 기준 금액 40,000원 이상 시 무료 배송이 가능합니다.</p>
						<p>상품의 평균 배송 기간은 입금 확인 후 1~3일 으로, 상품 도착일은 택배사 내규에 따라 주문 시점에 따른
							유동성이 발생될 수 있습니다.</p>
							
						<p>T. 042-276-2111</p>
						<p>(PC)홈페이지 Q&A 문의</p>
					</div>
				</div>
                
                    <a href="#question3" class="list-group-item list-group-item-action" data-toggle="collapse" aria-expanded="false" aria-controls="question3">
                    [주문] 주문 취소를 하고 싶어요.
                    </a>
                    <div id="question3" class="collapse">
                        <div class="card card-body">
						<p>- [배송준비중] 이전 단계 MY INFO 페이지 내 'ORDER LIST' 에서 주문 취소가 가능합니다. 비회원의
						경우 웹사이트 내 ORDER >비회원 주문 조회 후 취소 가능합니다.</p>
						<p>* 배송이 시작된 [배송준비중] 이후 단계에서는 취소가 제한되는 점 안내 드립니다.</p>
						<p>T. 042-276-2111</p>
						<p>(PC)홈페이지 Q&A 문의</p>
					</div>
                    </div>
                
                    <a href="#question4" class="list-group-item list-group-item-action" data-toggle="collapse" aria-expanded="false" aria-controls="question4">
                    [신선식품] 콜드브루 소비기한은 언제일까요?
                    </a>
                    <div id="question4" class="collapse">
                        <div class="card card-body">
                        	<p>- 소비기한 안내</p>
                        	<p>콜드브루 rtd: 제조일로부터 4개월 이내 소비(제품 하단부 별도 표기)</p>
                        	<p>콜드브루 원액: 제조일로부터 6개월 이내 소비(제품 하단부 별도 표기)</p>
                        	
                        	<p>주문과 동시에 자사 물류창고에서 직접 배송 되는 상품으로, 각 창고 마다 보관된 상품의 제조 연월일이 상이합니다.</p>
                            <p>직접 수령하실 상품의 정확한 일자 확인은 온라인 공식몰 대표번호로  문의하여 주시기 바랍니다.</p>
							<p>T. 042-276-2111</p>
                            <p>(PC)홈페이지 Q&A 문의</p>
                        </div>
                    </div>
            </div>
			<!-- 카테고리 3 -->
			
			<!-- 카테고리 4 -->

			<div class="tab-pane fade" id="category4" role="tabpanel" aria-labelledby="category4-tab">
                <div class="list-group mt-3">
                
                    <a href="#question1" class="list-group-item list-group-item-action" data-toggle="collapse" aria-expanded="false" aria-controls="question1">
                   [교환 및 반품] 상품 환불 규정이 어떻게 될까요?
                    </a>
					<div id="question1" class="collapse">
						<div class="card card-body">
							<p>택배 수령 후 상품에 이상이 발견 되었다면, 패키지 개봉 및 사용하지 않고 '상품의 이상' 을 확인할 수
								있는 사진과 영상을 카카오톡 채널 또는 1:1게시판으로 문의 부탁드립니다. 문의 내용 확인 후 받으셨던 상품과
								맞교환 및 환불 안내 드리겠습니다.</p>
							<p>다음에 해당하는 경우 교환 / 환불 신청이 어렵습니다.</p>
							<p>원두</p>
							<p>－기호에 따른 단순 변심의 의한 경우</p>
							<p>－분쇄 원두 및 주문 착오에 의한 경우</p>
							<br>

							<p>상품 및 굿즈</p>
							<p>－상품 개봉 및 포장 훼손의 경우 (상품의 내용 확인을 위한 경우 제외.)</p>
							<p>－상품 사용 및 일부 소비로 인해 상품의 가치가 감소한 경우</p>
							<br>

							<p>패키지 형태 그대로 보관하시거나, 가급적 공기와의 접촉을 최소화 시켜줄 진공 밀페용기에 담아서 보관 하실
								것을 권장 드립니다.</p>
							<p>더불어, 원두 패키지 사용 시에도 내부 공기를 제거 후 밀봉 하실 것을 권장 드리며, 햇빛이 들지 않는
								서늘한 곳에 상온 보관이 적합합니다.</p>
							<p>T. 042-276-2111</p>
							<p>(PC)홈페이지 Q&A 문의</p>
						</div>
					</div>
				</div>
                
            </div>
			<!-- 카테고리 4 -->
			<!-- 다른 카테고리 추가가능 -->
        </div>
        <!-- 탭 내용 끝 -->
    </div>
    <div class="footer">
    	<%@ include file="../common/footer.jsp" %>
    </div>
    

    <!-- 부트스트랩 JS, Popper.js, jQuery 추가 -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
        document.addEventListener('DOMContentLoaded', function () {
            var dropdownElements = document.querySelectorAll('.dropdown-toggle');
            dropdownElements.forEach(function (dropdown) {
                new bootstrap.Dropdown(dropdown); // 드롭다운 초기화
            });
        });
    </script>
</body>
</html>
