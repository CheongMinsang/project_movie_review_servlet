<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.JSONArray, org.json.JSONObject" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TRACK19기 정민상 영화 리뷰</title>
    <link href="main.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick-theme.min.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.js"></script>
<style>
    .slick-prev:before, .slick-next:before {
        font-size: 40px; /* 버튼 내부 아이콘 크기 증가 */
    }

    .section {
        position: relative; /* 섹션을 상대적으로 배치 */
    }

    .slick-prev, .slick-next {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        z-index: 1000;
    }

    .slick-prev {
        left: -5px; /* 왼쪽 끝으로 위치 조정 */
    }

    .slick-next {
        right: 25px; /* 오른쪽 끝으로 위치 조정 */
    }
</style>


    <script type="text/javascript">
        $(document).ready(function(){
            $('.slider').slick({
                slidesToShow: 5,
                slidesToScroll: 5,
                infinite: true,
                prevArrow: '<button type="button" class="slick-prev">◀</button>',
                nextArrow: '<button type="button" class="slick-next">▶</button>'
            });
        });
    </script>
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
	
	<style>
	  .section .section-title1 i {
	    color: red;
	  }
	</style>
	
    <!-- 인기 영화 섹션 -->
    <div class="section">
        <div class="section-title section-title1">
        	<i class="fa-solid fa-fire"></i>&nbsp인기 영화 목록
        	<a href="MovieList?t_gubun=popular&page=1" class="more-link">more</a>
        </div>
        <div class="slider-container">
            <div class="slider" id="popular-slider">
                <%
                    JSONArray nowPlayingMovies = (JSONArray) request.getAttribute("nowPlayingMovies");
                    if (nowPlayingMovies != null) {
                        for (int i = 0; i < nowPlayingMovies.length(); i++) {
                            JSONObject movie = nowPlayingMovies.getJSONObject(i);
                            String movieId = movie.optString("id", "N/A"); // 안전하게 id 가져오기
                            String title = movie.optString("title", "Unknown Title");
                            String releaseDate = movie.getString("release_date");
                            double voteAverage = movie.getDouble("vote_average");
                %>
                <div class="movie">
				    <a href="MovieDetail?id=<%= movieId %>">
				        <img src="https://image.tmdb.org/t/p/w500<%= movie.optString("poster_path", "") %>" 
				             alt="<%= title %>">
				        <div class="movie-info">
				            <h2><%= title %></h2>
				            <div class="rating"><span><i class="fa-solid fa-star"></i> <%= String.format("%.1f", voteAverage) %></div>
				            <p>개봉일: <%= releaseDate %></p>
				        </div>
				    </a>
				</div>
                <%
                        }
                    }
                %>
            </div>
        </div>
    </div>

	<style>
	  .section .section-title2 i {
	    color: #c094c4;
	  }
	</style>
	
    <!-- 개봉 예정 영화 섹션 -->
    <div class="section">
        <div class="section-title section-title2">
        	<i class="fa-solid fa-calendar"></i>&nbsp개봉 예정 영화
        	<a href="MovieList?t_gubun=upcoming&page=1" class="more-link">more</a>
        </div>
        <div class="slider-container">
            <div class="slider" id="upcoming-slider">
                <% JSONArray upcomingMovies = (JSONArray) request.getAttribute("upcomingMovies");
                   if (upcomingMovies != null) {
                       for (int i = 0; i < upcomingMovies.length(); i++) {
                           JSONObject movie = upcomingMovies.getJSONObject(i);
                           String movieId = movie.optString("id", "N/A"); // 안전하게 id 가져오기
                           String title = movie.optString("title", "Unknown Title");
                           String releaseDate = movie.getString("release_date");
                           double voteAverage = movie.getDouble("vote_average");
                %>
                <div class="movie">
				    <a href="MovieDetail?id=<%= movieId %>">
				        <img src="https://image.tmdb.org/t/p/w500<%= movie.optString("poster_path", "") %>" 
				             alt="<%= title %>">
				        <div class="movie-info">
				            <h2><%= title %></h2>
				            <div class="rating"><span><i class="fa-solid fa-star"></i> <%= String.format("%.1f", voteAverage) %></div>
				            <p>개봉일: <%= releaseDate %></p>
				        </div>
				    </a>
				</div>
                <%    }
                   } else { %>
                    <p>영화 데이터를 불러오는 중 오류가 발생했습니다.</p>
                <% } %>
            </div>
        </div>
    </div>
	
	<style>
	  .section .section-title3 i {
	    color: gold;
	  }
	</style>
	
    <!-- 평점 높은 영화 섹션 -->
    <div class="section">
        <div class="section-title section-title3">
        	<i class="fa-solid fa-star"></i>&nbsp평점 높은 영화
        	<a href="MovieList?t_gubun=top_rated&page=1" class="more-link">more</a>
        </div>
        <div class="slider-container">
            <div class="slider" id="top-rated-slider">
                <% JSONArray topRatedMovies = (JSONArray) request.getAttribute("topRatedMovies");
                   if (topRatedMovies != null) {
                       for (int i = 0; i < topRatedMovies.length(); i++) {
                           JSONObject movie = topRatedMovies.getJSONObject(i);
                           String movieId = movie.optString("id", "N/A"); // 안전하게 id 가져오기
                           String title = movie.optString("title", "Unknown Title");
                           String releaseDate = movie.getString("release_date");
                           double voteAverage = movie.getDouble("vote_average");
                %>
                <div class="movie">
				    <a href="MovieDetail?id=<%= movieId %>">
				        <img src="https://image.tmdb.org/t/p/w500<%= movie.optString("poster_path", "") %>" 
				             alt="<%= title %>">
				        <div class="movie-info">
				            <h2><%= title %></h2>
				            <div class="rating"><span><i class="fa-solid fa-star"></i> <%= String.format("%.1f", voteAverage) %></div>
				            <p>개봉일: <%= releaseDate %></p>
				        </div>
				    </a>
				</div>
                <%    }
                   } else { %>
                    <p>영화 데이터를 불러오는 중 오류가 발생했습니다.</p>
                <% } %>
            </div>
        </div>
    </div>

    <!-- 영화 예매 사이트 및 앱 링크 -->
    <div class="section-title" style="margin-top: 100px;">&nbsp&nbsp&nbsp&nbsp<i class="fa-solid fa-link"></i>&nbsp예매사이트 및 영화관람추천App</div>
    <div class="cgv-link" style="margin-bottom: 100px;">
        <%@ include file="../common/common_link.jsp" %>
    </div>
	
    <!-- 태그별 영화 분류 -->
    <div class="section-title section-title1" style="margin-top: 100px;"><i class="fa-solid fa-hashtag" style="color: #ffa500;"></i>&nbsp태그별 영화 분류</div>
    <%@ include file="../common/common_filter.jsp" %>

    <footer class="footer">
        <%@ include file="../common/common_footer.jsp" %>
    </footer>
<script type="text/javascript">
	function goReco(){
		mem.t_gubun.value="goRecoList";
		mem.method="post";
		mem.action="Index";
		mem.submit();
	}
</script>    
</body>
</html>
