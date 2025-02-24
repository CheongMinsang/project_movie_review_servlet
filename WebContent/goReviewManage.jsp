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
    </style>
</head>
<body>
    <!-- 헤더 -->
    <header>
        <%@ include file="../common/common_header.jsp" %>
    </header>

    <div class="review-container">
        <h2>작성한 리뷰 목록</h2>
        
        <%
        ArrayList<MovieDto> dtos = (ArrayList<MovieDto>)request.getAttribute("dtos");
        if(dtos != null && !dtos.isEmpty()) {
            for(MovieDto dto : dtos) {
                int rating = dto.getRating();
                int fullStars = rating / 2;
                int halfStar = (rating % 2);
                int emptyStars = 5 - fullStars - halfStar;
        %>
        <a href="MovieDetail?id=<%= dto.getMovieid() %>" class="review-link">
            <div class="review-card">
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
                    <div class="review-date"><%= dto.getRating_date() %></div>
                </div>
                <div class="review-content">
				    <h3 class="movie-title"><%= dto.getMoviename() %></h3>
				    <div><strong><%= dto.getName() %></strong>님의 리뷰</div>
				    <p><%= dto.getContent() %></p>
				</div>
            </div>
        </a>
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
</body>
</html>