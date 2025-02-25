<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.MovieDto" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>모든 리뷰 목록</title>
    <link href="main.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <style>
        .review-container {
            max-width: 800px;
            margin: 30px auto;
            padding: 20px;
            margin-top: 100px;
        }
        h2{
            color: #333;
            margin-bottom: 30px;
        }
        .review-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 20px;
            margin-bottom: 20px;
            transition: transform 0.2s;
        }
        
        .review-card:hover {
            transform: translateY(-5px);
        }
        
        .review-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .review-stars {
            color: #ffd700;
            font-size: 18px;
        }
        
        .review-info {
            color: #666;
            font-size: 14px;
        }
        
        .review-content {
            color: #333;
            line-height: 1.6;
            margin: 15px 0;
        }
        
        .review-link {
            text-decoration: none;
            color: inherit;
        }
        
        .review-date {
            color: #888;
            font-size: 14px;
        }
        
        .no-reviews {
            text-align: center;
            padding: 50px;
            color: #666;
        }
        .movie-title {
            font-size: 1.3em;
            color: #2c3e50;
            margin: 0 0 10px 0;
            padding-bottom: 8px;
            border-bottom: 1px solid #eee;
        }
        
        .delete-btn {
            background: #ff5252;
            color: white;
            border: none;
            border-radius: 4px;
            padding: 5px 10px;
            cursor: pointer;
            font-size: 12px;
            transition: background 0.2s;
        }
        .delete-btn:hover {
            background: #ff1a1a;
        }
        
        .delete-icon {
            color: #ff5252;
            cursor: pointer;
            font-size: 16px;
            transition: color 0.2s;
            margin-left: 10px;
        }
        .delete-icon:hover {
            color: #ff1a1a;
        }
        
        /* 페이징 스타일 */
        .pagination {
            display: flex;
            justify-content: center;
            list-style: none;
            padding: 0;
            margin-top: 30px;
        }
        
        .pagination li {
            margin: 0 5px;
        }
        
        .pagination a {
        	margin: 0 3px; /* 중앙 정렬을 유지하면서 여백 조정 */
            display: block;
            padding: 10px 25px;
            text-decoration: none;
            color: #666;
            border-radius: 20px;
            transition: background 0.3s, color 0.3s;
        }
        
        .pagination a:hover {
            background: #f0f0f0;
        }
        
        .pagination .active a {
            background: #292A31;
            color: white;
        }
        
        .pagination .disabled a {
            color: #ccc;
            cursor: not-allowed;
        }
        
        /* 검색 스타일 */
        .search-container1 {
            margin-bottom: 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .search-box1 {
            display: flex;
            align-items: center;
            width: 70%;
        }
        
        .search-input1 {
            flex-grow: 1;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px 0 0 4px;
            font-size: 14px;
        }
        
        .search-select1 {
            padding: 11px;
            border: 1px solid #ddd;
            border-right: none;
            border-radius: 4px 0 0 4px;
            background-color: #f8f8f8;
            font-size: 14px;
            cursor: pointer;
        }
        
        .search-button1 {
            padding: 10px 15px;
            background: #4a90e2;
            color: white;
            border: none;
            border-radius: 0 4px 4px 0;
            cursor: pointer;
            transition: background 0.3s;
        }
        
        .search-button1:hover {
            background: #3a80d2;
        }
        
        .reset-button1 {
            padding: 10px 15px;
            background: #ff5252;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background 0.3s;
            margin-left: 10px;
        }
        
        .reset-button1:hover {
            background: #e04343;
        }
        
    </style>
</head>
<body>
    <!-- 헤더 -->
    <header>
        <%@ include file="../common/common_header.jsp" %>
    </header>

    <div class="review-container">
        <h2>작성한 리뷰 목록</h2>
        
        <!-- 검색 기능 -->
        <div class="search-container1">
            <div class="search-box1">
                <select id="searchType" class="search-select1">
                    <option value="moviename">영화 제목</option>
                    <option value="name">작성자 이름</option>
                    <option value="writeid">작성자 ID</option>
                </select>
                <input type="text" id="searchInput" class="search-input1" placeholder="검색어를 입력하세요">
                <button id="searchButton" class="search-button1">검색</button>
                <button id="resetButton" class="reset-button1">초기화</button>
            </div>
        </div>
        
        <div id="reviewsContent">
            <%
            ArrayList<MovieDto> dtos = (ArrayList<MovieDto>)request.getAttribute("dtos");
            if(dtos != null && !dtos.isEmpty()) {
                // 페이징 처리를 위한 변수
                int currentPage = 1;
                String pageParam = request.getParameter("page");
                if(pageParam != null && !pageParam.isEmpty()) {
                    currentPage = Integer.parseInt(pageParam);
                }
                
                int totalReviews = dtos.size();
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
        
        // 검색 기능
        $(document).ready(function() {
            // 검색 버튼 클릭 시
            $("#searchButton").click(function() {
                performSearch();
            });
            
            // 엔터 키 입력 시 검색 실행
            $("#searchInput").keypress(function(e) {
                if(e.which === 13) {
                    performSearch();
                }
            });
            
            // 초기화 버튼 클릭 시
            $("#resetButton").click(function() {
                $("#searchInput").val("");
                $(".review-card").show();
                
                // 리뷰 카드가 있으면 no-reviews 메시지 숨김
                if($(".review-card").length > 0) {
                    $(".no-reviews").hide();
                    $(".pagination").show();
                }
            });
            
            function performSearch() {
                var searchType = $("#searchType").val();
                var searchValue = $("#searchInput").val().toLowerCase();
                
                if(searchValue.trim() === "") {
                    alert("검색어를 입력해주세요.");
                    return;
                }
                
                var found = false;
                
                $(".review-card").each(function() {
                    var dataValue = $(this).data(searchType).toString();
                    
                    if(dataValue.indexOf(searchValue) !== -1) {
                        $(this).show();
                        found = true;
                    } else {
                        $(this).hide();
                    }
                });
                
                // 검색 결과가 없을 때
                if(!found) {
                    if($(".no-reviews").length === 0) {
                        $("#reviewsContent").append(
                            '<div class="no-reviews"><p>검색 결과가 없습니다.</p></div>'
                        );
                    } else {
                        $(".no-reviews").show().find("p").text("검색 결과가 없습니다.");
                    }
                    $(".pagination").hide();
                } else {
                    $(".no-reviews").hide();
                    $(".pagination").hide(); // 검색 시에는 페이지네이션 숨김
                }
            }
        });
    </script>
</body>
</html>