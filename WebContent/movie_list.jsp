<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.json.JSONArray, org.json.JSONObject" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>영화 목록</title>
    <link href="movie_list.css" rel="stylesheet">
    <link href="main.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="user-wrap">
        <div class="user-image">
            <img src="images/1.jpg" alt="영화 리뷰 사이트" class="main-image">
        </div>
        <div class="user-text">
            <p><i class="fa-solid fa-play"></i>THE MOVIE INDEX</p>
        </div>
        <div class="user-text2">
            <p>국내 최대 규모 영화 리뷰 사이트</p>
        </div>
        <div class="user-text3">
            <p><i class="fa-solid fa-minus"></i>지금까지 개봉된 약 23,000편의 영화 중에서 보고 싶은 영화를 찾아보세요!<i class="fa-solid fa-minus"></i></p>
        </div>
        <div class="user-text4">
            <p>영화정보·감상·평가는 The Movie Index</p>
        </div>
    </div>
    <!-- 헤더 -->
    <header>
        <%@ include file="../common/common_header.jsp" %>
    </header>
    <div class="filter-section2">
		<div class="award-filter">
			<a href="MovieList?t_gubun=popular&page=1">
				<button class="filter-btn2 filter-btn3"><i class="fa-solid fa-fire"></i> 인기 영화 목록</button>
			</a>
			<a href="MovieList?t_gubun=upcoming&page=1">	
				<button class="filter-btn2 filter-btn4"><i class="fa-solid fa-calendar"></i> 개봉 예정 목록</button>
			</a>
			<a href="MovieList?t_gubun=top_rated&page=1">
				<button class="filter-btn2 filter-btn5"><i class="fa-solid fa-star"></i> 높은 평점 목록</button>
			</a>	
			<button class="filter-btn2 filter-btn6" onclick="goReco()"><i class="fa-solid fa-thumbs-up"></i> 추천 영화 목록</button>
			<button class="filter-btn2 filter-btn7"><i class="fa-solid fa-comments"></i> 리뷰 많은 순</button>
		</div>	
	</div>	
    <div class="movie-list-container" style="position: relative;">
        <!-- <a href="javascript:history.back()" class="home-link">&nbsp&nbsp<i class="fa-solid fa-arrow-left"></i> </a> -->
        <h1>
	        <%= request.getAttribute("pageTitle") %>
	    	<span id="selectedGenreName"></span>
	    </h1>
	    
        
    <!-- 검색 및 정렬 -->
    <form id="mainSearchForm" method="get" action="MovieList">
        <input type="hidden" name="t_gubun" value="<%= request.getParameter("t_gubun") %>">
        <input type="hidden" name="genre_id" value="<%= request.getParameter("genre_id") != null ? request.getParameter("genre_id") : "" %>">
        <input type="text" id="search-input" name="search" placeholder="영화 검색" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
        <select name="sort" id="sort">
            <option value="release_date" <%= "release_date".equals(request.getParameter("sort")) ? "selected" : "" %>>개봉일순</option>
            <option value="vote_average" <%= "vote_average".equals(request.getParameter("sort")) ? "selected" : "" %>>평점순</option>
        </select>
        <button type="submit">검색</button>
    </form>
            
<div class="container">
    <!-- 장르 목록 표시 -->

<div class="genre-box">
    <h2>장르 목록</h2>
    <ul class="genre-list">
        <a href="MovieList?t_gubun=popular&page=1"><h3>전체</h3></a>
        <c:forEach var="genre" items="${genres}">
            <li class="genre-item" data-id="${genre.id}" data-name="${genre.name}">
                <a href="MovieList?t_gubun=genre&genre_id=${genre.id}&sort=release_date">
                    <span class="genre-name">${genre.name}</span>
                    <i class="fa-solid fa-angle-right genre-icon"></i>
                </a>
            </li>
        </c:forEach>
    </ul>
</div>


    <!-- 영화 목록 표시 -->
    <div class="movie-list">
        <%-- 검색 결과 --%>
        <div class="movie-list">
            <%
                JSONArray movies = (JSONArray) request.getAttribute("movies");
                if (movies == null) {
                    movies = new JSONArray(); // 빈 배열로 초기화
                }
                if (movies != null) {
                    for (int i = 0; i < movies.length(); i++) {
                        JSONObject movie = movies.getJSONObject(i);
                        String movieId = movie.optString("id", "N/A");
                        String title = movie.optString("title", "Unknown Title");
                        String releaseDate = movie.optString("release_date", "Unknown Date");
                        double voteAverage = movie.optDouble("vote_average", 0.0);
            %>
            <div class="movie-item">
                <a href="MovieDetail?id=<%= movieId %>">
                    <img src="https://image.tmdb.org/t/p/w200<%= movie.optString("poster_path", "") %>" alt="<%= title %>">
                    <div class="movie-info">
	                    <h2><%= title %></h2>
	                    <p class="vote-average"><i class="fa-solid fa-star"></i> <%= String.format("%.1f", voteAverage) %></p>
	                    <p class="release-date">개봉일: <%= releaseDate %></p>
	                </div>    
                </a>
            </div>
            <% 
                    }
                } else { 
            %>
            <p>영화 데이터가 없습니다.</p>
            <% } %>
        </div>
    </div>
</div>


        <!-- 페이징 -->
        <%
            int currentPage = (int) request.getAttribute("currentPage");
            int totalPages = (int) request.getAttribute("totalPages");
            int maxPagesToShow = 6;
            int startPage = Math.max(1, currentPage - (maxPagesToShow / 2));
            int endPage = Math.min(totalPages, startPage + maxPagesToShow - 1);
        
            String tGubun = request.getParameter("t_gubun") != null ? request.getParameter("t_gubun") : "";
            String sort = request.getParameter("sort") != null ? request.getParameter("sort") : "";
            String search = request.getParameter("search") != null ? request.getParameter("search") : "";
            String genreId = request.getParameter("genre_id") != null ? request.getParameter("genre_id") : "";
        %>
        <div class="pagination">
            <% if (currentPage > 1) { %>
                <!-- <a href="MovieList?t_gubun=<%= tGubun %>&page=1&sort=<%= sort %>&search=<%= search %>&genre_id=<%= genreId %>"><i class="fa-solid fa-angles-left"></i></a> -->
                <a href="MovieList?t_gubun=<%= tGubun %>&page=<%= currentPage - 1 %>&sort=<%= sort %>&search=<%= search %>&genre_id=<%= genreId %>"><i class="fa-solid fa-angle-left"></i></a>
            <% } else { %>
            	<li class="disabled"><a href="#"><i class="fa-solid fa-angle-left"></i></a></li>
            <% } %>
            
            <% for (int i = startPage; i <= endPage; i++) { %>
                <a href="MovieList?t_gubun=<%= tGubun %>&page=<%= i %>&sort=<%= sort %>&search=<%= search %>&genre_id=<%= genreId %>" 
                   class="<%= i == currentPage ? "active" : "" %>">
                    <%= i %>
                </a>
            <% } %>
            
            <% if (currentPage < totalPages) { %>
                <a href="MovieList?t_gubun=<%= tGubun %>&page=<%= currentPage + 1 %>&sort=<%= sort %>&search=<%= search %>&genre_id=<%= genreId %>"><i class="fa-solid fa-angle-right"></i></a> 
                <!-- <a href="MovieList?t_gubun=<%= tGubun %>&page=<%= totalPages %>&sort=<%= sort %>&search=<%= search %>&genre_id=<%= genreId %>"><i class="fa-solid fa-angles-right"></i></a>  -->
            <% } else { %>
	            <li class="disabled"><a href="#"><i class="fa-solid fa-angle-right"></i></a></li>
	        <% } %>
        </div>
    </div>
    
    <footer class="footer">
        <%@ include file="../common/common_footer.jsp" %>
    </footer>
<script>
	document.getElementById('search-input').addEventListener('focus', function() {
	    this.style.borderColor = '#66afe9'; // 입력 중일 때 테두리 색을 오렌지색으로
	});
	
	document.getElementById('search-input').addEventListener('blur', function() {
	    this.style.borderColor = ''; // 기본 테두리 색으로 돌아감
	});
	document.getElementById('sort').addEventListener('focus', function() {
	    this.style.borderColor = '#66afe9'; // 입력 중일 때 테두리 색을 오렌지색으로
	});
	
	document.getElementById('sort').addEventListener('blur', function() {
	    this.style.borderColor = ''; // 기본 테두리 색으로 돌아감
	});
	// 현재 URL에서 genre_id를 추출
	const urlParams = new URLSearchParams(window.location.search);
	const currentGenreId = urlParams.get('genre_id');

	// 모든 genre-item 요소를 순회하며 강조 표시 및 genre.name 설정
	document.querySelectorAll('.genre-item').forEach(item => {
	    if (item.getAttribute('data-id') === currentGenreId) {
	        item.classList.add('selected'); // 선택된 항목에 'selected' 클래스 추가
	        const selectedGenreName = item.getAttribute('data-name'); // 선택된 genre.name 추출
	        document.getElementById('selectedGenreName').textContent = selectedGenreName; // <h1> 옆에 genre.name 출력
	        function addBrackets() {
	            var spanElement = document.getElementById("selectedGenreName");
	            var text = spanElement.innerText;
	            spanElement.innerText = "(" + text + ")";
	        }

	        document.addEventListener("DOMContentLoaded", function() {
	            addBrackets();
	        });
	    }
	});
	function goReco(){
		mem.t_gubun.value="goRecoList";
		mem.method="post";
		mem.action="Index";
		mem.submit();
	}
</script>    
</body>
</html>
