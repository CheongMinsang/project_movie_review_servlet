<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://kit.fontawesome.com/a6ae218852.js" crossorigin="anonymous"></script>
<script>
	function goLogin(){
		mem.t_gubun.value="login";
		mem.method="post";
		mem.action="Index";
		mem.submit();
	}
	function goRegister(){
		mem.t_gubun.value="register";
		mem.method="post";
		mem.action="Index";
		mem.submit();
	}
	function goLogout(){
		mem.t_gubun.value="logout";
		mem.method="post";
		mem.action="Index";
		mem.submit();
	}
	function goMyInfo(){
		mem.t_gubun.value="myinfo";
		mem.method="post";
		mem.action="Index";
		mem.submit();
	}
	function goControl(){
		mem.t_gubun.value="controlMenu";
		mem.method="post";
		mem.action="Index";
		mem.submit();
	}
	document.getElementById('search-input'&'submit').addEventListener('focus', function() {
	    this.style.borderColor = '#ffa500'; // 입력 중일 때 테두리 색을 오렌지색으로
	});

	document.getElementById('search-input'&'submit').addEventListener('blur', function() {
	    this.style.borderColor = ''; // 기본 테두리 색으로 돌아감
	});
</script>
<form name="mem">
	<input type="hidden" name="t_gubun">
</form>
<div class="logo">
            <a href="Index"><i class="fa-solid fa-play"></i>The Movie Index</a>
            <a href="Index"><i class="fa-solid fa-house"></i> 홈</a>
            <a href="#movies"><i class="fa-solid fa-clapperboard"></i> 영화</a>
        </div>
        <div class="search-login">
			<!-- 검색창 HTML -->
			<div class="search-box">
			    <form id="search-form" action="MovieList" method="get">
			        <div class="search-input-wrapper">
			            <i class="fas fa-search"></i>
			            <input type="hidden" name="t_gubun" value="${t_gubun != null ? t_gubun : 'search'}">
			            <input type="hidden" name="genre_id" value="<%= request.getParameter("genre_id") != null ? request.getParameter("genre_id") : "" %>">
			            <input type="text" id="search-input" name="search" placeholder="영화 검색..." autocomplete="off">
			            <button type="submit" id="submit">검색</button>
			        </div>
			    </form>
			</div>
			
			<c:if test="${empty sessionId}">
			    <div class="buttons">
			        <button id="login-btn" onclick="goLogin()"><i class="fa-solid fa-arrow-right-to-bracket"></i> 로그인</button>
			        <button id="signup-btn" onclick="goRegister()"><i class="fa-solid fa-user-plus"></i> 회원가입</button>
			    </div>
			</c:if>
			
	        <c:if test="${not empty sessionId}">
	        	<div class="buttons">
				    <button id="login-btn-myinfo" onclick="goMyInfo()"><i class="fa-solid fa-user"></i> ${sessionName}</button>
				   		<c:if test="${sessionLevel eq 'top'}">
							<button id="login-btn-myinfo" onclick="goControl()"><i class="fa-solid fa-gear"></i> 관리메뉴</button>
						</c:if>
				    <button id="login-btn" onclick="goLogout()"><i class="fa-solid fa-arrow-right-to-bracket"></i> 로그아웃</button>
				</div>
	        </c:if>    
        </div>