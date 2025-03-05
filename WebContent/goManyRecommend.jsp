<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>최다 북마크 목록</title>
    <link href="main.css" rel="stylesheet">
    <link href="css/goManyReview.css" rel="stylesheet">
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
    	<i class="fa-solid fa-bookmark" style="color: #94c4b4;"></i>&nbsp 최다 북마크 목록
   	</h1>
   	
    <div class="recommend-container">
    	
        <c:forEach var="movie" items="${recommendedMovies}">
	        <div class="recommend-card">
	        	<a href="MovieDetail?id=${movie.getInt('id')}">
		            <img class="recommend-poster" 
		                 src="https://image.tmdb.org/t/p/w500${movie.getString('poster_path')}" 
		                 alt="${movie.getString('title')}">
		            <div class="recommend-info">
		                <div class="recommend-title">${movie.getString('dbTitle')}</div>
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
</script>        
</body>
</html>