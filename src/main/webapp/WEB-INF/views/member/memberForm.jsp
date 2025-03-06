<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
    request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet"
	href="${contextPath}/resources/css/defaultStyle.css">
<link
	href="https://fonts.googleapis.com/css2?family=Merriweather:ital,wght@0,300;0,400;0,700;0,900;1,300;1,400;1,700;1,900&display=swap"
	rel="stylesheet">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원 가입</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- jQuery (for Ajax and Daum Postcode) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Daum Postcode Script -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">const contextPath = "${contextPath}";</script>
<script src="${contextPath}/resources/js/chatio.js"
	type="text/javascript"></script>
<script>
    $(document).ready(function(){
		$('.sel_email2').on('change',function(){
			console.log(this.value);
			var email2Obj = $(this).parent().parent().find('[name=mem_email2]');
			if(this.value == undefined || this.value == null || this.value == ''){
				email2Obj.prop('readOnly',false);
				email2Obj.val('');
			}else{
				email2Obj.prop('readOnly',true);
				email2Obj.val(this.value);
			}
		})
	})
	
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var fullRoadAddr = data.roadAddress; 
                var extraRoadAddr = ''; 

                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraRoadAddr += data.bname;
                }

                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }

                if (extraRoadAddr !== '') {
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                if (fullRoadAddr !== '') {
                    fullRoadAddr += extraRoadAddr;
                }

                    document.getElementById('mem_zipcode').value = data.zonecode;
                    document.getElementById('mem_add1').value = fullRoadAddr;
                    document.getElementById('mem_add2').value = data.jibunAddress;

                if (data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                } else if (data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                } else {
                    document.getElementById('guide').innerHTML = '';
                }
            }
        }).open();
    }
    
    document.addEventListener("DOMContentLoaded", function() {
        // DOM이 로드되었을 때 실행할 코드
        const form = document.getElementById("joinForm");
        if (form) {
            form.addEventListener("submit", function(event) {
                event.preventDefault(); // 기본 제출 동작을 막음
                if (validateForm1()) {  // validateForm1의 반환값에 따라 폼 제출 여부 결정
                    event.target.submit();  // 유효성 검사 통과 시 폼 제출
                }
            });
        }
    });
    
    document.addEventListener("DOMContentLoaded", function() {
        // DOM이 로드되었을 때 실행할 코드
        const form = document.getElementById("joinForm_seller");
        if (form) {
            form.addEventListener("submit", function(event) {
                event.preventDefault(); // 기본 제출 동작을 막음
                if (validateForm2()) {  // validateForm1의 반환값에 따라 폼 제출 여부 결정
                    event.target.submit();  // 유효성 검사 통과 시 폼 제출
                }
            });
        }
    });
</script>

<style>
.container-custom {
	background-color: #ffffff; /* 하얀색 배경 */
	padding: 30px; /* 안쪽 여백 */
	border-radius: 8px; /* 모서리 둥글게 */
	box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
	max-width: 800px; /* 최대 너비 설정 */
	margin: auto; /* 가운데 정렬 */
	border: 0.5px solid #dcdcdc !important;
}

.btn-light {
	color: black !important;
	border: 1px solid black !important;
	border-radius: 2.5px 2.5px !important;
}

#tabs {
	display: flex;
	justify-content: space-evenly;
	border-bottom: 2px solid #ddd;
	align-items: center;
	height: 140px;
	padding: 0 0 10px 0;
}

#tabs div {
	display: flex;
	flex-direction: column;
	text-align: center;
	padding: 10px;
	cursor: pointer;
	font-weight: bold;
	color: #333;
}

#tabs .active {
	background-color: #C29F6D;
	color: white;
}

.tab-content {
	display: none;
	margin-top: 20px;
	padding: 20px;
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
}

.tabs-list {
	weight: 100px;
	height: 125px;
}

.tab-content.active {
	display: block;
}

.req::after {
	content: " *";
	color: red;
}
</style>
</head>
<body>
	<div class="header">
		<%@ include file="../common/header.jsp"%>
	</div>
	<div id="tabs">
		<div class="tabs-list" id="tab_common" class="active"
			onclick="showTab('common')">
			<img src="${contextPath}/resources/images/profile.png" alt="일반회원">
			<p>일반회원</p>
		</div>
		<div class="tabs-list" id="tab_seller" class="active"
			onclick="showTab('seller')">
			<img src="${contextPath}/resources/images/profile.png" alt="판매자">
			<p>판매자</p>
		</div>
	</div>
	<!-- 일반회원 회원가입 -->
	<div class="tab-content" id="common_content">
		<div class="container mt-5 container-custom">
			<h3 class="text-center">일반회원 필수 정보 입력</h3>
			<br> <br>
			<form action="${contextPath}/member/addCommon.do" method="post"
				id="joinForm" onsubmit="return validateForm1(event);">
				<div class="row mb-3">
					<label for="mem_id" class="col-sm-3 col-form-label req">아이디</label>
					<div class="col-sm-6">
						<input type="hidden" name="_mem_id" id="_mem_id"
							class="form-control" /> <input type="text" name="mem_id"
							id="mem_id" class="form-control" required /> <span
							id="mem_id_error" class="text-danger"></span>
						<!-- 오류 메시지 추가 -->
					</div>
					<div class="col-sm-3">
						<button type="button" id="btnOverlapped" class="btn btn-custom"
							onClick="fn_overlapped()">중복체크</button>
					</div>
				</div>

				<div class="row mb-3">
					<label for="mem_pwd" class="col-sm-3 col-form-label req">비밀번호</label>
					<div class="col-sm-6">
						<input name="mem_pwd" type="password" id="mem_pwd"
							class="form-control" required /> <span id="mem_pwd_error"
							class="text-danger"></span>
						<!-- 오류 메시지 추가 -->
					</div>
				</div>

				<div class="row mb-3">
					<label for="mem_name" class="col-sm-3 col-form-label req">이름</label>
					<div class="col-sm-6">
						<input name="mem_name" type="text" id="mem_name"
							class="form-control t1" required /> <span id="mem_name_error"
							class="text-danger"></span>
						<!-- 오류 메시지 추가 -->
					</div>
				</div>

				<div class="row mb-3">
					<label class="col-sm-3 col-form-label req">성별</label>
					<div class="col-sm-9">
						<input type="radio" name="mem_gender" value="102" /> 여성 <input
							type="radio" name="mem_gender" value="101" checked /> 남성 <span
							id="mem_gender_error" class="text-danger"></span>
						<!-- 오류 메시지 추가 -->
					</div>
				</div>

				<div class="row mb-3">
					<label class="col-sm-3 col-form-label" for="mem_birth">법정생년월일</label>
					<div class="col-sm-6">
						<input type="date" name="mem_birth" id="mem_birth"
							class="form-control"> <span id="mem_birth_error"
							class="text-danger"></span>
						<!-- 오류 메시지 추가 -->
					</div>
				</div>

				<div class="row mb-3">
					<label for="tel" class="col-sm-3 col-form-label req">휴대폰번호</label>
					<div class="col-sm-2">
						<select name="mem_tel1" class="form-select">
							<option>없음</option>
							<option selected value="010">010</option>
						</select>
					</div>
					<div class="col-sm-2">
						<input type="text" id="mem_tel2" name="mem_tel2"
							class="form-control" required />
					</div>
					<div class="col-sm-2">
						<input type="text" id="mem_tel3" name="mem_tel3"
							class="form-control" required />
					</div>
					<span id="mem_tel_error" class="text-danger"></span>
					<!-- 오류 메시지 추가 -->
				</div>

				<div class="col-sm-8 d-flex align-items-center">
					<input type="checkbox" name="mem_telsts_yn" value="Y" checked />
					쇼핑몰에서 발송하는 SMS 소식을 수신합니다.
				</div>
				<br> <br>

				<div class="row mb-3">
					<label for="email" class="col-sm-3 col-form-label req">이메일</label>
					<div class="col-sm-3">
						<input type="text" name="mem_email1" id="mem_email1"
							class="form-control" size="10" required /> <span
							id="memEmail1_error" class="error-message"></span>
					</div>
					@
					<div class="col-sm-3">
						<input type="text" name="mem_email2" id="mem_email2"
							class="form-control" size="10" /> <span id="memEmail2_error"
							class="error-message"></span>
					</div>
					<div class="col-sm-2">
						<select class="form-select sel_email2" style="width: 100%;">
							<option value="">직접입력</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="naver.com">naver.com</option>
							<option value="yahoo.co.kr">yahoo.co.kr</option>
							<option value="hotmail.com">hotmail.com</option>
							<option value="paran.com">paran.com</option>
							<option value="nate.com">nate.com</option>
							<option value="google.com">google.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="empal.com">empal.com</option>
							<option value="korea.com">korea.com</option>
							<option value="freechal.com">freechal.com</option>
						</select>
						<button type="button" class="btn btn-custom" id="btnSend"
							style="float: left; margin-left: 10px;"
							onclick="sendVerificationCode()">인증번호발송</button>
					</div>
					<span id="mem_email_error" class="text-danger"></span>
					<!-- 오류 메시지 추가 -->
				</div>

				<div class="row mb-3">
					<label for="mem_name" class="col-sm-3 col-form-label req">인증번호</label>
					<div class="col-sm-7">
						<input type="text" id="confirmCode" name="confirmCode"
							class="form-control" required />
					</div>
					<div class="col-sm-2">
						<button type="button" class="btn btn-custom"
							onclick="confirmCode1()">인증</button>
					</div>
					<span id="confirmCode_error" class="text-danger"></span>
					<!-- 오류 메시지 추가 -->
				</div>

				<div class="col-sm-12 d-flex align-items-center">
					<input type="checkbox" name="mem_emailsts_yn" value="Y" checked />
					쇼핑몰에서 발송하는 e-mail을 수신합니다.
				</div>
				<br> <br>

				<div class="row mb-3">
					<label class="col-sm-3 col-form-label req">우편 번호</label>
					<div class="col-sm-5">
						<input type="text" id="mem_zipcode" name="mem_zipcode"
							class="form-control" style="height: 38px;" placeholder="우편 번호"
							readonly required />
					</div>
					<div class="col-sm-4">
						<button type="button" class="btn btn-custom"
							onClick="execDaumPostcode()" style="height: 38px;">우편번호검색</button>
					</div>
					<span id="mem_zipcode_error" class="text-danger"></span>
					<!-- 오류 메시지 추가 -->
				</div>

				<div class="row mb-3">
					<label for="mem_add1" class="col-sm-3 col-form-label">도로명
						주소</label>
					<div class="col-sm-5">
						<input type="text" id="mem_add1" name="mem_add1"
							class="form-control" placeholder="도로명 주소" readonly />
					</div>
				</div>

				<div class="row mb-3">
					<label for="mem_add2" class="col-sm-3 col-form-label">지번 주소</label>
					<div class="col-sm-5">
						<input type="text" id="mem_add2" name="mem_add2"
							class="form-control" placeholder="지번 주소" readonly />
					</div>
				</div>

				<div class="row mb-3">
					<label for="mem_add3" class="col-sm-3 col-form-label req">나머지
						주소</label>
					<div class="col-sm-5">
						<input type="text" name="mem_add3" id="mem_add3"
							class="form-control" placeholder="나머지 주소" size="50" required />
					</div>
					<span id="mem_add3_error" class="text-danger"></span>
					<!-- 오류 메시지 추가 -->
				</div>

				<input type="hidden" id="sendedCode" name="sendedCode"> <input
					type="hidden" id="codeConfirmFlag" name="codeConfirmFlag" value="N">

				<div class="text-center">
					<button type="submit" class="btn btn-custom">회원 가입</button>
					<button type="reset" class="btn btn-custom">다시 입력</button>
				</div>
			</form>
		</div>
		<br> <br> <br> <br>
	</div>
	<!-- 판매자 회원가입 -->
	<div class="tab-content" id="seller_content">
		<div class="container mt-5 container-custom">
			<!-- 새로운 클래스를 추가한 div -->
			<h3 class="text-center">판매자 필수 정보 입력</h3>
			<br> <br>
			<form action="${contextPath}/member/addSeller.do" method="post"
				id="joinForm_seller" onsubmit="return validateForm2(event);">
				<div class="row mb-3">
					<label for="mem_id" class="col-sm-3 col-form-label req">아이디</label>
					<div class="col-sm-6">
						<input type="hidden" name="_mem_id" id="_mem_id_seller"
							class="form-control" /> <input type="text" name="mem_id"
							id="mem_id_seller" class="form-control" required /> <span
							id="mem_id_seller_error" class="text-danger"></span>
						<!-- 오류 메시지 추가 -->
					</div>
					<div class="col-sm-3">
						<button type="button" id="btnOverlapped_seller" class="btn btn-custom"
							onClick="fn_overlapped_seller()">중복체크</button>
					</div>
				</div>

				<div class="row mb-3">
					<label for="mem_pwd" class="col-sm-3 col-form-label req">비밀번호</label>
					
					<div class="col-sm-6">
						<input name="mem_pwd" type="password" id="mem_pwd_seller"
							class="form-control" required />
							<!-- 오류 메시지 추가 -->
					<span id="mem_pwd_seller_error" class="text-danger"></span>
					</div>
				</div>
				<div class="row mb-3">
					<label for="mem_name" class="col-sm-3 col-form-label req">대표자
						이름</label>

					<div class="col-sm-6">
						<input name="mem_name" type="text" id="mem_name_seller"
							class="form-control t1" required /> <span
							id="mem_name_seller_error" class="text-danger"></span>
						<!-- 오류 메시지 추가 -->
					</div>
				</div>
				<div class="row mb-3">
					<label for="mem_seller_num" class="col-sm-3 col-form-label req">사업자
						등록 번호</label>
					<div class="col-sm-6">
						<input name="mem_seller_num" type="text" id="mem_num_seller"
							class="form-control t1" required />
					</div>
				</div>
				<div class="row mb-3">
					<label for="mem_cmp_name" class="col-sm-3 col-form-label req">기업명</label>
					<div class="col-sm-6">
						<input name="mem_cmp_name" type="text" id="mem_cmp_name_seller"
							class="form-control t1" required />
					</div>
				</div>

				<div class="row mb-3">
					<label for="tel" class="col-sm-3 col-form-label req">담당자
						휴대폰번호</label>
					<div class="col-sm-2">
						<select name="mem_tel1" class="form-select">
							<option selected value="010">010</option>

						</select>
					</div>
					<div class="col-sm-2">
						<input type="text" id="mem_tel2_seller" name="mem_tel2"
							class="form-control" required /> <span id="mem_tel_seller_error"
							class="text-danger"></span>
						<!-- 오류 메시지 추가 -->
					</div>
					<div class="col-sm-2">
						<input type="text" id="mem_tel3_seller" name="mem_tel3"
							class="form-control" required />
					</div>
				</div>

				<div class="col-sm-8 d-flex align-items-center">
					<input type="checkbox" name="mem_telsts_yn" value="Y" checked />
					쇼핑몰에서 발송하는 SMS 소식을 수신합니다.
				</div>
				<br> <br>


				<div class="row mb-3">
					<label for="email" class="col-sm-3 col-form-label req">이메일</label>
					<div class="col-sm-3">
						<input type="text" name="mem_email1" id="mem_email1_seller"
							class="form-control" size="10" required /> <span
							id="mem_email_seller_error" class="text-danger"></span>
						<!-- 오류 메시지 추가 -->
					</div>
					@
					<div class="col-sm-3">
						<input type="text" name="mem_email2" id="mem_email2_seller"
							class="form-control" size="10" />

					</div>
					<div class="col-sm-2">
						<select class="form-select sel_email2" style="width: 100%;">
							<option value="">직접입력</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="naver.com">naver.com</option>
							<option value="yahoo.co.kr">yahoo.co.kr</option>
							<option value="hotmail.com">hotmail.com</option>
							<option value="paran.com">paran.com</option>
							<option value="nate.com">nate.com</option>
							<option value="google.com">google.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="empal.com">empal.com</option>
							<option value="korea.com">korea.com</option>
							<option value="freechal.com">freechal.com</option>
						</select>
						<button type="button" class="btn btn-custom" id="btnSend"
							style="float: left; margin-left: 10px;"
							onclick="sendVerificationCode_seller()">인증번호발송</button>
					</div>
				</div>
				<div class="row mb-3">
					<label for="mem_name" class="col-sm-3 col-form-label req">인증번호</label>
					<div class="col-sm-7">
						<input type="text" id="confirmCode_seller" name="confirmCode"
							class="form-control" required> <span
							id="confirmCode_seller_error" class="text-danger"></span>
						<!-- 오류 메시지 추가 -->
					</div>
					<div class="col-sm-2">
						<button type="button" class="btn btn-custom"
							onclick="confirmCode2()">인증</button>
					</div>
				</div>
				<div class="col-sm-12 d-flex align-items-center">
					<input type="checkbox" name="mem_emailsts_yn" value="Y" checked />
					쇼핑몰에서 발송하는 e-mail을 수신합니다.
				</div>
				<br> <br>
				<div class="row mb-3">
					<label class="col-sm-3 col-form-label req">우편 번호</label>
					<div class="col-sm-5">
						<input type="text" id="seller_mem_zipcode" name="mem_zipcode"
							class="form-control" style="height: 38px;" placeholder="우편 번호"
							readonly required /> <span id="seller_mem_zipcode_error"
							class="text-danger"></span>
						<!-- 오류 메시지 추가 -->
					</div>
					<div class="col-sm-4">
						<button type="button" class="btn btn-custom"
							onClick="execDaumPostcode2()" style="height: 38px;">우편번호검색</button>
					</div>
				</div>

				<div class="row mb-3">
					<label for="mem_add1" class="col-sm-3 col-form-label">도로명
						주소</label>
					<div class="col-sm-5">
						<input type="text" id="seller_mem_add1" name="mem_add1"
							class="form-control" placeholder="도로명 주소" readonly />
					</div>
				</div>

				<div class="row mb-3">
					<label for="mem_add2" class="col-sm-3 col-form-label">지번 주소</label>
					<div class="col-sm-5">
						<input type="text" id="seller_mem_add2" name="mem_add2"
							class="form-control" placeholder="지번 주소" readonly />
					</div>
				</div>

				<div class="row mb-3">
					<label for="mem_add3" class="col-sm-3 col-form-label req">나머지
						주소</label>
					<div class="col-sm-5">
						<input type="text" name="mem_add3" id="seller_mem_add3"
							class="form-control" placeholder="나머지 주소" size="50" required /> <span
							id="seller_mem_add3_error" class="text-danger"></span>
						<!-- 오류 메시지 추가 -->
					</div>
				</div>
				<input type="hidden" id="sendedCode_seller" name="sendedCode">
				<input type="hidden" id="codeConfirmFlag_seller"
					name="codeConfirmFlag" value="N">
				<div class="text-center">
					<button type="submit" class="btn btn-custom">회원 가입</button>
					<button type="reset" class="btn btn-custom">다시입력</button>
				</div>
			</form>
		</div>
	</div>
	<br>
	<br>
	<br>
	<br>
	<div class="footer">
		<%@ include file="../common/footer.jsp"%>
	</div>
	<script>
            // 탭 전환 함수
            function showTab(tabName) {
    const tabs = document.querySelectorAll('#tabs div');
    const tabContents = document.querySelectorAll('.tab-content');

    // 모든 탭과 탭 내용을 비활성화
    tabs.forEach(tab => tab.classList.remove('active'));
    tabContents.forEach(content => content.classList.remove('active'));

    // 클릭된 탭 활성화
    document.getElementById('tab_' + tabName).classList.add('active');
    document.getElementById(tabName + '_content').classList.add('active');
}
        </script>


	<script>
function fn_overlapped() {
    var _id = $("#mem_id").val();  // 아이디 값 가져오기

    console.log("mem_id 값 확인: " + _id);  // _id 값 출력 (디버깅용)

    if (_id == '') {
        alert("ID를 입력하세요");
        return;
    }

    // 아이디 (mem_id) 유효성 검사
    const memId = document.getElementById("mem_id");
    if (!check(/^[a-zA-Z0-9]{5,}$/, memId, "아이디는 5자 이상 영문과 숫자로만 입력 가능합니다.")) {
        memId.focus();
        return;
    } else {
        document.getElementById("mem_id_error").textContent = ''; // 에러 메시지 초기화
    }

    $.ajax({
        type: "post",
        async: false,
        url: "${contextPath}/member/overlapped.do",  // 서버의 URL
        dataType: "text",
        data: { mem_id: _id },  // 'mem_id'를 서버로 전송
        success: function(data, textStatus) {
            console.log(data);  // 서버 응답 확인
            if (data == 'false') {
                alert("사용할 수 있는 ID입니다.");
                $('#mem_id').val(_id);  // mem_id에 값 넣기
                $('#_mem_id').prop("disabled", true);  // _mem_id 입력란 비활성화
            } else {
                alert("사용할 수 없는 ID입니다.");
            }
        },
        error: function(xhr, textStatus, errorThrown) {
            console.log("AJAX 요청 실패:");
            console.log("상태: " + textStatus);
            console.log("오류 메시지: " + errorThrown);
            console.log("응답: " + xhr.responseText);
            alert("에러가 발생했습니다.");
        },
        complete: function(data, textStatus) {
            console.log("작업을 완료했습니다.");
        }
    });
}


function validateForm1(event) {
    let isValid = true;

 // 이메일 인증 여부 확인
    var codeConfirmFlag = document.getElementById('codeConfirmFlag').value;
    if (codeConfirmFlag !== 'Y') {
        alert('이메일 인증을 먼저 해주세요.');
        isValid = false; // 이메일 인증이 되지 않으면 제출을 막음
    }
    
    const memId = document.getElementById("mem_id");
    if (!check(/^[a-zA-Z0-9]{5,}$/, memId, "아이디는 5자 이상 영문과 숫자로만 입력 가능합니다.")) {
        memId.focus();
        return;
    } else {
        document.getElementById("mem_id_error").textContent = ''; // 에러 메시지 초기화
    }
    
    // 비밀번호 (mem_pwd) 유효성 검사
    const memPwd = document.getElementById("mem_pwd");
    if (!check(/^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>])[a-zA-Z\d!@#$%^&*(),.?":{}|<>]{8,16}$/, memPwd, "비밀번호는 8~16자리, 문자+숫자+특수문자를 포함해야 합니다.")) {
        isValid = false;
        memPwd.focus();
    } else {
        document.getElementById("mem_pwd_error").textContent = ''; // 에러 메시지 초기화
    }

    // 이름 (mem_name) 유효성 검사 (한글만)
    const memName = document.getElementById("mem_name");
    if (!check(/^[가-힣]+$/, memName, "이름은 한글로만 입력 가능합니다.")) {
        isValid = false;
        memName.focus();
    } else {
        document.getElementById("mem_name_error").textContent = ''; // 에러 메시지 초기화
    }

    // 성별 (mem_gender) 체크
    const memGender = document.querySelector('input[name="mem_gender"]:checked');
    if (!memGender) {
        isValid = false;
        document.getElementById("mem_gender_error").textContent = "성별을 선택해주세요.";
    } else {
        document.getElementById("mem_gender_error").textContent = ''; // 에러 메시지 초기화
    }

    // 생년월일 (mem_birth) 유효성 검사
    const memBirth = document.getElementById("mem_birth");
    if (memBirth.value.trim() === "") {
        isValid = false;
        document.getElementById("mem_birth_error").textContent = "생년월일을 입력해주세요.";
    } else {
        document.getElementById("mem_birth_error").textContent = ''; // 에러 메시지 초기화
    }

 // 휴대폰 번호 (mem_tel2, mem_tel3) 길이 검사 (무조건 4자리)
    const memTel2 = document.getElementById("mem_tel2");
    const memTel3 = document.getElementById("mem_tel3");

    // 두 번째 번호 (mem_tel2) 길이 검사
    if (memTel2.value.trim().length !== 4) {
        isValid = false;
        document.getElementById("mem_tel_error").textContent = "휴대폰 번호 두 번째 자리는 4자리여야 합니다.";
        memTel2.focus();
    }
    // 세 번째 번호 (mem_tel3) 길이 검사
    else if (memTel3.value.trim().length !== 4) {
        isValid = false;
        document.getElementById("mem_tel_error").textContent = "휴대폰 번호 세 번째 자리는 4자리여야 합니다.";
        memTel3.focus();
    } else {
        document.getElementById("mem_tel_error").textContent = ''; // 에러 메시지 초기화
    }

    // 우편번호 (mem_zipcode) 유효성 검사
    const memZipcode = document.getElementById("mem_zipcode");
    if (memZipcode.value.trim() === "") {
        isValid = false;
        document.getElementById("mem_zipcode_error").textContent = "우편번호를 입력해주세요.";
    } else {
        document.getElementById("mem_zipcode_error").textContent = ''; // 에러 메시지 초기화
    }

    // 나머지 주소 (mem_add3) 유효성 검사
    const memAdd3 = document.getElementById("mem_add3");
    if (memAdd3.value.trim() === "") {
        isValid = false;
        document.getElementById("mem_add3_error").textContent = "나머지 주소를 입력해주세요.";
    } else {
        document.getElementById("mem_add3_error").textContent = ''; // 에러 메시지 초기화
    }

    if(isValid != true) {
    	return isValid; // 유효성 검사 실패 시 폼 제출 방지
    } else {
    	event.target.submit();  // 유효성 검사 통과 시 폼 제출
    }
    
}

function check(regex, element, message) {
    if (!regex.test(element.value)) {
        document.getElementById(element.id + "_error").textContent = message;
        element.style.borderColor = 'red';
        return false;
    }
    element.style.borderColor = ''; // 유효하면 기본 테두리 색으로 복원
    return true;
}


//아이디 비밀번호 찾기 / 이메일 인증
function sendVerificationCode() {
    var mem_email1 = $('#mem_email1').val();
    var mem_email2 = $('#mem_email2').val();

    var email = mem_email1 + "@" + mem_email2;  // 이메일 주소 결합
    
    // 이메일 유효성 체크
    if (mem_email1 === '' || mem_email2 === '') {
        alert('이메일을 입력하세요.');
        return;
    }
    const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/i;
    if (!emailPattern.test(email)) {
        alert('이메일 형식이 올바르지 않습니다.');
        return;
    }
      
    
    // 인증번호 초기화
    $('#sendedCode').val('');  

    console.log(email);

    // 인증번호 생성
    var sendCode = fnRandomStr(5);  // 인증번호 생성 함수가 정의되어 있어야 합니다.

    // AJAX 요청으로 인증번호 발송
    $.ajax({
        url: '${contextPath}/member/emailVerification.do',  // 실제 경로로 수정
        type: 'POST',
        data: {
            email: email,
            sendCode: sendCode
        },
        dataType: "text",
        success: function(resultCode) {
            console.log(resultCode);
            if (resultCode == "200") {
                alert("인증번호가 발송되었습니다.");
                $('#sendedCode').val(sendCode);  // 인증번호 저장
            } else {
                alert("인증번호 발송에 실패하였습니다.");
            }
        },
        error: function() {
            alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
        }
    });
}


        function confirmCode1() {
            var sendCode = $('#sendedCode');
            console.log(sendCode);
            // 발송된 인증번호가 없으면 경고
            if (sendCode.val() == undefined || sendCode.val() == null || sendCode.val() == '') {
                alert('인증번호 발송을 먼저 하세요.');
                return;
            }
            
            var confirmCode = $('#confirmCode');
            
            // 사용자가 입력한 인증번호 확인
            if (confirmCode.val() == undefined || confirmCode.val() == null || confirmCode.val() == '') {
                alert('인증번호를 입력하세요.');
                return;
            }
            
            // 인증번호 비교
            if (sendCode.val() != confirmCode.val()) {
                alert('입력된 인증번호와 발송된 인증번호가 다릅니다.\n재확인 바랍니다.');
                return;
            }
            
            alert('인증되었습니다.');
            $('#codeConfirmFlag').val('Y');
            
        };

	

	// 랜덤 문자열 생성
	function fnRandomStr(num){
        const characters ='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
        let result = '';
        const charactersLength = characters.length;
        for (let i = 0; i < num; i++) {
        	result += characters.charAt(Math.floor(Math.random() * charactersLength));
        }
        return result;
    }
	
</script>


	<script>
function execDaumPostcode2() {
    new daum.Postcode({
        oncomplete: function(data) {
            var fullRoadAddr = data.roadAddress; 
            var extraRoadAddr = ''; 

            if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                extraRoadAddr += data.bname;
            }

            if (data.buildingName !== '' && data.apartment === 'Y') {
                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }

            if (extraRoadAddr !== '') {
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            if (fullRoadAddr !== '') {
                fullRoadAddr += extraRoadAddr;
            }

                document.getElementById('seller_mem_zipcode').value = data.zonecode;
                document.getElementById('seller_mem_add1').value = fullRoadAddr;
                document.getElementById('seller_mem_add2').value = data.jibunAddress;

            if (data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
            } else if (data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
            } else {
                document.getElementById('guide').innerHTML = '';
            }
        }
    }).open();
}

function fn_overlapped_seller() {
    var _id = $("#mem_id_seller").val();  // 아이디 값 가져오기

    console.log("mem_id 값 확인: " + _id);  // _id 값 출력 (디버깅용)

    if (_id == '') {
        alert("ID를 입력하세요");
        return;
    }

    // 아이디 (mem_id) 유효성 검사
    const memId = document.getElementById("mem_id_seller");
    if (!check(/^[a-zA-Z0-9]{5,}$/, memId, "아이디는 5자 이상 영문과 숫자로만 입력 가능합니다.")) {
        memId.focus();
        return;
    } else {
        document.getElementById("mem_id_seller_error").textContent = ''; // 에러 메시지 초기화
    }

    $.ajax({
        type: "post",
        async: false,
        url: "${contextPath}/member/overlapped.do",  // 서버의 URL
        dataType: "text",
        data: { mem_id: _id },  // 'mem_id'를 서버로 전송
        success: function(data, textStatus) {
            console.log(data);  // 서버 응답 확인
            if (data == 'false') {
                alert("사용할 수 있는 ID입니다.");
                $('#mem_id_seller').val(_id);  // mem_id에 값 넣기
                $('#_mem_id_seller').prop("disabled", true);  // _mem_id 입력란 비활성화
            } else {
                alert("사용할 수 없는 ID입니다.");
            }
        },
        error: function(xhr, textStatus, errorThrown) {
            console.log("AJAX 요청 실패:");
            console.log("상태: " + textStatus);
            console.log("오류 메시지: " + errorThrown);
            console.log("응답: " + xhr.responseText);
            alert("에러가 발생했습니다.");
        },
        complete: function(data, textStatus) {
            console.log("작업을 완료했습니다.");
        }
    });
}


function validateForm2(event) {
    let isValid = true;

 // 이메일 인증 여부 확인
    var codeConfirmFlag = document.getElementById('codeConfirmFlag_seller').value;
    if (codeConfirmFlag !== 'Y') {
        alert('이메일 인증을 먼저 해주세요.');
        isValid = false; // 이메일 인증이 되지 않으면 제출을 막음
    }
    
    const memId = document.getElementById("mem_id_seller");
    if (!check(/^[a-zA-Z0-9]{5,}$/, memId, "아이디는 5자 이상 영문과 숫자로만 입력 가능합니다.")) {
        memId.focus();
        return;
    } else {
        document.getElementById("mem_id_seller_error").textContent = ''; // 에러 메시지 초기화
    }
    
    // 비밀번호 (mem_pwd) 유효성 검사
    const memPwd = document.getElementById("mem_pwd_seller");
    if (!check(/^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>])[a-zA-Z\d!@#$%^&*(),.?":{}|<>]{8,16}$/, memPwd, "비밀번호는 8~16자리, 문자+숫자+특수문자를 포함해야 합니다.")) {
        isValid = false;
        memPwd.focus();
    } else {
        document.getElementById("mem_pwd_seller_error").textContent = ''; // 에러 메시지 초기화
    }

    // 이름 (mem_name) 유효성 검사 (한글만)
    const memName = document.getElementById("mem_name_seller");
    if (!check(/^[가-힣]+$/, memName, "대표자 성명은 한글로만 입력 가능합니다.")) {
        isValid = false;
        memName.focus();
    } else {
        document.getElementById("mem_name_seller_error").textContent = ''; // 에러 메시지 초기화
    }


 // 휴대폰 번호 (mem_tel2, mem_tel3) 길이 검사 (무조건 4자리)
    const memTel2 = document.getElementById("mem_tel2_seller");
    const memTel3 = document.getElementById("mem_tel3_seller");

    // 두 번째 번호 (mem_tel2) 길이 검사
    if (memTel2.value.trim().length !== 4) {
        isValid = false;
        document.getElementById("mem_tel_seller_error").textContent = "담당자 연락처 두 번째 자리는 4자리여야 합니다.";
        memTel2.focus();
    }
    // 세 번째 번호 (mem_tel3) 길이 검사
    else if (memTel3.value.trim().length !== 4) {
        isValid = false;
        document.getElementById("mem_tel_seller_error").textContent = "담당자 연락처 세 번째 자리는 4자리여야 합니다.";
        memTel3.focus();
    } else {
        document.getElementById("mem_tel_seller_error").textContent = ''; // 에러 메시지 초기화
    }

    // 우편번호 (mem_zipcode) 유효성 검사
    const memZipcode = document.getElementById("seller_mem_zipcode");
    if (memZipcode.value.trim() === "") {
        isValid = false;
        document.getElementById("seller_mem_zipcode_error").textContent = "우편번호를 입력해주세요.";
    } else {
        document.getElementById("seller_mem_zipcode_error").textContent = ''; // 에러 메시지 초기화
    }

    // 나머지 주소 (mem_add3) 유효성 검사
    const memAdd3 = document.getElementById("seller_mem_add3");
    if (!memAdd3) {
        console.error('ID "seller_mem_add3"를 가진 요소를 찾을 수 없습니다.');
        return false;
    }

    if (memAdd3.value.trim() === "") {
        isValid = false;
        document.getElementById("seller_mem_add3_error").textContent = "나머지 주소를 입력해주세요.";
    } else {
        document.getElementById("seller_mem_add3_error").textContent = ''; // 에러 메시지 초기화
    }

    if(isValid != true) {
    	return isValid; // 유효성 검사 실패 시 폼 제출 방지
    } else {
    	event.target.submit();  // 유효성 검사 통과 시 폼 제출
    }
    
}


//아이디 비밀번호 찾기 / 이메일 인증
function sendVerificationCode_seller() {
    var mem_email1 = $('#mem_email1_seller').val();
    var mem_email2 = $('#mem_email2_seller').val();

    var email = mem_email1 + "@" + mem_email2;  // 이메일 주소 결합
    
    // 이메일 유효성 체크
    if (mem_email1 === '' || mem_email2 === '') {
        alert('이메일을 입력하세요.');
        return;
    }
    const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/i;
    if (!emailPattern.test(email)) {
        alert('이메일 형식이 올바르지 않습니다.');
        return;
    }
      
    
    // 인증번호 초기화
    $('#sendedCode_seller').val('');  

    console.log(email);

    // 인증번호 생성
    var sendCode = fnRandomStr(5);  // 인증번호 생성 함수가 정의되어 있어야 합니다.

    // AJAX 요청으로 인증번호 발송
    $.ajax({
        url: '${contextPath}/member/emailVerification.do',  // 실제 경로로 수정
        type: 'POST',
        data: {
            email: email,
            sendCode: sendCode
        },
        dataType: "text",
        success: function(resultCode) {
            console.log(resultCode);
            if (resultCode == "200") {
                alert("인증번호가 발송되었습니다.");
                $('#sendedCode_seller').val(sendCode);  // 인증번호 저장
            } else {
                alert("인증번호 발송에 실패하였습니다.");
            }
        },
        error: function() {
            alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
        }
    });
}


        function confirmCode2() {
            var sendCode = $('#sendedCode_seller');
            console.log(sendCode);
            // 발송된 인증번호가 없으면 경고
            if (sendCode.val() == undefined || sendCode.val() == null || sendCode.val() == '') {
                alert('인증번호 발송을 먼저 하세요.');
                return;
            }
            
            var confirmCode = $('#confirmCode_seller');
            
            // 사용자가 입력한 인증번호 확인
            if (confirmCode.val() == undefined || confirmCode.val() == null || confirmCode.val() == '') {
                alert('인증번호를 입력하세요.');
                return;
            }
            
            // 인증번호 비교
            if (sendCode.val() != confirmCode.val()) {
                alert('입력된 인증번호와 발송된 인증번호가 다릅니다.\n재확인 바랍니다.');
                return;
            }
            
            alert('인증되었습니다.');
            $('#codeConfirmFlag_seller').val('Y');
            
        };
</script>
	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
