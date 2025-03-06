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
<meta charset="UTF-8">
<link rel="stylesheet" href="${contextPath}/resources/css/defaultStyle.css">
<title>공지사항 수정</title>
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
    /* 기본 글꼴 및 배경 설정 */
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color:  #ECE6E6;
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

    /* 상단 NOTICE (가운데 정렬 + 밑줄) */
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

    /* 수정 폼 테이블 */
    .edit-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 30px;
         border-radius : 3px;
        
    }
    .edit-table th,
    .edit-table td {
        border: 1px solid #e9e9e9;
        padding: 12px;
        vertical-align: middle;
        font-size: 14px;
        color: #444;
         border-radius : 3px;
        
    }
    .edit-table th {
        width: 120px; /* 필요 시 조정 */
        background-color: #f9f9f9;
        text-align: left;
    }
    .edit-table input,
    .edit-table textarea,
    .edit-table select {
        width: 95%;             /* 공간 확보 */
        border: 1px solid #ddd;
         border-radius : 3px;
        padding: 10px;
        font-size: 14px;
        color: #333;
        margin: 0;
        box-sizing: border-box;  /* 패딩 포함 너비 계산 */
        
    }
    /* 이미지 업로드 시 파일 필드도 동일 스타일 유지 */
    .edit-table input[type="file"] {
        padding: 5px; 
         border-radius : 3px;
    }

    .edit-table textarea {
        min-height: 200px;      
        resize: none;           /* 크기 조정 불가능 */
    }

    /* 버튼 영역 */
    .btn-container {
        text-align: center;
        margin-top: 30px;
    }
   /* btn-custom 스타일 */
.btn-custom {
    display: inline-block;    /* 동일한 레이아웃 */
    border: 1px solid #ddd;  /* 테두리 스타일 */
     border-radius : 3px;       /* 직선 모서리 */
    background-color: #fff;  /* 배경 색상 */
    color: #000;             /* 글자 색상 */
    font-size: 14px;         /* 글자 크기 */
    padding: 10px 20px;      /* 안쪽 여백 */
    text-decoration: none;   /* 밑줄 제거 */
    cursor: pointer;         /* 클릭 가능한 상태 표시 */
    text-align: center;      /* 텍스트 가운데 정렬 */
    margin: 0 10px;          /* 양옆 여백 */
}

/* 버튼 호버 효과 */
.btn-custom:hover {
    background-color: #f0f0f0; /* 호버 시 배경 색상 */
    color: #000 !important;    /* 호버 시 글자 색상 */
    text-decoration: none;     /* 호버 시 밑줄 제거 */
}

/* 버튼과 링크에 동일 스타일 적용 */
button.btn-custom {
    all: unset;              /* 기본 스타일 초기화 */
    display: inline-block;   /* 동일한 레이아웃 */
    border: 1px solid #ddd;  /* 테두리 스타일 */
    border-radius: 0;        /* 직선 모서리 */
    background-color: #fff;  /* 배경 색상 */
    color: #000;             /* 글자 색상 */
    font-size: 14px;         /* 글자 크기 */
    padding: 10px 20px;      /* 안쪽 여백 */
    text-decoration: none;   /* 밑줄 제거 */
    cursor: pointer;         /* 클릭 가능한 상태 표시 */
    text-align: center;      /* 텍스트 가운데 정렬 */
    margin: 0 10px;          /* 양옆 여백 */
}
.validation{
	color: red;
}
</style>
<script>
function previewImage(event) {
    var reader = new FileReader();
    reader.onload = function(){
        var output = document.getElementById('previewImg');
        var previewRow = document.getElementById('previewRow');
        output.src = reader.result;

        // 새 이미지를 선택하면 미리보기를 보이게 설정
        previewRow.style.display = "table-row";
    };
    reader.readAsDataURL(event.target.files[0]);
}
function validateForm() {
    var title = document.forms["noticeForm"]["notice_title"].value.trim();
    var content = document.forms["noticeForm"]["notice_content"].value.trim();

    if (title === "") {
        alert("제목을 입력하세요.");
        return false; //  서버 요청 차단
    }
    if (content === "") {
        alert("내용을 입력하세요.");
        return false; // 서버 요청 차단
    }
    return true; //  유효성 검사 통과 시 폼 제출 허용
}
</script>
</head>
<body>
<!-- 헤더 영역 (공통 include) -->
<div class="header">
    <%@ include file="../common/header.jsp" %>
</div>

<div class="container">
    <!-- 상단 NOTICE -->
    <div class="notice-top">NOTICE</div>

    <!-- 수정 폼 -->
    <form name="noticeForm" action="${contextPath}/notice/updateNotice.do" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
        <!-- 수정할 글 번호 (hidden) -->
        <input type="hidden" name="notice_no" value="${notice.notice_no}" />
        
        <table class="edit-table">
            <tbody>
                <!-- 머릿글 선택 -->
                <tr>
                    <th>머릿글<span class="validation">*</span></th>
                    <td>
                        <select name="notice_head">
                            <option value="NOTICE" 
                                <c:if test="${notice.notice_head == 'NOTICE'}">selected</c:if>>[NOTICE]</option>
                            <option value="EVENT"  
                                <c:if test="${notice.notice_head == 'EVENT'}">selected</c:if>>[EVENT]</option>
                            <option value="INFO"   
                                <c:if test="${notice.notice_head == 'INFO'}">selected</c:if>>[INFO]</option>
                            <!-- 필요에 따라 옵션 추가 -->
                        </select>
                    </td>
                </tr>

                <!-- 제목 -->
                <tr>
                    <th>제목<span class="validation">*</span></th>
                    <td>
                        <input type="text" name="notice_title" 
                               value="${notice.notice_title}" 
                               placeholder="제목을 입력하세요" />
                    </td>
                </tr>

                <!-- 작성자 -->
                <tr>
                    <th>작성자<span class="validation">*</span></th>
                    <td>
                        <input type="text" name="mem_id" 
                               value="${notice.mem_id}" 
                               placeholder="작성자" 
                               readonly />
                    </td>
                </tr>



					<!-- 내용 -->
					<tr>
						<th>내용<span class="validation">*</span></th>
						<td><textarea name="notice_content" placeholder="내용을 입력하세요">${notice.notice_content}</textarea>
						</td>
					</tr>


					<!-- 이미지 업로드 -->
					<tr>
    <th>이미지 첨부</th>
    <td>
        <!-- 기존 파일명을 유지하는 hidden 필드 -->
        <input type="hidden" name="existingFileName" value="${notice.fileName}" />

        <!-- 새 파일 업로드 가능 (이미지 미리보기 없음) -->
        <input type="file" name="fileName" id="fileInput" accept="image/*" onchange="previewImage(event)"/>
    </td>
</tr>

<!-- 미리보기 (새 이미지 선택 시만 보임) -->
<tr id="previewRow" style="display: none;">
    <th>미리보기</th>
    <td>
        <img id="previewImg" src="" alt="미리보기 이미지" style="width:500px; height: 200px;"/>
    </td>
</tr>

<!-- 기존 파일 표시 -->
<tr>
    <th>현재 이미지</th>
    <td>
        <c:choose>
            <c:when test="${not empty notice.fileName}">
                <p>현재 파일: ${notice.fileName}</p>
                <img src="${contextPath}/base/getImage.do?fileName=${notice.fileName}&filePath=${image_path}"
                     alt="공지사항 이미지" style="max-width: 100%; height: auto;"/>
            </c:when>
            <c:otherwise>
                <p style="color: #888;">현재 게시된 이미지가 없습니다.</p>
            </c:otherwise>
        </c:choose>
    </td>
</tr>





					<!-- 조회수 (표시만 하고 수정 불가) -->
					<tr>
						<th>조회수</th>
						<td><input type="text" name="views"
							value="${notice.views}" readonly /></td>
					</tr>

					<!-- 작성일 (표시만 하고 수정 불가) -->
                <tr>
                    <th>작성일</th>
                    <td>
                        <input type="text" name="notice_writedate" 
                               value="${notice.notice_writedate}" 
                               readonly />
                    </td>
                </tr>
            </tbody>
        </table>

        <!-- 버튼 영역 -->
        <div class="btn-container">
            <!-- 수정 버튼 & 취소 버튼 동일 CSS 적용 -->
            <a href="${contextPath}/notice/noticeLists.do" class="btn-custom">
                목록
            </a>
            <button type="submit" class="btn-custom">수정</button>
        </div>
    </form>
</div>

<!-- 푸터 영역 (공통 include) -->
<div class="footer">
    <%@ include file="../common/footer.jsp" %>
</div>
</body>
</html>