<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>

<link rel="stylesheet" href="${contextPath}/resources/css/defaultStyle.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<meta charset="UTF-8">
<title>리뷰 수정</title>
<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
	rel="stylesheet">
<!-- Bootstrap CSS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
* {
	font-family: 'Noto Sans KR', sans-serif;
}

body {
	background-color: #f4f4f4;
	margin: 0;
	padding: 0;
	color: #333;
}

.container {
	max-width: 1000px;
	margin: 50px auto;
	background-color: #fff;
	border-radius: 3px;
	padding: 40px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

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

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 30px;
	border-radius: 3px;
}

th, td {
	border: 1px solid #e9e9e9;
	border-radius: 3px;
	padding: 12px;
	vertical-align: middle;
	font-size: 14px;
}

th {
	background-color: #f9f9f9;
	text-align: left;
	width: 120px;
}

input, textarea {
	width: 95%;
	padding: 10px;
	font-size: 14px;
	border: 1px solid #ddd;
	border-radius: 3px;
}

textarea {
	min-height: 200px;
	resize: none;
	border-radius: 3px;
}

.btn-container {
	text-align: center;
	margin-top: 30px;
}

.btn-custom {
	display: inline-block;
	padding: 10px 20px;
	font-size: 14px;
	border: 1px solid #ddd;
	border-radius: 3px;
	background-color: #fff;
	color: #000;
	text-decoration: none;
	cursor: pointer;
	margin: 0 10px;
}

.btn-custom:hover {
	background-color: #f0f0f0;
	color: #000 !important;
	border-radius: 3px;
}

.input-group {
	display: flex;
	align-items: center;
	gap: 10px;
	margin-top: 5px;
}

.image-container {
	margin-top: 10px;
}

.image-field {
	display: flex;
	align-items: center;
	margin-top: 10px;
}

.image-field:first-child {
	margin-top: 0;
}

.image-field input {
	flex: 1;
}

.image-field button {
	margin-left: 10px;
}

.review-image {
    display: block; /* ✅ 블록 요소로 변경 */
    width: 60%;  ✅ 너비 조절 (필요에 따라 변경 가능) 
    max-width: 300px; /* ✅ 최대 너비 설정 */
    height: auto; /* ✅ 원본 비율 유지 */
    border-radius: 5px; /* ✅ 모서리 둥글게 (선택 사항) */
}
.review-images {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
}
.image-preview {
    display: flex;
    flex-direction: column;
    align-items: center;  /* 이미지와 체크박스를 가운데 정렬 */
    text-align: center;
    margin: 10px;
}

.review-image {
    display: block;
    width: 200px; /* 필요에 따라 크기 조절 */
    height: 100px;
    border-radius: 5px;
    margin-bottom: 5px; /* 이미지와 체크박스 사이 간격 */
}
.checkbox-container {
    display: flex;  /* ✅ 체크박스와 글자를 가로로 정렬 */
    align-items: center;  /* ✅ 수직 가운데 정렬 */
    gap: 5px;  /* ✅ 체크박스와 텍스트 사이 간격 */
}

.checkbox-container label {
    display: inline-block; /* ✅ 인라인 블록 요소로 설정 */
    white-space: nowrap; /* ✅ 텍스트 줄바꿈 방지 */
    writing-mode: horizontal-tb; /* ✅ 텍스트 방향을 가로로 설정 */
}
.validation{
	color: red;
}
</style>
<script type="text/javascript">
    function addImageField() {
        const container = document.getElementById('image-container');
        const div = document.createElement('div');
        div.className = 'image-field';
        div.innerHTML = `
            <input type="file" name="images" />
            <button type="button" class="btn-custom" onclick="removeImageField(this)">삭제</button>
        `;
        container.appendChild(div);
    }

    function removeImageField(button) {
        const div = button.parentElement;
        div.remove();
    }
    </script>
</head>
<body>

	<!-- 헤더 include -->
	<div class="header">
		<%@ include file="../common/header.jsp"%>
	</div>

	<div class="container">
		<!-- 상단 제목 -->
		<div class="review-top">REVIEW</div>

		<!-- 수정 폼 -->
		<form action="${contextPath}/review/updateReview.do" method="post"
			enctype="multipart/form-data">
			<input type="hidden" name="review_no" value="${reviewVO.review_no}" />
			<table>
				<tbody>
					<!-- 제목 -->
					<tr>
						<th>제목<span class="validation">*</span></th>
						<td><input type="text" name="review_title"
							value="${reviewVO.review_title}" placeholder="제목을 입력하세요" required />
						</td>
					</tr>
					<!-- 작성자 -->
					<tr>
						<th>작성자<span class="validation">*</span></th>
						<td><input type="text" name="mem_id"
							value="${reviewVO.mem_id}" disabled /></td>
					</tr>

					<!-- 내용 -->
					<tr>
						<th>내용<span class="validation">*</span></th>
						<td><textarea name="review_content" placeholder="내용을 입력하세요" required>${reviewVO.review_content}</textarea>
						</td>
					</tr>

					<!-- 이미지 첨부 -->
					<tr>
						<th>이미지 첨부</th>
						<td>

							<div id="image-container">
								<div class="image-field">
									<input type="file" name="images" />
									<button type="button" class="btn-custom"
										onclick="addImageField()">추가</button>
								</div>
							</div>
						</td>
					</tr>
					
					
				<tr>
    <th>미리보기</th>
    <td>
        <div class="review-images">
            <c:if test="${not empty reviewImages}">
                <c:forEach var="image" items="${reviewImages}">
                    <div class="image-preview">
                        <!-- 기존 이미지 표시 -->
                        <img src="${contextPath}/base/getImage.do?fileName=${image.fileName}&filePath=${filePath}" 
                             alt="레시피 이미지" class="review-image">
                        <!-- ✅ 메인 이미지는 삭제 체크박스 비활성화 -->
                        <div class="checkbox-container">
                            <input type="checkbox" name="deleteImage" value="${image.fileName}" 
                                id="delete_${image.fileName}" 
                                <c:if test="${image.fileType eq 'main_image'}">disabled</c:if> />
                            <label for="delete_${image.fileName}">
                                삭제 <c:if test="${image.fileType eq 'main_image'}">(메인 이미지 삭제 불가)</c:if>
                            </label>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
        </div>
    </td>
</tr>

					
					
					
					

					<!-- 작성일 -->
					<tr>
						<th>작성일<span class="validation">*</span></th>
						<td><input type="text"
							value=" <fmt:formatDate value="${reviewVO.review_writedate}" pattern="yyyy-MM-dd HH:mm" />" disabled /></td>
					</tr>

					<!-- 조회수 -->
					<tr>
						<th>조회수<span class="validation">*</span></th>
						<td><input type="text" value="${reviewVO.views}" disabled />
						</td>
					</tr>

				</tbody>
			</table>
			<!-- 버튼 -->
			<div class="btn-container">
				<!--             <button type="submit" class="btn-custom">수정</button> -->
				<a href="${contextPath}/review/reviewLists.do" class="btn-custom">목록</a>
				<button type="submit" class="btn-custom">수정</button>
			</div>
		</form>
	</div>

	<!-- 푸터 include -->
	<div class="footer">
		<%@ include file="../common/footer.jsp"%>
	</div>

</body>
</html>