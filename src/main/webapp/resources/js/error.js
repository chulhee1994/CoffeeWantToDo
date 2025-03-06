function handleErrorResponse(response) {
    console.log(response);

    // 서버 응답에서 errorCode와 errorMessage를 안전하게 처리
    var errorCode = response.errorCode || '알 수 없는 오류';
    var errorMessage = response.errorMessage || '예기치 않은 오류가 발생했습니다.';

    // 에러 상태에 맞는 에러 페이지로 리다이렉트
    window.location.href = contextPath + "/common/error/errorForm.do";
}

$(document).ajaxError(function(event, xhr) {
    try {
        // 서버 응답에서 JSON을 파싱하여 handleErrorResponse에 전달
        var response = JSON.parse(xhr.responseText);
        handleErrorResponse(response);  // 오류 상태에 맞게 리다이렉트 처리
    } catch (e) {
        // JSON 파싱 실패 시 기본적인 오류 처리
        console.error('응답 본문 파싱 오류:', e);
        alert("알 수 없는 오류가 발생했습니다.");
        window.location.href = contextPath + "/common/error/errorForm.do";  // 여기서 다시 리다이렉트
    }
});
