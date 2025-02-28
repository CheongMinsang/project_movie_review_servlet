<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 상세 정보</title>
    <!-- 메인 CSS 파일 -->
    <link href="main.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a6ae218852.js" crossorigin="anonymous"></script>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: white;
            color: #333;
            margin-top: 150px;
        }
    	.container{
			width: 100%;
            max-width: 1000px;
            margin: 0 auto; /* 좌우 자동 마진을 추가하여 중앙 정렬 */
            position: relative;
		}
        h2 {
            margin-left: 100px;
            margin-bottom: 30px;
        }
        /* 테이블 기본 스타일 (세로 정보 표시용) */
        table {
            width: 80%;
            border-collapse: collapse;
            margin: 20px auto;
        }
        table, th, td {
            border: 1px solid #747474;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        /* 탈퇴회원(탈퇴일이 있는 회원)은 빨간색으로 표시 */
        .withdrawn {
            color: red;
        }
        /* 뒤로가기 버튼 스타일 */
        .back-btn {
        	margin-top: 30px;
            display: inline-block;
            background-color: #292A31;
            border: 1px solid #e0e0e0;
            padding: 7px 15px;
            color: white;
            text-decoration: none;
            transition: background-color 0.3s ease, color 0.3s ease;
            border-radius: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .back-btn:hover {
            background-color: black;
        }
    </style>
</head>
<body>

    <!-- 헤더 include -->
    <header>
        <%@ include file="../common/common_header.jsp" %>
    </header>
    
    <form name="mem" id="mem">
		<input type="hidden" name="t_gubun">
		<input type="hidden" id="t_id2" name="t_id2" value="${dto.id}">
    <div class="container">
        <h2>회원 상세 정보</h2>
        <table border="1">
            <colgroup>
                <col style="width: 40%;">
                <col style="width: 60%;">
            </colgroup>
            <tr>
                <th>아이디</th>
                <td>${dto.id}</td>
            </tr>
            <tr>
                <th>이름</th>
                <td>${dto.name}</td>
            </tr>
            <tr>
                <th>닉네임</th>
                <td>${dto.nickname}</td>
            </tr>
            <tr>
                <th>성별</th>
                <td>${dto.gender}</td>
            </tr>
            <tr>
                <th>생년월일</th>
                <td>${dto.birthdate}</td>
            </tr>
            <tr>
                <th>휴대폰번호</th>
                <td>${dto.phone}</td>
            </tr>
            <tr>
                <th>가입날짜</th>
                <td>${dto.reg_date}</td>
            </tr>
            <tr>
                <th>최종로그인시각</th>
                <td>${dto.last_login_date}</td>
            </tr>
            <c:if test="${dto.exit_date != null and dto.exit_date != ''}">
                <tr class="withdrawn">
                    <th>탈퇴일</th>
                    <td>${dto.exit_date}</td>
                </tr>
            </c:if>
        </table>
        <!-- 목록으로 돌아가기 버튼 -->
        <div style="text-align: center; margin-top: 20px;">
            <a href="Index?t_gubun=goMemberList" class="back-btn">목록으로 돌아가기</a>
            <a href="javascript:goExit()" class="back-btn">해당회원탈퇴</a>
        </div>
    </div>
    </form>
    <!-- 푸터 include -->
    <footer class="footer">
        <%@ include file="../common/common_footer.jsp" %>
    </footer>
<script type="text/javascript">
	function goExit(){
		if (confirm("정말 탈퇴시키겠습니까?")) {
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
