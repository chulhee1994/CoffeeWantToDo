<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
    request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <script type="text/javascript">const contextPath = "${contextPath}";</script>
    <script src="${contextPath}/resources/js/chatio.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${contextPath}/resources/css/defaultStyle.css">
    <link href="https://fonts.googleapis.com/css2?family=Merriweather:ital,wght@0,300;0,400;0,700;0,900;1,300;1,400;1,700;1,900&display=swap" rel="stylesheet">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>추가 정보 입력 폼</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery (for Ajax and Daum Postcode) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Daum Postcode Script -->
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <!-- validation.js -->
    <script src="${contextPath}/resources/js/validation.js" type="text/javascript"></script>
    
    <script>
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
</script>
</head>
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
        	color:black !important;
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
            	text-align:center;
                padding: 10px;
                cursor: pointer;
                font-weight: bold;
                color: #333;
            }
			
            #tabs .active {
                background-color: red;
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
	<%@ include file="../common/header.jsp" %>
</div>
<div class="container mt-5 container-custom">
    <h3 class="text-center">카카오 추가 정보 입력</h3>
    <br>
    <br>
    <form action="${contextPath}/member/addKakao.do" method="post" onsubmit="return check_Member();">
			<div class="row mb-3">          
            <div class="col-sm-6">
                <input type="hidden" name="mem_id" id="mem_id" class="form-control" value="${param.mem_id}"/>
            </div>
            </div>
        <div class="row mb-3">
            <div class="col-sm-6">
                <input name="mem_pwd" type="hidden" id="mem_pwd" class="form-control" value="${param.mem_pwd}"/>
            </div>
            </div>
            <div class="row mb-3">
            <div class="col-sm-6">
                <input name="mem_grade" type="hidden" id="mem_grade" value="kakao" class="form-control t1" />
            </div>
            </div>
        <div class="row mb-3">
					            <label for="mem_name" class="col-sm-3 col-form-label req">이름</label>
					            <div class="col-sm-6">
					                <input name="mem_name" type="text" id="mem_name" class="form-control t1" />
					            </div>
					        </div>
        <div class="row mb-3">
            <label class="col-sm-3 col-form-label req">성별</label>
            <div class="col-sm-9">
                <input type="radio" name="mem_gender" value="102" /> 여성
                <input type="radio" name="mem_gender" value="101" checked /> 남성
            </div>
        </div>
        <div class="row mb-3">
					    <label for="tel" class="col-sm-3 col-form-label req">휴대폰번호</label>
					    <div class="col-sm-2">
					        <select name = "mem_tel1" class="form-select">
					            <option>없음</option>
					            <option selected value="010">010</option>
					            <!-- 추가된 옵션들 -->
					        </select>
					    </div>
					    <div class="col-sm-2">
					        <input type="text" name="mem_tel2" class="form-control" />
					    </div>
					    <div class="col-sm-2">
					        <input type="text" name="mem_tel3" class="form-control" />
					    </div>
					</div>
					<div class="col-sm-8 d-flex align-items-center">
					        <input type="checkbox" name="mem_telsts_yn" value="Y" checked /> 
					        쇼핑몰에서 발송하는 SMS 소식을 수신합니다.
					    </div>
					    <br>
					    <br>
					    <div class="row mb-3">
    <label for="email" class="col-sm-3 col-form-label req">이메일</label>
    <div class="col-sm-3">
        <input type="text" name="mem_email1" class="form-control" size="10" />
    </div>@
    <div class="col-sm-3">
        <input type="text" name="mem_email2" class="form-control" size="10" />
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
    </div>
</div>
<div class="col-sm-12 d-flex align-items-center">
        <input type="checkbox" name="mem_emailsts_yn" value="Y" checked /> 쇼핑몰에서 발송하는 e-mail을 수신합니다.
    </div>
    <div class="row mb-3">
					    <label class="col-sm-3 col-form-label req">우편 번호</label>
					    <div class="col-sm-5">
					        <input type="text" id="mem_zipcode" name="mem_zipcode" class="form-control" style="height: 38px;" placeholder="우편 번호" readonly/>
					    </div>
					    <div class="col-sm-4">
					        <button type="button" class="btn btn-custom" onClick="execDaumPostcode()" style="height: 38px;">우편번호검색</button>
					    </div>
					</div>
					
					<div class="row mb-3">
					    <label for="mem_add1" class="col-sm-3 col-form-label">도로명 주소</label>
					    <div class="col-sm-5">
					        <input type="text" id="mem_add1" name="mem_add1" class="form-control" placeholder="도로명 주소" readonly/>
					    </div>
					</div>
					
					<div class="row mb-3">
					    <label for="mem_add2" class="col-sm-3 col-form-label">지번 주소</label>
					    <div class="col-sm-5">
					        <input type="text" id="mem_add2" name="mem_add2" class="form-control" placeholder="지번 주소" readonly/>
					    </div>
					</div>
					
					<div class="row mb-3">
					    <label for="mem_add3" class="col-sm-3 col-form-label req">나머지 주소</label>
					    <div class="col-sm-5">
					        <input type="text" name="mem_add3" class="form-control" placeholder="나머지 주소" size="50" />
					    </div>
					</div>
					        <div class="text-center">
					            <button type="submit" class="btn btn-custom">저장</button>
					            <button type="reset" class="btn btn-custom">다시 입력</button>
					        </div>
            </form>
            </div>
            
</body>
</html>