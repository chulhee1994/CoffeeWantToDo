<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="${contextPath}/resources/css/defaultStyle.css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
	rel="stylesheet">
<title>리뷰 작성</title>
<style type="text/css">
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
	width: 100%;
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
	border: 1px solid #ddd;
	background-color: #fff;
	color: #000;
	font-size: 14px;
	padding: 10px 20px;
	text-decoration: none;
	cursor: pointer;
	margin: 0 10px;
	border-radius: 3px;
	transition: background-color 0.3s ease, transform 0.3s ease;
}

.btn-custom:hover {
	background-color: #f0f0f0;
	color: #000 !important;
	text-decoration: none;
	transform: scale(1.05);
}

.image-container {
	margin-top: 20px; /* 간격 추가 */
	display: flex;
	flex-direction: column;
	gap: 15px; /* 각 이미지 필드 간격 조정 */
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
.image-field {
	display: flex;
	align-items: center;
	margin-top: 10px;
}

.image-field input[type="file"] {
	flex: 1;
	border: 1px solid #ddd;
	padding: 5px; /* 파일 입력 필드 내 여백 */
}

.image-field button {
	padding: 10px 20px; /* 버튼 크기 통일 */
	font-size: 14px;
	background-color: #fff;
	border: 1px solid #ddd;
	cursor: pointer;
	border-radius: 3px;
	transition: background-color 0.3s ease, transform 0.3s ease;
}

.image-field button:hover {
	background-color: #f0f0f0; /* 버튼 호버 색상 통일 */
	transform: scale(1.05);
}

.input-group {
	display: flex;
	align-items: center;
	gap: 15px; /* 파일 선택 간격 조정 */
}

.center-buttons {
	text-align: center;
}

.product-selection {
	display: flex;
	align-items: center;
	gap: 15px; /* 간격 조정 */
}

.review_content {
	resize: none;
}

fieldset{
 margin: 0px 70px 20px;
}
#myform fieldset {
    display: inline-block;
    border: 0;
    direction: ltr; /* 왼쪽부터 정렬 */
}

#myform input[type=radio] {
    display: none;
}

#myform label {
    font-size: 3em;
    color: transparent;
    text-shadow: 0 0 0 #ddd; /* 기본 회색 별 */
    cursor: pointer;
}

/* 마우스 호버 시 왼쪽부터 색상 변경 */
#myform label:hover,
#myform label:hover ~ label {
    text-shadow: 0 0 0 #ffc107; /* 노란색 */
}

/* 클릭 시 선택된 별과 왼쪽 별들 색상 적용 */
#myform input[type=radio]:checked ~ label,
#myform input[type=radio]:checked ~ label ~ label {
    text-shadow: 0 0 0 #ffc107;
}

.product-selection button {
	display: inline-block; /* 버튼을 가로로 정렬 */
	padding: 10px 20px; /* 버튼 내부 여백 설정 */
	font-size: 14px; /* 텍스트 크기 */
	background-color: #fff;
	border: 1px solid #ddd;
	cursor: pointer;
	border-radius: 3px;
	transition: background-color 0.3s ease, transform 0.3s ease;
	white-space: nowrap; /* 텍스트가 줄 바꿈되지 않도록 설정 */
	text-align: center; /* 텍스트를 버튼 중앙에 정렬 */
	line-height: normal; /* 텍스트 세로 정렬 문제 해결 */
}

.product-selection button:hover {
	background-color: #f0f0f0; /* 호버 색상 통일 */
	transform: scale(1.05);
}
.validation{
	color: red;
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript">
$(document).ready(function() {
    let selectedStar = 0;  // 선택된 별점 저장

    // 별점 클릭 시 선택 값 반영
    $('#myform input[type="radio"]').on('change', function() {
        selectedStar = parseInt($(this).val()); // 정수 변환
        $('#rating-value').text("선택한 별점: " + selectedStar + "점");

        // 전체 별 초기화 (회색으로 변경)
        $('#myform label').css('text-shadow', '0 0 0 #ddd');

        // 선택한 별점과 왼쪽 별들까지 정확하게 색상 변경
        $('#myform input[type="radio"]').each(function() {
            if (parseInt($(this).val()) <= selectedStar) {
                $(this).next('label').css('text-shadow', '0 0 0 #ffc107'); // 별 색칠
            }
        });
    });

    // 마우스를 올리면 해당 별까지 색상 변경
    $('#myform label').hover(
        function() {
            let hoverStar = parseInt($(this).prev('input').val()); // 호버한 별 값 가져오기
            $('#myform label').css('text-shadow', '0 0 0 #ddd'); // 전체 초기화

            $('#myform input[type="radio"]').each(function() {
                if (parseInt($(this).val()) <= hoverStar) {
                    $(this).next('label').css('text-shadow', '0 0 0 #ffc107'); // 호버한 별까지 색칠
                }
            });
        },
        function() {
            // 원래 선택한 별점으로 되돌리기
            $('#myform label').css('text-shadow', '0 0 0 #ddd');

            $('#myform input[type="radio"]').each(function() {
                if (parseInt($(this).val()) <= selectedStar) {
                    $(this).next('label').css('text-shadow', '0 0 0 #ffc107');
                }
            });
        }
    );
});







        function openProduct(event){
            var width = 1200;
            var height = 600;

            // 화면의 가운데 위치 계산
            var left = (window.innerWidth / 2) - (width / 2);
            var top = (window.innerHeight / 2) - (height / 2);
            
            event.preventDefault();
            var popup = window.open('reviewGoods.do', 'OrderPopup', 'width=' + width + ',height=' + height + ',left=' + left + ',top=' + top);
        }

        function setSelectedProduct(productName, goods_id,seq_order_id) {
            document.getElementById('selectedProductName').value = productName;  // 상품명 설정
            document.getElementById('goods_id').value = goods_id;  // hidden 필드에 goods_id 설정
            document.getElementById('seq_order_id').value = seq_order_id;  // 주문 번호 설정
        }
        
        function addImageField() {
            const container = document.getElementById('image-container');
            const div = document.createElement('div');	
            div.className = 'image-field';
            div.innerHTML = `
                <input type="file" name="images" accept="image/*" onchange="previewImage(event, this)">
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
        
        function validateForm(event) {
            let title = document.getElementById("title").value.trim();
            let content = document.querySelector(".review_content").value.trim();
            let productName = document.getElementById("selectedProductName").value.trim();
            let starSelected = document.querySelector('input[name="review_star"]:checked');

            if (title === "") {
                alert("제목을 입력해주세요.");
                return false;
            }

            if (content === "") {
                alert("내용을 입력해주세요.");
                return false;
            }

            if (productName === "") {
                alert("리뷰할 상품을 선택해주세요.");
                return false;
            }

            if (!starSelected) {
                alert("별점을 선택해주세요.");
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
		<div class="review-top">REVIEW</div>


		<form action="${contextPath}/review/addReview.do" method="post" id="myform"
			enctype="multipart/form-data" onsubmit="return validateForm(event);">

			<table>
				<tbody>
					<!-- 제목 -->
					<tr>
						<th>제목<span class="validation">*</span></th>
						<td><input type="text" id="title" name="review_title"
							 placeholder="제목을 입력하세요."></td>
					</tr>

					<!-- 작성자 -->
					<tr>
						<th>작성자<span class="validation">*</span></th>
						<td><input type="text" id="mem_id" name="mem_id" value="${mem_id}" readonly></td>
					</tr>

					<!-- 내용 -->
					<tr>
						<th>내용<span class="validation">*</span></th>
						<td><textarea name="review_content" class="review_content"
								placeholder="내용을 입력하세요" ></textarea></td>
					</tr>


					<!-- 리뷰 상품 -->
					<tr>
						<th>상품<span class="validation">*</span></th>
						<td>
							<div class="product-selection" >
								<input type="text" id="selectedProductName"
									name="selectedProductName" readonly> <input
									type="hidden" id="goods_id" name="goods_id" value="">
									<input type="hidden" id="seq_order_id" name="seq_order_id" value="">
								<button type="button" onclick="openProduct(event)"
									class="btn-custom">선택</button>
							</div>
						</td>
					</tr>



 		<tr>
 		<th scope="row">별점<span class="validation">*</span></th>
 		<td>
<fieldset>
    <legend></legend>
    <input type="radio" name="review_star" value="1" id="rate1">
    <label for="rate1">★</label>
    <input type="radio" name="review_star" value="2" id="rate2">
    <label for="rate2">★</label>
    <input type="radio" name="review_star" value="3" id="rate3">
    <label for="rate3">★</label>
    <input type="radio" name="review_star" value="4" id="rate4">
    <label for="rate4">★</label>
    <input type="radio" name="review_star" value="5" id="rate5">
    <label for="rate5">★</label>
</fieldset>


</td>
 		</tr>

					<!-- 이미지 -->
					<tr>
						<th>이미지 첨부</th>
						<td>
							<div id="image-container">
								<div class="image-field">
									<input type="file" name="images" accept="image/*" onchange="previewImage(event, this)"/>
									<img class="image-preview" src="#" alt="미리보기" style="display:none;">
									<button type="button" class="btn-custom"
										onclick="addImageField()">추가</button>
								</div>
							</div>
						</td>
					</tr>

				</tbody>

			</table>

			<!-- 버튼: 목록보기와 글쓰기 -->
			<div class="center-buttons">
				<a href="${contextPath}/board/listArticles.do" class="btn-custom">목록보기</a>
				<button type="submit" class="btn-custom">글쓰기</button>
			</div>
		</form>
	</div>

	<!-- 푸터 include -->
	<div class="footer">
		<%@ include file="../common/footer.jsp"%>
	</div>

</body>
</html>


