<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<link href="main.css" rel="stylesheet">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://kit.fontawesome.com/a6ae218852.js" crossorigin="anonymous"></script>
<title>내 정보</title>
<style>
    body {
    	background-image: url('images/4.jpg');
        background-color: white;
        background-size: 100%;
        color: #333;
        font-family: Arial, sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }
    h2{
    	color:black;
    }
    .container {
        background-color: white;
        padding: 20px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1), 
		            0 -4px 6px rgba(0, 0, 0, 0.1), 
		            4px 0 6px rgba(0, 0, 0, 0.1),
		            -4px 0 6px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 400px;
        max-height: 600px;
        overflow: auto;
        position: relative;
        border-radius: 10px;
    }
        /* 전체 스크롤 바 */
    .container::-webkit-scrollbar {
        width: 12px; /* 세로 스크롤 바 너비 */
        height: 12px; /* 가로 스크롤 바 높이 */
    }

    /* 스크롤 바 트랙 */
    .container::-webkit-scrollbar-track {
        border-radius: 10px;
    }

    /* 스크롤 바 핸들 */
    .container::-webkit-scrollbar-thumb {
        background: #333; /* 핸들 배경 색상 */
        border-radius: 10px; /* 핸들 둥근 모서리 */
        height: 5px;
    }

    /* 스크롤 바 핸들 - 마우스 오버 상태 */
    .container::-webkit-scrollbar-thumb:hover {
        background: black; /* 오버 시 핸들 배경 색상 */
    }
    input[type="text"], input[type="password"] {
        width: calc(100%);
        padding: 10px 15px;
        margin: 10px 0;
        border: 1px solid #e0e0e0;
        background-color: white;
        color: black;
        outline: none;
  		transition: border-color 0.3s ease;
  		border-radius: 20px;
    }
    input[type="text"]:hover, input[type="password"]:hover {
    	outline: none;
		border-color: #66afe9;
    }
    input[type="text"]:focus, input[type="password"]:focus {
    	outline: none;
		border-color: #66afe9;
    }
    input[readonly] {
        background-color: white; /* 읽기 전용 필드 스타일 */
    }
    input[disabled] {
    	background-color: white;
    	color: #747474;
    }
    button {
        margin-top: 20px;
        width: 100%;
        padding: 10px;
        border: none;
        background-color: #292A31;
        border: 1px solid #e0e0e0;
        color: white;
        font-size: 16px;
        cursor: pointer;
   		border-radius: 20px;
   		transition: background-color 0.3s ease, color 0.3s ease;
    }
    button:disabled {
    	color: #333;
        background-color: white;
        cursor: not-allowed;
    }
    button:hover {
        background-color: black;
        color: white;
    }
    .home-link {
        position: absolute;
        top: 10px;
        left: 10px;
        font-size: 14px;
        color: #333;
        text-decoration: none;
        display: flex;
        align-items: center;
    }
    .home-link:hover {
        color: black;
    }
    .home-link i {
        margin-right: 5px;
    }
</style>
</head>
<body>
	
    <!-- 로그인 여부 체크 -->
    <c:if test="${empty sessionScope.sessionId}">
        <script>
            redirectToIndex();
        </script>
    </c:if>

    <div class="container">
        <a href="Index" class="home-link">&nbsp;&nbsp;<i class="fa-solid fa-house"></i> 홈으로</a>
        <h2 align="center">정보 확인</h2>
        <form name="mem" id="mem">
            <input type="hidden" name="t_gubun">
            <input type="hidden" id="t_id2" name="t_id2" value="${dto.id}"><br><br>
            <label>이메일</label>
	            <input type="text" id="t_id" name="t_id" value="${dto.id}" disabled><br><br>
	        <label for="phone">비밀번호 입력</label>
	            <input type="password" id="t_password" name="t_password" placeholder="비밀번호 입력" oninput="checkPassword()" required><br><br>    
	        <label>이름</label>
	            <input type="text" id="t_name" name="t_name" value="${dto.name}" readonly style="background-color: white;"><br><br>
	        <label>닉네임</label>  
	            <input type="text" id="t_nickname" name="t_nickname" value="${dto.nickname}" readonly style="background-color: white;"><br><br>
	        <label for="birthDate">생년월일</label>   
	            <input type="text" id="t_birthdate" name="t_birthdate" value="${dto.birthdate}" readonly style="background-color: white;"><br><br>
	        <label for="phone">전화번호</label>
	            <input type="text" id="t_phone" name="t_phone" value="${dto.phone}" readonly style="background-color: white;"><br><br>
	        <label>성별</label>  
	            <input type="text" id="t_gender" name="t_gender" value="${dto.gender}" disabled><br><br>
	        <label for="phone">가입날짜</label>   
	            <input type="text" id="t_reg_date" name="t_reg_date" value="${dto.reg_date}" disabled><br><br>
	        <label for="phone">마지막 로그인 시간</label>   
	            <input type="text" id="t_last_login_date" name="t_last_login_date" value="${dto.last_login_date}" disabled><br><br>
            <button type="button" id="button1" onclick="enableEditing()" disabled>비밀번호 확인</button>
            <button type="button" id="button1" onclick="goExit()">회원탈퇴</button>
        </form>
    </div>
<script src="js/inputmask.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/inputmask/5.0.6/inputmask.min.js"></script>
<script>
	const ids = ['t_password'];
		
		ids.forEach(id => {
		const element = document.getElementById(id);
		element.addEventListener('focus', function() {
		this.style.borderColor = '#66afe9'; // 입력 중일 때 테두리 색을 오렌지색으로
		});
		
		element.addEventListener('blur', function() {
		this.style.borderColor = ''; // 기본 테두리 색으로 돌아감
		});
	});
	document.addEventListener("DOMContentLoaded", function() {
	    // 생년월일 입력 필드 마스크 적용 (형식: "9999년99월99일")
	    Inputmask({
	        mask: "9999년99월99일",
	        placeholder: " ",
	        showMaskOnFocus: true,
	        showMaskOnHover: false
	    }).mask(document.getElementById("t_birthdate"));

	    // 전화번호 입력 필드 마스크 적용 (형식: "999-9999-9999")
	    Inputmask({
	        mask: "999-9999-9999",
	        placeholder: " ",
	        showMaskOnFocus: true,
	        showMaskOnHover: false
	    }).mask(document.getElementById("t_phone"));
	});
	
</script>  
<script>

    // 로그인 정보가 없을 때 alert를 띄우고 Index 페이지로 이동
    function redirectToIndex() {
        alert("로그인 정보가 없습니다.");
        window.location.href = "Index";
    }

    // 비밀번호 입력 시 확인 후 버튼 활성화
    function checkPassword() {
        var inputPassword = document.getElementById("t_password").value;
        var encryptedPassword = "${dto.password}"; // DB에 저장된 암호화된 비밀번호

        fetch("EncryptServlet", { // 암호화 요청을 보낼 서블릿
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: "password=" + encodeURIComponent(inputPassword)
        })
        .then(response => response.text())
        .then(hashedPassword => {
        	var button = document.getElementById("button1");
            if (hashedPassword === encryptedPassword) {
                button.disabled = false;
                button.textContent = "정보 수정";
                enableEditing()
                button.setAttribute("onclick", "goInfo()");
            } else {
                button.disabled = true;
                button.textContent = "비밀번호 확인";
                button.removeAttribute("onclick");
            }
        });
    }
    function enableEditing() {
        var inputs = document.querySelectorAll('#mem input[readonly]');
        inputs.forEach(function(input) {
            input.removeAttribute('readonly');
            input.style.backgroundColor = 'white';
            input.style.border = '1px solid #66afe9';
        });
       	alert("내 정보 수정이 가능합니다.");
    }
    function goInfo() {
        var mem = document.getElementById("mem");

        // 앞뒤 공백 제거
        var t_name      = mem.t_name.value.trim();
        var t_nickname  = mem.t_nickname.value.trim();
        var t_birthdate = mem.t_birthdate.value.trim();
        var t_phone     = mem.t_phone.value.trim();

        // 1. 이름 검사: 빈칸, 10자 초과
        if (t_name === "") {
            alert("이름을 입력해주세요.");
            mem.t_name.focus();
            return;
        }
        if (t_name.length > 10) {
            alert("이름은 10자 이하로 입력해주세요.");
            mem.t_name.focus();
            return;
        }

        // 2. 닉네임 검사: 빈칸, 20자 초과
        if (t_nickname === "") {
            alert("닉네임을 입력해주세요.");
            mem.t_nickname.focus();
            return;
        }
        if (t_nickname.length > 20) {
            alert("닉네임은 20자 이하로 입력해주세요.");
            mem.t_nickname.focus();
            return;
        }

        // 3. 생년월일 검사
        if (t_birthdate === "") {
            alert("생년월일을 입력해주세요.");
            mem.t_birthdate.focus();
            return;
        }
        // xxxx년xx월xx일 형식 검사 (예: 1990년05월20일)
        var birthRegex = /^(\d{4})년(0[1-9]|1[0-2])월(0[1-9]|[12]\d|3[01])일$/;
        var match = t_birthdate.match(birthRegex);
        if (!match) {
            alert("생년월일은 xxxx년xx월xx일 형식으로 입력해주세요.");
            mem.t_birthdate.focus();
            return;
        }
        // 실제 날짜 유효성 검사 (예: 01월35일 체크)
        var year  = parseInt(match[1], 10);
        var month = parseInt(match[2], 10);
        var day   = parseInt(match[3], 10);
        var dateObj = new Date(year, month - 1, day);
        if (dateObj.getFullYear() !== year || (dateObj.getMonth() + 1) !== month || dateObj.getDate() !== day) {
            alert("생년월일의 날짜가 올바르지 않습니다.");
            mem.t_birthdate.focus();
            return;
        }

        // 4. 전화번호 검사: 빈칸, xxx-xxxx-xxxx 형식
        if (t_phone === "") {
            alert("전화번호를 입력해주세요.");
            mem.t_phone.focus();
            return;
        }
        var phoneRegex = /^\d{3}-\d{4}-\d{4}$/;
        if (!phoneRegex.test(t_phone)) {
            alert("전화번호는 xxx-xxxx-xxxx 형식으로 입력해주세요.");
            mem.t_phone.focus();
            return;
        }

        // 모든 검증 통과 시 폼 전송
        mem.t_gubun.value = "myinfoupdate";
        mem.method      = "post";
        mem.action      = "Index";
        mem.submit();
    }

    document.addEventListener("DOMContentLoaded", function() {
        // 각 input에서 엔터키 입력 시 다음 요소로 포커스 이동
        var t_password = document.getElementById("t_password");
        var t_name     = document.getElementById("t_name");
        var t_nickname = document.getElementById("t_nickname");
        var t_birthdate= document.getElementById("t_birthdate");
        var t_phone    = document.getElementById("t_phone");
        var button1    = document.getElementById("button1");

        t_password.addEventListener("keydown", function(event) {
            if (event.key === "Enter") {
                event.preventDefault();
                t_name.focus();
            }
        });

        t_name.addEventListener("keydown", function(event) {
            if (event.key === "Enter") {
                event.preventDefault();
                t_nickname.focus();
            }
        });

        t_nickname.addEventListener("keydown", function(event) {
            if (event.key === "Enter") {
                event.preventDefault();
                t_birthdate.focus();
            }
        });

        t_birthdate.addEventListener("keydown", function(event) {
            if (event.key === "Enter") {
                event.preventDefault();
                t_phone.focus();
            }
        });

        t_phone.addEventListener("keydown", function(event) {
            if (event.key === "Enter") {
                event.preventDefault();
                button1.focus();
            }
        });
    });
    
	function goExit(){
		if (confirm("정말 탈퇴하시겠습니까?")) {
		 	mem.t_gubun.value = "goMemberExit";
	        mem.method      = "post";
	        mem.action      = "Index";
	        mem.submit();
		} else {
			return;
		}
	}
</script>
</body>
</html>
