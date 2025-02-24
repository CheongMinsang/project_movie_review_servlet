<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://kit.fontawesome.com/a6ae218852.js" crossorigin="anonymous"></script>
<!DOCTYPE html>
<html lang="ko">
<head>
<script>
	function goRegister(){
		mem.t_gubun.value="register";
		mem.method="post";
		mem.action="Index";
		mem.submit();
	}
	function goLogin(){
        var emailInput = document.getElementById("input1");
        var passwordInput = document.getElementById("input2");

        if (emailInput.value === "") {
            alert("이메일을 입력해주세요.");
            emailInput.focus();
            return;
        }

        if (passwordInput.value === "") {
            alert("비밀번호를 입력해주세요.");
            passwordInput.focus();
            return;
        }
		
		mem.t_gubun.value="loginForm";
		mem.method="post";
		mem.action="Index";
		mem.submit();
	}
	function focusNext(event, nextId) {
		if (event.key === "Enter") {
			event.preventDefault(); 
			document.getElementById(nextId).focus(); 
		} 
	}
</script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 페이지</title>
    <style>
        body {
            /* background-image: url('images/loginBackGround.jpg'); */
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
        .container {
            background-color: white;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1), 
					    0 -4px 6px rgba(0, 0, 0, 0.1), 
					    4px 0 6px rgba(0, 0, 0, 0.1),
					    -4px 0 6px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            position: relative;
            border-radius: 20px;
        }
        input[type="text"], input[type="password"] {
            width: calc(100%); /* input 요소의 너비 조정 */
            padding: 10px 15px;
            margin: 10px 0;
            border: 1px solid #e0e0e0;
            background-color: white;
            color: #333;
            outline: none;
    		transition: border-color 0.3s ease;
    		border-radius: 20px;
        }
        input[type="text"]:focus , input[type="password"]:focus {
        	border-color: #292A31;
        }
        input[type="text"]:hover , input[type="password"]:hover {
        	border-color: #292A31;
        }
        button {
            margin-top: 20px;
            width: 100%;
            padding: 10px;
            border: none;
            background-color: #292A31;
            color: white;
            font-size: 16px;
            cursor: pointer;
            border-radius: 20px;
        }
        button:hover {
            background-color: black;
        }
        .home-link {
            position: absolute;
            top: 10px; /* 로그인 글자와 같은 높이로 설정 */
            left: 10px; /* 로그인 글자의 왼쪽 상단에 위치 */
            font-size: 14px;
            color: #292A31;
            text-decoration: none;
            display: flex;
            align-items: center;
            transition: transform 0.3s ease;
        }
        .home-link:hover {
            color: black;
        }
        .home-link i {
            margin-right: 5px; /* 아이콘과 텍스트 사이의 간격 조정 */
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="Index" class="home-link">&nbsp&nbsp<i class="fa-solid fa-house"></i> 홈으로</a>
        <h2 align="center">로그인</h2>
        <form name="mem">
        <input type="hidden" name="t_gubun">
            <input type="text" id="input1" name="t_id" onkeydown="focusNext(event,'input2')" placeholder="이메일" required autofocus>
            <input type="password" id="input2" name="t_password" onkeydown="focusNext(event,'button1')" placeholder="비밀번호" required>
            <button type="button" id="button1" onclick="goLogin()">로그인</button>
            <button type="button" onclick="goRegister()">회원가입</button>
        </form>
    </div>
<script>
	const ids = ['input1', 'input2'];
	
	ids.forEach(id => {
	    const element = document.getElementById(id);
	    element.addEventListener('focus', function() {
	        this.style.borderColor = '#292A31'; // 입력 중일 때 테두리 색을 오렌지색으로
	    });
	
	    element.addEventListener('blur', function() {
	        this.style.borderColor = ''; // 기본 테두리 색으로 돌아감
	    });
	});
</script>    
<script>
    // 팝업창이 언로드될 때(닫힐 때) 부모창 새로고침 시도
    window.addEventListener('unload', function(){
        if(window.opener && !window.opener.closed){
            window.opener.location.reload();
        }
    });
</script>
</body>
</html>
