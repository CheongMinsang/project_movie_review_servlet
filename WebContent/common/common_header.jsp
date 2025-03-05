<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://kit.fontawesome.com/a6ae218852.js" crossorigin="anonymous"></script>
<script>
	function goLogin(){
		mem.t_gubun.value="login";
		mem.method="post";
		mem.action="Index2";
		mem.submit();
	}
	function goRegister(){
		mem.t_gubun.value="register";
		mem.method="post";
		mem.action="Index2";
		mem.submit();
	}
	function goLogout(){
		mem.t_gubun.value="logout";
		mem.method="post";
		mem.action="Index2";
		mem.submit();
	}
	function goMyInfo(){
		mem.t_gubun.value="myinfo";
		mem.method="post";
		mem.action="Index2";
		mem.submit();
	}
	function goControl(){
		mem.t_gubun.value="controlMenu";
		mem.method="post";
		mem.action="Index2";
		mem.submit();
	}
	function goMemberInfo(){
		mem.t_gubun.value="myinfo";
		mem.method="post";
		mem.action="Index2";
		mem.submit();
	}
	function goSaveMovieList(){
		mem.t_gubun.value="goSaveMovieList";
		mem.method="post";
		mem.action="Index2";
		mem.submit();
	}
	function goSaveRatingList(){
		mem.t_gubun.value="goSaveRatingList";
		mem.method="post";
		mem.action="Index2";
		mem.submit();
	}
	function goReviewManage(){
		mem.t_gubun.value="goReviewManage";
		mem.method="post";
		mem.action="Index2";
		mem.submit();
	}
	function goReco(){
		mem.t_gubun.value="goRecoList";
		mem.method="post";
		mem.action="Index2";
		mem.submit();
	}
	function goManyReview(){
		mem.t_gubun.value="goManyReview";
		mem.method="post";
		mem.action="Index2";
		mem.submit();
	}
	function goManyRecommend(){
		mem.t_gubun.value="goManyRecommend";
		mem.method="post";
		mem.action="Index2";
		mem.submit();
	}
	
	// 관리메뉴 관련 함수들
	function goMemberList(){
		mem.t_gubun.value="goMemberList";
		mem.method="post";
		mem.action="Index2";
		mem.submit();
	}
	function goRecoList(){
		mem.t_gubun.value="goRecoList";
		mem.method="post";
		mem.action="Index2";
		mem.submit();
	}
	function goReviewManage(){
		mem.t_gubun.value="goReviewManage";
		mem.method="post";
		mem.action="Index2";
		mem.submit();
	}
	
	/*
	// search-input 요소에 이벤트 등록
	document.getElementById('search-input').addEventListener('focus', function() {
	  this.style.borderColor = '#66afe9'; // 포커스 시 테두리 색 변경
	});
	document.getElementById('search-input').addEventListener('blur', function() {
	  this.style.borderColor = ''; // 포커스 아웃 시 원래 색으로 복구
	});
	*/
	
	// 드롭다운 관련 함수들
	function toggleMemberMenu() {
	    document.getElementById("memberDropdown").classList.toggle("show");
	}
	
	function toggleMovieMenu(event) {
	    event.preventDefault();
	    document.getElementById("movieDropdown").classList.toggle("show");
	}
	
	// 관리메뉴 드롭다운 토글 함수
	function toggleAdminMenu() {
	    document.getElementById("adminDropdown").classList.toggle("show");
	}

	// 드롭다운 외부 클릭시 닫기 - 모든 드롭다운을 처리하도록 수정
	window.onclick = function(event) {
	    if (!event.target.closest('.dropdown') && !event.target.closest('.movie-dropdown')) {
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
<style>
    /* 드롭다운 메뉴 스타일 */
    header .dropdown, 
    body > .dropdown {
        position: relative !important;
        display: inline-block !important;
    }
    /* 헤더 드롭다운 메뉴 스타일 */
    body header .dropdown-content,
    body .dropdown .dropdown-content {
        display: none !important;
        position: absolute !important;
        /* right: 0 !important; */
        background-color: #fff !important;
        min-width: 200px !important;
        box-shadow: 0 8px 16px rgba(0,0,0,0.1) !important;
        border-radius: 8px !important;
        z-index: 9999 !important;
        margin-top: 5px !important;
        padding: 10px !important; /* padding 추가 */
    }
    /* container 클래스와의 충돌 방지 */
    /* dropdown 전용 컨테이너 스타일 */
    body header .dropdown-content .dropdown-container,
    body .dropdown .dropdown-content .dropdown-container {
        background-color: transparent !important;
        padding: 0 !important;
        max-width: none !important;
        margin: 0 !important;
    }
    /* menu-items 클래스 추가로 더 구체적인 선택자 사용 */
    body header .dropdown-content .menu-items button,
    body .dropdown .dropdown-content .menu-items button {
        width: 100% !important;
        padding: 12px 15px !important;
        text-align: left !important;
        background: none !important;
        border: none !important;
        border-radius: 0px !important;
        color: #333 !important;
        font-size: 14px !important;
        cursor: pointer !important;
        transition: background-color 0.2s !important;
        display: flex !important;
        align-items: center !important;
        gap: 8px !important;
    }
    body header .dropdown-content .menu-items button:hover,
    body .dropdown .dropdown-content .menu-items button:hover {
        background-color: #f5f5f5 !important;
        color: black !important;
    }
    body header .dropdown-content .menu-items,
    body .dropdown .dropdown-content .menu-items {
        display: flex !important;
        flex-direction: column !important;
        gap: 5px !important;
    }
    body header .dropdown-content .menu-items .close-btn,
    body .dropdown .dropdown-content .menu-items .close-btn {
        margin-top: 10px !important;
        border-top: 1px solid #3a3a3a !important;
        padding-top: 15px !important;
    }
    /* 영화 드롭다운 specific 스타일 */
    body header .movie-dropdown .movie-link,
    body .movie-dropdown .movie-link {
        text-decoration: none !important;
        color: #333 !important;
        cursor: pointer !important;
    }
    /* show 클래스 */
    body header .dropdown-content.show,
    body .dropdown .dropdown-content.show {
        display: block !important;
    }
    .icon-small {
        font-size: 0.7em; /* 아이콘 크기를 조정 */
        position: relative;
        top: 2px; /* 위치를 약간 아래로 이동 */
    }
</style>
<form name="mem">
	<input type="hidden" name="t_gubun">
</form>
<div class="logo">
    <a href="Index"><i class="fa-solid fa-play"></i>The Movie Index</a>
    <!-- <a href="Index"><i class="fa-solid fa-house"></i> 홈</a>  -->
    <!-- 영화 메뉴 수정 -->
    <div class="dropdown movie-dropdown">
        <a href="#" class="movie-link" onclick="toggleMovieMenu(event)">
            <i class="fa-solid fa-clapperboard"></i> 영화 <i class="fa-solid fa-chevron-down icon-small"></i>
        </a>
        <!-- 
        <div id="movieDropdown" class="dropdown-content">
            <div class="dropdown-container">
                <div class="menu-items">
                    <a href="MovieList?t_gubun=popular&page=1">
                        <button type="button">
                            <i class="fa-solid fa-fire" style="color: red;"></i> 인기 영화 목록
                        </button>
                    </a>
                    <a href="MovieList?t_gubun=upcoming&page=1">    
                        <button type="button">
                            <i class="fa-solid fa-calendar" style="color: #c094c4;"></i> 개봉 예정 목록
                        </button>
                    </a>
                    <a href="MovieList?t_gubun=top_rated&page=1">
                        <button type="button">
                            <i class="fa-solid fa-star" style="color: gold;"></i> 높은 평점 목록
                        </button>
                    </a>    
                    <button type="button" onclick="goReco()">
                        <i class="fa-solid fa-thumbs-up" style="color: #66afe9;"></i> 추천 영화 목록
                    </button>
                    <button type="button" onclick="goManyReview()">
                        <i class="fa-solid fa-comments" style="color: #32CD32;"></i> 리뷰 많은 순
                    </button>
                    <button type="button" class="close-btn" onclick="toggleMovieMenu(event)">
                        <i class="fa-solid fa-times"></i> 닫기
                    </button>
                </div>
            </div>
             -->
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
                            <i class="fa-solid fa-star"></i> 높은평점목록
                        </button>
                    </a>    
                    <button type="button" onclick="goReco()">
                        <i class="fa-solid fa-thumbs-up"></i> 추천 영화 목록
                    </button>
                    <button type="button" onclick="goManyReview()">
                    	<i class="fa-solid fa-comment"></i> 최다 리뷰 목록
                    </button>
                    <button type="button" onclick="goManyRecommend()">
                    	<i class="fa-solid fa-bookmark"></i> 최다 북마크 목록
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
            <div class="search-input-wrapper common-hover-focus">
                <i class="fas fa-search"></i>
                <input type="hidden" name="t_gubun" value="${t_gubun != null ? t_gubun : 'search'}">
                <input type="hidden" name="genre_id" value="<%= request.getParameter("genre_id") != null ? request.getParameter("genre_id") : "" %>">
                <input type="text" id="search-input" name="search" placeholder="영화 검색..." autocomplete="off" class="common-hover-focus">
                <button type="submit" id="submit" class="common-hover-focus">검색</button>
            </div>
        </form>
    </div>
    <c:if test="${empty sessionId}">
	    <div class="buttons">
	        <button id="login-btn" onclick="openLoginPopup()">
	            <i class="fa-solid fa-arrow-right-to-bracket"></i> 로그인
	        </button>
	        <button id="signup-btn" onclick="openRegisterPopup()">
	            <i class="fa-solid fa-user-plus"></i> 회원가입
	        </button>
	    </div>
	</c:if>
	<script>
	    function openLoginPopup(){
	        // 팝업창 이름, 크기, 기타 옵션 설정 (필요에 따라 옵션을 조정)
	        window.open('login.jsp', 'loginPopup', 'width=500,height=600,scrollbars=yes');
	    }
	    function openRegisterPopup(){
	        // 팝업창 이름, 크기, 기타 옵션 설정 (필요에 따라 옵션을 조정)
	        window.open('register.jsp', 'registerPopup', 'width=500,height=1200,scrollbars=yes');
	    }
	</script>
    
    <c:if test="${not empty sessionId}">
        <div class="buttons">
            <button id="login-btn-myinfo" onclick="goMyInfo()"><i class="fa-solid fa-user"></i> ${sessionName}</button>
            <c:if test="${sessionLevel eq 'top'}">
                <!-- 관리메뉴 드롭다운 구현 부분 -->
                <div class="dropdown">
                    <button id="login-btn-myinfo" onclick="toggleAdminMenu()">
                        <i class="fa-solid fa-gear"></i> 관리메뉴
                    </button>
                    <div id="adminDropdown" class="dropdown-content">
                        <div class="dropdown-container">
                            <div class="menu-items">
                                <button type="button" onclick="goMemberList()">
                                    <i class="fa-solid fa-users"></i> 회원목록
                                </button>
                                <button type="button" onclick="goRecoList()">
                                    <i class="fa-solid fa-film"></i> 추천영화목록
                                </button>
                                <button type="button" onclick="goReviewManage()">
                                    <i class="fa-solid fa-comment"></i> 리뷰관리
                                </button>
                                <button type="button" class="close-btn" onclick="toggleAdminMenu()">
                                    <i class="fa-solid fa-times"></i> 닫기
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
            <!-- 회원메뉴 드롭다운 수정 -->
            <div class="dropdown">
                <button id="login-btn-myinfo" onclick="toggleMemberMenu()">
                    <i class="fa-solid fa-list"></i> 회원메뉴
                </button>
                <div id="memberDropdown" class="dropdown-content">
                    <div class="dropdown-container">
                        <div class="menu-items">
                            <button type="button" onclick="goMyInfo()">
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