<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="recipe" value="${recipeVO}" />
<c:set var="comments" value="${comments}" />
<c:set var="isLogOn" value="${sessionScope.isLogOn}" />
<c:set var="mem_id" value="${mem_id}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${contextPath}/resources/css/defaultStyle.css">
<title>레시피 상세보기</title>
<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
	rel="stylesheet">
<!-- Bootstrap CSS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
/* ✅ 전체 기본 스타일 */
* {
    font-family: 'Noto Sans KR', sans-serif;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    background-color: #f4f4f4;
    color: #333;
}

.container {
    max-width: 1000px;
    margin: 50px auto;
    background-color: #fff;
    border-radius: 3px;
    padding: 40px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

/* ✅ 레시피 제목 영역 */
.recipe-top {
    text-align: center;
    font-size: 24px;
    font-weight: 700;
    color: #000;
    margin-bottom: 30px;
    position: relative;
    padding-bottom: 10px;
}

.recipe-top::after {
    content: "";
    display: block;
    width: 60px;
    height: 2px;
    background-color: #000;
    margin: 0 auto;
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
    bottom: 0;
}

/* ✅ 레시피 정보 */
.recipe-header {
    border-bottom: 1px solid #ddd;
    padding-bottom: 15px;
    margin-bottom: 30px;
}

.recipe-header h2 {
    font-size: 24px;
    font-weight: bold;
    color: #000;
}

.recipe-info span {
    font-size: 14px;
    color: #666;
    margin-right: 20px;
}

/* ✅ 레시피 본문 */
.recipe-content {
    line-height: 1.8;
    color: #333;
    min-height: 300px;
    margin-bottom: 40px;
}

/* ✅ 댓글 섹션 스타일 */
.comment-section {
    background-color: #fff;
    border-radius: 8px;
    padding: 20px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

/* ✅ 댓글 개별 박스 */
.comment {
    display: flex;
    padding: 15px;
    border-bottom: 1px solid #eee;
    align-items: flex-start;
}

.comment:last-child {
    border-bottom: none;
}

/* ✅ 프로필 이미지 */
.comment .comment-avatar {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    margin-right: 10px;
}

/* ✅ 댓글 내용 */
.comment .comment-content {
    flex-grow: 1;
}

.comment .comment-header {
    font-weight: bold;
    color: #333;
}

.comment .comment-time {
    font-size: 12px;
    color: #777;
    margin-left: 5px;
}

.comment .comment-body {
    margin-top: 5px;
    color: #555;
}
.deleted-comment {
    color: #888;
    font-style: italic;
    font-size: 14px;
    text-align: left;
    margin: 10px 0;
}
/* ✅ 좋아요 & 답글 버튼 */
.comment .comment-actions {
    display: flex;
    gap: 10px;
    margin-top: 10px;
}

.comment .comment-actions button {
  border: none;
    background: none;
    cursor: pointer;
    font-size: 14px;
    display: flex;
    align-items: center;
    gap: 5px;
    color: #666;
    transition: color 0.2s ease-in-out;
}
/* ✅ 아이콘 기본 스타일 */
.comment-actions img {
    width: 18px;
    height: 18px;
    transition: transform 0.2s ease-in-out;
}

/* ✅ 버튼 hover 효과 */
.comment-actions button:hover img {
    transform: scale(1.1);
}
/* ✅ 클릭한 버튼 색상 변경 */
.liked {
    color: #007bff !important;
}

.liked img {
    filter: brightness(1.2) saturate(2);
}

.disliked {
    color: #ff3333 !important;
}

.disliked img {
    filter: brightness(1.2) contrast(1.2);
}
/* ✅ 좋아요 / 싫어요 */
.like-button, .dislike-button {
    display: flex;
    align-items: center;
    cursor: pointer;
}

.like-button span, .dislike-button span {
    margin-left: 5px;
    font-size: 14px;
    color: #666;
}

/* ✅ 답글 입력 폼 */
.reply-form {
    margin-left: 50px;
    margin-top: 10px;
}

.reply-form textarea {
    width: 100%;
    border: 1px solid #ddd;
    padding: 8px;
    border-radius: 5px;
    font-size: 14px;
	resize:none;    
}

.reply-form button {
    margin-top: 5px;
    background-color: #007bff;
    color: white;
    border: none;
    padding: 6px 12px;
    border-radius: 5px;
    cursor: pointer;
}

.reply-form button:hover {
    background-color: #0056b3;
}
/* ✅ 수정 입력 폼 스타일 (답글 입력 폼과 동일하게 적용) */
.edit-comment-form {
    margin-left: 50px;
    margin-top: 10px;
}

.edit-comment-form textarea {
    width: 100%;
    border: 1px solid #ddd;
    padding: 8px;
    border-radius: 5px;
    font-size: 14px;
    resize: none;
}

.edit-comment-form button {
    margin-top: 5px;
    background-color: #007bff;
    color: white;
    border: none;
    padding: 6px 12px;
    border-radius: 5px;
    cursor: pointer;
}

.edit-comment-form button:hover {
    background-color: #0056b3;
}
.comment-form {
    display: flex;
    align-items: center;
    background: #f9f9f9;
    padding: 10px;
    border-radius: 10px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    margin-top: 15px;
}

.comment-input-form {
    display: flex;
    flex-grow: 1;
    align-items: center;
    gap: 10px;
}

.comment-input-form textarea {
    flex-grow: 1;
    height: 40px;
    border: none;
    padding: 10px;
    font-size: 14px;
    border-radius: 5px;
    background: #f1f3f5;
    resize: none;
    transition: all 0.2s;
}
.comment-form-buttons {
    display: flex;
    gap: 5px;
}
/* ✅ 입력창 포커스 시 변경 */
.comment-input-form textarea:focus {
    background: #fff;
    border: 1px solid #007bff;
    outline: none;
}

/* ✅ 입력 버튼 스타일 */
.btn-submit,
.btn-photo,
.btn-emoji {
    background: none;
    border: none;
    font-size: 14px;
    cursor: pointer;
    margin-left: 10px;
    color: #007bff;
}

/* ✅ 등록 버튼 (비활성화) */
.btn-submit {
    color: #ccc;
    cursor: default;
}

/* ✅ 등록 버튼 (활성화) */
.btn-submit.active {
    color: #007bff;
    cursor: pointer;
}

/* ✅ 버튼 hover 효과 */
.btn-photo:hover,
.btn-emoji:hover,
.btn-submit.active:hover {
    text-decoration: underline;
}


/* ✅ 페이지네이션 (공지사항 & 댓글 공통 적용) */
/* ✅ 댓글 페이지네이션 스타일 */
/* 페이지네이션 */
.pagination {
	margin-top: 30px;
	justify-content: center;
}

.pagination .page-item .page-link {
	color: #000;
	border-radius: 0;
	margin: 0 5px;
	border: none;
}

.pagination .page-item.active .page-link {
	background-color: #333;
	color: #fff;
	border: none;
}



/* ✅ 버튼 중앙 정렬 */
.btn-container {
    text-align: center;
    margin-top: 30px;
    display: flex;
    justify-content: center;
    gap: 15px; /* 버튼 간 간격 */
}

/* ✅ 공통 버튼 스타일 */
.btn-custom {
    display: inline-block;
    border: 0.3px solid #ddd;
    border-radius: 3px;
    background-color: #fff;
    color: #000;
    font-size: 14px;
    padding: 10px 20px;
    text-decoration: none;
    cursor: pointer;
}

.recipe-images p {
    font-size: 20px; /* ✅ 글자 크기 키우기 */
    font-weight: bold; /* ✅ 글자 굵게 */
    color: #333; /* ✅ 글자 색상 변경 (필요 시) */
    margin-bottom: 10px; /* ✅ 이미지와의 간격 조정 */
}

   /* 하단 구분선 (필요 시) */
.divider {
     margin: 40px 0;
	 border-top: 1px solid #ccc;
}
        
        
.btn-custom:hover {
    background-color: #f0f0f0;
    color: #000 !important;
    text-decoration: none;
    box-shadow: 0px 0px 1px 0px #fff; 
    border-radius: 3px;
}
.recipe-image {
    display: block; /* ✅ 블록 요소로 변경 */
    width: 60%;  ✅ 너비 조절 (필요에 따라 변경 가능) 
    max-width: 300px; /* ✅ 최대 너비 설정 */
    height: auto; /* ✅ 원본 비율 유지 */
    border-radius: 5px; /* ✅ 모서리 둥글게 (선택 사항) */
}
/* ✅ 상품 정보 카드 스타일 (공백 최소화) */
/* ✅ 상품 정보 카드 스타일 (공백 최소화) */
.product-card {
    display: flex;
    align-items: center;
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    padding: 8px 12px;  /* ✅ 패딩 조정 (기존 10px → 8px 12px) */
    cursor: pointer;
    transition: all 0.2s ease-in-out;
    width: 100%;  /* ✅ 전체 너비 사용 */
    margin: 5px auto; /* ✅ 좌우 여백 최소화 */
}

/* ✅ 마우스 호버 효과 */
.product-card:hover {
    transform: scale(1.02);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

/* ✅ 상품 이미지 */
.product-image img {
    width: 60px;  /* ✅ 크기 줄이기 (기존 70px → 60px) */
    height: 60px;
    object-fit: cover;
    border-radius: 5px;
    margin-right: 8px; /* ✅ 오른쪽 마진 줄이기 */
}

/* ✅ 상품 정보 */
.product-info {
    flex-grow: 1;
    display: flex;
    flex-direction: column;
    gap: 2px; /* ✅ 요소 간격 최소화 */
}

/* ✅ 상품명 */
.product-name {
    font-size: 15px; /* ✅ 글자 크기 소폭 감소 */
    font-weight: bold;
    color: #333;
    margin-bottom: 3px; /* ✅ 간격 최소화 */
}

/* ✅ 가격 스타일 */
.product-price {
    font-size: 16px;
    color: #555;
}

/* ✅ 할인가격 강조 */
.sale-price {
    font-size: 20px;
    font-weight: bold;
    color: #28a745;
    margin-right: 4px;
}

/* ✅ 원래 가격 (할인 전 가격, 취소선 추가) */
.original-price {
    font-size: 16px;
    color: #999;
    text-decoration: line-through;
}

/* ✅ 재고 정보 */
.product-stock {
    font-size: 12px;
    color: #666;
}

.reply-comment {
    margin-left: 40px;       /* 부모 댓글보다 들여쓰기 */
    border-left: 2px solid #ddd; /* 좌측 구분선 */
    padding-left: 10px;      /* 구분선과 내용 사이 간격 */
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript">


$(document).ready(function () {
    console.log("페이지 로드 완료");
	const contextPath = "${contextPath}";
	const recipeNo = "${recipe.recipe_no}" ? parseInt("${recipe.recipe_no}") : null; // ✅ Null 체크 추가
	const loggedInUser = "${mem_id}"; // ✅ 로그인 사용자 ID
    // 댓글 입력 폼 제출 시 AJAX 요청 처리
    $(".comment-input-form").submit(function (event) {
        event.preventDefault(); // ✅ 기본 제출 방지 (페이지 이동 방지)

        let commentContent = $("#commentInput").val().trim();
        if (!commentContent) {
            alert("댓글을 입력하세요!");
            return;
        }

        $.ajax({
            type: "POST",
            url: contextPath + "/recipe/addComment.do",
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            data: {
                recipe_no: recipeNo,
                mem_id: loggedInUser,
                comment_content: commentContent
            },
            success: function (response) {
                if (response.success) {
					alert("댓글 작성을 완료했습니다.");
                    $("#commentInput").val(""); // 입력창 초기화
                    addCommentToList(response); // 댓글 추가
                    location.reload();
                } else {
                    alert(response.message); // 실패 이유 출력
                }
            },
            error: function (xhr) {
                alert("서버 오류 발생! 상태 코드: " + xhr.status);
            }
        });
    });
	


    /** ✅ 댓글 수정 버튼 클릭 이벤트 */
$(document).on("click", ".edit-comment-btn", function () {
    let commentNo = $(this).attr("data-comment-no");  // `.data()` 대신 `.attr()` 사용
    console.log("수정 버튼 클릭 - commentNo:", commentNo); // 🔹 값 확인용

    let editForm = $("#edit-form-" + commentNo);
    let commentText = $("#comment-text-" + commentNo);

    console.log("찾은 수정 폼:", editForm.length); // 🔹 찾은 폼 개수 확인

    if (editForm.length === 0 || commentText.length === 0) {
        alert(`수정할 댓글(${commentNo})을 찾을 수 없습니다.`);
        return;
    }

    commentText.hide();
    editForm.show();
});

    const isLogOn = "${isLogOn}" === "true"; // JSP에서 로그인 여부 가져오기
// ✅ 댓글 수정 저장 버튼 클릭
$(document).on("click", ".save-edit-btn", function () {
    let commentNo = $(this).attr("data-comment-no"); // `.data()` → `.attr()`
    let updatedContent = $("#edit-textarea-" + commentNo).val().trim();
    if (!updatedContent) {
        alert("댓글 내용을 입력하세요.");
        return;
    }

    $.ajax({
        type: "POST",
        url: contextPath + "/recipe/modComment.do",
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        data: {
            comment_no: commentNo,
            comment_content: updatedContent
        },
        success: function (response) {
            if (response.success) {
                alert("댓글 수정 완료!");
                $("#comment-text-" + commentNo).text(updatedContent).show();
                $("#edit-form-" + commentNo).hide();
            } else {
                alert("댓글 수정 실패!");
            }
        },
        error: function () {
            alert("서버 오류 발생! 댓글을 수정할 수 없습니다.");
        }
    });
});

    /** ✅ 답글 폼 토글 (보이기/숨기기) */
 $(document).on("click", ".reply-btn", function () {
    if (!isLogOn) { 
        alert("로그인 후 이용하세요.");
        return;
    }

    let commentNo = $(this).attr("data-comment-no");  
    let replyForm = $("#reply-form-" + commentNo);  

    if (replyForm.length === 0) {
        alert(`해당 댓글(${commentNo})의 답글 입력 폼을 찾을 수 없습니다.`);
        return;
    }

    replyForm.toggle();
});

    
 $(document).on("click", ".cancel-edit-btn", function () {
	    let commentNo = $(this).attr("data-comment-no"); // `.data()` 대신 `.attr()` 사용

	    let editForm = $("#edit-form-" + commentNo);
	    let commentText = $("#comment-text-" + commentNo);

	    if (editForm.length === 0 || commentText.length === 0) {
	        alert("취소할 댓글을 찾을 수 없습니다.");
	        return;
	    }

	    editForm.hide(); // 수정 폼 숨기기
	    commentText.show(); // 기존 댓글 다시 표시
	});


 // ✅ 답글 작성 AJAX 요청
$(document).on("click", ".submit-reply-btn", function () {
    if (!isLogOn) { 
        alert("로그인 후 이용하세요.");
        return;
    }

    let commentNo = $(this).attr("data-comment-no"); 
    let replyContent = $("#reply-text-" + commentNo).val().trim();

    if (!replyContent) {
        alert("답글을 입력하세요!");
        return;
    }

    $.ajax({
        type: "POST",
        url: contextPath + "/recipe/addReplyComment.do",
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        data: {
            parent_comment_no: commentNo,  
            comment_content: replyContent,
            recipe_no: recipeNo
        },
        success: function (response) {
            if (response.success) {
                alert("답글 작성 완료!");
                $("#reply-text-" + commentNo).val("");
                $("#reply-form-" + commentNo).hide();
                location.reload();
            } else {
                alert(response.message || "답글 작성 실패!");
            }
        },
        error: function () {
            alert("서버 오류 발생! 답글을 등록할 수 없습니다.");
        }
    });
});


        // ✅ 좋아요 버튼 클릭 이벤트
        $(".like-button").click(function () {
            let commentNo = $(this).data("comment-no");
            handleLikeDislike(commentNo, "like");
        });

        // ✅ 싫어요 버튼 클릭 이벤트
        $(".dislike-button").click(function () {
            let commentNo = $(this).data("comment-no");
            handleLikeDislike(commentNo, "dislike");
        });

        // ✅ 좋아요/싫어요 처리 함수
        function handleLikeDislike(commentNo, action) {
            let confirmMessage = action === "like" ? "이 댓글을 추천하시겠습니까?" : "이 댓글을 비추천하시겠습니까?";
            let successMessage = action === "like" ? "추천 완료!" : "비추천 완료!";

            // ✅ 쿠키 확인하여 중복 방지
            let voteStatus = getCookie("vote_" + commentNo);
            if (voteStatus) {
                alert("이미 " + (voteStatus === "like" ? "추천" : "비추천") + "하셨습니다.");
                return;
            }

            if (!confirm(confirmMessage)) return;

            $.ajax({
                type: "POST",
                url: contextPath + "/recipe/updateComment.do",
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                data: { comment_no: commentNo, action: action },
                success: function (response) {
                    if (response.success) {
                        // ✅ 추천/비추천 개수 업데이트
                        $("#like-count-" + commentNo).text(response.likeCount);
                        $("#dislike-count-" + commentNo).text(response.dislikeCount);
                        $("#ratio-" + commentNo).text(response.ratio.toFixed(2) + "%");
                        setCookie("vote_" + commentNo, action, 30);
                        // ✅ 버튼 색상 변경
                        updateButtonStyles(commentNo, action);
                    } else {
                        alert(response.message);
                    }
                },
                error: function () {
                    alert("서버 오류 발생! 다시 시도해 주세요.");
                }
            });
        }

        // ✅ 쿠키 가져오기 함수
        function getCookie(name) {
            let decodedCookie = decodeURIComponent(document.cookie);
            let cookies = decodedCookie.split(';');
            for (let i = 0; i < cookies.length; i++) {
                let c = cookies[i].trim();
                if (c.indexOf(name + "=") === 0) {
                    return c.substring(name.length + 1);
                }
            }
            return "";
        }

        // ✅ 쿠키 설정 함수
        function setCookie(name, value, days) {
            let date = new Date();
            date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
            let expires = "expires=" + date.toUTCString();
            document.cookie = name + "=" + value + ";" + expires + ";path=/";
        }

        $(".like-button, .dislike-button").each(function () {
            let commentNo = $(this).data("comment-no");
            let voteStatus = getCookie("vote_" + commentNo);

            if (voteStatus === "like") {
                updateButtonStyles(commentNo, "like");
            } else if (voteStatus === "dislike") {
                updateButtonStyles(commentNo, "dislike");
            }
        });

        function updateButtonStyles(commentNo, action) {
            let likeBtn = $("#like-btn-" + commentNo).find("svg path");
            let dislikeBtn = $("#dislike-btn-" + commentNo).find("svg path");

            if (action === "like") {
                likeBtn.css("fill", "#007bff");  // ✅ 파란색 (추천)
                dislikeBtn.css("fill", "gray");  // ✅ 기본 색상
            } else if (action === "dislike") {
                likeBtn.css("fill", "gray");  // ✅ 기본 색상
                dislikeBtn.css("fill", "#dc3545");  // ✅ 빨간색 (비추천)
            }
        }
    
    
        
        
   

}); /*document.ready  */

function editComment(commentNo) {
    console.log("Editing commentNo:", commentNo); // ✅ 디버깅용 콘솔 출력
    const editForm = document.getElementById(`edit-form-${commentNo}`);
    const commentText = document.getElementById(`comment-text-${commentNo}`);

    // ✅ 요소가 존재하는지 확인 후 실행
    if (!editForm || !commentText) {
        alert("수정할 댓글을 찾을 수 없습니다.");
        return;
    }

    commentText.style.display = "none";
    editForm.style.display = "block";
}
function showReplyForm(commentNo) {
    const replyForm = document.getElementById(`reply-form-${commentNo}`);

    // ✅ 요소가 존재하는지 확인 후 실행
    if (!replyForm) {
        alert("해당 댓글의 답글 입력 폼을 찾을 수 없습니다.");
        return;
    }

    replyForm.style.display = replyForm.style.display === "none" ? "block" : "none";
}


function showReplyForm(commentNo) {
    const replyForm = document.getElementById(`reply-form-${commentNo}`);

    // ✅ 요소가 존재하는지 확인 후 실행
    if (!replyForm) {
        alert("해당 댓글의 답글 입력 폼을 찾을 수 없습니다.");
        return;
    }

    replyForm.style.display = replyForm.style.display === "none" ? "block" : "none";
}

function submitReply(commentNo) {

    const replyContent = document.querySelector(`#reply-form-${commentNo} textarea`).value;
    if (!replyContent) {
        alert("답글을 입력하세요!");
        return;
    }
    
    console.log(commentNo);
    console.log(replyContent);
    console.log(recipeNo);
    console.log(loggedInUser);
    $.ajax({
        type: "POST",
        url: contextPath+"/recipe/addReplyComment.do",
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        data: JSON.stringify({
            parent_comment_no: commentNo,
            comment_content: replyContent,
            recipe_no: recipeNo,
            mem_id: loggedInUser
        }),
        dataType: "json",
        success: function (response) {
            if (response.success) {
                $("#reply-form-" + commentNo + " textarea").val(""); // 입력창 초기화
                $("#reply-form-" + commentNo).hide(); // 입력창 숨기기
                addCommentToList(response.comment);
            } else {
                alert("답글 작성에 실패했습니다.");
            }
        },
        error: function () {
            alert("서버 오류 발생! 답글을 등록할 수 없습니다.");
        }
    });
}
const contextPath = "${contextPath}";
	// ✅ 새로운 댓글을 리스트에 추가하는 함수
	 function addCommentToList(comment) {
        let commentHtml = `
            <div class="comment" id="comment-${comment.comment_no}">
                <div class="comment-content">
                    <div class="comment-header">
                        ${comment.mem_id}
                        <span class="comment-time">${comment.comment_writedate}</span>
                    </div>
        `;

        if (comment.comment_content === "삭제된 댓글입니다.") {
            commentHtml += `<div class="comment-body deleted-comment">삭제된 댓글입니다.</div>`;
        } else {
            commentHtml += `
                <div class="comment-body" id="comment-text-${comment.comment_no}">
                    ${comment.comment_content}
                </div>

                <div class="comment-actions">
                    <button id="like-btn-${comment.comment_no}" class="like-button" data-comment-no="${comment.comment_no}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="gray" class="bi bi-hand-thumbs-up-fill" viewBox="0 0 16 16">
                    <path d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a10 10 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733q.086.18.138.363c.077.27.113.567.113.856s-.036.586-.113.856c-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.2 3.2 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.8 4.8 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z"/>
                  </svg>
                        <span id="like-count-${comment.comment_no}">0</span>
                    </button>

                    <button id="dislike-btn-${comment.comment_no}" class="dislike-button" data-comment-no="${comment.comment_no}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="gray" class="bi bi-hand-thumbs-down-fill" viewBox="0 0 16 16">
                    <path d="M6.956 14.534c.065.936.952 1.659 1.908 1.42l.261-.065a1.38 1.38 0 0 0 1.012-.965c.22-.816.533-2.512.062-4.51q.205.03.443.051c.713.065 1.669.071 2.516-.211.518-.173.994-.68 1.2-1.272a1.9 1.9 0 0 0-.234-1.734c.058-.118.103-.242.138-.362.077-.27.113-.568.113-.856 0-.29-.036-.586-.113-.857a2 2 0 0 0-.16-.403c.169-.387.107-.82-.003-1.149a3.2 3.2 0 0 0-.488-.9c.054-.153.076-.313.076-.465a1.86 1.86 0 0 0-.253-.912C13.1.757 12.437.28 11.5.28H8c-.605 0-1.07.08-1.466.217a4.8 4.8 0 0 0-.97.485l-.048.029c-.504.308-.999.61-2.068.723C2.682 1.815 2 2.434 2 3.279v4c0 .851.685 1.433 1.357 1.616.849.232 1.574.787 2.132 1.41.56.626.914 1.28 1.039 1.638.199.575.356 1.54.428 2.591"/>
                  </svg>
                        <span id="dislike-count-${comment.comment_no}">0</span>
                    </button>

                    <button class="reply-btn" data-comment-no="${comment.comment_no}">답글쓰기</button>
                </div>

                <div id="reply-form-${comment.comment_no}" class="reply-form" style="display: none;">
                    <textarea id="reply-text-${comment.comment_no}" placeholder="답글을 입력하세요"></textarea>
                    <button class="submit-reply-btn" data-comment-no="${comment.comment_no}">답글 등록</button>
                </div>
            `;
        }

        commentHtml += `</div></div>`;

        $("#comment-list").prepend(commentHtml);
    }

		function deleteComment(commentNo) {
	    if (!confirm("정말 이 댓글을 삭제하시겠습니까?")) return;

	    $.ajax({
	        type: "POST",
	        url: contextPath + "/recipe/deleteComment.do",
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        data: { comment_no: commentNo },
	        success: function (response) {
	            if (response.success) {
	                alert("삭제되었습니다.");
	                location.reload(); // ✅ 페이지 새로고침하여 최신 상태 반영
	            } else {
	                alert("댓글 삭제에 실패했습니다.");
	            }
	        },
	        error: function () {
	            alert("서버 오류 발생! 댓글을 삭제할 수 없습니다.");
	        }
	    });
	}


		// 상품 상세 페이지 이동 함수
		function goToProductDetail(url) {
		    window.location.href = url;
		}
</script>
</head>
<body>

	<!-- 헤더 include -->
	<div class="header">
		<%@ include file="../common/header.jsp"%>
	</div>

	<div class="container">
		<!-- 상단 제목 -->
		<div class="recipe-top">RECIPE</div>

		<!-- 레시피 제목 -->
		<div class="recipe-header">
			<h2>${recipe.recipe_title}</h2>
			<div class="recipe-info">
				<span><strong>작성자:</strong> ${recipe.mem_id}</span> <span><strong>등록일:	 <fmt:formatDate value="${recipe.recipe_writedate}" pattern="yyyy.MM.dd" /></strong>
				
					</span> <span><strong>조회수:</strong> ${recipe.views}</span>
			</div>
		</div>
		
	<!-- ✅ 상품 정보 박스 (간략한 카드 형식) -->
<div class="product-card" onclick="goToProductDetail('${contextPath}/goods/goodsDetail.do?goods_id=${recipe.goods_id}')">
    <div class="product-image">
        <img src="${contextPath}/image.do?goods_id=${recipe.goods_id}&fileName=${recipe.fileName}" alt="${recipe.goods_name}" onerror="this.src='${contextPath}/resources/images/no_image.png';">
    </div>
    <div class="product-info">
        <p class="product-name">${recipe.goods_name}</p>
        <p class="product-price">
            <span class="original-price"><fmt:formatNumber value="${recipe.goods_price}" type="currency" currencySymbol="₩" /></span>
            <span class="sale-price"><fmt:formatNumber value="${recipe.goods_sales_price}" type="currency" currencySymbol="₩" /></span>
        </p>
        <p class="product-stock">재고: ${recipe.goods_stock}개</p>
    </div>
</div>
		<!-- 레시피 내용 -->
		<div class="recipe-content">
		
			<p>${recipe.recipe_content}</p>
		</div>


	

<div class="recipe-images">
	<p>image</p>
	<div class="divider"></div>
    <c:if test="${not empty recipeImages}">
        <c:forEach var="image" items="${recipeImages}">
            <img src="${contextPath}/base/getImage.do?fileName=${image.fileName}&filePath=${filePath}" 
                 alt="레시피 이미지" class="recipe-image">
        </c:forEach>
    </c:if>
    <c:if test="${empty recipeImages}">
        <p>이미지가 없습니다.</p>
    </c:if>
</div>




	<!-- 댓글 섹션 -->
<div class="comment-section">
    <h4>댓글 ${toComments}개</h4>


  <!-- ✅ 댓글 리스트 -->
<div id="comment-list">
    <c:choose>
        <c:when test="${not empty commentsList}">
            <c:forEach var="comment" items="${commentsList}">
                <c:if test="${comment.parent_comment_no == 0}">
                    <div class="comment" id="comment-${comment.comment_no}">
                        <img class="comment-avatar" src="${contextPath}/resources/images/person-fill.svg" alt="User">
                        <div class="comment-content">
                            <div class="comment-header">
                                ${comment.mem_id}
                                <span class="comment-time">
                                    <fmt:formatDate value="${comment.comment_writedate}" pattern="yyyy-MM-dd HH:mm"/>
                                </span>
                            </div>
                            <div class="comment-body" id="comment-text-${comment.comment_no}">
                                ${comment.comment_content}
                            </div>

                            <!-- ✅ 기존 SVG 포함한 액션 버튼 유지 -->
                            <div class="comment-actions">
                                <button id="like-btn-${comment.comment_no}" class="like-button" data-comment-no="${comment.comment_no}">
                                       <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="gray" class="bi bi-hand-thumbs-up-fill" viewBox="0 0 16 16">
  <path d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a10 10 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733q.086.18.138.363c.077.27.113.567.113.856s-.036.586-.113.856c-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.2 3.2 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.8 4.8 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z"/>
</svg>
                                    <span id="like-count-${comment.comment_no}">${comment.comment_like}</span>
                                </button>
                                <button id="dislike-btn-${comment.comment_no}" class="dislike-button" data-comment-no="${comment.comment_no}">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="gray" class="bi bi-hand-thumbs-down-fill" viewBox="0 0 16 16">
  <path d="M6.956 14.534c.065.936.952 1.659 1.908 1.42l.261-.065a1.38 1.38 0 0 0 1.012-.965c.22-.816.533-2.512.062-4.51q.205.03.443.051c.713.065 1.669.071 2.516-.211.518-.173.994-.68 1.2-1.272a1.9 1.9 0 0 0-.234-1.734c.058-.118.103-.242.138-.362.077-.27.113-.568.113-.856 0-.29-.036-.586-.113-.857a2 2 0 0 0-.16-.403c.169-.387.107-.82-.003-1.149a3.2 3.2 0 0 0-.488-.9c.054-.153.076-.313.076-.465a1.86 1.86 0 0 0-.253-.912C13.1.757 12.437.28 11.5.28H8c-.605 0-1.07.08-1.466.217a4.8 4.8 0 0 0-.97.485l-.048.029c-.504.308-.999.61-2.068.723C2.682 1.815 2 2.434 2 3.279v4c0 .851.685 1.433 1.357 1.616.849.232 1.574.787 2.132 1.41.56.626.914 1.28 1.039 1.638.199.575.356 1.54.428 2.591"/>
</svg>
                                    <span id="dislike-count-${comment.comment_no}">${comment.comment_dislike}</span>
                                </button>
                                <button class="reply-btn" data-comment-no="${comment.comment_no}">답글쓰기</button>
                                <c:if test="${mem_id eq comment.mem_id}">
                                    <button class="edit-comment-btn" data-comment-no="${comment.comment_no}">수정</button>
                                    <button class="delete-comment-btn" onclick="deleteComment(${comment.comment_no})">삭제</button>
                                </c:if>
                            </div>

                            <!--  댓글 수정 폼 (숨김) -->
                            <div class="edit-comment-form" id="edit-form-${comment.comment_no}" style="display:none;">
                                <textarea id="edit-textarea-${comment.comment_no}" class="edit-textarea">${comment.comment_content}</textarea>
                                <button class="save-edit-btn" data-comment-no="${comment.comment_no}">저장</button>
                                <button class="cancel-edit-btn" data-comment-no="${comment.comment_no}">취소</button>
                            </div>
                        </div>
                    </div>

                    <!--  부모 댓글 아래 답글 정렬 -->
                    <div id="reply-container-${comment.comment_no}" class="reply-container">
                        <c:forEach var="reply" items="${commentsList}">
                            <c:if test="${reply.parent_comment_no == comment.comment_no}">
                                <div class="comment reply-comment" id="comment-${reply.comment_no}">
                                    <img class="comment-avatar" src="${contextPath}/resources/images/person-fill.svg" alt="User">
                                    <div class="comment-content">
                                        <div class="comment-header">
                                            ${reply.mem_id}
                                            <span class="comment-time">
                                                <fmt:formatDate value="${reply.comment_writedate}" pattern="yyyy-MM-dd HH:mm"/>
                                            </span>
                                        </div>
                                        <div class="comment-body" id="comment-text-${reply.comment_no}">
                                            ${reply.comment_content}
                                        </div>

                                        <div class="comment-actions">
                                            <button id="like-btn-${reply.comment_no}" class="like-button" data-comment-no="${reply.comment_no}">
                                                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="gray" class="bi bi-hand-thumbs-up-fill" viewBox="0 0 16 16">
												  <path d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a10 10 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733q.086.18.138.363c.077.27.113.567.113.856s-.036.586-.113.856c-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.2 3.2 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.8 4.8 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z"/>
												</svg>
                                                <span id="like-count-${reply.comment_no}">${reply.comment_like}</span>
                                            </button>
                                            <button id="dislike-btn-${reply.comment_no}" class="dislike-button" data-comment-no="${reply.comment_no}">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="gray" class="bi bi-hand-thumbs-down-fill" viewBox="0 0 16 16">
												  <path d="M6.956 14.534c.065.936.952 1.659 1.908 1.42l.261-.065a1.38 1.38 0 0 0 1.012-.965c.22-.816.533-2.512.062-4.51q.205.03.443.051c.713.065 1.669.071 2.516-.211.518-.173.994-.68 1.2-1.272a1.9 1.9 0 0 0-.234-1.734c.058-.118.103-.242.138-.362.077-.27.113-.568.113-.856 0-.29-.036-.586-.113-.857a2 2 0 0 0-.16-.403c.169-.387.107-.82-.003-1.149a3.2 3.2 0 0 0-.488-.9c.054-.153.076-.313.076-.465a1.86 1.86 0 0 0-.253-.912C13.1.757 12.437.28 11.5.28H8c-.605 0-1.07.08-1.466.217a4.8 4.8 0 0 0-.97.485l-.048.029c-.504.308-.999.61-2.068.723C2.682 1.815 2 2.434 2 3.279v4c0 .851.685 1.433 1.357 1.616.849.232 1.574.787 2.132 1.41.56.626.914 1.28 1.039 1.638.199.575.356 1.54.428 2.591"/>
												</svg>
                                                <span id="dislike-count-${reply.comment_no}">${reply.comment_dislike}</span>
                                            </button>
                                            <c:if test="${mem_id eq reply.mem_id}">
                                                <button class="edit-comment-btn" data-comment-no="${reply.comment_no}">수정</button>
                                                <button class="delete-comment-btn" onclick="deleteComment(${reply.comment_no})">삭제</button>
                                            </c:if>
                                        </div>

                                        <!-- ✅ 답글 수정 폼 (숨김) -->
                                        <div class="edit-comment-form" id="edit-form-${reply.comment_no}" style="display:none;">
                                            <textarea id="edit-textarea-${reply.comment_no}" class="edit-textarea">${reply.comment_content}</textarea>
                                            <button class="save-edit-btn" data-comment-no="${reply.comment_no}">저장</button>
                                            <button class="cancel-edit-btn" data-comment-no="${reply.comment_no}">취소</button>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>

                        <!-- ✅ 답글 입력 폼 -->
                        <div id="reply-form-${comment.comment_no}" class="reply-form" style="display: none;">
                            <textarea id="reply-text-${comment.comment_no}" placeholder="답글을 입력하세요"></textarea>
                            <button class="submit-reply-btn" data-comment-no="${comment.comment_no}">답글 등록</button>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </c:when>

        <c:otherwise>
            <p class="no-comments">댓글이 없습니다.</p>
        </c:otherwise>
    </c:choose>
</div>


    <c:set var="totalPages" value="${(toComments + 9) / 10}" />
<c:set var="totalPages" value="${totalPages < 1 ? 1 : totalPages}" />

<!-- ✅ 페이지네이션 (댓글이 있을 경우에만 표시) -->
<nav aria-label="Page navigation">
        <ul class="pagination">
            <c:if test="${toComments != null}">
                <c:forEach var="page" begin="1" end="10" step="1">
                    <c:if test="${section > 1 && page == 1}">
                        <li class="page-item"><a class="page-link" href="${contextPath}/recipe/viewRecipe.do?recipe_no=${recipe.recipe_no}&section=${section-1}&pageNum=${(section-1)*10 +1 }">&laquo;</a></li>
                    </c:if>
                    <li class="page-item"><a class="page-link" href="${contextPath}/recipe/viewRecipe.do?recipe_no=${recipe.recipe_no}&section=${section}&pageNum=${page}">${(section-1)*10 +page }</a></li>
                    <c:if test="${page == 10}">
                        <li class="page-item"><a class="page-link" href="${contextPath }/recipe/viewRecipe.do?recipe_no=${recipe.recipe_no}&section=${section+1}&pageNum=${section*10+1}">&raquo;</a></li>
                    </c:if>
                </c:forEach>
            </c:if>
        </ul>
    </nav>

    <!-- ✅ 댓글 입력 폼 -->
    <div class="comment-form">
        <c:if test="${isLogOn}">
            <img class="comment-avatar" src="${contextPath}/resources/images/person-fill.svg" alt="User">
            <form action="${contextPath}/recipe/addComment.do" method="post" class="comment-input-form">
                <textarea id="commentInput" name="comment_content" placeholder="댓글을 입력하세요..." required></textarea>
                <div class="comment-form-buttons">
                    <button type="button" class="btn-photo">📷</button>
                    <button type="button" class="btn-emoji">😊</button>
                    <button type="submit" id="submitBtn" class="btn-submit">등록</button>
                </div>
            </form>
        </c:if>

        <c:if test="${!isLogOn}">
            <p>댓글을 작성하려면 <a href="${contextPath}/member/loginForm.do">로그인</a>하세요.</p>
        </c:if>
    </div>
</div>



</div>


		<!-- 버튼 -->
		<div class="btn-container">
		
		<!-- ✅ 수정 & 삭제 버튼 (작성자이거나 관리자만 표시) -->
<c:if test="${mem_id eq recipe.mem_id or sessionScope.member.mem_grade eq 'admin'}">
        <a href="${contextPath}/recipe/editRecipe.do?recipe_no=${recipe.recipe_no}" class="btn-custom">수정</a> 
        <a href="${contextPath}/recipe/deleteRecipe.do?recipe_no=${recipe.recipe_no}" class="btn-custom" 
           onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
</c:if>
		
			<a href="${contextPath}/recipe/recipeLists.do" class="btn-custom">목록</a>
		</div>

	<!-- 푸터 include -->
	<div class="footer">
		<%@ include file="../common/footer.jsp"%>
	</div>

</body>
</html>