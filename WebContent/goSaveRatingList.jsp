<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, dto.MovieDto" %>
<%@ page buffer="64kb" autoFlush="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>나의 리뷰 목록</title>
    <link href="css/main.css" rel="stylesheet">
    <link href="css/goSaveRatingList.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <!-- 헤더 -->
    <header>
        <%@ include file="../common/common_header.jsp" %>
    </header>

    <div class="review-container">
        <h2>내가 작성한 리뷰</h2>
        
        <%
        @SuppressWarnings("unchecked")
        ArrayList<MovieDto> dtos = (ArrayList<MovieDto>)request.getAttribute("dtos");
        if(dtos != null && !dtos.isEmpty()) {
            for(MovieDto dto : dtos) {
                int rating = dto.getRating();
                int fullStars = rating / 2;
                int halfStar = (rating % 2);
                int emptyStars = 5 - fullStars - halfStar;
        %>
        <div class="review-card" id="review-<%= dto.getMovieid() %>">
            <div class="review-header">
                <div class="review-stars">
                    <% for(int i = 0; i < fullStars; i++) { %>
                        <i class="fa-solid fa-star"></i>
                    <% } %>
                    <% if(halfStar == 1) { %>
                        <i class="fa-solid fa-star-half-stroke"></i>
                    <% } %>
                    <% for(int i = 0; i < emptyStars; i++) { %>
                        <i class="fa-regular fa-star"></i>
                    <% } %>
                    <span class="review-info">(<%= rating %>/10)</span>
                </div>
                <div class="review-date">
                    <%= dto.getRating_date() %>
                    <i class="fa-solid fa-trash delete-icon" onclick="confirmDelete('<%= dto.getMovieid() %>')"></i>
                </div>
            </div>
                <div class="review-content">
                    <h3 class="movie-title"><%= dto.getMoviename() %></h3>
                    <p><%= dto.getContent() %></p>
                </div>
            <a href="MovieDetail?id=<%= dto.getMovieid() %>" class="review-link">상세보기</a>
        </div>
        <%
            }
        } else {
        %>
        <div class="no-reviews">
            <p>작성한 리뷰가 없습니다.</p>
        </div>
        <%
        }
        %>
    </div>

    <!-- 푸터 -->
    <footer class="footer">
        <%@ include file="../common/common_footer.jsp" %>
    </footer>
<script src="js/reviewManagement.js"></script>
</body>
</html>