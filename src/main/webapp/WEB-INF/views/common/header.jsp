<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="p" uri="http://java.sun.com/jsp/jstl/core" %>
<p:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<style>
	.body {
		font-family: "Merriweather", serif;
    	font-weight: bold;
    	background-color: #f8f9fa;  
    	margin:0;
    	padding:0;  	
	}
	.nametitle {
		font-size:12px;
		font-weight:bold;
	}
	.dropdown-menu li {
		background-color: #A4814F !important;
		color:white !important;
		text-align:center;
	}
	
		.dropdown-menu li a {
		background-color: #A4814F !important;
		color:white !important;
		text-align:center;
	}
	
	nav-link dropdown-toggle {
		color:white !important;
	}
	
</style>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${contextPath}/resources/css/defaultStyle.css"> <!-- 외부 CSS 링크 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Merriweather:ital,wght@0,300;0,400;0,700;0,900;1,300;1,400;1,700;1,900&display=swap" rel="stylesheet">
    <title>원두 want to do</title>
</head>
<body>
    <!-- 로고 부분 -->
    <div>
        <div class="navbar-logo-container">
            <img src="${contextPath}/resources/images/logo.png" alt="Logo" onclick="toggleNavbar()"/>
        </div>
    </div>   
	<div>
		<div class="mypage-container">
			<ul>
				<p:choose>
				<p:when test="${isLogOn==true and not empty member }">
					<li><h5 class="nametitle">${member.mem_name}님, 환영합니다</h5></li>
					<li><a href="${contextPath}/member/logout.do">로그아웃</a></li>&nbsp;&nbsp;<br>
				</p:when>
				</p:choose>

			</ul>
		</div>
	</div>
    <!-- 네비게이션 메뉴 -->
    <nav id="navbarFullscreen" class="navbar-fullscreen">
        <div class="navbar-logo-section">
            <img src="${contextPath}/resources/images/logo.png" alt="Logo" onclick="toggleNavbar()"/>
        </div>
        <div class="navbar-list-section">
            <ul>
                <p:choose>
                    <p:when test="${member.mem_grade == '' || member.mem_grade == null}">
                        <li><a href="${contextPath}/">HOME</a></li>
                        <br>
                        <li><a href="${contextPath}/goods/goodsListBean.do?goods_category=원두">BEAN</a></li>
						<li><a href="${contextPath}/goods/goodsListBakery.do?goods_category=베이커리">BAKERY</a></li>
                        <li><a href="${contextPath}/goods/goodsListTool.do?goods_category=커피용품">TOOL</a></li>
                        <br>
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            SUGGEST
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="${contextPath}/notice/noticeLists.do">NOTICE</a></li>
                            <li><a class="dropdown-item" href="${contextPath}/recipe/recipeLists.do">RECIPE</a></li>
                            <li><a class="dropdown-item" href="${contextPath}/review/reviewLists.do">REVIEW</a></li>
                            <li><a class="dropdown-item" href="${contextPath}/faq/faqLists.do">FAQ</a></li>
                        </ul>
                    </li>
                </ul>
						<li><a href="${contextPath}/member/loginForm.do">LOGIN</a></li>
                    </p:when>
                    
                    
                    
                    
                    <p:when test="${member.mem_grade == 'common' || member.mem_grade == 'kakao' }">
                        <li><a href="${contextPath}/">HOME</a></li>
                        <br>
                        <li><a href="${contextPath}/goods/goodsListBean.do?goods_category=원두">BEAN</a></li>
						<li><a href="${contextPath}/goods/goodsListBakery.do?goods_category=베이커리">BAKERY</a></li>
                        <li><a href="${contextPath}/goods/goodsListTool.do?goods_category=커피용품">TOOL</a></li>

                      	<br>
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            SUGGEST
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="${contextPath}/notice/noticeLists.do">NOTICE</a></li>
                            <li><a class="dropdown-item" href="${contextPath}/recipe/recipeLists.do">RECIPE</a></li>
                            <li><a class="dropdown-item" href="${contextPath}/review/reviewLists.do">REVIEW</a></li>
                            <li><a class="dropdown-item" href="${contextPath}/faq/faqLists.do">FAQ</a></li>
                        </ul>
                    </li>
                </ul>
                        <br>
                        <li><a href="${contextPath}/mypage/myPageUsers.do">MY PAGE</a></li>
                        <li><a href="${contextPath}/cart/myCartList.do">CART</a></li>
                        <li><a href="${contextPath}/member/logout.do">LOGOUT</a></li>
                        <br>                                              
                    </p:when>
                    
                    
                    
                    
                    
                                        <p:when test="${member.mem_grade == 'seller'}">
                        <li><a href="${contextPath}/seller/sellergoodsList.do">HOME</a></li>
						<li><a href="${contextPath}/goods/goodsListBean.do?goods_category=원두">BEAN</a></li>
						<li><a href="${contextPath}/goods/goodsListBakery.do?goods_category=베이커리">BAKERY</a></li>
                        <li><a href="${contextPath}/goods/goodsListTool.do?goods_category=커피용품">TOOL</a></li>
						<br><br>
						<h3>MANAGEMENT</h3>
                        <li><a href="${contextPath}/seller/modgoodsListBean.do?goods_category=원두&mem_id=${mem_id}">MOD GOODS</a></li>
                        <li><a href="${contextPath}/admin/goods/addNewGoodsForm.do">ADD GOODS</a></li>
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            SUGGEST
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="${contextPath}/notice/noticeLists.do">NOTICE</a></li>
                            <li><a class="dropdown-item" href="${contextPath}/recipe/recipeLists.do">RECIPE</a></li>
                            <li><a class="dropdown-item" href="${contextPath}/review/reviewLists.do">REVIEW</a></li>
                            <li><a class="dropdown-item" href="${contextPath}/faq/faqLists.do">FAQ</a></li>
                        </ul>
                    </li>
                </ul>                 
						<br>
                        <li><a href="${contextPath}/seller/SellerOrderList.do">ORDER LIST</a></li>
                        <li><a href="${contextPath}/member/logout.do">LOGOUT</a></li>                     
                    </p:when>
                    
                    
                    
                    

                    
                    <p:when test="${member.mem_grade == 'admin'}">
                       <li><a href="${contextPath}/admin/admingoodsList.do">HOME</a></li>
						<li><a href="${contextPath}/goods/goodsListBean.do?goods_category=원두">BEAN</a></li>
						<li><a href="${contextPath}/goods/goodsListBakery.do?goods_category=베이커리">BAKERY</a></li>
                        <li><a href="${contextPath}/goods/goodsListTool.do?goods_category=커피용품">TOOL</a></li>
                        
						<br>
						<h3>MANAGEMENT</h3>
						<br>
                        <li><a href="${contextPath}/admin/goods/modgoodsListBean.do?goods_category=원두">MOD GOODS</a></li>
                        <li><a href="${contextPath}/admin/goods/addNewGoodsForm.do">ADD GOODS</a></li>						
						<li><a href="${contextPath}/admin/member/mgmMemberForm.do">MEMBER</a></li>
						<li><a href="${contextPath}/admin/order/mgmOrderForm.do">ORDER</a></li>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            SUGGEST
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="${contextPath}/notice/noticeLists.do">NOTICE</a></li>
                            <li><a class="dropdown-item" href="${contextPath}/recipe/recipeLists.do">RECIPE</a></li>
                            <li><a class="dropdown-item" href="${contextPath}/review/reviewLists.do">REVIEW</a></li>
                            <li><a class="dropdown-item" href="${contextPath}/faq/faqLists.do">FAQ</a></li>
                        </ul>
                    </li>
                </ul>
                        <br>
                        <br>
                        <li><a href="${contextPath}/member/logout.do">LOGOUT</a></li>                        
                    </p:when>
                </p:choose>
            </ul>
        </div>
    </nav>

    <script>
        function toggleNavbar() {
            var navbar = document.getElementById("navbarFullscreen");
            navbar.classList.toggle("open");
        }
        
        document.addEventListener('DOMContentLoaded', function () {
            var dropdownElements = document.querySelectorAll('.dropdown-toggle');
            dropdownElements.forEach(function (dropdown) {
                new bootstrap.Dropdown(dropdown); // 드롭다운 초기화
            });
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>
