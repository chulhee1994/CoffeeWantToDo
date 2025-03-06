<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet" href="${contextPath}/resources/css/defaultStyle.css">
<meta charset="UTF-8">
<title>레시피 작성</title>
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
	padding: 40px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
	border-radius: 3px;
}

.recipe-top {
	text-align: center;
	font-size: 24px;
	font-weight: 700;
	color: #000;
	margin-bottom: 30px;
	position: relative;
	padding-bottom: 10px;
}

.recipe-top::after {
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
	padding: 12px;
	vertical-align: middle;
	font-size: 14px;
	border-radius: 3px;
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
	min-height: 150px;
	resize: none;
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

.image-preview {
	width: 120px;
	height: 120px;
	object-fit: cover;
	border: 1px solid #ddd;
	border-radius: 3px;
	margin-left: 10px;
	display: none; /* 기본적으로 숨김 */
}
.recipe_content{
	resize: none;
}

.product-selection {
    display: flex;
    align-items: center;
    gap: 10px; /* 입력창과 버튼 간 간격 */
}

.product-selection input {
    flex-grow: 1; /* 입력창이 남는 공간을 차지하도록 설정 */
    padding: 10px;
    font-size: 14px;
    border: 1px solid #ddd;
    border-radius: 3px;
    width: 70%; /* 적절한 너비 조정 */
}

.product-selection button {
    padding: 10px 15px;
    font-size: 14px;
    border: 1px solid #ddd;
    border-radius: 3px;
    background-color: #fff;
    cursor: pointer;
}

.product-selection button:hover {
    background-color: #f0f0f0;
}
.validation{
	color: red;
}
</style>
<script>
function addImageField() {
    const container = document.getElementById('image-container');
    const div = document.createElement('div');
    div.className = 'image-field';
    div.innerHTML = `
        <input type="file" name="fileName" accept="image/*" onchange="previewImage(event, this)">
        <img class="image-preview" src="#" alt="미리보기" style="display:none;">
        <button type="button" class="btn-custom" onclick="removeImageField(this)">삭제</button>
    `;
    container.appendChild(div);
}

function removeImageField(button) {
    button.parentElement.remove(); // 해당 이미지 필드 삭제
}

function previewImage(event, input) {
    const reader = new FileReader();
    reader.onload = function() {
        const preview = input.parentElement.querySelector(".image-preview");
        preview.src = reader.result;
        preview.style.display = "block";
    };
    if (input.files && input.files[0]) {
        reader.readAsDataURL(input.files[0]);
    }
}



function openProduct(event){
    var width = 1000;
    var height = 500;

    // 화면의 가운데 위치 계산
    var left = (window.innerWidth / 2) - (width / 2);
    var top = (window.innerHeight / 2) - (height / 2);
    
    event.preventDefault();
    var popup = window.open('recipeGoods.do', 'OrderPopup', 'width=' + width + ',height=' + height + ',left=' + left + ',top=' + top);
}

function setSelectedProduct(productName, goods_id) {
    document.getElementById('selectedProductName').value = productName;  // 상품명 설정
    document.getElementById('goods_id').value = goods_id;  // hidden 필드에 goods_id 설정
}

function validateForm(event) {
    let title = document.getElementsByName("recipe_title")[0].value.trim();
    let content = document.getElementsByName("recipe_content")[0].value.trim();
    let productName = document.getElementById("selectedProductName").value.trim();
    let images = document.querySelectorAll('input[name="fileName"]');

    if (title === "") {
        alert("제목을 입력해주세요.");
        return false;
    }

    if (content === "") {
        alert("내용을 입력해주세요.");
        return false;
    }

    if (productName === "") {
        alert("레시피와 관련된 상품을 선택해주세요.");
        return false;
    }

    let hasImage = false;
    images.forEach(img => {
        if (img.files.length > 0) {
            hasImage = true;
        }
    });

    if (!hasImage) {
        alert("최소 한 개의 이미지를 첨부해주세요.");
        return false;
    }

    return true;
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
		<div class="recipe-top">RECIPE</div>

		<!-- 작성 폼 -->
		<form id="myform" action="${contextPath}/recipe/addRecipe.do" method="post"
			enctype="multipart/form-data" onsubmit="return validateForm(event);">
			<table>
				<tbody>
					<!-- 제목 -->
					<tr>
						<th>제목<span class="validation">*</span></th>
						<td><input type="text" name="recipe_title" placeholder="제목을 입력하세요"
							 /></td>
					</tr>
					<!-- 작성자 -->
					<tr>
						<th>작성자<span class="validation">*</span></th>
						<td><input type="text" name="mem_id" placeholder="작성자를 입력하세요" readonly value="${memberVO.mem_id}"
							required /></td>
					</tr>
					<!-- 내용 -->
					<tr>
						<th>내용<span class="validation">*</span></th>
						<td><textarea name="recipe_content" class="recipe_content" placeholder="내용을 입력하세요" ></textarea>
						</td>
					</tr>
					
					<tr>
						<th>상품<span class="validation">*</span></th>
						<td>
								<div class="product-selection" >
								<input type="text" id="selectedProductName"
									name="selectedProductName" readonly> <input
									type="hidden" id="goods_id" name="goods_id" value="">
								<button type="button" onclick="openProduct(event)"
									class="btn-custom">선택</button>
							</div>		
							</td>		
					</tr>
					
				<!-- 이미지 첨부 -->
<tr>
    <th>이미지 첨부</th>
    <td>
        <div id="image-container">
            <div class="image-field">
                <input type="file" name="fileName" accept="image/*" onchange="previewImage(event, this)">
                <img class="image-preview" src="#" alt="미리보기" style="display:none;">
                <button type="button" class="btn-custom" onclick="addImageField()">추가</button>
            </div>
        </div>
    </td>
</tr>

				</tbody>
			</table>
			<!-- 버튼 -->
			<div class="btn-container">
				<button type="submit" class="btn-custom">작성</button>
				<a href="${contextPath}/recipe/listRecipes.do" class="btn-custom">목록</a>
				<script>
					function disableSubmitButton() {
					    var btn = document.getElementById("submit-btn");
					    btn.disabled = true;
					    return true; // 폼 제출 진행
						}
				</script>
			</div>
		</form>
	</div>

	<!-- 푸터 include -->
	<div class="footer">
		<%@ include file="../common/footer.jsp"%>
	</div>

</body>
</html>
