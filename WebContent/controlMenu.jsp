<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://kit.fontawesome.com/a6ae218852.js" crossorigin="anonymous"></script>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리메뉴 페이지</title>
    <style>
        body {
            background-color: #121212;
            background-size: 100%;
            color: #FFFFFF;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background-color: rgba(30, 30, 30, 0.9);
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
            width: 100%;
            max-width: 600px;
            position: relative;
            border-radius: 25px;
        }
        .container button {
            margin-top: 20px;
            width: 100%;
            padding: 10px;
            border: none;
            background-color: #ffa500;
            color: #fff;
            font-size: 25px;
            cursor: pointer;
            border-radius: 25px;
        }
        .container button:hover {
            background-color: #ff8c00;
        }
        .home-link {
            position: absolute;
            top: 10px; /* 로그인 글자와 같은 높이로 설정 */
            left: 10px; /* 로그인 글자의 왼쪽 상단에 위치 */
            font-size: 14px;
            color: #ffa500;
            text-decoration: none;
            display: flex;
            align-items: center;
            transition: transform 0.3s ease;
        }
        .home-link:hover {
            color: #ff8c00;
            transform: scale(1.2);
        }
        .home-link i {
            margin-right: 5px; /* 아이콘과 텍스트 사이의 간격 조정 */
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="Index" class="home-link">&nbsp&nbsp<i class="fa-solid fa-house"></i> 홈으로</a>
        <h2 align="center">관리메뉴</h2>
        <form name="mem">
        <input type="hidden" name="t_gubun">
            <button type="button" id="button1" onclick="goMemberList()">회원목록</button>
            <button type="button" id="button1" onclick="goReco()">추천영화목록</button>
            <button type="button" id="button1" onclick="goLogin()">리뷰관리</button>
        </form>
    </div>
<script>
	function goMemberList(){
		mem.t_gubun.value="goMemberList";
		mem.method="post";
		mem.action="Index";
		mem.submit();
	}
	function goReco(){
		mem.t_gubun.value="goRecoList";
		mem.method="post";
		mem.action="Index";
		mem.submit();
	}
</script>    
</body>
</html>
