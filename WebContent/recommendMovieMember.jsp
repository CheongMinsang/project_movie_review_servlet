<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>추천 영화 목록</title>
    <link href="main.css" rel="stylesheet">
    <style>
        .recommend-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
        
        .recommend-card {
            width: 300px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: transform 0.3s ease;
        }
        
        .recommend-card:hover {
            transform: translateY(-5px);
        }
        
        .recommend-card a {
		    text-decoration: none;
		    color: inherit;
		    display: block;
		}
        
        .recommend-poster {
            width: 100%;
            height: 450px;
            object-fit: cover;
        }
        
        .recommend-info {
            padding: 15px;
        }
        
        .recommend-title {
            font-size: 1.2em;
            font-weight: bold;
            margin-bottom: 10px;
            color: black;
        }
        
        .recommend-rating {
            color: #f5c518;
            color: gold;
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        .recommend-date {
            color: #2a2a2a;
            font-size: 0.9em;
        }
    </style>
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
			<button class="filter-btn2 filter-btn7" onclick="goManyReview()"><i class="fa-solid fa-comments"></i> 리뷰 많은 순</button>
		</div>	
	</div>				
    
    <h1 style="text-align:center; margin-bottom:60px; margin-top:80px; color:#333;">
    	<i class="fa-solid fa-play"></i>&nbsp내가 저장한 영화
   	</h1>
   	
    <div class="recommend-container">
    	
        <c:forEach var="movie" items="${recommendedMovies}">
	        <div class="recommend-card">
	        	<a href="MovieDetail?id=${movie.getInt('id')}">
		            <img class="recommend-poster" 
		                 src="https://image.tmdb.org/t/p/w500${movie.getString('poster_path')}" 
		                 alt="${movie.getString('title')}">
		            <div class="recommend-info">
		                <div class="recommend-title">${movie.getString('title')}</div>
		                <div class="recommend-rating"><i class="fa-solid fa-star"></i> ${movie.getDouble('vote_average')}</div>
		                <div class="recommend-date">개봉일: ${movie.getString('release_date')}</div>
		            </div>
		         </a>   
	         </div>
        </c:forEach>
    </div>
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
	function goManyReview(){
		mem.t_gubun.value="goManyReview";
		mem.method="post";
		mem.action="Index";
		mem.submit();
	}
</script>        
</body>
</html>