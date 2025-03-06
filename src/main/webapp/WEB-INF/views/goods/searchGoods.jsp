<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
  request.setCharacterEncoding("UTF-8");
%>
<c:set var="includeCommonPath"  value="/WEB-INF/views/common"  />
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <script type="text/javascript">const contextPath = "${contextPath}";</script>
    <script src="${contextPath}/resources/js/chatio.js" type="text/javascript"></script>
    
    <!-- 메타 태그 추가 (뷰포트 설정) -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- 부트스트랩 CSS 추가 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- 사용자 정의 CSS 추가 -->
<style>

 /* 페이지네이션 */
    .pagination {
        margin-top: 30px;
        justify-content: center;
    }
    .pagination .page-item .page-link {
        color: #000;
         border-radius : 3px;
        margin: 0 5px;
        border: none;
    }
    .pagination .page-item.active .page-link {
        background-color: #333;
        color: #fff;
         border-radius : 3px;
        border: none;
    }

		    /* 검색 & 버튼 영역: 우측 정렬 예시 */
.search-bar {
    display: flex; 
    justify-content: flex-end;  /* 오른쪽 정렬 */
    align-items: center;
    gap: 10px;
}

    .search-bar select,
    .search-bar input {
        border: 1px solid #ddd;
        font-size: 14px;
        border-radius: 0;
        padding: 10px;
         border-radius : 3px;
    }
    .search-bar input {
        width: 250px; 
    }


.top-right-area {
    margin-bottom: 30px; /* 상위 탭과 검색창 사이의 간격을 줄이기 위한 마진 */
}



    /* 하위 탭 메뉴에서 선택된 탭에 대한 스타일 */
    .nav-pills .nav-link.active {
        color: black !important;
        border-radius: 3px;
        font-weight: bolder;
    }

    .nav-link.title1 {
        all: unset; /* 기존 스타일을 모두 초기화 */
        text-decoration: none; /* 기본 텍스트 꾸밈을 제거 */
        background-color: transparent !important;  /* 배경색을 투명으로 설정 */
        color: gray !important;
         cursor: pointer  !important;
    }

    /* 상위탭에서 border 제거 */
    .nav-tabs .nav-link.title1 {
        all: unset; /* 기존 스타일을 모두 초기화 */
        text-decoration: none; /* 기본 텍스트 꾸밈을 제거 */
        background-color: transparent !important;  /* 배경색을 투명으로 설정 */
        color: gray !important; /* 기본 텍스트 색상 회색 */
        border: #f8f9fa !important; /* 상위탭 선택시 border 제거 */
    }

    .nav-tabs .nav-link.active.title1 {
        color: black !important;
        border-radius: 3px;
        font-weight: bolder;
        border: none !important; /* 선택된 상위탭의 border 제거 */
    }

    /* 탭 디자인 */
    .nav-tabs {
        border: 1px solid #f8f9fa !important;
    }

    /* 굿즈 타이틀과 가격이 들어가는 부분의 배경색을 연한 브라운으로 변경 */
    .card-body {
        background-color: #f8f9fa; /* 연한 브라운 색상 (베이지색) */
    }

    .card-title {
        font-size: 1rem; /* 기존보다 작은 크기로 변경 (원하는 크기로 조정 가능) */
    }

    .carousel-item img {
        width: 100%; /* 화면의 가로 길이에 맞게 이미지 크기 자동 조정 */
        height: auto; /* 세로 크기는 자동으로 조정 */
    }

    .carousel-inner {
        width: 100%;
    }

    .book img {
        width: 200px;
        height: 200px;
        object-fit: cover;
    }

    .nav-link.title1 {
        color: black !important; /* 기본 텍스트 색상 검은색 */
        margin-right: 20px;
    }

    .book {
        width: 200px;
        height: 400px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        margin: 0 auto; /* 카드 가운데 정렬 */
    }

    .card-img-top {
        border-radius: 3px;
    }

    /* 카드 테두리 제거 */
    .card {
        border: none !important;
    }

	.card-body {
		background-color : #fff;
	}
    /* 기존 가격에 대해 회색과 줄을 긋기 */
    .old-price {
        color: #808080; /* 회색 */
        text-decoration: line-through; /* 줄 긋기 */
        font-size: 0.9rem; /* 크기 작게 */
        margin-right: 10px; /* 할인 가격과의 간격 */
    }

    /* 할인 가격에 대해 검은색으로 표시 */
    .new-price {
        color: #000; /* 검은색 */
        font-size: 1.1rem; /* 크기 약간 키움 */
        font-weight: bold; /* 가격을 돋보이게 하기 위해 굵게 */
    }
    
    .card-title {
    	text-align: center;
    	font-weight: bold;
    }
    
    .card-text {
    	text-align: center;
    }

    @media (min-width: 1300px) {
        #outer_wrap {
            padding-left: 25%;
            padding-right: 25%;
        }
    }
</style>
<script type="text/javascript">
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
    <!-- 부트스트랩 JS와 Popper.js 포함 (bundle.min.js로 Popper.js 포함) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <div class="header">
    	<%@ include file="../common/header.jsp" %>
    </div>
    <br>
    <br>
    <div id="outer_wrap" class="container-fluid">
        <div id="wrap">
        
<!-- 상품 검색창 -->
<div class="top-right-area">
    <form action="${contextPath}/goods/searchGoods.do" method="get" class="search-bar"onsubmit="submitSearchForm(event)">

        <input type="text" name="searchQuery" placeholder="검색어를 입력하세요" />
        <button type="submit" class="btn-custom">
            검색
        </button>
    </form>
</div>

<script>
    // 폼 제출 전 검색어를 확인하고 제출 여부를 결정하는 함수
    function submitSearchForm(event) {
        const form = event.target.closest('form');
        const searchQuery = form.querySelector('input[name="searchQuery"]').value.trim();

        // 검색어가 비어 있으면 경고 메시지 표시하고 폼 제출 안 함
        if (searchQuery === '') {
            alert('검색어를 입력해주세요.');
            event.preventDefault(); // 폼 제출을 막기
        }
    }
</script>

    
        
            <div class="clear"></div>

            <!-- 상위 탭 메뉴 -->
            <ul class="nav nav-tabs justify-content-center" id="myTab" role="tablist">
                <li class="nav-item" role="presentation">
                    <a class="nav-link title1" href="${contextPath}/goods/goodsListBean.do?goods_category=원두">원두</a>&nbsp;&nbsp;&nbsp;&nbsp;
                </li>
                <li class="nav-item" role="presentation">
                   <a class="nav-link title1" href="${contextPath}/goods/goodsListBakery.do?goods_category=베이커리">베이커리</a>&nbsp;&nbsp;&nbsp;&nbsp;
                </li>
                <li class="nav-item" role="presentation">
                   
                   <a class="nav-link title1"href="${contextPath}/goods/goodsListTool.do?goods_category=커피용품">커피 용품</a>
                </li>
           
                
                
            </ul>
			<br>
            <!-- 상위 탭 내용 -->
            <div class="tab-content mt-4" id="myTabContent">

    <div class="main_book mb-5">
        <div class="row">
            <!-- 상품 목록 출력 -->
            <c:forEach var="goods" items="${goodsList}">
               
                
                    <div class="col-md-3 mb-4">
                        <div class="book card h-100">
                            <a href="${contextPath}/goods/goodsDetail.do?goods_id=${goods.goods_id}">
                                <!-- 상품 이미지 출력 -->
                                <img src="${contextPath}/image.do?goods_id=${goods.goods_id}&fileName=${goods.fileName}" 
                                     class="card-img-top" alt="${goods.goods_name}">
                            </a>
                            <div class="card-body">
                                <h5 class="card-title">${goods.goods_name}</h5>
                                <p class="card-text">
                                    <span class="old-price">${goods.goods_price}원</span><br>
                                    <span class="new-price">${goods.goods_sales_price}원</span>
                                </p>
                            </div>
                        </div>
                    </div>
                
            </c:forEach>
        </div>
    </div>






            </div>
        </div>
    </div>

    <div class="footer">
    	<%@ include file="../common/footer.jsp" %>
    </div>
    
</body>
</html>
