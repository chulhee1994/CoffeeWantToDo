<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <script type="text/javascript">const contextPath = "${contextPath}";</script>
    <script src="${contextPath}/resources/js/chatio.js" type="text/javascript"></script>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>
    <div class="header">
        <%@ include file="../common/header.jsp" %>
    </div>

    <!-- 지도를 표시할 div 입니다 -->
    <div id="map" style="width:100%;height:350px;"></div>

    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ab084529c6bbfac0eb9626ca820c009f"></script>
    <script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        mapOption = { 
            center: new kakao.maps.LatLng(36.349284, 127.377477), // 지도의 중심좌표
            level: 2 // 지도의 확대 레벨
        };

    // 지도를 표시할 div와 지도 옵션으로 지도를 생성합니다
    var map = new kakao.maps.Map(mapContainer, mapOption); 

    var markerPosition  = new kakao.maps.LatLng(36.349251, 127.377617); 

    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        position: markerPosition
    });

    // 마커가 지도 위에 표시되도록 설정합니다
    marker.setMap(map);

    // 마커 클릭 시 길찾기 페이지로 이동하는 이벤트 추가
    kakao.maps.event.addListener(marker, 'click', function() {
        var lat = markerPosition.getLat(); // 마커의 위도
        var lng = markerPosition.getLng(); // 마커의 경도

        // 길찾기 URL 포맷
        var url = "https://map.kakao.com/link/to/WTD," + lat + "," + lng;

        // 새 창으로 길찾기 페이지 열기
        window.open(url, "_blank");
    });
    </script>

    <footer class="footer mt-5">
        <%@ include file="../common/footer.jsp" %>
    </footer>
</body>
</html>
