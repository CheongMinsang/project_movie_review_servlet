<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page buffer="64kb" autoFlush="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 목록</title>
    <!-- 메인 CSS 파일 -->
    <link href="main.css" rel="stylesheet">
    <link href="css/showMemberList.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <!-- 헤더 include -->
    <header>
        <%@ include file="../common/common_header.jsp" %>
    </header>
    <div class="container">
        <h2>회원 목록</h2>
        <!-- 검색폼 -->
        <form class="search-form" action="Index" method="get">
      	  	<input type="hidden" name="t_gubun" value="goMemberList">
            <select name="category">
                <option value="id" <c:if test="${param.category == 'id'}">selected</c:if>>아이디</option>
                <option value="name" <c:if test="${param.category == 'name'}">selected</c:if>>이름</option>
                <option value="nickname" <c:if test="${param.category == 'nickname'}">selected</c:if>>닉네임</option>
                <!-- 필요한 경우 다른 검색 카테고리 추가 -->
            </select>
            <input type="text" name="keyword" value="${param.keyword}" placeholder="검색어 입력">
            <input type="submit" value="검색">
        </form>
        <!-- 회원목록 테이블 -->
        <table>
            <thead>
                <tr>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>가입날짜</th>
                    <th>닉네임</th>
                    <th>성별</th>
                    <th>생년월일</th>
                    <th>휴대폰번호</th>
                    <th>탈퇴여부</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="dto" items="${dtos}">
                    <!-- dto.exit_date가 null이 아니거나 공백이 아니면 withdrawn 클래스 적용 -->
                    <tr class="${(dto.exit_date != null && dto.exit_date != '') ? 'withdrawn' : ''}"
                    	style="cursor:pointer;"
                        onclick="location.href='Index?t_gubun=goMemberInfo&id=${dto.id}'">
                        <td>${dto.id}</td>
                        <td>${dto.name}</td>
                        <td>${dto.reg_date}</td>
                        <td>${dto.nickname}</td>
                        <td>${dto.gender}</td>
                        <td>${dto.birthdate}</td>
                        <td>${dto.phone}</td>
                        <td>
				            <c:choose>
				                <c:when test="${dto.exit_date != null && dto.exit_date != ''}">
				                  	탈퇴회원
				                </c:when>
				                <c:otherwise>
				                    &nbsp; <!-- 탈퇴회원이 아닌 경우 공백 -->
				                </c:otherwise>
				            </c:choose>
				        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <!-- 페이징 처리 (서블릿에서 page, totalPage 등의 값이 전달되었다고 가정) -->
        <div class="pagination">
            <!-- 이전 페이지 링크 -->
            <c:if test="${page > 1}">
                <a href="Index?t_gubun=goMemberList&page=${page - 1}&category=${param.category}&keyword=${param.keyword}"><i class="fa-solid fa-angle-left"></i> 이전</a>
            </c:if>
            <!-- 페이지 번호 링크 -->
            <c:forEach var="i" begin="1" end="${totalPage}">
                <a href="Index?t_gubun=goMemberList&page=${i}&category=${param.category}&keyword=${param.keyword}"
                   class="${i == page ? 'active' : ''}">${i}</a>
            </c:forEach>
            <!-- 다음 페이지 링크 -->
            <c:if test="${page < totalPage}">
                <a href="Index?t_gubun=goMemberList&page=${page + 1}&category=${param.category}&keyword=${param.keyword}">다음 <i class="fa-solid fa-angle-right"></i></a>
            </c:if>
        </div>
    </div>
    <!-- 푸터 include -->
    <footer class="footer">
        <%@ include file="../common/common_footer.jsp" %>
    </footer>
</body>
</html>
