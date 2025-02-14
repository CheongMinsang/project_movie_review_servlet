<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>추천 영화 목록</title>
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
            background-color: white;
            transition: transform 0.3s ease;
        }
        
        .recommend-card:hover {
            transform: translateY(-5px);
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
        }
        
        .recommend-rating {
            color: #f5c518;
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        .recommend-date {
            color: #666;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="recommend-container">
        <c:forEach var="movie" items="${recommendedMovies}">
            <div class="recommend-card">
                <img class="recommend-poster" 
                     src="https://image.tmdb.org/t/p/w500${movie.getString('poster_path')}" 
                     alt="${movie.getString('title')}">
                <div class="recommend-info">
                    <div class="recommend-title">${movie.getString('title')}</div>
                    <div class="recommend-rating">⭐ ${movie.getDouble('vote_average')}</div>
                    <div class="recommend-date">개봉일: ${movie.getString('release_date')}</div>
                </div>
            </div>
        </c:forEach>
    </div>
</body>
</html>