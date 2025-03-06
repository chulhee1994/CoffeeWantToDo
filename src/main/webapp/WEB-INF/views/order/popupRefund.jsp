<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>취소 요청</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            text-align: center;
            padding: 20px;
        }
        .popup-container {
            max-width: 300px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }
        textarea {
            width: 100%;
            height: 80px;
            margin-top: 10px;
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 5px;
            resize: none;
        }
        .popup-buttons {
            margin-top: 15px;
        }
        .btn {
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-confirm {
            background-color: #007bff;
            color: white;
        }
        .btn-cancel {
            background-color: #ccc;
            color: black;
        }
    </style>
    <script>
    function sendRefundReason() {
        const reason = document.getElementById("refundReason").value.trim();
        if (!reason) {
            alert("취소 사유를 입력하세요!");
            return;
        }

        // ✅ 부모 창의 receiveRefundReason 함수 호출 (팝업이 닫히기 전에 실행)
        if (window.opener && typeof window.opener.receiveRefundReason === "function") {
            window.opener.receiveRefundReason(reason);
        } else {
            alert("❌ 부모 창과의 통신에 문제가 발생했습니다.");
        }

        window.close();
    }

    </script>
</head>
<body>
    <div class="popup-container">
        <h3>취소 요청</h3>
        <textarea id="refundReason" placeholder="취소 사유를 입력하세요"></textarea>
        <div class="popup-buttons">
            <button class="btn btn-confirm" onclick="sendRefundReason()">확인</button>
            <button class="btn btn-cancel" onclick="window.close()">취소</button>
        </div>
    </div>
</body>
</html>