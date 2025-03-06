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
		<%@ include file="../common/common_filter_section2.jsp" %>			
    
    <h1 style="text-align:center; margin-bottom:60px; margin-top:80px; color:#333;">
    	<i class="fa-solid fa-play" style="color: #66afe9"></i>&nbsp추천 영화 목록
   	</h1>
   	
        <div class="recommend-container">
		    <!-- 데이터가 없는 경우 메시지 표시 -->
		    <c:if test="${empty recommendedMovies}">
		        <div style="text-align: center; width: 100%; padding: 50px; color: #666;">
		            <i class="fa-solid fa-exclamation-circle" style="color: #ff6b6b;"></i>
		            <p style="font-size: 1.2em; margin-top: 10px;">추천 영화가 없습니다.</p>
		            <p>추천 영화를 등록해보세요!</p>
		        </div>
		    </c:if>
		
		    <!-- 데이터가 있는 경우 영화 목록 표시 -->
		    <c:if test="${not empty recommendedMovies}">
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
		    </c:if>
		</div>
    <footer class="footer">
        <%@ include file="../common/common_footer.jsp" %>
    </footer>
<script type="text/javascript">
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
</script>        
</body>
</html>