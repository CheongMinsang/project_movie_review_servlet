<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, dto.MovieDto" %>
<%@ page buffer="64kb" autoFlush="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>모든 리뷰 목록</title>
    <link href="main.css" rel="stylesheet">
    <link href="css/goReviewManage.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <header>
        <%@ include file="../common/common_header.jsp" %>
    </header>
    <div class="review-container">
        <h2>작성한 리뷰 목록</h2>
        <div class="search-container1">
		  <div class="search-box1">
		    <select id="searchType">
		      <option value="moviename">영화명</option>
		      <option value="name">작성자명</option>
		      <option value="writeid">작성자ID</option>
		    </select>
		    <input type="text" id="searchValue" placeholder="검색어를 입력하세요">
		    <button type="button" onclick="doSearch()">검색</button>
		    <button type="button" onclick="resetSearch()">초기화</button>
		  </div>
		</div>
        <div id="reviewsContent">
            <%
            @SuppressWarnings("unchecked")
            ArrayList<MovieDto> dtos = (ArrayList<MovieDto>)request.getAttribute("dtos");
            if(dtos != null && !dtos.isEmpty()) {
                // 페이징 처리를 위한 변수
                int currentPage = 1;
                String pageParam = request.getParameter("page");
                if(pageParam != null && !pageParam.isEmpty()) {
                    currentPage = Integer.parseInt(pageParam);
                }
                
                int totalReviews = (dtos != null) ? dtos.size() : 0;
                int reviewsPerPage = 6;
                int totalPages = (int) Math.ceil((double) totalReviews / reviewsPerPage);
                
                // 현재 페이지에 표시할 리뷰의 시작 인덱스와 끝 인덱스 계산
                int startIndex = (currentPage - 1) * reviewsPerPage;
                int endIndex = Math.min(startIndex + reviewsPerPage, totalReviews);
                
                for(int i = startIndex; i < endIndex; i++) {
                    MovieDto dto = dtos.get(i);
                    int rating = dto.getRating();
                    int fullStars = rating / 2;
                    int halfStar = (rating % 2);
                    int emptyStars = 5 - fullStars - halfStar;
            %>
                <div class="review-card" id="review-<%= dto.getMovieid() %>" 
                     data-moviename="<%= dto.getMoviename().toLowerCase() %>" 
                     data-writername="<%= dto.getName().toLowerCase() %>" 
                     data-writerid="<%= dto.getWriteid().toLowerCase() %>">
                    <div class="review-header">
                        <div class="review-stars">
                            <% for(int j = 0; j < fullStars; j++) { %>
                                <i class="fa-solid fa-star"></i>
                            <% } %>
                            <% if(halfStar == 1) { %>
                                <i class="fa-solid fa-star-half-stroke"></i>
                            <% } %>
                            <% for(int j = 0; j < emptyStars; j++) { %>
                                <i class="fa-regular fa-star"></i>
                            <% } %>
                            <span class="review-info">(<%= rating %>/10)</span>
                        </div>
                        <div>
                            <span class="review-date"><%= dto.getRating_date() %></span>
                            <i class="fa-solid fa-trash delete-icon" onclick="confirmDelete('<%= dto.getMovieid() %>','<%= dto.getWriteid() %>')"></i>
                        </div>
                    </div>
                    <a href="MovieDetail?id=<%= dto.getMovieid() %>" class="review-link">
                        <div class="review-content">
                            <h3 class="movie-title"><%= dto.getMoviename() %></h3>
                            <div><strong><%= dto.getName() %></strong>님의 리뷰</div>
                            <p><%= dto.getContent() %></p>
                        </div>
                    </a>
                </div>
            <%
                }
                
                // 페이지네이션 링크 생성
                %>
                <ul class="pagination">
                    <% if(currentPage > 1) { %>
                        <li><a href="?t_gubun=goReviewManage&page=<%= currentPage - 1 %>"><i class="fa-solid fa-angle-left"></i></a></li>
                    <% } else { %>
                        <li class="disabled"><a href="#"><i class="fa-solid fa-angle-left"></i></a></li>
                    <% } %>
                    
                    <% 
                    int startPage = Math.max(1, currentPage - 2);
                    int endPage = Math.min(totalPages, startPage + 4);
                    startPage = Math.max(1, endPage - 4);
                    
                    for(int i = startPage; i <= endPage; i++) { 
                    %>
                        <li<%= i == currentPage ? " class=\"active\"" : "" %>><a href="?t_gubun=goReviewManage&page=<%= i %>"><%= i %></a></li>
                    <% } %>
                    
                    <% if(currentPage < totalPages) { %>
                        <li><a href="?t_gubun=goReviewManage&page=<%= currentPage + 1 %>"><i class="fa-solid fa-angle-right"></i></a></li>
                    <% } else { %>
                        <li class="disabled"><a href="#"><i class="fa-solid fa-angle-right"></i></a></li>
                    <% } %>
                </ul>
            <%
            } else {
            %>
            <div class="no-reviews">
                <p>작성한 리뷰가 없습니다.</p>
            </div>
            <%
            }
            %>
        </div>
    </div>

    <!-- 푸터 -->
    <footer class="footer">
        <%@ include file="../common/common_footer.jsp" %>
    </footer>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        function confirmDelete(movieId, writeId) {
            if (confirm("해당 리뷰를 삭제하시겠습니까?")) {
                deleteReview(movieId, writeId);
            }
        }
        function deleteReview(movieId, writeId) {
            $.ajax({
                url: "Index", // 컨트롤러 메인 서블릿으로 요청 전송
                type: "POST",
                data: {
                    t_gubun: "MemberRatingDelete", // MyReviewDelete 클래스 호출을 위한 구분자
                    movieId: movieId,
                    writeId: writeId
                },
                success: function(response) {
                    // DB에서 삭제는 성공했으므로 화면에서도 리뷰 카드 제거
                    $("#review-" + movieId).fadeOut(300, function() {
                        $(this).remove();
                        
                        // 남은 리뷰가 없는지 확인하고 메시지 표시
                        if ($(".review-card:visible").length === 0) {
                            if($(".no-reviews").length === 0) {
                                $(".review-container").append(
                                    '<div class="no-reviews"><p>작성한 리뷰가 없습니다.</p></div>'
                                );
                            } else {
                                $(".no-reviews").show();
                            }
                            $(".pagination").hide();
                        }
                        
                        // 성공 메시지 표시
                        alert("리뷰가 삭제되었습니다!");
                    });
                },
                error: function(xhr, status, error) {
                    alert("리뷰 삭제 중 오류가 발생했습니다: " + error);
                }
            });
        }
        
        // 검색 함수: 입력값이 없으면 전체검색 수행
        function doSearch() {
            var searchValue = document.getElementById("searchValue").value;
            var searchType = document.getElementById("searchType").value;
            if(searchValue.trim() === ""){
                // 입력값이 없으면 전체검색(검색 파라미터 없이 이동)
                window.location.href = "Index?t_gubun=goReviewManage";
            } else {
                window.location.href = "Index?t_gubun=goReviewManage&searchType=" 
                                   + searchType + "&searchValue=" + encodeURIComponent(searchValue);
            }
        }

        // 초기화 함수: 검색 입력값과 선택값 초기화 후 전체검색 페이지로 이동
        function resetSearch() {
            document.getElementById("searchValue").value = "";
            document.getElementById("searchType").selectedIndex = 0;
            window.location.href = "Index?t_gubun=goReviewManage";
        }

        // 엔터키 이벤트: 검색 입력창에서 엔터를 누르면 doSearch() 호출
        document.getElementById("searchValue").addEventListener("keyup", function(event) {
            if (event.key === "Enter") {
                doSearch();
            }
        });
    </script>
</body>
</html>