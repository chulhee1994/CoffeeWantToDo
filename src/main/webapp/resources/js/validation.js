// check 함수
function check(regExp, e, msg) {
    if (regExp.test(e.value)) {
        return true;
    }
    alert(msg);
    e.focus();
    return false;
}

	

//추가 배송지 수정
function check_modAddress() {
	//----------공란 방지--------------//
    // 배송지 이름
    var address_name = document.getElementById("address_name");
    if (!check(/.+/, address_name, "배송지 이름을 입력해주세요.")) {
        return false;
    }

    // 우편번호
    var mem_zipcode = document.getElementById("mem_zipcode");
    if (!check(/.+/, mem_zipcode, "우편 번호를 입력해주세요.")) {
        return false;
    }

    // 도로명 주소
    var mem_add1 = document.getElementById("mem_add1");
    if (!check(/.+/, mem_add1, "도로명 주소를 입력해주세요.")) {
        return false;
    }

    // 지번 주소
    var mem_add2 = document.getElementById("mem_add2");
    if (!check(/.+/, mem_add2, "지번 주소를 입력해주세요.")) {
        return false;
    }

    // 나머지 주소
    var mem_add3 = document.getElementById("mem_add3");
    if (!check(/.+/, mem_add3, "나머지 주소를 입력해주세요.")) {
        return false;
    }
	//----------공란 방지--------------//
}


