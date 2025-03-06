// 카카오 SDK 초기화
window.Kakao.init('8e2e67e2fb755f4cf764efadc8cefdfa'); // 카카오 REST API 키 입력

// 카카오 로그인진행
function fnKakaoLoginCheck() {
    Kakao.Auth.login({
        success: function (res) {
	        Kakao.API.request({
	            url: '/v2/user/me',
	            data: {
	                property_keys: ['id', 'properties.nickname', 'kakao_account.email'],
	            },
	            success: function (res) {
	                fnKakaoLogin(res);
	                console.log(res);
	                const token = Kakao.Auth.getAccessToken(); // 카카오 접근 토큰 가져오기
	                Kakao.Auth.setAccessToken(token);			// 토큰 설정
	                console.log("token: " + token);
	            },
	
	            fail: function (error) {
	                // 카카오 로그인 실패 시 alert 창
	                alert('카카오 로그인에 실패하였습니다.');
	            }
	        });
        },
        fail: function (error) {
            //location.href=contextPath+"/member/loginPage.do";
        }
    });
} // loginWithKakao

// 카카오 로그인 실행
function fnKakaoLogin(res){
    const kakao_kakaoId = res.id; // 카카오 email
    const kakao_email = res.kakao_account.email; // 카카오 닉네임(이름)
    const kakao_name = res.properties.nickname; 

    $.ajax({
            type : 'POST',
            url : contextPath+'/member/kakaoLogin.do',
            data : {
                "kakao_kakaoId" : kakao_kakaoId,
                "kakao_email" : kakao_email,
                "kakao_name" : kakao_name
                },
            dataType : 'text',
            success : function(result){
                console.log("result : " + result)
                console.log("kakaoId : " + kakao_kakaoId)

                if(result == "success"){
			        Kakao.API.request({
			            url: '/v1/user/unlink',
			            data: {},
			            success: function (res) {
			                console.log(res);
			            },
			            fail: function (error) {
			            }
			        });
                	// 로그인 성공
                    alert("카카오톡으로 로그인을 시작합니다.");
                    location.href = contextPath + "/";
                } else if(result == "fail"){
                	// 로그인 실패
                    var isJoin = confirm("가입된 정보가 없습니다.\n회원가입을 하시겠습니까?");
                    if(isJoin){
	                    let memberForm = $('<form></form>');
	                    memberForm.attr('action',contextPath + "/member/kakaoForm.do");
	                    memberForm.append('<input type="hidden" name="mem_id" value="'+kakao_email+'">');
	                    memberForm.append('<input type="hidden" name="mem_pwd" value="'+kakao_email+'">');
	                    
	                    memberForm.appendTo(document.body);
	                    memberForm.submit();
	                    memberForm.remove();
                    }
                } else {
                    alert("로그인에 실패했습니다");
                }
            }, // success
            error: function(xhr, status, error){
                alert("로그인에 실패했습니다." + error);
            }
        }) // ajax
}; // kakaoLoginPro