<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    

<!-- JSP에서 공통 경로 설정 -->
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="notice" value="${noticeVO}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet" href="${contextPath}/resources/css/defaultStyle.css">
    <meta charset="UTF-8">
    <title>공지사항 상세보기</title>
    <!-- Google Fonts -->
<link 
    href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" 
    rel="stylesheet">
    <!-- Bootstrap CSS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
    	*{
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
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
              border-radius : 3px;
        }

        /* 상단 NOTICE(가운데 정렬, 밑줄) */
        .notice-top {
            text-align: center;
            font-size: 24px;
            font-weight: 700;
            color: #000;   /* 검정색 */
            margin-bottom: 30px;
            position: relative;    /* 밑줄 스타일을 위해 position 사용 가능 */
            padding-bottom: 10px;  /* 밑줄과 텍스트 사이 간격 */
        }
        .notice-top::after {
            content: "";
            display: block;
            width: 60px;          /* 밑줄 길이 */
            height: 2px;          /* 밑줄 두께 */
            background-color: #000; 
            margin: 0 auto;
            position: absolute;   /* 아래쪽에 밑줄 */
            left: 50%;            /* 가운데 정렬 */
            transform: translateX(-50%);
            bottom: 0;            /* 텍스트 영역 아래 */
        }

        /* 공지사항 헤더 */
        .notice-header {
            border-bottom: 1px solid #ddd; /* 밑줄 */
            padding-bottom: 15px;          /* 아래 여백 */
            margin-bottom: 30px;
        }

        /* 작성자, 날짜, 조회수 */
        .notice-info {
            font-size: 14px;
            color: #666;
        }
        .notice-info span {
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
            border: 1px solid #ddd;   /* 테두리 */
             border-radius : 3px;         /* 둥근 모서리 제거 => 직선 모서리 */
            background-color: #fff;   /* 버튼 배경은 흰색(또는 원하는 색) */
            color: #000;              /* 글자색 검정 */
            margin: 0 10px;
            text-decoration: none;    /* a 태그 기본 밑줄 제거 */
            cursor: pointer;
        }

        /* 버튼 호버 시 파랑색 제거 + 배경 강조 */
        .btn-custom:hover, .btn-custom:focus, .btn-custom:active {
            color: #000 !important;   /* 파란색 제거, 검정색으로 유지 */
            background-color: #f0f0f0; 
            text-decoration: none;
            outline: none;
            <div class="divider">
        }
	.image-container p{
    font-size: 20px; /* ✅ 글자 크기 키우기 */
    font-weight: bold; /* ✅ 글자 굵게 */
    color: #333; /* ✅ 글자 색상 변경 (필요 시) */
    margin-bottom: 10px; /* ✅ 이미지와의 간격 조정 */
	}
    </style>
</head>
<body>

<!-- 헤더 include -->
<div class="header">
    <%@ include file="../common/header.jsp" %>
</div>

<!-- 메인 컨테이너 -->
<div class="container">
    <!-- NOTICE 상단 영역 (가운데 정렬 + 밑줄) -->
    <div class="notice-top">NOTICE</div>

    <!-- 공지사항 헤더 -->
    <div class="notice-header">
        <h2 style="font-size:24px; font-weight:600; color:#000; margin-bottom:10px;">
        ${notice.notice_title}
        </h2>
        <div class="notice-info">
            <span><strong>작성자 :</strong> ${notice.mem_id}</span>
            <span><strong>작성일 :</strong>${notice.notice_writedate}</span>
            <span><strong>조회수 :</strong> ${notice.views }</span>
        </div>
    </div>

    <!-- 본문 내용 -->
    <div class="notice-content">
        <p>
            ${notice.notice_content}
        </p>
    </div>
<!-- 이미지가 존재하는 경우에만 <img> 태그를 표시 -->
<!-- 이미지가 존재하는 경우에만 <img> 태그를 표시 -->
<div class="image-container">
    <p>image</p>
    <div class="divider"></div>

    <c:choose>
        <c:when test="${not empty notice.fileName}">
            <img src="${contextPath}/base/getImage.do?fileName=${notice.fileName}&filePath=${image_path}"
                 alt="공지사항 이미지" style="max-width: 100%; height: auto;"/>
        </c:when>
        <c:otherwise>
            <p style="text-align: center; color: #777; font-size: 16px;">게시된 이미지가 없습니다.</p>
        </c:otherwise>
    </c:choose>
</div>


    <!-- 필요하다면 하단 구분선 -->
  	 <div class="divider"></div> 

    <!-- 버튼 영역 -->
    <div class="btn-container">
    
    <c:set var="mem_grade" value="${sessionScope.member.mem_grade}" />
    
    <c:if test="${mem_grade eq 'admin'}">
        <!-- 수정 버튼 -->
        <a href="${contextPath}/notice/editNotice.do?notice_no=${notice.notice_no}" class="btn-custom">
            수정
        </a>
        <!-- 삭제 버튼 -->
        <a href="${contextPath}/notice/deleteNotice.do?notice_no=${notice.notice_no}" class="btn-custom"
           onclick="return confirm('정말 삭제하시겠습니까?');">
            삭제
        </a>
    </c:if>
        <!-- 목록 버튼 -->
        <a href="${contextPath}/notice/noticeLists.do" class="btn-custom">
            목록
        </a>
    </div>
</div>

<!-- 푸터 include -->
<div class="footer">
    <%@ include file="../common/footer.jsp" %>
</div>

</body>
</html>