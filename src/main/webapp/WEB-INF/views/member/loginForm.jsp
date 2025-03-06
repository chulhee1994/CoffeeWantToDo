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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- 이거 없으면 진짜 안된다. 아예 안넘어가니까 꼭 넣어라 잊지말아라 진짜 잊으면 짐승이다. -->
    
    <script type="text/javascript">const contextPath = "${contextPath}";</script>
    
    <!-- 이거 없으면 진짜 안된다. 아예 안넘어가니까 꼭 넣어라 잊지말아라 진짜 잊으면 짐승이다. -->
    
    <link rel="stylesheet" href="${contextPath}/resources/css/defaultStyle.css">    
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
    <script type="text/javascript" src="<p:url value="/resources/js/kakaoApi.js"/>"></script>
    <script src="${contextPath}/resources/js/chatio.js" type="text/javascript"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title>로그인 창</title>
    <style>
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
        label {
		  margin-right: 5px;
		}
		
		req::after {
		  content: " *";
		  color: red;
		}            
</style>
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
                    <h1 class="mb-4 text-center">LOGIN</h1>

                    <!-- 에러 메시지 -->
                    <p:choose>
                        <p:when test="${result == 'loginFailed'}">
                            <div class="alert alert-danger">
                                아이디나 비밀번호가 틀립니다. 다시 시도해주세요.
                            </div>
                        </p:when>
                        <p:when test="${result == 'RemoveID'}">
                        	<div class="alert alert-danger">
                        		회원 탈퇴 처리 된 아이디입니다.<br>
                        		챗봇 1:1 문의를 이용해주세요.
                        	</div>
                        </p:when>
                    </p:choose>

                    <!-- 로그인 폼 -->
                    <form name="frmLogin" method="post" action="${contextPath}/member/login.do">
                        <!-- ID 입력 -->
                        <div class="mb-3">
                            <input type="text" id="mem_id" name="mem_id" class="form-control" placeholder="ID" required>
                        </div>
                        <!-- 비밀번호 입력 -->
                        <div class="mb-3">
                            <input type="password" id="mem_pwd" name="mem_pwd" class="form-control" placeholder="Password" required>
                        </div>
                        <!-- 버튼 -->
                        <div class="btn-group">
                            <button type="submit" class="btn btn-login">LOGIN</button>
                            <a href="${contextPath}/member/agreeForm.do" class="btn btn-join">JOIN US</a>
                        </div>
                        <!-- 비밀번호 찾기/아이디 찾기 -->
                        <div class="forgot-group">
                            <a class="btn btn-link" href="${contextPath}/member/findId.do">FORGOT ID</a>
                            <a class="btn btn-link" href="${contextPath}/member/findPwd.do">FORGOT PW</a>
                        </div>
                        <div class="text-center">
                            <a class="kakao" href="javascript:void(0);" onclick="fnKakaoLoginCheck()"> <!-- javascript:void(0) 페이지가 리로드되지 않거나 다른 페이지로 이동하지 않고 -->
                                <img src="${contextPath}/resources/images/kakao_login_medium_wide.png" alt="카카오 로그인">
                            </a>
                         
                        </div>
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
