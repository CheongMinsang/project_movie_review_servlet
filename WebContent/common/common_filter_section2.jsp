<%@ page pageEncoding="UTF-8"%>
<div class="filter-section2">
	<div class="award-filter">
		<a href="MovieList?t_gubun=popular&page=1">
			<button class="filter-btn2"><!--  <i class="fa-solid fa-fire"></i>--> 인기 영화 목록</button>
		</a>
		<a href="MovieList?t_gubun=upcoming&page=1">	
			<button class="filter-btn2"><!-- <i class="fa-solid fa-calendar"></i>--> 개봉 예정 목록</button>
		</a>
		<a href="MovieList?t_gubun=top_rated&page=1">
			<button class="filter-btn2"> <!--<i class="fa-solid fa-star"></i>--> 높은 평점 목록</button>
		</a>	
		<button class="filter-btn2" onclick="goReco()"> <!-- <i class="fa-solid fa-thumbs-up"></i>--> 추천 영화 목록</button>
		<button class="filter-btn2" onclick="goManyReview()"> <!-- <i class="fa-solid fa-comments"></i>--> 최다 리뷰 목록</button>
		<button class="filter-btn2" onclick="goManyRecommend()"> <!-- <i class="fa-solid fa-comments"></i>--> 최다 북마크 목록</button>
	</div>	
</div>