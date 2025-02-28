<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.json.JSONArray, org.json.JSONObject" %>
<%@ page import="dao.*,dto.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    // "id"라는 이름의 쿼리 파라미터 값을 가져와서 String 변수에 저장합니다.
    String movieId = request.getParameter("id");

	MovieDao dao = new MovieDao();
	ArrayList<MovieDto> dtos = dao.getRatingList(movieId);
	
	String writeMan = (String) session.getAttribute("sessionId");
	
	int count = dao.getRecommendList(movieId,writeMan);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>영화 상세 정보</title>
    <link href="movieDetail.css" rel="stylesheet">
    <link href="main.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.css"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.js"></script>
	<script src="js/jquery-1.8.1.min.js"></script>
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
	
        <%
        JSONObject movieDetail = (JSONObject) request.getAttribute("movieDetail");
        JSONArray trailers = (JSONArray) request.getAttribute("movieTrailers");
        JSONArray crew = (JSONArray) request.getAttribute("movieCrew");
        if (movieDetail != null) {
            JSONArray genres = movieDetail.optJSONArray("genres");
            JSONArray productionCountries = movieDetail.optJSONArray("production_countries");

            String genreNames = "";
            if (genres != null) {
                for (int i = 0; i < genres.length(); i++) {
                    JSONObject genre = genres.getJSONObject(i);
                    genreNames += genre.optString("name", "N/A") + (i < genres.length() - 1 ? ", " : "");
                }
            } else {
                genreNames = "N/A";
            }

            String countryNames = "";
            if (productionCountries != null) {
                for (int i = 0; i < productionCountries.length(); i++) {
                    JSONObject country = productionCountries.getJSONObject(i);
                    countryNames += country.optString("name", "N/A") + (i < productionCountries.length() - 1 ? ", " : "");
                }
            } else {
                countryNames = "N/A";
            }

            String director = "N/A";
            if (crew != null) {
                for (int i = 0; i < crew.length(); i++) {
                    JSONObject crewMember = crew.getJSONObject(i);
                    if ("Director".equals(crewMember.optString("job"))) {
                        director = crewMember.optString("name", "N/A");
                        break;
                    }
                }
            }
        %>
        <div class="container">
		    <div class="header" style="position: relative;">
		        <!-- <a href="javascript:history.back()" class="home-link">&nbsp&nbsp<i class="fa-solid fa-arrow-left"></i> </a> -->
		        <!-- h1에 클래스 적용 -->
	            <h1 class="movie-header-title">
	                <%= movieDetail.optString("title", "Unknown Movie") %>
	            </h1>
	            <!-- sessionLevel이 'top'일 경우에만 버튼 표시 -->
	            <c:if test="${sessionLevel eq 'top'}">
	                <button type="button" class="recommend-btn">
	                	<!-- <i class="fa-solid fa-circle-check"></i> 추천영화등록하기 --> 
	                	<% if(count == 0){ %>
	                	<a href="javascript:goRecommendSave('top')" style="text-decoration: none; color: inherit;">
	                		<i class="fa-regular fa-circle-check"></i> 추천 영화 등록
	                	</a>
		               	<% } else if(count == 1){ %>	
			                	<a href="javascript:goRecommendDelete('top')" style="text-decoration: none; color: inherit;">
			                		<i class="fa-regular fa-circle-xmark"></i> 추천 영화 삭제
			                	</a>
		                <% } %>
	                </button>
	            </c:if>
	            <c:if test="${sessionLevel eq 'member'}">
	                <button type="button" class="recommend-btn">
	                	<!-- <i class="fa-solid fa-circle-check"></i> 추천영화등록하기 --> 
	                	<% if(count == 0){ %>
	                	<a href="javascript:goRecommendSave('member')" style="text-decoration: none; color: inherit;">
	                		<i class="fa-regular fa-bookmark"></i> 북마크
	                	</a>
		               	<% } else if(count == 1){ %>	
			                	<a href="javascript:goRecommendDelete('member')" style="text-decoration: none; color: inherit;">
			                		<i class="fa-solid fa-bookmark"></i> 북마크 해제
			                	</a>
		                <% } %>
	                </button>
	            </c:if>
	        </div>
            <div class="movie-details">
                <div class="movie-poster">
                    <img src="https://image.tmdb.org/t/p/w500<%= movieDetail.optString("poster_path", "") %>" alt="포스터">
                </div>
                <div class="movie-info movie-info2" style="background-color: white;">
                    <h2>영화 정보</h2>
                    <p>개봉일: <%= movieDetail.optString("release_date", "N/A") %></p>
                    <p class="vote-average"><i class="fa-solid fa-star"></i> <%= String.format("%.1f", movieDetail.optDouble("vote_average", 0.0)) %></p>
                    <p>장르: <%= genreNames %></p>
                    <p>상영 시간: <%= movieDetail.optInt("runtime", 0) %>분</p>
                    <p>제작 국가: <%= countryNames %></p>
                    <p class="overview"><%= movieDetail.optString("overview", "상세 정보가 없습니다.") %></p>
                </div>	
            </div>
            <div class="movie-extra">
                <h2 align="center">예고편</h2>
                <% if (trailers != null && trailers.length() > 0) { 
                    JSONObject trailer = trailers.getJSONObject(0); %>
                    <div class="trailer">
                        <iframe src="https://www.youtube.com/embed/<%= trailer.optString("key") %>" frameborder="0" allowfullscreen></iframe>
                    </div>
                <% } else { %>
                    <p>예고편 정보가 없습니다.</p>
                <% } %>
            </div>
            <div class="movie-extra">
                <h3>감독</h3>
                <p><%= director %></p>
            </div>
        <%
        } else {
        %>
            <p>영화 정보를 가져오는 중 오류가 발생했습니다.</p>
        <%
        }
        %>
		
		  <!-- 세션의 값으로 sessionId를 초기화 -->
	  <script>
	    var sessionId = '<%= session.getAttribute("sessionId") == null ? "" : session.getAttribute("sessionId") %>';
	  </script>
		
		<div class="review-list">
        <h2>사이트 리뷰 목록</h2>
        <%
            // ArrayList<MovieDto> dtos가 request에 저장되어 있다고 가정합니다.
            if(dtos != null && !dtos.isEmpty()){
                for(MovieDto dto : dtos) {
                    // rating은 0 ~ 10 사이의 값으로 저장되어 있다고 가정
                    int rating = dto.getRating();
                    int fullStars = rating / 2;               // 예: 7 -> 3
                    int halfStar = (rating % 2);                // 예: 7 -> 1 (있으면 1)
                    int emptyStars = 5 - fullStars - halfStar;  // 나머지 빈 별
        %>
        <div class="review-item" <%
        	 String sessionLevel = (String)session.getAttribute("sessionLevel");
	         String sessionId = (String) session.getAttribute("sessionId");
	         String writeId = dto.getWriteid();
	         if (sessionId != null && sessionId.equals(writeId)) {
	       %>
	         id="myReview" data-rating="<%= dto.getRating() %>" data-content="<%= dto.getContent() %>"
	       <%
	         }
	       %>
        >
        
            <div class="review-header">
                <div class="review-stars">
                    <%  // 꽉 찬 별 출력  %>
                    <% for(int i = 0; i < fullStars; i++) { %>
                        <i class="fa-solid fa-star"></i>
                    <% } %>
                    <%  // 반 별 (있으면 한 개만 출력)  %>
                    <% if(halfStar == 1) { %>
                        <i class="fa-solid fa-star-half-stroke"></i>
                    <% } %>
                    <%  // 빈 별 출력  %>
                    <% for(int i = 0; i < emptyStars; i++) { %>
                        <i class="fa-regular fa-star"></i>
                    <% } %>
                </div>
                <div class="review-nickname"><%= dto.getNickname() %>&nbsp;&nbsp;
                	<% 
	
	              	    if (sessionId != null && sessionId.equals(writeId)) {
	              	%>
	              		<a href="javascript:goFix();" class="review-link"><i class="fa-solid fa-pen-to-square"></i>수정</a>&nbsp;
	              		<a href="javascript:goDelete();" class="review-link"><i class="fa-regular fa-circle-xmark"></i>삭제</a>
	              	<%
	              	    } if (sessionLevel != null && sessionLevel.equals("top")) {
	              	%>    	
	              	    <a href="javascript:goDelete();" class="review-link"><i class="fa-regular fa-circle-xmark"></i>삭제</a>
	              	<%    	
	              	    }
                	%>
                </div>
            </div>
            <div class="review-content">
                <%= dto.getContent() %>
            </div>
            <div class="review-date">
                <%= dto.getRating_date() %>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <p>리뷰가 없습니다. 리뷰를 남겨보세요!</p>
        <%
            }
        %>
    </div>
		
        <div class="movie-review" id="movie-review"> 
		    <h2>리뷰 작성하기</h2>
		    <!-- form 액션 및 메서드는 환경에 맞게 수정 -->
			<form id="reviewForm" name="reviewForm" action="Index" method="post">
			  <!-- 등록 시 기본값은 reviewSave -->
			  <!-- 값을 비워두고 JavaScript에서 설정하도록 변경 -->
			  <input type="hidden" name="t_gubun" id="reviewT_gubun" value="">
			  <input type="hidden" name="movieId" id="reviewMovieId" value="">
			  <input type="hidden" name="movieName" id="reviewMovieName" value="<%= movieDetail.optString("title", "Unknown Movie") %>">
			  <!-- 선택된 별점 값을 전송하기 위한 히든필드 -->
			  <input type="hidden" id="ratingValue" name="ratingValue" value="0">
			  
			  <!-- 별점 선택 영역 (5개의 별, 각 별은 2점 가치) -->
			  <div class="star-rating" id="starRating">
			    <i class="fa-regular fa-star" data-index="1"></i>
			    <i class="fa-regular fa-star" data-index="2"></i>
			    <i class="fa-regular fa-star" data-index="3"></i>
			    <i class="fa-regular fa-star" data-index="4"></i>
			    <i class="fa-regular fa-star" data-index="5"></i>
			  </div>
			  
			  <!-- 리뷰 작성 텍스트 영역 -->
			  <textarea name="reviewContent" id="reviewContent" placeholder="리뷰를 작성하세요"></textarea>
			  <button type="submit">등록</button>
			</form>
			<form name="reco">
				<input type="hidden" name="t_gubun" id="recoT_gubun" value="">
				<input type="hidden" name="movieId" id="movieId" value="">
				<input type="hidden" name="movieName" id="recoMovieName" value="<%= movieDetail.optString("title", "Unknown Movie") %>">
			</form>
		  </div>
    </div>
	<footer class="footer">
		<%@ include file="../common/common_footer.jsp" %>
	</footer>
<script type="text/javascript">
	var isUpdateMode = false; // false: 등록 모드, true: 수정 모드

	const ids = ['reviewContent'];
	
	ids.forEach(id => {
	    const element = document.getElementById(id);
	    element.addEventListener('focus', function() {
	        this.style.borderColor = '#292A31'; // 입력 중일 때 테두리 색을 오렌지색으로
	    });
	
	    element.addEventListener('blur', function() {
	        this.style.borderColor = ''; // 기본 테두리 색으로 돌아감
	    });
	});
	
    /***********************
     * 1. URL에서 movieId 추출 및 할당
     ***********************/
    const urlParams = new URLSearchParams(window.location.search);
    const movieIdParam = urlParams.get('id');
    if(movieIdParam) {
      document.getElementById('reviewMovieId').value = movieIdParam;
    }
    
    /***********************
     * 2. 별점 선택 기능
     *  - 각 별은 2점의 가치를 지님 (총 10점)
     *  - 마우스 오버 시 해당 별의 왼쪽(반칸, 1점) 또는 오른쪽(한칸, 2점) 위치를 감지하여 임시로 별 상태 변경
     *  - 클릭 시 고정되고, 히든필드에 값이 설정되어 폼 전송됨.
     ***********************/
    const starRating = document.getElementById('starRating');
    const stars = starRating.getElementsByTagName('i');
    const ratingValueInput = document.getElementById('ratingValue');
    let fixedRating = 0; // 클릭으로 고정된 별점 (0~10)
    
    // 별의 상태를 업데이트하는 함수
    function updateStars(rating) {
      for (let i = 0; i < stars.length; i++) {
        const fullThreshold = (i + 1) * 2;       // 예: 첫번째 별이면 2, 두번째 별이면 4, ...
        const halfThreshold = fullThreshold - 1;   // 예: 첫번째 별이면 1, 두번째 별이면 3, ...
        if (rating >= fullThreshold) {
          stars[i].className = "fa-solid fa-star";
          stars[i].style.color = "#FFD700"; // 골드 컬러
        } else if (rating === halfThreshold) {
          stars[i].className = "fa-solid fa-star-half-stroke";
          stars[i].style.color = "#FFD700";
        } else {
          stars[i].className = "fa-regular fa-star";
          stars[i].style.color = "#ccc";
        }
      }
    }
    
    // 각 별에 마우스 이벤트 부여
    Array.from(stars).forEach((star, index) => {
      star.addEventListener('mousemove', function(e) {
        if (fixedRating) return; // 이미 고정된 경우 변경하지 않음
        const rect = star.getBoundingClientRect();
        const offsetX = e.clientX - rect.left;
        let tempRating = (offsetX < rect.width / 2) ? (index * 2) + 1 : (index + 1) * 2;
        updateStars(tempRating);
      });
      
      star.addEventListener('mouseleave', function(e) {
        updateStars(fixedRating);
      });
      
      star.addEventListener('click', function(e) {
        const rect = star.getBoundingClientRect();
        const offsetX = e.clientX - rect.left;
        fixedRating = (offsetX < rect.width / 2) ? (index * 2) + 1 : (index + 1) * 2;
        ratingValueInput.value = fixedRating;
        updateStars(fixedRating);
      });
    });
    
    starRating.addEventListener('mouseleave', function(e) {
      updateStars(fixedRating);
    });
    
    /***********************
     * 3. 폼 제출 시 검증
     ***********************/
     document.getElementById('reviewForm').addEventListener('submit', function(e) {
    	    e.preventDefault();
    	    
    	    // 로그인 체크
    	    if (!sessionId || sessionId === "null") {
    	       alert("로그인이 필요합니다");
    	       window.location.href = "Index?t_gubun=login";
    	       return;
    	    }
    	    
    	    // 리뷰 내용 입력 여부 체크
    	    const reviewContent = document.getElementById('reviewContent').value.trim();
    	    if (reviewContent === "") {
    	       alert("내용을 입력해주세요");
    	       return;
    	    }
    	    
    	    // 별점 선택 여부 체크
    	    if (parseInt(document.getElementById('ratingValue').value) === 0) {
    	       alert("별점을 선택해주세요");
    	       return;
    	    }
    	    
    	    // URL에서 id 값 추출
    	    const urlParams = new URLSearchParams(window.location.search);
    	    const id = urlParams.get('id');
    	    if (!id) {
    	       console.error("URL에서 id 값을 찾을 수 없습니다.");
    	       return;
    	    }
    	    
    	    if (isUpdateMode) {
    	        document.getElementById('reviewT_gubun').value = "ReviewUpdate";
    	        this.submit();
    	    } else {
    	    	document.getElementById('reviewT_gubun').value = "reviewSave";
    	         // 등록 모드: AJAX 호출로 중복 등록 여부 확인
    	         $.ajax({
    	             url: "CheckRatingMember",
    	             type: "GET",
    	             data: { 
    	               id: id,
    	               sessionId: sessionId
    	             },
    	             dataType: "json",
    	             success: function(data) {
    	                 if (data.count == 1) {
    	                     alert("이미 리뷰를 작성하였습니다!");
    	                     return;
    	                 } else {
	   	                	   document.getElementById('reviewT_gubun').value = "reviewSave";
	   	                       document.getElementById('reviewForm').submit();
    	                 }
    	             },
    	             error: function(xhr, status, error) {
    	                 console.error("데이터를 가져오는 데 실패했습니다:", error);
    	             }
    	         });
    	    }
    	});
     // URL에서 ID 값을 추출하는 함수
     function getIdFromUrl() {
         const urlParams = new URLSearchParams(window.location.search);
         return urlParams.get('id');
     }
    
     function goFix(){
    	    var myReview = document.getElementById('myReview');
    	    if (!myReview) {
    	        alert("수정할 리뷰를 찾을 수 없습니다.");
    	        return;
    	    }
    	    
    	    // 기존 리뷰 데이터 가져오기
    	    var rating = myReview.getAttribute('data-rating');
    	    var content = myReview.getAttribute('data-content');
    	    
    	    // movieId 가져오기
    	    const movieId = getIdFromUrl();
    	    if (!movieId) {
    	        alert("영화 정보를 찾을 수 없습니다.");
    	        return;
    	    }
    	    
    	    // 폼에 기존 데이터 채워넣기
    	    document.getElementById('reviewMovieId').value = movieId;
    	    document.getElementById('ratingValue').value = rating;
    	    document.getElementById('reviewContent').value = content;
    	    document.getElementById('reviewT_gubun').value = "ReviewUpdate";  // ID를 사용하여 직접 접근
    	    
    	    fixedRating = parseInt(rating);
    	    updateStars(fixedRating);
    	    
    	    isUpdateMode = true;
    	    
    	    // 버튼 텍스트를 "수정"으로 변경
    	    document.querySelector('#reviewForm button[type="submit"]').textContent = "수정";
    	    
    	    // 수정 폼 영역으로 스크롤 이동
    	    document.getElementById('movie-review').scrollIntoView({ behavior: 'smooth' });
    	}
    
    function goDelete(){
		if (confirm("리뷰를 삭제하시겠습니까?")) {
			reviewForm.t_gubun.value = "RatingDelete";
			reviewForm.method      = "post";
			reviewForm.action      = "Index";
			reviewForm.submit();
		} else {
			return;
		}    	
    }
    function goRecommendSave(sessionLevel) {
    	const movieId = getIdFromUrl();
        document.getElementById('movieId').value = movieId;

        // sessionLevel에 따라 다른 confirm 메시지 표시
        const confirmMessage = sessionLevel === 'top' 
            ? "추천 영화로 등록하시겠습니까?" 
            : "북마크에 등록하시겠습니까?";
            
        if (confirm(confirmMessage)) {
            document.reco.t_gubun.value = "goSaveRecommend";
            document.reco.method = "post";
            document.reco.action = "Index";
            document.reco.submit();
        } else {
            return;
        }
    }
    function goRecommendDelete(sessionLevel) {
    	const movieId = getIdFromUrl();
        document.getElementById('movieId').value = movieId;

        // sessionLevel에 따라 다른 confirm 메시지 표시
        const confirmMessage = sessionLevel === 'top' 
            ? "추천 영화 목록에서 삭제하시겠습니까?" 
            : "북마크에서 삭제하시겠습니까?";
            
        if (confirm(confirmMessage)) {
            document.reco.t_gubun.value = "goDeleteRecommend";
            document.reco.method = "post";
            document.reco.action = "Index";
            document.reco.submit();
        } else {
            return;
        }
    }
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
<style>
	body {
	background-color: white; 
	background-size: cover; 
	color: black; 
	font-family: Arial, sans-serif; 
	margin: 0; 
	padding: 0;
	}
</style>
</html>
