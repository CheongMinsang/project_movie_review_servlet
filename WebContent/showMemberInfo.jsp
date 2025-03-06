<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page buffer="64kb" autoFlush="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 상세 정보</title>
    <!-- 메인 CSS 파일 -->
    <link href="main.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
        /*
        tr:hover {
            background-color: #f5f5f5;
        }
        */
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
        /* 찜한 영화 목록 스타일 */
        .recommend-list {
            list-style: none;
            padding: 0;
            margin: 10px 0 0 0; /* 상단 여백 10px 추가 */
        }
        .recommend-item {
            padding: 8px 0;
            border-bottom: 1px solid #e0e0e0;
        }
        .recommend-item:last-child {
            border-bottom: none; /* 마지막 항목은 밑줄 제거 */
        }
        .recommend-link {
            color: #333; /* 기본 텍스트 색상 */
            text-decoration: none; /* 밑줄 제거 */
            font-size: 14px;
            transition: color 0.3s ease, background-color 0.3s ease;
            display: block; /* 클릭 영역 확장 */
            padding: 5px 10px; /* 내부 여백 추가 */
        }
        .recommend-link:hover {
            background-color: #f5f5f5 !important;
    		color: black !important;
        /*
            color: #ffffff; 
            background-color: #292A31; 
            border-radius: 5px;
        */
        }
        .recommend-date {
            color: #777; /* 등록일 색상 */
            font-size: 12px;
        }
    </style>
</head>
<body>
    <!-- 헤더 include -->
    <header>
        <%@ include file="../common/common_header.jsp" %>
    </header>
    <form name="mem1" id="mem1">
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
            <!-- 찜한 영화 목록 추가 -->
			<tr>
                <th>찜한 영화 목록</th>
                <td>
                    <c:out value=" 찜한 영화 개수: ${fn:length(dto.recommendList)}" /><br/>
                    <c:choose>
                        <c:when test="${empty dto.recommendList}">
                            찜한 영화가 없습니다.
                        </c:when>
                        <c:otherwise>
                            <ul class="recommend-list">
                                <c:forEach var="recommend" items="${dto.recommendList}">
                                    <li class="recommend-item">
                                        <a href="MovieDetail?id=${recommend.movieid}" class="recommend-link">
                                            ${recommend.moviename} 
                                            <span class="recommend-date">(등록일: ${recommend.reg_date})</span>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:otherwise>
                    </c:choose>
                </td>
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
            <a href="Index2?t_gubun=goMemberList" class="back-btn">목록으로 돌아가기</a>
            <c:if test="${dto.exit_date == null or dto.exit_date == ''}">
                <a href="javascript:goExit()" class="back-btn">해당회원탈퇴</a>
            </c:if>
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
		 	mem1.t_gubun.value = "goMemberExit";
	        mem1.method      = "post";
	        mem1.action      = "Index2";
	        mem1.submit();
		} else {
			return;
		}
	}
</script>    
</body>
</html>
