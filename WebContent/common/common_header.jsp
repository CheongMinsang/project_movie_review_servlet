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
	/*
	function goMemberMenu(){
		mem.t_gubun.value="MemberControlMenu";
		mem.method="post";
		mem.action="Index";
		mem.submit();
	}
	*/
	function goMemberInfo(){
		mem.t_gubun.value="myinfo";
		mem.method="post";
		mem.action="Index";
		mem.submit();
	}
	function goSaveMovieList(){
		mem.t_gubun.value="goSaveMovieList";
		mem.method="post";
		mem.action="Index";
		mem.submit();
	}
	function goSaveRatingList(){
		mem.t_gubun.value="goSaveRatingList";
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
	// JavaScript 수정
	function toggleMemberMenu() {
	    document.getElementById("memberDropdown").classList.toggle("show");
	}

	// 드롭다운 외부 클릭시 닫기
	window.onclick = function(event) {
	    if (!event.target.closest('.dropdown')) {
	        var dropdowns = document.getElementsByClassName("dropdown-content");
	        for (var i = 0; i < dropdowns.length; i++) {
	            var openDropdown = dropdowns[i];
	            if (openDropdown.classList.contains('show')) {
	                openDropdown.classList.remove('show');
	            }
	        }
	    }
	}
	// JavaScript 수정
	function toggleMovieMenu(event) {
	    event.preventDefault();
	    document.getElementById("movieDropdown").classList.toggle("show");
	}

	// 드롭다운 외부 클릭시 닫기
	window.onclick = function(event) {
	    if (!event.target.closest('.movie-dropdown')) {
	        var dropdowns = document.getElementsByClassName("dropdown-content");
	        for (var i = 0; i < dropdowns.length; i++) {
	            var openDropdown = dropdowns[i];
	            if (openDropdown.classList.contains('show')) {
	                openDropdown.classList.remove('show');
	            }
	        }
	    }
	}
</script>
<form name="mem">
	<input type="hidden" name="t_gubun">
</form>
<div class="logo">
            <a href="Index"><i class="fa-solid fa-play"></i>The Movie Index</a>
            <a href="Index"><i class="fa-solid fa-house"></i> 홈</a>
			<!-- 영화 메뉴 수정 -->
			<div class="dropdown movie-dropdown">
			    <a href="#" class="movie-link" onclick="toggleMovieMenu(event)">
			        <i class="fa-solid fa-clapperboard"></i> 영화
			    </a>
			    <div id="movieDropdown" class="dropdown-content">
			        <div class="dropdown-container">
			            <div class="menu-items">
			                <a href="MovieList?t_gubun=popular&page=1">
			                    <button type="button">
			                        <i class="fa-solid fa-fire"></i> 인기 영화 목록
			                    </button>
			                </a>
			                <a href="MovieList?t_gubun=upcoming&page=1">    
			                    <button type="button">
			                        <i class="fa-solid fa-calendar"></i> 개봉 예정 목록
			                    </button>
			                </a>
			                <a href="MovieList?t_gubun=top_rated&page=1">
			                    <button type="button">
			                        <i class="fa-solid fa-star"></i> 높은 평점 목록
			                    </button>
			                </a>    
			                <button type="button" onclick="goReco()">
			                    <i class="fa-solid fa-thumbs-up"></i> 추천 영화 목록
			                </button>
			                <button type="button">
			                    <i class="fa-solid fa-comments"></i> 리뷰 많은 순
			                </button>
			                <button type="button" class="close-btn" onclick="toggleMovieMenu(event)">
			                    <i class="fa-solid fa-times"></i> 닫기
			                </button>
			            </div>
			        </div>
			    </div>
			</div>
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
					<!-- 회원메뉴 드롭다운 수정 -->
					<div class="dropdown">
					    <button id="login-btn-myinfo" onclick="toggleMemberMenu()">
					        <i class="fa-solid fa-list"></i> 회원메뉴
					    </button>
					    <div id="memberDropdown" class="dropdown-content">
					        <div class="dropdown-container">
					            <div class="menu-items">
					                <button type="button" onclick="goMemberInfo()">
					                    <i class="fa-solid fa-user"></i> 내 정보
					                </button>
					                <button type="button" onclick="goSaveMovieList()">
					                    <i class="fa-solid fa-film"></i> 저장한 영화
					                </button>
					                <button type="button" onclick="goSaveRatingList()">
					                    <i class="fa-solid fa-star"></i> 작성한 리뷰
					                </button>
					                <button type="button" class="close-btn" onclick="toggleMemberMenu()">
					                    <i class="fa-solid fa-times"></i> 닫기
					                </button>
					            </div>
					        </div>
					    </div>
					</div>
				    <button id="login-btn" onclick="goLogout()"><i class="fa-solid fa-arrow-right-to-bracket"></i> 로그아웃</button>
				</div>
	        </c:if>    
        </div>