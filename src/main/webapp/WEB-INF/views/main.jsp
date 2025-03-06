<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="p" uri="http://java.sun.com/jsp/jstl/core"%>
<p:set var="contextPath" value="${pageContext.request.contextPath}"></p:set>
<%@ page import="java.io.*, java.net.*, org.json.JSONArray, org.json.JSONObject" %>

<%
    // 페이지 번호와 페이지 크기 동적 처리 (사용자가 입력한 값으로 처리)
    String pageNo = "1";  // pageNo 파라미터를 고정값 1로 설정
    String numOfRows = "1000";  // 한 번에 불러올 최대 데이터 수 설정

    // API 호출 URL 생성 (페이지 번호와 페이지 크기 파라미터를 포함)
    String apiUrl = "https://www.seogu.go.kr/seoguAPI/3660000/getRestRstrt?pageNo=" + pageNo + "&numOfRows=" + numOfRows;

    // API 응답을 받아오는 처리 (HTTP GET 요청)
    String jsonResponse = ""; 
    try {
        // URL 객체 생성
        URL url = new URL(apiUrl);  
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();

        // GET 요청 설정 (타임아웃 5초 설정)
        connection.setRequestMethod("GET");
        connection.setConnectTimeout(5000);  // 연결 타임아웃 5초
        connection.setReadTimeout(5000);     // 읽기 타임아웃 5초

        // API 응답 받기
        BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
        String inputLine;
        StringBuffer responseBuffer = new StringBuffer();  // 응답 내용을 저장할 StringBuffer 객체

        // 서버에서 응답을 한 줄씩 읽어서 responseBuffer에 추가
        while ((inputLine = in.readLine()) != null) {
            responseBuffer.append(inputLine);
        }
        in.close();

        // 최종적으로 응답 내용을 문자열로 변환
        jsonResponse = responseBuffer.toString();
    } catch (Exception e) {
        // 예외 발생 시 에러 메시지 출력
        out.println("<p>API 호출 중 오류가 발생했습니다: " + e.getMessage() + "</p>"); 
        // 클라이언트에게 페이지 새로 고침을 유도하는 JavaScript 코드 삽입
        out.println("<script type='text/javascript'>");
        out.println("window.location.reload();");
        out.println("</script>");
        return;
    }

    // JSON 응답을 JSONObject로 변환
    JSONObject jsonObject = new JSONObject(jsonResponse);

    // 응답 구조에서 'response' -> 'body' -> 'items' 배열을 추출
    JSONArray restList = new JSONArray();
    if (jsonObject.has("response") && jsonObject.getJSONObject("response").has("body") && jsonObject.getJSONObject("response").getJSONObject("body").has("items")) {
        restList = jsonObject.getJSONObject("response").getJSONObject("body").getJSONArray("items");
    } else {
        // 응답에서 'items' 배열이 없으면 콘솔에 출력
        System.out.println("'items' 배열이 응답에 없습니다.");
        out.println("<p>'items' 배열이 응답에 없습니다.</p>");
    }
%>

<html>
<head>
    <link rel="stylesheet" href="${contextPath}/resources/css/defaultStyle.css"> 
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <meta charset="UTF-8">
    <title>메인</title>
    <style>
            /* 업소명 텍스트 스타일 */
        .restaurant-name {
            position: absolute;
            background-color: #fff;
            padding: 5px;
            border-radius: 5px;
            font-weight: bold;
            color: #2c3e50;
            font-size: 14px;
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
        }
        /* 퀴즈 섹션 버튼 스타일링 */
        .quiz-section {
            width: 100%; /* 전체 가로 길이를 꽉 채움 */
            padding: 5px; /* 퀴즈 섹션의 여백 */
        }

        .btn-container {
            display: flex; /* 버튼들을 가로로 정렬 */
            justify-content: space-between; /* 버튼 사이의 공간을 최대화 */
        }

        .quiz-btn {
            width: 50%; /* 버튼의 너비를 화면의 50%로 설정, 두 개 버튼을 배치하기 위해 48% */
            height: 100px; /* 버튼의 높이를 100px로 설정 */
            font-size: 16px; /* 버튼 글자 크기 설정 */
            border: none !important; /* 테두리 제거 */
            border-radius: 3px; /* 버튼 모서리 둥글게 3px */
            background-color: #f0f0f0; /* 기본 배경색을 연한 회색으로 설정 */
            color: black; /* 글자 색을 검정으로 설정 */
            cursor: pointer; /* 마우스 포인터를 버튼 위에 올리면 포인터가 손 모양으로 변경 */
            transition: background-color 0.3s, color 0.3s; /* 호버 효과를 부드럽게 변경 */
            font-family: Arial, sans-serif; /* 기본 서체로 변경 */
            text-decoration: none; /* 링크 기본 스타일 제거 */
            display: flex; /* 버튼 내용 중앙 정렬 */
            justify-content: center;
            align-items: center;
        }

        .quiz-btn:hover {
            background-color: white; /* 호버 시 배경색을 하얀색으로 변경 */
            color: black; /* 호버 시 글자 색을 검정으로 변경 */
            border: none; /* 호버 시 테두리 없애기 */
        }
    </style>
    <script>
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
    
    //웨더api
            // 사용자의 현재 위치를 가져옴
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                var lat = position.coords.latitude;  // 위도
                var lon = position.coords.longitude; // 경도
                console.log('현재 위치 위도: ' + lat + ', 경도: ' + lon); // 위도, 경도 출력

                // 오픈웨더 API에서 지역 이름과 날씨 정보 가져오기
                loadWeatherData(lat, lon);

                // 카카오 맵에 위치 표시
                loadMap(lat, lon);
            }, function(error) {
                alert("위치를 가져오는 데 실패했습니다. 브라우저에서 위치 권한을 허용했는지 확인해 주세요.");
            });
        } else {
            alert("이 브라우저는 Geolocation을 지원하지 않습니다.");
        }

        // 오픈웨더 API에서 날씨 정보를 불러오는 함수
        function loadWeatherData(lat, lon) {
            var apiKey = 'da489bc83439d6bd38c7c6ca5cced160'; // 본인의 오픈웨더 API 키를 입력하세요.
            if (!lat || !lon) {
                console.error('위도와 경도가 유효하지 않습니다.');
                return;
            }

            var cacheKey = 'weatherData';
            var cacheTimeKey = 'weatherDataTime';
            var cacheDuration = 60 * 60 * 1000;  // 1시간 (밀리초 단위)
            var currentTime = new Date().getTime(); // 현재 시간 (밀리초 단위)

            // 로컬 스토리지에서 캐시된 날씨 정보와 캐시된 시간 가져오기
            
            var cachedWeather = localStorage.getItem(cacheKey);
            var cachedTime = localStorage.getItem(cacheTimeKey);

            
            var weatherMainFromStorage = localStorage.getItem('weatherMain'); // 로컬 스토리지에서 weatherMain 가져오기

         // weatherMain 값이 있을 때만 컨트롤러로 넘기기
        if (weatherMainFromStorage) {
    var weatherUrl = "${contextPath}/goods/wegoods.do?weatherMain=" + encodeURIComponent(weatherMainFromStorage);
    // 링크에 값 할당
    var weatherLink = document.querySelector('.quiz-btn[href="${contextPath}/goods/wegoods.do"]');
    if (weatherLink) {
        weatherLink.setAttribute('href', weatherUrl);
    }
}


            
            // 로컬 스토리지에 저장된 정보 확인하기 위한 콘솔 로그
            console.log('로컬 스토리지에 저장된 날씨 정보:', cachedWeather);
            console.log('로컬 스토리지에 저장된 시간:', cachedTime);

            // 캐시된 정보가 있고, 1시간 내에 요청했으면 캐시된 데이터 사용
            if (cachedWeather && cachedTime && (currentTime - cachedTime < cacheDuration)) {
                console.log('캐시된 날씨 정보 사용:', cachedWeather);
                document.getElementById('weather').innerHTML = cachedWeather;
                return;
            }

            var weatherApiUrl = 'https://api.openweathermap.org/data/2.5/weather?lat=' + lat + '&lon=' + lon + '&appid=' + apiKey + '&units=metric&lang=kr';
            console.log('최종 API URL: ' + weatherApiUrl); // 생성된 URL 확인

            fetch(weatherApiUrl)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('API 호출 실패: ' + response.status);
                    }
                    return response.json();
                })
                .then(data => {
                	
                	console.log('날씨 데이터 (JSON 형식):', data); // JSON 형식의 데이터 출력
                     
                    var temp = data.main.temp; // 기온
                    var weather = data.weather[0].description; // 날씨 상태
                    var weatherMain = data.weather[0].main; // weather 배열에서 main 값 가져오기 
                    var cityName = data.name; // 도시명
                    var icon = data.weather[0].icon; // 날씨 아이콘 코드

                    
                 // 날씨 정보를 포함한 URL을 생성
                    var weatherUrl = "${contextPath}/goods/wegoods.do?weatherMain=" + encodeURIComponent(weatherMain);

                    // '오늘 날씨에 맞는 레시피와 원두는 무엇일까?' 버튼에 링크를 설정
                    document.querySelector('.quiz-btn[href="${contextPath}/goods/wegoods.do"]').setAttribute('href', weatherUrl);
                   
                    console.log('날씨 데이터 (JSON 형식):', data); // JSON 형식의 데이터 출력
                    
                    // 지역명과 날씨 정보 출력
                    console.log('도시명: ' + cityName); // 지역명 출력
                    console.log('기온: ' + temp + '°C, 날씨 상태: ' + weather  ); // 날씨 상태 출력

                    // 날씨 정보 출력
                    var weatherHtml = cityName + ': ' + temp + '°C, ' + weatherMain + ' (' + weather + ') <br>';
					weatherHtml += '<img src="http://openweathermap.org/img/wn/' + icon + '.png" alt="' + weather + '">';

                    // 로컬 스토리지에 날씨 정보와 시간 저장
                    localStorage.setItem('weatherMain', weatherMain); // weatherMain 저장
                    localStorage.setItem(cacheKey, weatherHtml); // 날씨 정보 저장
                    localStorage.setItem(cacheTimeKey, currentTime); // 요청 시간 저장

                    document.getElementById('weather').innerHTML = weatherHtml;
                })
                .catch(error => {
                    console.error('오픈웨더 API 에러:', error);
                    //alert('날씨 정보를 가져오는 데 문제가 발생했습니다 페이지를 새로고침 합니다.');
                    // 로컬스토리지 초기화
                    localStorage.clear();

                    // 페이지 새로고침
                    location.reload();
                });
        }

    
    
    
    
    
    
</script>
</head>
<body>
    <!-- 헤더 -->
    <div class="header">
        <%@ include file="common/header.jsp" %>
    </div>
<br><br>
                                <!-- 날씨 정보 -->
                        <div class="weather-info text-center mb-4">
                             <div id="weather"></div>
                        </div>
        
        <!-- 퀴즈 섹션 -->
        <div class="quiz-section">
            <div class="btn-container">
                <a href="${contextPath}/member/beanmbtiForm.do" class="quiz-btn">당신의 원두 MBTI를 알아보세요!</a> <!-- 이동할 링크 추가 -->
                <a href="${contextPath}/goods/wegoods.do" class="quiz-btn">오늘 날씨에 맞는 레시피와 원두는 무엇일까?</a> <!-- 이동할 링크 추가 -->
            </div>
        </div>
        <br><br>
        <hr>
        

    <!-- 전체 페이지 컨테이너 -->
    <div class="page-container">
        <!-- 동영상 섹션 -->
        <div class="video-section">
            <video autoplay loop muted playsinline>
                <source src="${contextPath}/resources/videos/background.mp4" type="video/mp4">
                <source src="${contextPath}/resources/videos/background.webm" type="video/webm">
                <p>죄송합니다. 브라우저에서 동영상을 지원하지 않습니다.</p>
            </video>
        </div>



        <!-- 이미지 섹션 -->
        <div class="image-section">
            <img src="${contextPath}/resources/images/main_pt.png" alt="main_pt"/>
        </div>
    <!-- 지도를 표시할 div -->
    <div id="map" style="width:100%;height:350px;"></div>

    <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=ab084529c6bbfac0eb9626ca820c009f"></script>
    <script>
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div
            mapOption = { 
                center: new kakao.maps.LatLng(36.349284, 127.377477), // 지도의 중심좌표
                level: 5 // 지도의 확대 레벨
            };

        // 지도를 표시할 div와  지도 옵션으로 지도를 생성
        var map = new kakao.maps.Map(mapContainer, mapOption); 

<%
    // 'items' 배열에서 각 항목을 순차적으로 가져와서 필터링 후 마커를 생성
    for (int i = 0; i < restList.length(); i++) {
        JSONObject rest = restList.getJSONObject(i);
        String bsshNm = rest.getString("bssh_nm");  // 업소명

        // "카페"나 "로스터즈", "로스터스", "로스팅" 키워드가 포함된 업소만 마커 추가
        if (bsshNm.contains("카페") || bsshNm.contains("에스프레소") || bsshNm.contains("로스터스") || bsshNm.contains("로스팅") || bsshNm.contains("로스터")) {
            Double la = rest.isNull("la") ? null : rest.getDouble("la");  // 위도
            Double lo = rest.isNull("lo") ? null : rest.getDouble("lo");  // 경도

            if (la != null && lo != null) { // 위도와 경도가 있는 경우에만 마커 생성
%>
                // 마커 위치 설정
                var markerPosition = new kakao.maps.LatLng(<%= la %>, <%= lo %>);

                // 마커 생성
                var marker = new kakao.maps.Marker({
                    position: markerPosition
                });

                // 마커 지도에 표시
                marker.setMap(map);

                // 업소명을 마커 옆에 표시하는 div 생성
                var nameDiv = document.createElement('div');
                nameDiv.className = 'restaurant-name';
                nameDiv.innerHTML = "<%= bsshNm %>";  // 업소명

                // 업소명 위치 설정 (마커의 위치 바로 옆에)
                var namePosition = new kakao.maps.LatLng(<%= la %>, <%= lo %>);
                var markerPositionForText = new kakao.maps.LatLng(<%= la %> + 0.00003, <%= lo %>);  // 약간 위쪽에 위치하도록 설정

                // 업소명 텍스트를 지도에 표시
                var nameMarker = new kakao.maps.CustomOverlay({
                    position: markerPositionForText,
                    content: nameDiv
                });

                // 마커 옆에 업소명 텍스트 표시
                nameMarker.setMap(map);

                // 마커 클릭 시 길찾기 기능 추가
                kakao.maps.event.addListener(marker, 'click', function() {
                    var startPoint = new kakao.maps.LatLng(36.349284, 127.377477);  // 시작 위치 (예: 사용자 위치)
                    var endPoint = markerPosition;  // 마커 위치 (목적지)

                    // 카카오 길찾기 URL 생성
                    var url = "https://map.kakao.com/link/to/" + encodeURIComponent("<%= bsshNm %>") + "," + endPoint.getLat() + "," + endPoint.getLng();

                    // 새 탭으로 열기
                    window.open(url, '_blank');
                });
             // 마커 위치 설정 (기본 마커와 동일한 위치, 예시로 위도, 경도 사용)
                var markerPosition = new kakao.maps.LatLng(36.349194, 127.377569);

                // 기본 마커를 생성하지 않고 커스텀 마커만 생성
                var customMarkerImageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png'; // 빨간색 마커 이미지
                var customMarkerSize = new kakao.maps.Size(40, 40); // 마커 이미지 크기

                // 커스텀 마커 객체 생성 (기본 마커 없이 커스텀 마커만 사용)
                var customMarker = new kakao.maps.Marker({
                    position: markerPosition,  // 위치 설정
                    image: new kakao.maps.MarkerImage(customMarkerImageSrc, customMarkerSize)  // 커스텀 이미지 설정
                });

                // 커스텀 마커 지도에 표시
                customMarker.setMap(map);
<%
            }
        }
    }
%>

    </script>
        
        <!-- 푸터 -->
        <div class="footer">
            <%@ include file="common/footer.jsp" %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
