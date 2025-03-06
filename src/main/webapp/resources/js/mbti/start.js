// DOM 요소들 선택
const main = document.querySelector("#main");  // 메인 화면
const question = document.querySelector("#question");  // 질문 화면
const result = document.querySelector("#result");  // 결과 화면

const endPoint = 16;  // 총 질문 개수 (최종 질문까지 진행)
const select = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];  // 선택한 각 MBTI 유형의 점수 (0부터 시작)

// MBTI 결과 계산 함수
function calResult(){
  console.log(select);  // 선택한 값들 출력 (디버깅용)
  var result = select.indexOf(Math.max(...select));  // 가장 큰 값을 가지는 인덱스를 찾음 (가장 많이 선택된 MBTI 유형)
  return result;
}

// 결과 화면을 세팅하는 함수
function setResult() {
    let point = calResult();  // 결과 계산
    const resultName = document.querySelector('.resultname');  // 결과 이름을 표시할 DOM 요소
    resultName.innerHTML = infoList[point].name;  // MBTI 결과 이름 설정

    var resultImg = document.createElement('img');  // 결과 이미지 요소 생성
    const imgDiv = document.querySelector('#resultImg');  // 이미지가 들어갈 div 요소
    var imgURL = contextPath + '/resources/images/image-' + point + '.jpg';  // 이미지 URL 생성
    resultImg.src = imgURL;  // 이미지 소스 설정
    resultImg.classList.add('img-fluid');  // 부트스트랩 클래스 추가 (반응형 이미지)
    imgDiv.appendChild(resultImg);  // 이미지 div에 추가

    const resultDesc = document.querySelector('.resultDesc');  // 결과 설명을 표시할 DOM 요소
    resultDesc.innerHTML = infoList[point].desc;  // MBTI 결과 설명 설정

    // 상품 정보 요청 (fetch 사용)
    fetch(`${contextPath}/goods/mbti.do?mbti=${infoList[point].mbti}`, {
    method: 'POST', // POST 메소드 사용
    headers: {
        'Content-Type': 'application/json'
    }
})
.then(response => response.json())  // JSON 형식으로 응답 받기
.then(data => {
    console.log(data);  // 데이터 확인 (디버깅용)
    
    // #goods 내의 기존 카드들을 비우고 새로 추가
    const goodsContainer = document.querySelector("#goods");
    goodsContainer.innerHTML = '';  // 기존 상품 카드들 제거

    if (data.length > 0) {  // 상품 데이터가 있을 경우
        data.forEach(product => {  // 각 상품에 대해 처리
            const productDiv = document.createElement('div');  // 상품 카드 div 생성
            productDiv.classList.add('card', 'product');  // 상품 카드를 위한 클래스 추가

            const link = document.createElement('a');  // 상품 상세 페이지로 이동할 링크 생성
            link.href = `${contextPath}/goods/goodsDetail.do?goods_id=${product.goods_id}`;  // 상품 상세 페이지 URL
            link.classList.add('product-link');  // 링크 클래스 추가
            
            const img = document.createElement('img');  // 상품 이미지 요소 생성
            const imageURL = `${contextPath}/mbti/image.do?goods_id=${product.goods_id}&fileName=${encodeURIComponent(product.fileName)}`;  // 상품 이미지 URL
            img.src = imageURL;  // 이미지 소스 설정
            img.classList.add('product-img');  // 이미지 클래스 추가
            
            link.appendChild(img);  // a 태그 안에 이미지를 넣기

            const goodsName = document.createElement('h3');  // 상품 이름 요소 생성
            goodsName.innerHTML = product.goods_name || '상품 이름 없음';  // 상품 이름 설정 (없으면 기본 텍스트)
            goodsName.classList.add('card-title');  // 상품 이름 클래스 추가

            const goodsPrice = document.createElement('p');  // 상품 가격 요소 생성
            goodsPrice.innerHTML = product.goods_price ? `${product.goods_price}원` : '가격 미제공';  // 상품 가격 설정 (없으면 기본 텍스트)
            goodsPrice.classList.add('price');  // 가격 클래스 추가

            const goodsDetail = document.createElement('p');  // 상품 상세 설명 요소 생성
            goodsDetail.innerHTML = product.goods_c_det_note || '상세 설명 없음';  // 상품 설명 설정 (없으면 기본 텍스트)
            goodsDetail.classList.add('card-text');  // 설명 클래스 추가

            const cardBody = document.createElement('div');  // 카드 본문 div 생성
            cardBody.classList.add('card-body');  // 카드 본문 클래스 추가
            cardBody.appendChild(goodsName);  // 상품 이름 추가
            cardBody.appendChild(goodsPrice);  // 가격 추가
            cardBody.appendChild(goodsDetail);  // 상세 설명 추가

            productDiv.appendChild(link);  // 링크 (이미지 포함) 추가
            productDiv.appendChild(cardBody);  // 카드 본문 추가

            goodsContainer.appendChild(productDiv);  // 상품 div를 최상위 div에 추가
        });
    } else {
        // 데이터가 없을 경우, 표시할 메시지 추가
        goodsContainer.innerHTML = '<p>검색된 상품이 없습니다.</p>';
    }
})
.catch(error => {
    console.error('오류 발생:', error);  // 오류 발생 시 콘솔에 출력
});
}

// 결과 화면으로 이동하는 함수
function goResult(){
  question.style.WebkitAnimation = "fadeout 1s";  // 질문 화면 fadeout 애니메이션
  question.style.animation = "fadeout 1s";  // 질문 화면 fadeout 애니메이션
  setTimeout(() => {
    result.style.WebkitAnimation = "fadein 1s";  // 결과 화면 fadein 애니메이션
    result.style.animation = "fadein 1s";  // 결과 화면 fadein 애니메이션
    setTimeout(() => {
      question.style.display = "none";  // 질문 화면 숨기기
      result.style.display = "block"  // 결과 화면 보이기
    }, 450)});  // 애니메이션이 끝난 후 실행
    setResult();  // 결과 세팅 함수 호출
}

// 사용자가 답을 선택하는 함수
function addAnswer(answerText, qIdx, idx){
  var a = document.querySelector('.aBox');  // 답변이 들어갈 영역
  var answer = document.createElement('button');  // 답변 버튼 생성
  answer.classList.add('answerList');  // 버튼에 클래스 추가
  answer.classList.add('my-3');  // 부트스트랩 클래스 추가 (여백)
  answer.classList.add('py-3');  // 부트스트랩 클래스 추가 (여백)
  answer.classList.add('mx-auto');  // 부트스트랩 클래스 추가 (가로 중앙 정렬)
  answer.classList.add('fadein');  // 부드러운 등장 효과 추가

  a.appendChild(answer);  // 답변 버튼을 화면에 추가
  answer.innerHTML = answerText;  // 답변 버튼 텍스트 설정

  answer.addEventListener("click", function(){
    var children = document.querySelectorAll('.answerList');  // 모든 답변 버튼 선택
    for(let i = 0; i < children.length; i++){
      children[i].disabled = true;  // 클릭된 후 버튼 비활성화
      children[i].style.WebkitAnimation = "fadeout 0.5s";  // 버튼 fadeout 애니메이션
      children[i].style.animation = "fadeout 0.5s";  // 버튼 fadeout 애니메이션
    }
    setTimeout(() => {
      var target = questionList[qIdx].a[idx].type;  // 선택된 답변에 해당하는 MBTI 유형을 가져옴
      for(let i = 0; i < target.length; i++){
        select[target[i]] += 1;  // 해당 유형의 점수를 1 증가시킴
      }

      for(let i = 0; i < children.length; i++){
        children[i].style.display = 'none';  // 답변 버튼 숨기기
      }
      goNext(++qIdx);  // 다음 질문으로 이동
    },450)  // 애니메이션이 끝난 후 실행
  }, false);
}

// 다음 질문으로 넘어가는 함수
function goNext(qIdx){
  if(qIdx === endPoint){  // 마지막 질문에 도달하면 결과 화면으로 이동
    goResult();
    return;
  }

  var q = document.querySelector('.qBox');  // 질문 박스
  q.innerHTML = questionList[qIdx].q;  // 새로운 질문 설정
  for(let i in questionList[qIdx].a){  // 현재 질문에 대한 답변 목록
    addAnswer(questionList[qIdx].a[i].answer, qIdx, i);  // 답변 버튼 생성
  }
  var status = document.querySelector('.statusBar');  // 진행 상태바
  status.style.width = (100/endPoint) * (qIdx+1) + '%';  // 진행 상태바 업데이트
}

// 퀴즈 시작 함수
function begin(){
  main.style.WebkitAnimation = "fadeout 1s";  // 메인 화면 fadeout 애니메이션
  main.style.animation = "fadeout 1s";  // 메인 화면 fadeout 애니메이션
  setTimeout(() => {
    question.style.WebkitAnimation = "fadein 1s";  // 질문 화면 fadein 애니메이션
    question.style.animation = "fadein 1s";  // 질문 화면 fadein 애니메이션
    setTimeout(() => {
      main.style.display = "none";  // 메인 화면 숨기기
      question.style.display = "block"  // 질문 화면 보이기
    }, 450)
    let qIdx = 0;  // 첫 번째 질문부터 시작
    goNext(qIdx);  // 첫 번째 질문으로 이동
  }, 450);
}
