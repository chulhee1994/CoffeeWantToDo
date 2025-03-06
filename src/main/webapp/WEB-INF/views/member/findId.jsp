<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="p" uri="http://java.sun.com/jsp/jstl/core"%>
<p:set var="contextPath" value="${pageContext.request.contextPath}" />
<p:set var="result" value="${param.result}"/>
<%
    request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <script type="text/javascript">const contextPath = "${contextPath}";</script>
    <script src="${contextPath}/resources/js/chatio.js" type="text/javascript"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script type="text/javascript">const contextPath = "${contextPath}";</script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="${contextPath}/resources/css/defaultStyle.css">    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title>아이디찾기</title>
    <style type="text/css">
        .loginForm {
            max-width: 600px; /* 카드의 너비를 넓힘 */
            margin: 0 auto; /* 수평 중앙 정렬 */
        }
        .card {
            padding: 40px; /* 카드 안쪽 여백 */
            border-radius: 8px; /* 모서리 둥글게 */
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
        }
        .btn-login, .btn-join {
            width: 48%; /* 두 버튼을 가로로 배치하고 넓이를 48%로 설정 */
            padding: 10px; /* 버튼 여백 */
            font-size: 16px; /* 버튼 글자 크기 */
        }
        .btn-join {
            margin-left: 4%; /* 두 번째 버튼에 좌측 여백 추가 */
        }
        .btn-link {
            font-size: 14px;
            text-decoration: none;
            color: #007bff;
        }
        .btn-link:hover {
            text-decoration: underline;
        }
        .btn-group {
            display: flex; /* 버튼들을 가로로 정렬 */
            justify-content: center; /* 가운데 정렬 */
            gap: 10px; /* 버튼 간의 간격 */
        }
        .forgot-group {
            display: flex; /* 버튼들을 가로로 정렬 */
            justify-content: center; /* 가운데 정렬 */
            gap: 10px; /* 버튼 간의 간격 */
            margin-top: 15px; /* 위쪽 여백 추가 */
        }
        .container {
            text-align: center; /* 전체 컨테이너에서 텍스트 및 버튼을 중앙 정렬 */
        }
        .btn-group {
            display: flex; /* 버튼들을 가로로 정렬 */
            justify-content: center; /* 가운데 정렬 */
            gap: 10px; /* 버튼 간의 간격 */
            width: 100%; /* 부모 요소의 100% 너비를 차지하게 하여 정확히 중앙 정렬되도록 함 */
        }
        
        .kakao {
            text-decoration: none;
        }
        	
		.req::after {
		  content: " *";
		  color: red;
		}
    </style>
    <script type="text/javascript">
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
    		$('#btnFindId').on('click',function(){
    			var mem_name = $('#mem_name');
    			var mem_email1 = $('#mem_email1');
    			var mem_email2 = $('#mem_email2');
    			if(mem_name.val() == undefined || mem_name.val() == null || mem_name.val() == ''){
    				alert('이름을 입력하세요.');
    				mem_name.focus();
    				return;
    			}
    			if(mem_email1.val() == undefined || mem_email1.val() == null || mem_email1.val() == ''){
    				alert('이메일을 입력하세요.');
    				mem_email1.focus();
    				return;
    			}
    			if(mem_email2.val() == undefined || mem_email2.val() == null || mem_email2.val() == ''){
    				alert('이메일을 입력하세요.');
    				mem_email2.focus();
    				return;
    			}
    			$('#frmFindId').submit();
    		});
    	});
    </script>
</head>
<body>
    <div class="header">
        <%@ include file="../common/header.jsp" %>
    </div>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-12">
                <!-- 카드로 감싸진 로그인 폼 -->
                <div class="card">
                    <h1 class="mb-4 text-center">아이디찾기</h1>
                    <!-- 로그인 폼 -->
                    <form id="frmFindId" method="post" action="${contextPath}/member/findId.do">
                        <p:choose>
                            <p:when test="${isResult eq 'Y'}">
                                <div class="row mb-3">
                                    <div class="col-md-12">
                                        <p>${resultMassage}</p>
                                    </div>
                                </div>
                                <!-- 버튼 -->
                                <div class="btn-group">
                                    <p:choose>
                                        <p:when test="${isFind eq 'Y'}">
                                            <a class="btn btn-login" href="${contextPath}/member/loginForm.do">로그인</a>
                                            <a class="btn btn-login" href="${contextPath}/member/findPwd.do">비밀번호 찾기</a>
                                        </p:when>
                                        <p:otherwise>
                                            <a class="btn btn-login" href="${contextPath}/member/findId.do">다시입력</a>
                                        </p:otherwise>
                                    </p:choose>
                                </div>
                            </p:when>
                            <p:otherwise>
                                <!-- ID 입력 -->
                                <div class="row mb-3">
                                    <label for="mem_name" class="col-sm-3 col-form-label req">이름</label>
                                    <div class="col-sm-9">
                                        <input type="text" id="mem_name" name="mem_name" class="form-control">
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label for="email" class="col-sm-3 col-form-label req">이메일</label>
                                    <div class="col-sm-3">
                                        <input type="text" id="mem_email1" name="mem_email1" class="form-control" size="10" />
                                    </div>@
                                    <div class="col-sm-3">
                                        <input type="text" id="mem_email2" name="mem_email2" class="form-control" size="10" />
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
                                <!-- 버튼 -->
                                <div class="btn-group">
                                    <button type="button" class="btn btn-login" id="btnFindId">입력</button>
                                </div>
                            </p:otherwise>
                        </p:choose>
                    </form>
                </div> <!-- .card 끝 -->
            </div>
        </div>
    </div>

    <footer class="footer mt-5">
        <%@ include file="../common/footer.jsp" %>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
