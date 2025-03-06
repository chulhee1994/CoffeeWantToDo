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
<title>신규 배송지 등록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <script type="text/javascript">const contextPath = "${contextPath}";</script>
    <script src="${contextPath}/resources/js/chatio.js" type="text/javascript"></script>
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

		
    (function() {
        var w = window;
        if (w.ChannelIO) {
            return w.console.error("ChannelIO script included twice.");
        }
        var ch = function() {
            ch.c(arguments);
        };
        ch.q = [];
        ch.c = function(args) {
            ch.q.push(args);
        };
        w.ChannelIO = ch;

        function l() {
            if (w.ChannelIOInitialized) {
                return;
            }
            w.ChannelIOInitialized = true;
            var s = document.createElement("script");
            s.type = "text/javascript";
            s.async = true;
            s.src = "https://cdn.channel.io/plugin/ch-plugin-web.js";
            var x = document.getElementsByTagName("script")[0];
            if (x.parentNode) {
                x.parentNode.insertBefore(s, x);
            }
        }
        if (document.readyState === "complete") {
            l();
        } else {
            w.addEventListener("DOMContentLoaded", l);
            w.addEventListener("load", l);
        }
    })();

    ChannelIO('boot', {
        "pluginKey": 'a0ac98cf-93df-4eac-88ff-be0aaffa661f'
    });


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
					<div class="container mt-5 container-custom">
					    <h3 class="text-center">신규 배송지 등록</h3>
					    <br>
					    <br>
					    <form action="${contextPath}/address/addAddress.do" method="post" onsubmit="return check_modAddress();">
					    <div class="row mb-3">
					    <label class="col-sm-3 col-form-label req">배송지 이름</label>
					    <div class="col-sm-5">
					        <input type="text" id="address_name" name="address_name" class="form-control" style="height: 38px;" placeholder="배송지 이름"/>
					    </div>
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
					        <input type="text" name="mem_add3" class="form-control" placeholder="나머지 주소" size="50"/>
					    </div>
					</div>
					        <div class="text-center">
					            <button type="submit" class="btn btn-custom">배송지 등록</button>
					            <button type="reset" class="btn btn-custom">다시 입력</button>
					        </div>
					    </form>
					    </div>                                
		<div class="footer">
			<%@ include file="../common/footer.jsp" %>
		</div>	               
</body>
</html>