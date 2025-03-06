<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    

<!-- JSP에서 공통 경로 설정 -->
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="review" value="${reviewVO}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet" href="${contextPath}/resources/css/defaultStyle.css">
    <meta charset="UTF-8">
    <title>REVIEW 상세</title>
    <!-- Google Fonts -->
<link 
    href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" 
    rel="stylesheet">
    <!-- Bootstrap CSS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <style type="text/css">
    * {
    font-family: 'Noto Sans KR', sans-serif;
}
/* 전체 배경과 폰트 설정 */
body {
	background-color: #f4f4f4;
	color: #333; /* 기본 글씨색은 짙은 회색, 필요 시 #000으로 조정 가능 */
	margin: 0;
	padding: 0;
}

/* 헤더, 푸터 */
.header, .footer {
	width: 100%;
	background-color: #fff;
}

/* 메인 컨테이너 */
.container {
	max-width: 1000px;
	margin: 50px auto;
	background-color: #fff;
	padding: 40px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
	border-radius : 3px;
}

/* 상단 REVIEW(가운데 정렬, 밑줄) */
.review-top {
	text-align: center;
	font-size: 24px;
	font-weight: 700;
	color: #000; /* 검정색 */
	margin-bottom: 30px;
	position: relative; /* 밑줄 스타일을 위해 position 사용 가능 */
	padding-bottom: 10px; /* 밑줄과 텍스트 사이 간격 */
}

.review-top::after {
	content: "";
	display: block;
	width: 60px; /* 밑줄 길이 */
	height: 2px; /* 밑줄 두께 */
	background-color: #000;
	margin: 0 auto;
	position: absolute; /* 아래쪽에 밑줄 */
	left: 50%; /* 가운데 정렬 */
	transform: translateX(-50%);
	bottom: 0; /* 텍스트 영역 아래 */
}

/* 리뷰 헤더 */
.review-header {
	border-bottom: 1px solid #ddd; /* 밑줄 */
	padding-bottom: 15px; /* 아래 여백 */
	margin-bottom: 30px;
}

/* 작성자, 날짜, 조회수 */
.review-info {
	font-size: 14px;
	color: #666;
}

.review-info span {
	margin-right: 20px;
}

/* 본문 내용 */
.notice-content {
	line-height: 1.8;
	color: #333;
	min-height: 300px;
	margin-bottom: 40px;
}

/* 하단 구분선 (필요 시) */
.divider {
	margin: 40px 0;
	border-top: 1px solid #ccc;
}

/* 버튼 영역 */
.btn-container {
	text-align: center;
	margin-top: 30px;
}

/* 버튼 공통 스타일 */
.btn-custom {
	display: inline-block;
	padding: 10px 20px;
	font-size: 16px;
	border: 1px solid #ddd; /* 테두리 */
	border-radius : 3px;
	background-color: #fff; /* 버튼 배경은 흰색(또는 원하는 색) */
	color: #000; /* 글자색 검정 */
	margin: 0 10px;
	text-decoration: none; /* a 태그 기본 밑줄 제거 */
	cursor: pointer;
}

/* 버튼 호버 시 파랑색 제거 + 배경 강조 */
.btn-custom:hover, .btn-custom:focus, .btn-custom:active {
	color: #000 !important; /* 파란색 제거, 검정색으로 유지 */
	background-color: #f0f0f0;
	border-radius : 3px;
	text-decoration: none;
	outline: none;
}

.like-container {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 20px;
	gap: 10px;
}

.like-container img {
    cursor: pointer;
    transition: transform 0.3s ease, fill 0.3s ease; /* 부드러운 전환 */
    filter: grayscale(100%); /* 기본 회색 처리 */
    transform: scale(1);
}

.like-container img:hover {
    filter: grayscale(0%); /* 색상 활성화 */
    transform: scale(1.1); /* 살짝 확대 */
    animation: fillHeart 0.6s forwards; /* 하트 색상 채우기 애니메이션 */
}
.image-container p{
	  font-size: 20px; /* ✅ 글자 크기 키우기 */
    font-weight: bold; /* ✅ 글자 굵게 */
    color: #333; /* ✅ 글자 색상 변경 (필요 시) */
    margin-bottom: 10px; /* ✅ 이미지와의 간격 조정 */
}
@keyframes fillHeart {
    from {
        filter: grayscale(100%);
    }
    to {
        filter: grayscale(0%);
    }
}

.like-container span {
	font-size: 18px;
	font-weight: bold;
}

/* Modal Styles */
.modal {
	display: none;
	position: fixed;
	z-index: 1050;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: hidden;
	background-color: rgba(0, 0, 0, 0.5);
	align-items: center;
	justify-content: center;
}
.modal-content {
	position: relative;
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	width: 90%;
	height: 90%;
	display: flex;
	justify-content: center;
	align-items: center;
}
.modal-content img {
	width: 100%;
	height: 100%;
	border-radius : 3px;
	object-fit: contain;
}
.modal-close {
	position: absolute;
	top: 10px;
	right: 10px;
	font-size: 24px;
	font-weight: bold;
	color: #000;
	cursor: pointer;
}
.images{
	  width: 300px; /* 컨테이너에 맞게 너비 조절 */
    height: 200px; /* 가로 비율 유지하면서 크기 조정 */
    max-height: 200px; /* 너무 큰 이미지 제한 */
    /*object-fit: cover;*/ /* 비율을 유지하면서 채우기 */
    margin-bottom: 10px;
    display: bloack;
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
	const contextPath = "${contextPath}";
    const reviewNo = "${review.review_no}";
	
    console.log(reviewNo);
    
    $(document).ready(function () {
        const reviewNo = "${review.review_no}";
        const likeCookie = document.cookie.split('; ').find(row => row.startsWith('liked_review_' + reviewNo));

        if (likeCookie) {
            $(".bi-heart-fill").css("fill", "red"); // 이미 눌렀다면 빨간 하트로 변경
        }
    });

    function incrementLike() {
        $.ajax({
            type: "POST",
            url: contextPath + "/review/incrementLike.do",
            xhrFields: {
                withCredentials: true // 세션 쿠키 포함
            },
            data: { review_no: reviewNo },
            success: function (response) {
                if (response.success) {
                    alert("리뷰에 좋아요를 눌렀습니다.");
                    $("#likeCount").text(parseInt($("#likeCount").text()) + 1);
                    $(".bi-heart-fill").css("fill", "red"); // 하트 색 변경
                } else {
                    alert(response.message);
                }
            },
            error: function (xhr) {
                console.error("서버 응답 코드:", xhr.status);
                console.error("서버 응답 메시지:", xhr.responseText);
                alert("오류 발생: " + xhr.status + " " + xhr.responseText);
            }
        });
    }



function openModal(imageSrc) {
    const modal = document.getElementById("imageModal");
    const modalImage = document.getElementById("modalImage");
    modalImage.src = imageSrc;
    modal.style.display = "flex";
}

function closeModal() {
    const modal = document.getElementById("imageModal");
    modal.style.display = "none";
}
</script>
</head>
<body>
<!-- 헤더 include -->
<div class="header">
    <%@ include file="../common/header.jsp" %>
</div>

<!-- 메인 컨테이너 -->
<div class="container">
    <!-- REVIEW 상단 영역 (가운데 정렬 + 밑줄) -->
    <div class="review-top">REVIEW</div>

    <!-- 공지사항 헤더 -->
    <div class="review-header">
        <h2 style="font-size:24px; font-weight:600; color:#000; margin-bottom:10px;">${review.review_title }</h2>
        <div class="review-info">
            <span><strong>작성자 :</strong> ${review.mem_id}</span>
            <span><strong>작성일 :</strong>  <fmt:formatDate value="${review.review_writedate}" pattern="yyyy-MM-dd HH:mm" /></span>
            <span><strong>조회수 :</strong> ${review.views }</span>
           
        </div>
    </div>

    <!-- 본문 내용 -->
    <div class="notice-content">
        <p>
          ${review.review_content }
        </p>
    </div>

		<div class="image-container">
		<p>image</p>
			<div class="divider"></div>
			<c:choose>
				<c:when test="${not empty reviewImages}">
			<c:forEach var="review" items="${reviewImages}">
			
		 <img src="${contextPath}/base/getImage.do?fileName=${review.fileName}&filePath=${filePath}" style="cursor: pointer;" onclick="openModal(this.src)" alt="${review.fileName}" class="images" >
			</c:forEach>
				</c:when>
				<c:otherwise>
				<p style="text-align: center; color: #777; font-size: 16px;">게시된 이미지가 없습니다.</p>
				</c:otherwise>
			
			</c:choose>
		</div>

		<!-- 필요하다면 하단 구분선 -->
  	 <div class="divider"></div>

	<div class="like-container">
		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="gray" class="bi bi-heart-fill" viewBox="0 0 16 16"  onclick="incrementLike()" style="cursor: pointer;">
  		<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314"/>
		</svg>
		<span id="likeCount"><c:out value="${reviewVO.goods_like}" default="0" /></span>
	</div>
		<!-- 버튼 영역 -->
    <div class="btn-container">
        <!-- 목록 버튼 -->
        <a href="${contextPath}/review/reviewLists.do" class="btn-custom">
            목록
        </a>
        
        <c:if test="${mem_id eq reviewVO.mem_id}">
        <!-- 수정 버튼 -->
        <a href="${contextPath}/review/editReview.do?review_no=${reviewVO.review_no}" class="btn-custom">
            수정
        </a>
        <!-- 삭제 버튼 -->
        <a href="${contextPath}/review/deleteReview.do?review_no=${reviewVO.review_no}" class="btn-custom"
           onclick="return confirm('정말 삭제하시겠습니까?');">
            삭제
        </a>
        </c:if>
		
				
    </div>
</div>

<!-- Modal -->
<div id="imageModal" class="modal" onclick="closeModal()">
    <div class="modal-content">
        <span class="modal-close" onclick="closeModal()">&times;</span>
        <img id="modalImage" src="" alt="확대된 이미지" />
    </div>
</div>

<!-- 푸터 include -->
<div class="footer">
    <%@ include file="../common/footer.jsp" %>
</div>

</body>
</html>
