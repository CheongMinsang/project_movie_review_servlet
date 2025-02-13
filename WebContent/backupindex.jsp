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

    <!-- 인기 영화 섹션 -->
    <div class="section">
        <div class="section-title"><i class="fa-solid fa-play"></i>&nbsp인기 영화 목록</div>
        <div class="slider-container">
            <button class="slider-button left" onclick="slide('popular-slider', -1)">◀</button>
            <div class="slider" id="popular-slider" data-current-index="0">
                <% JSONArray nowPlayingMovies = (JSONArray) request.getAttribute("nowPlayingMovies");
                   if (nowPlayingMovies != null) {
                       for (int i = 0; i < nowPlayingMovies.length(); i++) {
                           JSONObject movie = nowPlayingMovies.getJSONObject(i);
                           String posterPath = movie.getString("poster_path");
                           String title = movie.getString("title");
                           String releaseDate = movie.getString("release_date");
                           double voteAverage = movie.getDouble("vote_average");
                %>
                    <div class="movie">
                        <img src="https://image.tmdb.org/t/p/w200<%= posterPath %>" alt="<%= title %>">
                        <h2><%= title %></h2>
                        <p>개봉일: <%= releaseDate %></p>
                        <div class="rating"><span>★ <%= voteAverage %></span></div>
                    </div>
                <%    }
                   } else { %>
                    <p>영화 데이터를 불러오는 중 오류가 발생했습니다.</p>
                <% } %>
            </div>
            <button class="slider-button right" onclick="slide('popular-slider', 1)">▶</button>
        </div>
    </div>

    <!-- 개봉 예정 영화 섹션 -->
    <div class="section">
        <div class="section-title"><i class="fa-solid fa-play"></i>&nbsp개봉 예정 영화</div>
        <div class="slider-container">
            <button class="slider-button left" onclick="slide('upcoming-slider', -1)">◀</button>
            <div class="slider" id="upcoming-slider" data-current-index="0">
                <% JSONArray upcomingMovies = (JSONArray) request.getAttribute("upcomingMovies");
                   if (upcomingMovies != null) {
                       for (int i = 0; i < upcomingMovies.length(); i++) {
                           JSONObject movie = upcomingMovies.getJSONObject(i);
                           String posterPath = movie.getString("poster_path");
                           String title = movie.getString("title");
                           String releaseDate = movie.getString("release_date");
                           double voteAverage = movie.getDouble("vote_average");
                %>
                    <div class="movie">
                        <img src="https://image.tmdb.org/t/p/w200<%= posterPath %>" alt="<%= title %>">
                        <h2><%= title %></h2>
                        <p>개봉일: <%= releaseDate %></p>
                        <div class="rating"><span>★ <%= voteAverage %></span></div>
                    </div>
                <%    }
                   } else { %>
                    <p>영화 데이터를 불러오는 중 오류가 발생했습니다.</p>
                <% } %>
            </div>
            <button class="slider-button right" onclick="slide('upcoming-slider', 1)">▶</button>
        </div>
    </div>

    <!-- 평점 높은 영화 섹션 -->
    <div class="section">
        <div class="section-title"><i class="fa-solid fa-play"></i>&nbsp평점 높은 영화</div>
        <div class="slider-container">
            <button class="slider-button left" onclick="slide('top-rated-slider', -1)">◀</button>
            <div class="slider" id="top-rated-slider" data-current-index="0">
                <% JSONArray topRatedMovies = (JSONArray) request.getAttribute("topRatedMovies");
                   if (topRatedMovies != null) {
                       for (int i = 0; i < topRatedMovies.length(); i++) {
                           JSONObject movie = topRatedMovies.getJSONObject(i);
                           String posterPath = movie.getString("poster_path");
                           String title = movie.getString("title");
                           String releaseDate = movie.getString("release_date");
                           double voteAverage = movie.getDouble("vote_average");
                %>
                    <div class="movie">
                        <img src="https://image.tmdb.org/t/p/w200<%= posterPath %>" alt="<%= title %>">
                        <h2><%= title %></h2>
                        <p>개봉일: <%= releaseDate %></p>
                        <div class="rating"><span>★ <%= voteAverage %></span></div>
                    </div>
                <%    }
                   } else { %>
                    <p>영화 데이터를 불러오는 중 오류가 발생했습니다.</p>
                <% } %>
            </div>
            <button class="slider-button right" onclick="slide('top-rated-slider', 1)">▶</button>
        </div>
    </div>

    <!-- 영화 예매 사이트 및 앱 링크 -->
    <div class="section-title" style="margin-top: 100px;">&nbsp&nbsp&nbsp&nbsp<i class="fa-solid fa-link"></i>&nbsp예매사이트 및 영화관람추천App</div>
    <div class="cgv-link" style="margin-bottom: 100px;">
        <%@ include file="../common/common_link.jsp" %>
    </div>

    <!-- 태그별 영화 분류 -->
    <div class="section-title" style="margin-top: 100px;"><i class="fa-solid fa-hashtag"></i>태그별 영화 분류</div>
    <%@ include file="../common/common_filter.jsp" %>

    <footer class="footer">
        <%@ include file="../common/common_footer.jsp" %>
    </footer>

    <script>
    function slide(sliderId, direction) {
        const slider = document.getElementById(sliderId);
        const slideWidth = slider.querySelector('.movie').offsetWidth + 20; // 카드의 너비 + 여백
        const visibleCount = 5; // 한 번에 보이는 카드 수
        const totalItems = slider.children.length; // 슬라이더의 총 아이템 개수
        const maxScroll = Math.max(totalItems - visibleCount, 0); // 이동 가능한 최대 인덱스

        // 현재 인덱스 가져오기
        let currentIndex = parseInt(slider.dataset.currentIndex || 0);

        // 방향에 따라 인덱스 업데이트
        currentIndex += direction;

        // 인덱스 범위 조정
        if (currentIndex > maxScroll) {
            currentIndex = 0; // 처음으로 이동
        } else if (currentIndex < 0) {
            currentIndex = maxScroll; // 마지막으로 이동
        }

        // 업데이트된 인덱스를 저장
        slider.dataset.currentIndex = currentIndex;

        // 슬라이더 이동
        const nextTransform = -(slideWidth * currentIndex);
        slider.style.transform = `translateX(${nextTransform}px)`;
    }
    </script>
</body>
</html>
