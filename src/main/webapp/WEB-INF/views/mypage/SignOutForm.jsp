<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
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
    <link rel="stylesheet" href="${contextPath}/resources/css/defaultStyle.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title>회원 탈퇴</title>
    <style>
        .signout-form {
            max-width: 600px;
            margin: 0 auto;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }

        .signout-form h3 {
            text-align: center;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-control {
            padding: 10px;
            font-size: 16px;
            width: 100%;
        }

        .btn-signout {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            background-color: #dc3545;
            border: none;
            color: white;
            border-radius: 5px;
        }

        .btn-signout:hover {
            background-color: #c82333;
        }

        .btn-link {
            font-size: 14px;
            text-decoration: none;
            color: #007bff;
        }

        .btn-link:hover {
            text-decoration: underline;
        }

        .footer {
            text-align: center;
            margin-top: 30px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="header">
        <%@ include file="../common/header.jsp" %>
    </div>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="signout-form">
                    <h3>회원 탈퇴</h3>

                    <form action="${contextPath}/member/removeMember.do" method="post" onsubmit="return SignOutCheck()">
                        <div class="form-group">
                            <label for="mem_id">아이디</label>
                            <input name="mem_id" id="mem_id" type="text" class="form-control" size="20" value="${member.mem_id}" readonly required />
                        </div>
                        <div class="form-group">
                            <label for="mem_pwd">비밀번호</label>
                            <input name="mem_pwd" id="mem_pwd" type="password" class="form-control" size="20" required />
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn-signout">회원탈퇴</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <footer class="footer mt-5">
        <%@ include file="../common/footer.jsp" %>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script>
        function SignOutCheck() {
            const result = confirm("정말 회원탈퇴 하시겠습니까?");
            if(result) {
                return true;
            } else {
                event.preventDefault();
                event.stopPropagation();
                return false;
            }
        }
    </script>
</body>
</html>
