	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var = "contextPath"  value="${pageContext.request.contextPath}" />
<c:set var="section" value="${reviewsMap.section}" />
<c:set var="pageNum" value="${reviewsMap.pageNum}" />
<c:set var="reviewList" value="${reviewsMap.reviewList}" />
<c:set var="toReviews" value="${not empty reviewsMap.toReviews ? reviewsMap.toReviews : 0}" />


<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${contextPath}/resources/css/defaultStyle.css">
<meta charset="UTF-8">
<title>검색결과</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script> 
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;700&display=swap" rel="stylesheet">

<style>
* {
    font-family: 'Noto Sans KR', sans-serif;
}
    body {
        background-color: #f8f9fa;
    }
        /* 메인 컨테이너 */
    .container {
        max-width: 1000px; 
        margin: 50px auto; 
        background-color: #fff;
        padding: 40px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
         border-radius : 3px;
    }
    
    /* 검색 & 버튼 영역: 우측 정렬 예시 */
    .search-bar {
        display: inline-flex; 
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
    
     /* 버튼 공통 스타일 (검정 글씨, 직선 모서리) */
    .btn-custom {
        display: inline-block;
        border: 1px solid #ddd;
         border-radius : 3px;
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
         border-radius : 3px;
    }

    /* 목록 상단 우측 영역(검색폼 + 글쓰기버튼)을 한 줄 */
    .top-right-area {
        display: flex;
        justify-content: flex-end; 
        align-items: center;
        gap: 10px;
        margin-bottom: 20px;
    }

    /* 상단 REVIEW 텍스트 (가운데 정렬 + 밑줄) */
    .review-top {
        text-align: center;
        font-size: 24px;
        font-weight: 700;
        color: #000;
        margin-bottom: 30px;
        position: relative;
        padding-bottom: 10px; 
    }
    .review-top::after {
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

    .review-grid {
        display: grid;
		 grid-template-columns: repeat(5, 1fr); /* 한 줄에 5개 */
        gap: 15px;
        margin-top: 20px;
        
    }

    .review-item {
        background-color: #fff;
        padding: 15px;
        border: 1px solid #ddd;
         border-radius : 3px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        text-align: center;
    }

    .review-item img {
        width: 100%;
        height: 150px;
        object-fit: cover;
         border-radius : 3px;
        margin-bottom: 10px;
    }

    .review-title {
        font-size: 1.2rem;
        font-weight: bold;
        margin-bottom: 5px;
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
    /* ✅ 상품 이름 스타일 (a 태그 밑줄 제거 & 색상 변경) */
/* ✅ 상품 이름 스타일 (a 태그 밑줄 제거 & 밝은 색상 적용) */
.product-name a {
    text-decoration: none;  /* 🔹 밑줄 제거 */
    color: #2a9df4;  /* 🔹 밝은 블루 계열 적용 (파스텔 느낌) */
    font-weight: bold; /* 🔹 글씨 굵게 강조 */
    transition: color 0.2s ease-in-out; /* 🔹 부드러운 색상 변경 효과 */
}

/* ✅ 마우스 호버 시 스타일 */
.product-name a:hover {
    color: #1d71b8; /* 🔹 살짝 더 진한 블루 (강조 효과) */
}
.no-reviews {
    text-align: center; /* 텍스트 가운데 정렬 */
    font-size: 1.2rem;  /* 글자 크기 키우기 */
    font-weight: bold;   /* 굵게 */
    color: #555;         /* 회색 톤 적용 */
    background-color: #f8f9fa; /* 연한 배경 */
    padding: 20px;       /* 패딩 추가 */
    border-radius: 5px;  /* 둥근 테두리 */
    margin-top: 20px;    /* 상단 여백 */
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    animation: fadeIn 0.8s ease-in-out; /* 부드러운 페이드 인 효과 */
}

.review-item img {
    width: 100%; /* 컨테이너에 맞게 너비 조절 */
    height: 200px; /* 가로 비율 유지하면서 크기 조정 */
    max-height: 200px; /* 너무 큰 이미지 제한 */
    object-fit: cover; /* 비율을 유지하면서 채우기 */
    border-radius: 3px;
    margin-bottom: 10px;
    display: bloack;
}

    .review-image {
    position: relative; /* 하트 아이콘 위치 기준 */
    width: 100%;
}
.heart-container {
    position: absolute;
    bottom: 10px; /* 하단 여백 */
    right: 5px;  /* 우측 여백 */
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
</style>

<script type="text/javascript">
function fn_review_add(isLogOn, reviewForm, loginForm){
    if(isLogOn != '' && isLogOn != 'false'){
        location.href = reviewForm;
    } else {
        alert("로그인 후에 리뷰작성이 가능합니다.");
        location.href = loginForm + '?action=/review/addNewReviewForm.do';
    }
}
</script>

</head>
<body>
<div class="header">
    <%@ include file="../common/header.jsp" %>
</div>
<div class="container">
    <div class="review-top">REVIEW</div>
	
	  <!-- 검색폼 + 글쓰기버튼 (우측 정렬) -->
    <div class="top-right-area">
        <form action="${contextPath}/review/searchReviewLists.do" method="get" class="search-bar">
            <select name="searchType">
                <option value="review_title">제목</option>
                <option value="review_content">내용</option>
                <option value="both">제목+내용</option>
            </select>
            <input type="text" name="searchQuery" placeholder="검색어를 입력하세요" />
                  <a href="#" onclick="this.closest('form').submit();" class="btn-custom">
            검색
        </a>
        </form>

        <!-- 글쓰기 버튼 -->
        <a href="${contextPath}/review/reviewForm.do" class="btn-custom">
            글쓰기
        </a>
    </div>
    
    
    <div class="search-result-info">
    <c:choose>
        <c:when test="${toReviews > 0 and not empty reviewList}">
            <p>총 <strong>${toReviews}</strong>건의 검색 결과가 있습니다.</p>
        </c:when>
        <c:otherwise>
            <p>검색 결과가 없습니다.</p>
        </c:otherwise>
    </c:choose>
</div>
    
    
    
    
    
    
    
	<c:choose>
	<c:when test="${not empty reviewList}">
    <div class="review-grid">
        <c:forEach var="review"  varStatus="reviewNum" items="${reviewList}">
            <div class="review-item">
            
            	<div class="review-image">
                 <c:set var="reviewNoPath" value="${reviewNoList[reviewNum.index]}" />
                   <img src="${contextPath}/base/getImage.do?fileName=${review.fileName}&filePath=${reviewNoPath}"  alt="${review.fileName}" onerror="this.onerror=null; this.src='${contextPath}/resources/images/no_image.png';">
       		 	
       		 	
       		 	   <!-- 하트 & 좋아요 수 -->
				    <div class="heart-container">
				        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="red" class="bi bi-heart-fill" viewBox="0 0 16 16" onclick="incrementLike()" >
				            <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314"/>
				        </svg>
				        <span>${review.goods_like}</span>
				    </div>
       		 	
       		 	</div>
       		 
            <c:set var="maxLength" value="15" /> <!-- 원하는 최대 글자수 설정 -->
       			
       				 
               <div class="review-title">
			    <a href="${contextPath}/review/viewReview.do?review_no=${review.review_no}" class="text-dark" style="text-decoration: none;">
			        <c:choose>
			            <c:when test="${fn:length(review.review_title) > maxLength}">
			                ${fn:substring(review.review_title, 0, maxLength)}...
			            </c:when>
			            <c:otherwise>
			                ${review.review_title}
			            </c:otherwise>
			        </c:choose>
			    </a>
			</div>
                
                
                <div class="review-meta">
                <p style="display: inline; margin-right: 10px;">${review.mem_id}</p>
                <p style="display: inline; margin-right: 10px;">${reivew.writedate}</p>
                <p>조회 : ${review.views}</p>
                <p  class="product-name"><a href="${contextPath}/goods/goodsDetail.do?goods_id=${review.goods_id}">${review.goods_name}</a></p>
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
		<div class="no-reviews">
		작성된 리뷰글이 없습니다.
		</div>
	</c:otherwise>
	</c:choose>

	<nav aria-label="Page navigation">

    <ul class="pagination">
        <c:if test="${toReviews > 0}">
            <!-- 이전 페이지 버튼 -->
            <c:if test="${section > 1}">
                <li class="page-item">
                    <a class="page-link" href="${contextPath}/review/SearchReviewLists.do?section=${section-1}&pageNum=${Math.max(1, (section-1)*10 + 1)}&searchType=${searchType}&searchQuery=${searchQuery}">&laquo;</a>
                </li>
            </c:if>

            <!-- 페이지 번호 -->
            <c:set var="totalPages" value="${(toReviews + 9) / 10}" />
            <c:forEach var="page" begin="1" end="${totalPages < 10 ? totalPages : 10}" step="1">
                <c:set var="pageNumber" value="${(section-1)*10 + page}" />
                <c:if test="${pageNumber <= totalPages}">
                    <li class="page-item">
                        <a class="page-link" href="${contextPath}/review/SearchReviewLists.do?section=${section}&pageNum=${pageNumber}&searchType=${searchType}&searchQuery=${searchQuery}">
                            ${pageNumber}
                        </a>
                    </li>
                </c:if>
            </c:forEach>

            <!-- 다음 페이지 버튼 -->
            <c:if test="${(section * 10) < toReviews}">
                <li class="page-item">
                    <a class="page-link" href="${contextPath}/review/SearchReviewLists.do?section=${section+1}&pageNum=${section*10+1}&searchType=${searchType}&searchQuery=${searchQuery}">&raquo;</a>
                </li>
            </c:if>
        </c:if>
    </ul>
</nav>




</div>

<footer class="footer mt-5">
    <%@ include file="../common/footer.jsp" %>
</footer>
</body>
</html>
