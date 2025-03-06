<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="category_json" value="${contextPath}/resources/json/category.json"/>
<c:set var="goods" value="${goodsDetail}" />
<!DOCTYPE html>
<html lang="ko">
    <head>

        <script type="text/javascript">
            
            // 맛/향에 따른 세부 분류 데이터를 미리 준비
            var flavorSubcategories = {
                "과일": ["선택하세요", "레몬", "베리", "체리"],
                "견과류": ["선택하세요", "아몬드", "호두", "피스타치오"],
                "초콜릿": ["선택하세요", "다크 초콜릿", "밀크 초콜릿", "화이트 초콜릿"],
                "꽃": ["선택하세요", "라벤더", "장미", "자스민"],
                "곡물": ["선택하세요", "귀리", "보리", "밀"],
               
            };

            // 맛/향 변경 시 세부 분류 업데이트
            function updateSubcategory() {
                var selectedFlavor = document.getElementById("goods_c_note").value; // 선택된 맛/향
                var subcategorySelect = document.getElementById("goods_c_det_note"); // 세부 분류 select 요소
                subcategorySelect.innerHTML = ''; // 기존 옵션을 지움

                // 선택된 맛/향에 맞는 세부 분류 옵션 추가
                var subcategories = flavorSubcategories[selectedFlavor];
                subcategories.forEach(function(subcategory) {
                    var option = document.createElement("option");
                    option.value = subcategory;
                    option.text = subcategory;
                    subcategorySelect.appendChild(option);
                });
            }

            // 카테고리 변경 시 필드 동적으로 업데이트
            function updateFieldsBasedOnCategory() {
                var selectedCategory = document.getElementById("goods_category").value;
                var fieldsContainer = document.getElementById("dynamic-fields");

                // 기존 필드들 초기화
                fieldsContainer.innerHTML = '';

                // 카테고리별로 필요한 필드를 추가
                if (selectedCategory === "원두") {
                    fieldsContainer.innerHTML = ` 
                        <tr>
                            <td>원두이름 <span>*</span></td>
                            <td><input name="goods_name" type="text" class="form-control form-control-sm" size="40" value="${goods.goods_name}"/></td>
                        </tr>
                        <tr>
                            <td>맛/향 <span>*</span></td>
                            <td>
                                <select name="goods_c_note" id="goods_c_note" class="form-control form-control-sm" onchange="updateSubcategory()">
                                    <option value="과일" selected>과일</option>
                                    <option value="견과류">견과류</option>
                                    <option value="초콜릿">초콜릿</option>
                                    <option value="꽃">꽃</option>
                                    <option value="곡물">곡물</option>

                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>세부 분류 <span>*</span></td>
                            <td>
                                <select name="goods_c_det_note" id="goods_c_det_note" class="form-control form-control-sm">
                                    <!-- JavaScript로 세부 분류가 동적으로 변경됨 -->
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>판매자 <span>*</span></td>
                            <td>
                            <input name="mem_id" type="text" class="form-control form-control-sm" size="40" value="${member.mem_id}" readonly />
                        </td>

                        </tr>
                        <tr>
                            <td>제품가격 <span>*</span></td>
                            <td><input name="goods_price" type="text" class="form-control form-control-sm" size="40" value="${goods.goods_price}" oninput="calculateDiscountAndPoint()" onkeypress="return isNumberKey(event)"/></td>
                        </tr>
                        <tr>
                            <td>제품할인가격</td>
                            <td><input name="goods_sales_price" type="text" class="form-control form-control-sm" size="40" value="${goods.goods_sales_price}"readonly/></td>
                        </tr>
                        <tr>
                            <td>제품 구매 포인트</td>
                            <td><input name="goods_point" type="text" class="form-control form-control-sm" size="40" value="${goods.goods_point}"readonly/></td>
                        </tr>
                        <tr>
                            <td>로스팅 날짜 <span>*</span></td>
                            <td><input name="goods_roasting_date" type="date" class="form-control form-control-sm" /></td>
                        </tr>
                        <tr>
                            <td>로스팅 강도 <span>*</span></td>
                            <td>
                                <select name="goods_c_roasting" class="form-control form-control-sm">
                                    <option value="라이트" selected>라이트</option>
                                    <option value="라이트미디움">라이트미디움</option>
                                    <option value="미디움">미디움</option>
                                    <option value="다크미디움">다크미디움</option>
                                    <option value="다크">다크</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>블렌딩 유무 <span>*</span></td>
                            <td>
                                <input type="radio" name="goods_c_blending" value="Y" id="blending_y" />
                                <label for="blending_y">예</label>
                                <input type="radio" name="goods_c_blending" value="N" id="blending_n" />
                                <label for="blending_n">아니오</label>
                            </td>
                        </tr>
                        <tr>
                            <td>재고 수량 <span>*</span></td>
                            <td><input name="goods_stock" type="text" class="form-control form-control-sm" size="40" value="${goods.goods_stock}" /></td>
                        </tr>
                        <tr>
                            <td>원산지1 <span>*</span></td>
                            <td><input name="goods_origin1" type="text" class="form-control form-control-sm" size="40" value="${goods.goods_origin1}"/></td>
                        </tr>
                        <tr>
                            <td>원산지2</td>
                            <td><input name="goods_origin2" type="text" class="form-control form-control-sm" value="${goods.goods_origin2}" size="40" /></td>
                        </tr>
                        <tr>
                            <td>원산지3</td>
                            <td><input name="goods_origin3" type="text" class="form-control form-control-sm" size="40" value="${goods.goods_origin3}" /></td>
                        </tr>
                        <tr>
                            <td>그램수 <span>*</span></td>
                            <td><input name="goods_c_gram" type="text" class="form-control form-control-sm" size="40" value="${goods.goods_c_gram}"/></td>
                        </tr>
                        <tr>
                        <td>원두MBTI<span>*</span></td>
                        <td>
                            <select id="mbtiSelect" name="goods_m_filter" class="form-control form-control-sm">
                                <option value="INFJ">INFJ</option>
                                <option value="INFP">INFP</option>
                                <option value="INTJ">INTJ</option>
                                <option value="INTP">INTP</option>
                                <option value="ISFJ">ISFJ</option>
                                <option value="ISFP">ISFP</option>
                                <option value="ISTJ">ISTJ</option>
                                <option value="ISTP">ISTP</option>
                                <option value="ENFJ">ENFJ</option>
                                <option value="ENFP">ENFP</option>
                                <option value="ENTJ">ENTJ</option>
                                <option value="ENTP">ENTP</option>
                                <option value="ESFJ">ESFJ</option>
                                <option value="ESFP">ESFP</option>
                                <option value="ESTJ">ESTJ</option>
                                <option value="ESTP">ESTP</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>날씨추천<span>*</span></td>
                        <td>
                            <select id="weatherSelect" name="goods_w_filter" class="form-control form-control-sm">
                                <option value="Thunderstorm">번개가 치는 날씨</option>
                                <option value="Drizzle">이슬비가 내리는 날씨</option>
                                <option value="Rain">비 내리는 날씨</option>
                                <option value="Snow">눈이 내리는 날씨</option>
                                <option value="Atmosphere">안개낀 날씨</option>
                                <option value="Clear">맑은 날씨</option>
                                <option value="Clouds">구름이 낀 날씨</option>
                            </select>
                        </td>
                    </tr>
                
                    `;
                } else if (selectedCategory === "베이커리") {
                    fieldsContainer.innerHTML = ` 
                        <tr>
                            <td>빵이름 <span>*</span></td>
                            <td><input name="goods_name" type="text" class="form-control form-control-sm" size="40"  value="${goods.goods_name}"/></td>
                        </tr>
                        <tr>
                            <td>맛/향 <span>*</span></td>
                            <td>
                                <select name="goods_c_note" id="goods_c_note" class="form-control form-control-sm" onchange="updateSubcategory()">
                                    <option value="과일" selected>과일</option>
                                    <option value="견과류">견과류</option>
                                    <option value="초콜릿">초콜릿</option>
                                    <option value="꽃">꽃</option>
                                    <option value="곡물">곡물</option>
                                  
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>세부 분류 <span>*</span></td>
                            <td>
                                <select name="goods_c_det_note" id="goods_c_det_note" class="form-control form-control-sm">
                                    <!-- JavaScript로 세부 분류가 동적으로 변경됨 -->
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>판매자 <span>*</span></td>
                            <td>
                            <input name="mem_id" type="text" class="form-control form-control-sm" size="40" value="${member.mem_id}" readonly />
                        </td>

                        </tr>
                        <tr>
                            <td>제품가격 <span>*</span></td>
                            <td><input name="goods_price" type="text" class="form-control form-control-sm" size="40" value="${goods.goods_price}" oninput="calculateDiscountAndPoint()" onkeypress="return isNumberKey(event)"/></td>
                        </tr>
                        <tr>
                            <td>제품할인가격</td>
                            <td><input name="goods_sales_price" type="text" class="form-control form-control-sm" size="40" value="${goods.goods_sales_price}" readonly  /></td>
                        </tr>
                        <tr>
                            <td>제품 구매 포인트</td>
                            <td><input name="goods_point" type="text" class="form-control form-control-sm" size="40" value="${goods.goods_point}" readonly /></td>
                        </tr>
                        <tr>
                            <td>재고 수량 <span>*</span></td>
                            <td><input name="goods_stock" type="text" class="form-control form-control-sm" size="40" value="${goods.goods_stock}"/></td>
                        </tr>
                        <tr>
                        <td>원두MBTI<span>*</span></td>
                        <td>
                            <select id="mbtiSelect" name="goods_m_filter" class="form-control form-control-sm">
                                <option value="INFJ">INFJ</option>
                                <option value="INFP">INFP</option>
                                <option value="INTJ">INTJ</option>
                                <option value="INTP">INTP</option>
                                <option value="ISFJ">ISFJ</option>
                                <option value="ISFP">ISFP</option>
                                <option value="ISTJ">ISTJ</option>
                                <option value="ISTP">ISTP</option>
                                <option value="ENFJ">ENFJ</option>
                                <option value="ENFP">ENFP</option>
                                <option value="ENTJ">ENTJ</option>
                                <option value="ENTP">ENTP</option>
                                <option value="ESFJ">ESFJ</option>
                                <option value="ESFP">ESFP</option>
                                <option value="ESTJ">ESTJ</option>
                                <option value="ESTP">ESTP</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>날씨추천<span>*</span></td>
                        <td>
                            <select id="weatherSelect" name="goods_w_filter" class="form-control form-control-sm">
                                <option value="Thunderstorm">번개가 치는 날씨</option>
                                <option value="Drizzle">이슬비가 내리는 날씨</option>
                                <option value="Rain">비 내리는 날씨</option>
                                <option value="Snow">눈이 내리는 날씨</option>
                                <option value="Atmosphere">안개낀 날씨</option>
                                <option value="Clear">맑은 날씨</option>
                                <option value="Clouds">구름이 낀 날씨</option>
                            </select>
                        </td>
                    </tr>
                <input type="hidden" name="goods_roasting_date" value="2000-01-01" />
                	 <input type="hidden" name="goods_c_blending" value="없음" />
                	<td>
                	    <input type="hidden" name="goods_c_roasting" value="없음" />
                	</td>
                    `;
                }else if (selectedCategory === "테스트") {
                    fieldsContainer.innerHTML = ` 
                        <tr>
                            <td>테스트이름 <span>*</span></td>
                            <td><input name="goods_name" type="text" class="form-control form-control-sm" size="40"  value="${goods.goods_name}"/></td>
                        </tr>

                        <tr>
                            <td>판매자 <span>*</span></td>
                            <td>
                            <input name="mem_id" type="text" class="form-control form-control-sm" size="40" value="${member.mem_id}" readonly />
                        </td>

                        </tr>
                        <tr>
                            <td>제품가격 <span>*</span></td>
                            <td><input name="goods_price" type="text" class="form-control form-control-sm" size="40" value="${goods.goods_price}" oninput="calculateDiscountAndPoint()" onkeypress="return isNumberKey(event)"/></td>
                        </tr>
                        <tr>
                            <td>제품할인가격</td>
                            <td><input name="goods_sales_price" type="text" class="form-control form-control-sm" size="40" value="${goods.goods_sales_price}" readonly/></td>
                        </tr>
                        <tr>
                        <td>재고 수량 <span>*</span></td>
                        <td><input name="goods_stock" type="text" class="form-control form-control-sm" size="40" /></td>
                    </tr>

                    `;
                } else if (selectedCategory === "커피용품") {
                    fieldsContainer.innerHTML = ` 
                        <tr>
                            <td>용품이름 <span>*</span></td>
                            <td><input name="goods_name" type="text" class="form-control form-control-sm" size="40"  value="${goods.goods_name}"/></td>
                        </tr>
                        <tr>
                            <td>판매자 <span>*</span></td>
                            <td>
                            <input name="mem_id" type="text" class="form-control form-control-sm" size="40" value="${member.mem_id}" readonly />
                        </td>

                        </tr>
                        <tr>
                            <td>제품가격 <span>*</span></td>
                            <td><input name="goods_price" type="text" class="form-control form-control-sm" size="40" value="${goods.goods_price}" oninput="calculateDiscountAndPoint()" onkeypress="return isNumberKey(event)"/></td>
                        </tr>
                        <tr>
                            <td>제품할인가격</td>
                            <td><input name="goods_sales_price" type="text" class="form-control form-control-sm" size="40" value="${goods.goods_sales_price}"readonly/></td>
                        </tr>
                        <tr>
                            <td>제품 구매 포인트</td>
                            <td><input name="goods_point" type="text" class="form-control form-control-sm" size="40" value="${goods.goods_point}"readonly/></td>
                        </tr>
                        <tr>
                            <td>재고 수량 <span>*</span></td>
                            <td><input name="goods_stock" type="text" class="form-control form-control-sm" size="40" value="${goods.goods_stock}"/></td>
                        </tr>
                        <input type="hidden" name="goods_roasting_date" value="2000-01-01" />
                        	
                        	<td>
                        	    <input type="hidden" name="goods_c_roasting" value="없음" />
                        	</td>
                        	 <input type="hidden" name="goods_c_blending" value="없음" />
                    `;
                }
            }

            // 페이지 로드 시 기본 필드 설정
            window.onload = function() {
                updateFieldsBasedOnCategory();
            };
         // 전역 변수로 cnt 선언
  // 페이지 로드 시 기본 필드 설정
        window.onload = function() {
            updateFieldsBasedOnCategory();
        };

        // 전역 변수 cnt 선언 (추가 이미지용)
        var cnt = 0;
        function fn_addFile() {
            console.log("cnt value before adding:", cnt);
            if (cnt > 0) { // 두 번째 호출부터 추가 이미지 input 생성
                var detailName = "detail_image" + cnt;
                var detailId = "detail_image" + cnt;
                // 파일 input 요소를 추가하고 미리보기용 img 태그를 생성할 공간 확보
$("#d_file").append("<br><input type='file' name='" + detailName + "' id='" + detailId + "' class='btn btn-custom'>");

                console.log("Added detail image field:", detailName);
                // 동적으로 추가된 파일 input에 change 이벤트를 등록하여 미리보기 기능을 적용
                $("#" + detailId).on("change", function(event) {
                    var input = event.target;
                    if (input.files && input.files[0]) {
                        var reader = new FileReader();
                        reader.onload = function(e) {
                            var previewId = detailId + "_preview";
                            var $preview = $("#" + previewId);
                            if (!$preview.length) {
                                $preview = $("<img>", { id: previewId, style: "max-width:200px; max-height:200px; margin-top:10px;" });
                                $("#" + detailId).after($preview);
                            }
                            $preview.attr("src", e.target.result);
                        };
                        reader.readAsDataURL(input.files[0]);
                    }
                });
            }
            cnt++;
            console.log("cnt value after adding:", cnt);
        }

        function fn_add_new_goods(obj) {
            fileName = $('#f_main_image').val();
            if (fileName != null && fileName != undefined) {
                obj.submit();
            } else {
                alert("메인 이미지는 반드시 첨부해야 합니다.");
                return;
            }
        }

        /* 드랍다운 */
        document.addEventListener("DOMContentLoaded", function () {
            var dropdown = document.getElementById("mbtiDropdown");
            var selectedOption = dropdown.querySelector(".selected-option");
            var dropdownOptions = dropdown.querySelector(".dropdown-options");
            var selectedImg = document.getElementById("selectedImg");
            var selectedText = document.getElementById("selectedText");
            var hiddenInput = document.getElementById("selectedMBTI");

            selectedOption.addEventListener("click", function () {
                dropdownOptions.style.display = dropdownOptions.style.display === "block" ? "none" : "block";
            });

            dropdownOptions.addEventListener("click", function (event) {
                if (event.target.tagName === "LI" || event.target.closest("li")) {
                    var targetLi = event.target.closest("li");
                    var value = targetLi.getAttribute("data-value");
                    var imgSrc = targetLi.getAttribute("data-img");
                    var text = targetLi.innerText.trim();

                    selectedImg.src = imgSrc;
                    selectedText.innerText = text;
                    hiddenInput.value = value;
                    dropdownOptions.style.display = "none";
                }
            });

            document.addEventListener("click", function (event) {
                if (!dropdown.contains(event.target)) {
                    dropdownOptions.style.display = "none";
                }
            });
        });
        /* 드랍다운 */

        function calculateDiscountAndPoint() {
            var priceInput = document.getElementsByName("goods_price")[0];
            var discountInput = document.getElementsByName("goods_sales_price")[0];
            var pointInput = document.getElementsByName("goods_point")[0];
            var price = parseFloat(priceInput.value);
            if (!isNaN(price) && price > 0) {
                var discountedPrice = (price * 0.9).toFixed(0);
                discountInput.value = discountedPrice;
                var point = (price * 0.03).toFixed(0);
                pointInput.value = point;
            } else {
                discountInput.value = "";
                pointInput.value = "";
            }
        }

        // 제품 가격 입력 시 자동 계산
        document.addEventListener("DOMContentLoaded", function() {
            var priceInput = document.getElementsByName("goods_price")[0];
            priceInput.addEventListener("input", calculateDiscountAndPoint);
        });

     // 폼 제출 시 유효성 및 이미지 첨부 개수(최소 2개) 벨리데이션
        document.addEventListener("DOMContentLoaded", function() {
            document.querySelector("form").addEventListener("submit", function(event) {
                let isValid = true;
                let errorMessage = "필수 항목을 입력하세요.";

                document.querySelectorAll("td").forEach(function(td) {
                    if (td.textContent.includes("*")) {
                        let input = td.nextElementSibling.querySelector("input, select, textarea");
                        if (input && (input.value.trim() === "" || input.value === "선택하세요")) {
                            isValid = false;
                            input.classList.add("is-invalid");
                        } else {
                            input.classList.remove("is-invalid");
                        }
                    }
                });

                // 이미지 첨부 개수 벨리데이션
                var imageInputs = document.querySelectorAll("#d_file input[type='file']");
                var filledImages = 0;
                imageInputs.forEach(function(input) {
                    if (input.value.trim() !== "") {
                        filledImages++;
                    }
                });
                if (filledImages < 2) {
                    alert("메인 이미지와 추가 이미지를 포함하여 최소 2개의 이미지를 첨부해야 합니다.");
                    event.preventDefault();
                    return;
                }

                if (!isValid) {
                    alert(errorMessage);
                    event.preventDefault();
                }
            });
        });
        // 상품 이미지 미리보기 기능
        document.addEventListener("DOMContentLoaded", function() {
            var mainImageInput = document.getElementById("f_main_image");
            mainImageInput.addEventListener("change", function(event) {
                var input = event.target;
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function(e) {
                        var imgPreview = document.getElementById("imgPreview");
                        if (!imgPreview) {
                            imgPreview = document.createElement("img");
                            imgPreview.id = "imgPreview";
                            imgPreview.style.maxWidth = "200px";
                            imgPreview.style.maxHeight = "200px";
                            imgPreview.style.marginTop = "10px";
                            // 파일 입력 요소의 부모에 미리보기 이미지 추가
                            input.parentNode.appendChild(imgPreview);
                        }
                        imgPreview.src = e.target.result;
                    };
                    reader.readAsDataURL(input.files[0]);
                }
            });
        });
    
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                alert("숫자만 입력 가능합니다.");
                evt.preventDefault();
                return false;
            }
            return true;
        }



        </script>

        <!-- 부트스트랩 CSS 추가 -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <!-- 부트스트랩 JS 추가 -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
      
        <style>
        /* 전체 레이아웃 */
        body, html {
            height: 100%;
            margin: 0;
            display: flex;
            flex-direction: column;
        }
        /* 헤더 스타일 */
        header {
            width: 100%;
            padding: 20px 0;
            background-color: #f1f1f1;
            text-align: center;
        }
        /* 푸터 스타일 */
        footer {
            width: 100%;
            padding: 20px 0;
            background-color: #f8f9fa;
            text-align: center;
        }
        /* 본문 영역 */
        #outer_wrap {
            width: 100%;
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            background-color: white;
            flex-grow: 1;
        }
        /* 본문 내용 */
        article {
            width: 100%;
            font-size: 16px;
            line-height: 1.6;
        }
        .nav-link {
            color: black !important;
        }
        /* 등록하기 버튼 */
        .btn-custom {
            border-radius: 3px;
            color: black;
            background-color: transparent;
            border: 2px solid black;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            transition: all 0.3s ease;
        }
        .btn-custom:hover {
            background-color: #f8f9fa;
            border-color: #555;
        }
        /* 드랍다운 */
        .custom-dropdown {
            position: relative;
            width: 220px;
            cursor: pointer;
            font-family: Arial, sans-serif;
        }
        .selected-option {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px;
            border: 1px solid #ccc;
            background: white;
            cursor: pointer;
        }
        .selected-option img {
            width: 25px;
            height: 25px;
            margin-right: 10px;
        }
        .dropdown-options {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            width: 100%;
            background: white;
            border: 1px solid #ccc;
            list-style: none;
            padding: 0;
            margin: 0;
            z-index: 10;
        }
        .dropdown-options li {
            display: flex;
            align-items: center;
            padding: 8px;
            cursor: pointer;
        }
        .dropdown-options li img {
            width: 25px;
            height: 25px;
            margin-right: 10px;
        }
        .dropdown-options li:hover {
            background: lightgray;
        }
        span {
    	    color:red;
        }
        </style>

    </head>

    <body>
        <div class="header">
            <%@ include file="../../common/header.jsp" %>
        </div>
    
        <div id="outer_wrap">
            <div id="wrap">
                <article>
                    <!-- 화면 내용 시작(body start) -->
                    <form action="${contextPath}/admin/goods/updateGoods.do" method="post" enctype="multipart/form-data" onsubmit="return fn_add_new_goods(this)">
                        <h1 class="text-center">상품 수정</h1>
                        <div class="tab-container">
                            <!-- 탭 메뉴 -->
                            <ul class="nav nav-tabs" id="myTab" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" id="tab1-tab" data-toggle="tab" href="#tab1" role="tab" aria-controls="tab1" aria-selected="true">상품</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="tab4-tab" data-toggle="tab" href="#tab4" role="tab" aria-controls="tab4" aria-selected="false">상품 이미지</a>
                                </li>
                            </ul>

                            <!-- 탭 내용 -->
                            <div class="tab-content" id="myTabContent">
                                <!-- 상품 탭 내용 (tab1) -->
                                <div class="tab-pane fade show active" id="tab1" role="tabpanel" aria-labelledby="tab1-tab">
                                    <table class="table">
                                        <tr>
                                            <td>카테고리</td>
                                            <td>
                                                <select name="goods_category" id="goods_category" class="form-control form-control-sm" onchange="updateFieldsBasedOnCategory()">
                                                    <option value="원두" selected>원두</option>
                                                    <option value="베이커리">베이커리</option>
                                                    <option value="커피용품">커피용품</option>
                                                    <option value="테스트">테스트</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <!-- 동적으로 업데이트되는 필드 영역 -->
                                        <tbody id="dynamic-fields">
                                            <!-- 초기 필드 내용 (원두 관련 필드들) -->
                                        </tbody>
                                    </table>
                                </div>

                                <!-- 상품 이미지 탭 내용 (tab4) -->
                                <div class="tab-pane fade" id="tab4" role="tabpanel" aria-labelledby="tab4-tab">
                                    <table class="table">
                                        <tr>
                                            <td class="product-image-text">상품 이미지</td>
                                            <td id="d_file">
                                                <input type="file" name="main_image" id="f_main_image" class="btn btn-custom" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>추가 이미지</td>
                                            <td>
                                                <button type="button" class="btn btn-custom" onclick="fn_addFile()">추가 이미지</button>
                                            </td>
                                        </tr>
                                    </table>
                                   <input name="goods_id" type="hidden" value="${goods.goods_id}"/>

                                </div>
                            </div>
                        </div>
                        <script>
function fn_add_new_goods(form) {
    // 메인 이미지가 선택되었는지 확인
    var mainImage = document.getElementById('f_main_image').value;
    if (!mainImage) {
        alert("이미지를 추가하셔야 합니다.");
        return false;  // 폼 제출을 막음
    }

    // 추가 이미지가 있는지 확인 (cnt는 이미지를 추가할 때마다 증가)
    for (var i = 0; i < cnt; i++) {
        var additionalImage = document.getElementById('detail_image' + i).value;
        if (additionalImage && additionalImage !== "") {
            return true; // 추가 이미지가 있으면 폼 제출을 계속 진행
        } 
    }

    // 추가 이미지가 없으면 경고창 띄우고 제출 막기
    alert("추가 이미지를 추가해주세요.");
    return false;
}
</script>
            <!-- 전체 폼 제출 버튼 -->
                        <div class="text-center">
                            <button type="submit" class="btn btn-custom">등록하기</button>
                        </div>

                    </form>
                    <!-- 화면 내용 끝(body end) -->
                </article>
            </div>
        </div>
            <footer class="footer mt-5">
        <%@ include file="../../common/footer.jsp" %>
    </footer>

    </body>
</html>
