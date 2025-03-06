<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="p" uri="http://java.sun.com/jsp/jstl/core" %>
<p:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
    request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기본 주소 수정</title>
    <script type="text/javascript">const contextPath = "${contextPath}";</script>
    <script src="${contextPath}/resources/js/chatio.js" type="text/javascript"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
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
<style>
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
	 <p:choose>
                    <p:when test="${member.mem_grade == 'common'}">
					<div class="container mt-5 container-custom">
					    <h3 class="text-center">일반회원 기본주소 수정</h3>
					    <br>
					    <br>
					    <form action="${contextPath}/member/modDefaultAddress.do" method="post">
					    <div class="row mb-3">
					    <label class="col-sm-3 col-form-label req">우편 번호</label>
					    <div class="col-sm-5">
					        <input type="text" id="mem_zipcode" name="mem_zipcode" class="form-control" style="height: 38px;" placeholder="우편 번호" />
					    </div>
					    <div class="col-sm-4">
					        <button type="button" class="btn btn-custom" onClick="execDaumPostcode()" style="height: 38px;">우편번호검색</button>
					    </div>
					</div>
					
					<div class="row mb-3">
					    <label for="mem_add1" class="col-sm-3 col-form-label">도로명 주소</label>
					    <div class="col-sm-5">
					        <input type="text" id="mem_add1" name="mem_add1" class="form-control" placeholder="도로명 주소" />
					    </div>
					</div>
					
					<div class="row mb-3">
					    <label for="mem_add2" class="col-sm-3 col-form-label">지번 주소</label>
					    <div class="col-sm-5">
					        <input type="text" id="mem_add2" name="mem_add2" class="form-control" placeholder="지번 주소" />
					    </div>
					</div>
					
					<div class="row mb-3">
					    <label for="mem_add3" class="col-sm-3 col-form-label req">나머지 주소</label>
					    <div class="col-sm-5">
					        <input type="text" name="mem_add3" class="form-control" placeholder="나머지 주소" size="50" />
					    </div>
					</div>
					        <div class="text-center">
					            <button type="submit" class="btn btn-custom">정보 수정</button>
					            <button type="reset" class="btn btn-custom">다시 입력</button>
					        </div>
					    </form>
					    </div>                  
                    </p:when>
                    <p:when test="${member.mem_grade == 'seller'}">
					<div class="container mt-5 container-custom"> <!-- 새로운 클래스를 추가한 div -->
					    <h3 class="text-center">판매자 기본주소 수정</h3>
					    <br>
					    <br>
					    <form action="${contextPath}/member/modDefaultAddress.do" method="post">
					    <div class="row mb-3">
					    <label class="col-sm-3 col-form-label req">우편 번호</label>
					    <div class="col-sm-5">
					        <input type="text" id="mem_zipcode" name="mem_zipcode" class="form-control" style="height: 38px;" placeholder="우편 번호" />
					    </div>
					    <div class="col-sm-4">
					        <button type="button" class="btn btn-custom" onClick="execDaumPostcode()" style="height: 38px;">우편번호검색</button>
					    </div>
					</div>
					
					<div class="row mb-3">
					    <label for="mem_add1" class="col-sm-3 col-form-label">도로명 주소</label>
					    <div class="col-sm-5">
					        <input type="text" id="mem_add1" name="mem_add1" class="form-control" placeholder="도로명 주소" />
					    </div>
					</div>
					
					<div class="row mb-3">
					    <label for="mem_add2" class="col-sm-3 col-form-label">지번 주소</label>
					    <div class="col-sm-5">
					        <input type="text" id="mem_add2" name="mem_add2" class="form-control" placeholder="지번 주소" />
					    </div>
					</div>
					
					<div class="row mb-3">
					    <label for="mem_add3" class="col-sm-3 col-form-label req">나머지 주소</label>
					    <div class="col-sm-5">
					        <input type="text" name="mem_add3" class="form-control" placeholder="나머지 주소" size="50" />
					    </div>
					</div>
					        <div class="text-center">
					            <button type="submit" class="btn btn-custom">정보 수정</button>
					            <button type="reset" class="btn btn-custom">다시입력</button>
					        </div>
					    </form>
					    </div>                     
                    </p:when>
                </p:choose>
		<div class="footer">
			<%@ include file="../common/footer.jsp" %>
		</div>	               
</body>
</html>