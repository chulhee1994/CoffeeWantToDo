<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>

<!-- JSTL로 받아올 값 (예: noticesMap.section, pageNum 등) -->
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />
<c:set var="section" value="${noticesMap.section}" />
<c:set var="pageNum" value="${noticesMap.pageNum}" />
<c:set var="noticesList" value="${noticesMap.noticesList}" />
<c:set var="toNotices" value="${noticesMap.toNotices}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>공지사항 목록</title>
<link rel="stylesheet" href="${contextPath}/resources/css/defaultStyle.css">
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
    /* 전체 폰트/배경 */
    body {
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
        color: #333;
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

    /* 상단 NOTICE 텍스트 (가운데 정렬 + 밑줄) */
    .notice-top {
        text-align: center;
        font-size: 24px;
        font-weight: 700;
        color: #000;
        margin-bottom: 30px;
        position: relative;
        padding-bottom: 10px; 
    }
    .notice-top::after {
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

    /* 게시판 테이블 */
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        margin-bottom: 20px;
    }
    th, td {
        border-bottom: 1px solid #e9e9e9; /* 옅은 선 */
        padding: 12px;
        text-align: left;
        font-size: 14px;
        color: #444;
    }
    th {
        background-color: #f9f9f9;
        font-weight: 700;
        color: #000;
    }
    /* 링크 호버 시 파란색 제거 */
    td a {
        color: black;
        text-decoration: none;
    }
    td a:hover {
        color: black;
    }

    /* 검색 & 버튼 영역 */
    .search-bar {
        display: inline-flex; 
        align-items: center;
        gap: 10px;
        
    }
    .search-bar select,
    .search-bar input {
        border: 1px solid #ddd;
        font-size: 14px;
        border-radius : 3px;
        padding: 10px;
    }
    .search-bar input {
        width: 250px; 
        border-radius : 3px;
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
        border-radius : 3px;
    }

    /* 목록 상단 우측 영역 */
    .top-right-area {
        display: flex;
        justify-content: flex-end; 
        align-items: center;
        gap: 10px;
        margin-bottom: 20px;
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
        border: none;
    }
</style>
</head>
<body>

<!-- 헤더 include -->
<div class="header">
    <%@ include file="../common/header.jsp" %>
</div>

<div class="container">
    <!-- 상단 NOTICE -->
    <div class="notice-top">NOTICE</div>

    <!-- 검색폼 + 글쓰기버튼 -->
    <div class="top-right-area">
<form action="${contextPath}/notice/searchNoticeLists.do" method="get" class="search-bar">

    <select name="searchType">
        <option value="notice_title" ${searchType == 'notice_title' ? 'selected' : ''}>제목</option>
        <option value="notice_content" ${searchType == 'notice_content' ? 'selected' : ''}>내용</option>
        <option value="both" ${searchType == 'both' ? 'selected' : ''}>제목+내용</option>
    </select>
    <input type="text" name="searchQuery" placeholder="검색어를 입력하세요" value="${searchQuery}" />
    <a href="#" onclick="this.closest('form').submit();" class="btn-custom">검색</a>
</form>


        <!-- 글쓰기 버튼 -->
        <a href="${contextPath}/notice/noticeForm.do" class="btn-custom">글쓰기</a>
    </div>

    <!-- 게시판 테이블 -->
    <table>
        <thead>
            <tr>
                <th style="width:7%;">번호</th>
                <th style="width:10%;">머릿글</th>
                <th>제목</th>
                <th style="width:10%;">작성자</th>
                <th style="width:15%;">등록일</th>
                <th style="width:8%;">조회수</th>
            </tr>
        </thead>
        <tbody>
    <c:choose>
        <c:when test="${not empty noticesList}">
            <c:forEach var="notice" varStatus="noticeNum" items="${noticesList}">
                <tr>
                    <td>${notice.notice_no}</td>
                    <td>[${fn:toUpperCase(notice.notice_head)}]</td>
                    <td><a href="${contextPath}/notice/viewNotice.do?notice_no=${notice.notice_no}">${notice.notice_title}</a></td>
                    <td>${notice.mem_id}</td>
                    <td>${notice.notice_writedate}</td>
                    <td>${notice.views}</td>
                </tr>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <tr>
                <td colspan="6" style="text-align:center; padding: 20px; font-size: 16px; color: #888;">
                    작성된 글이 없습니다.
                </td>
            </tr>
        </c:otherwise>
    </c:choose>
</tbody>

    </table>

     <!-- 페이지 네비게이션 -->
    <nav aria-label="Page navigation">
        <ul class="pagination">
            <c:if test="${toNotices != null}">
                <c:forEach var="page" begin="1" end="10" step="1">
                    <c:if test="${section > 1 && page == 1}">
                        <li class="page-item"><a class="page-link" href="${contextPath }/notice/noticeLists.do?section=${section-1}&pageNum=${(section-1)*10 +1 }">&laquo;</a></li>
                    </c:if>
                    <li class="page-item"><a class="page-link" href="${contextPath }/notice/noticeLists.do?section=${section}&pageNum=${page}">${(section-1)*10 +page }</a></li>
                    <c:if test="${page == 10}">
                        <li class="page-item"><a class="page-link" href="${contextPath }/notice/noticeLists.do?section=${section+1}&pageNum=${section*10+1}">&raquo;</a></li>
                    </c:if>
                </c:forEach>
            </c:if>
        </ul>
    </nav>
    
    
    
</div>

<!-- 푸터 include -->
<div class="footer">
    <%@ include file="../common/footer.jsp" %>
</div>

</body>
</html>
