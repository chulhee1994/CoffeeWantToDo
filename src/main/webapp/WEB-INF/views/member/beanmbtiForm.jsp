<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<!DOCTYPE html>
<html lang="ko">
<head>
    <script type="text/javascript">const contextPath = "${contextPath}";</script>
    <script src="${contextPath}/resources/js/chatio.js" type="text/javascript"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script type="text/javascript">const contextPath = "${contextPath}";</script>
    <title>원두 MBTI</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${contextPath}/resources/css/mbti/style.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/mbti/main.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/mbti/question.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/mbti/animation.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/mbti/result.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/mbti/goods.css">
</head>
<body>
	<div class= "container">
    <div id = "main" class = "mx-auto mt-5 py-5 px-3">
    <!-- 머릿말 -->
        <h1>원두 MBTI</h1>
        <p>당신의 MBTI에 맞는 원두를 추천해 드립니다 !! </p>
        
        <!-- 시작페이지 이미지 --> 
        <div class="col-6 mx-auto">
        <img src="${contextPath}/resources/images/mbtistart.jpg" class = "img-fluid">
        </div>
    <!-- 잡다한 설명 들어가고  --> 
    	<p class="mt-5 py-3">여러분의 성격에 맞는 커피 원두를 찾아보세요! 우리가 커피를 즐기는 방식도 각자의 성격에 따라 다르듯, 각기 다른 성격 유형에 맞는 특별한 원두가 있습니다. 이제, 간단한 질문들로 여러분의 성격 유형을 알아보고, 그에 맞는 원두를 추천받아보세요. 여러분의 성격에 딱 맞는 원두로 오늘 하루를 특별하게 만들어보세요! ☕✨
    	

이 검사는 MBTI 성격 유형을 바탕으로 여러분이 가장 좋아할 원두를 찾아주는 재미있는 경험이 될 것입니다. 준비되셨다면, 시작해볼까요? 😊</p>   
    <!-- 시작 버튼 --> 
    	<button type ="button" class="btn btn-outline-danger mt-3" onclick="begin()">시작하기</button>	
    </div>
    
    <!-- 질문 페이지 -->
    <div id="question">
    <!-- 진행바 -->
    <div class="status mx-auto mt-5">
    	<div class="statusBar">
    	
    	</div>
    </div>
    
    <!-- 질문 란 -->
     <div class="qBox my-5 py-3">
     
     </div>
     
     <!-- 답 선택란 -->
     <div class="aBox">
     
     </div>
    </div>
    
    <!-- 결과 페이지(상품 추천까지 하는) -->
    <div id="result" class="mx-auto my-5 py-5 px-3">
      <h1>당신의 결과는?!</h1>
      <div class="resultname">

      </div>
      <div id="resultImg" class="my-3 col-lg-6 col-md-8 col-sm-10 col-12 mx-auto">

      </div>
      <div class="resultDesc">

      </div>
      <div class="home">
 		
 		<br>
 		<br>
      	<a href="${contextPath}/"><button class="btn btn-custom">메인 페이지로 이동</button></a>
      </div>
      <div id="goods" class="goods mx-auto my-5 py-5 px-3">      
    	<div class="card">      
            <h5 class="card-title"></h5>
            <p class="card-text"></p>
            <p class="price"></p>
        </div>
    </div>
      </div>
    <script src="${contextPath}/resources/js/mbti/mbti-logic.js" type="text/javascript"></script>    
    <script src="${contextPath}/resources/js/mbti/start.js" type="text/javascript"></script>
</div>
</body>
</html>
