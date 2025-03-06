<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- JSP에서 공통 경로 설정 -->
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${contextPath}/resources/css/defaultStyle.css">
<title>공지사항 작성</title>
<!-- Google Fonts -->
<link 
    href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" 
    rel="stylesheet">
<!-- Bootstrap CSS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

<style>
    /* 기본 글꼴 및 배경 설정 */
    	*{
		  font-family: 'Noto Sans KR', sans-serif;
	}
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

    /* 작성 폼 테이블 */
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
        border-radius: 0;
        padding: 10px;
        font-size: 14px;
        color: #333;
        margin: 0;
        box-sizing: border-box;  /* 패딩 포함 너비 계산 */
           border-radius : 3px;
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
       border-radius : 3px;        /* 직선 모서리 */
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
.validation{
	color: red;
}

</style>
<script type="text/javascript">
function readURL(input) {
    var preview = document.getElementById('preview');

    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            preview.src = e.target.result;
        }
        reader.readAsDataURL(input.files[0]); // 파일을 읽고 미리보기로 표시
    } else {
        // 파일이 없을 경우 기본 이미지로 되돌림
        preview.src = '${contextPath}/resources/images/no_image.png';
    }
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

    <!-- 작성 폼 -->
<form name="noticeForm" action="${contextPath}/notice/addNotice.do" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">

        <table class="edit-table">
            <tbody>
                <!-- 머릿글 선택 -->
                <tr>
                    <th>머릿글<span class="validation">*</span></th>
                    <td>
                        <select name="notice_head">
                            <option value="NOTICE">[NOTICE]</option>
                            <option value="EVENT">[EVENT]</option>
                            <option value="INFO">[INFO]</option>
                            <!-- 필요에 따라 옵션 추가 -->
                        </select>
                    </td>
                </tr>

                <!-- 제목 -->
                <tr>
                    <th>제목<span class="validation">*</span></th>
                    <td>
                        <input type="text" name="notice_title" 
                               placeholder="제목을 입력하세요" />
                    </td>
                </tr>

                <!-- 작성자 -->
                <tr>
                    <th>작성자<span class="validation">*</span></th>
                    <td>
                        <input type="text" name="mem_id" 
                                value="${memberVO.mem_id}" readonly/>
                    </td>
                </tr>

					<!-- 내용 -->
					<tr>
						<th>내용<span class="validation">*</span></th>
						<td><textarea name="notice_content" placeholder="내용을 입력하세요"></textarea>
						</td>
					</tr>

					<!-- 이미지 업로드 -->
					<tr>
						<th>이미지 첨부</th>
						<td><input type="file" name="fileName" onchange="readURL(this);"  /></td>
					</tr>
					
					<tr>
				    <th>미리보기</th>
				    <td>
		    		    <img id="preview" src=# style="width:500px; height:200px;" 
        		     onerror="this.src='${contextPath}/resources/images/no_image.png';" />
				    </td>
					</tr>
				</tbody>
				
        </table>

        <!-- 버튼 영역 -->
           <!-- 버튼 영역 -->
    <div class="btn-container">
        <button type="submit" class="btn-custom">작성</button>
        <a href="${contextPath}/notice/noticeLists.do" class="btn-custom">취소</a>
    </div>
    </form>
</div>

<!-- 푸터 영역 (공통 include) -->
<div class="footer">
    <%@ include file="../common/footer.jsp" %>
</div>
</body>
</html>