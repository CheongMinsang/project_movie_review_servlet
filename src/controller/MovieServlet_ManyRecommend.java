package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * Servlet implementation class MovieServlet_ManyRecommend
 */
@WebServlet("/MovieServlet_ManyRecommend")
public class MovieServlet_ManyRecommend extends HttpServlet {
private static final String TMDB_API_KEY = "14268f35e4a6081c29de2405e84e82c2";
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // URL 파라미터에서 값 읽기
        String ids = request.getParameter("id");
        String movienames = request.getParameter("name");
        if (ids == null) {
            ids = (String) request.getAttribute("movieIds");
        }
        
        // 쉼표로 구분된 문자열을 배열로 분리 (양쪽 모두 순서가 맞다고 가정)
        String[] recommendedMovieIds = ids.split(",");
        String[] movieNameArray = movienames.split(",");
        
        List<JSONObject> recommendedMovies = new ArrayList<>();
        
        for (int i = 0; i < recommendedMovieIds.length; i++) {
            String id = recommendedMovieIds[i].trim();
            String apiUrl = "https://api.themoviedb.org/3/movie/" + id +
                          "?api_key=" + TMDB_API_KEY + "&language=ko-KR";
            
            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            
            BufferedReader reader = new BufferedReader(
                new InputStreamReader(conn.getInputStream(), "UTF-8"));
            StringBuilder result = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                result.append(line);
            }
            reader.close();
            conn.disconnect();
            
            JSONObject movieData = null;
            try {
                movieData = new JSONObject(result.toString());
                // DB에서 가져온 영화 제목(리뷰 수 정보 포함)을 추가
                if(i < movieNameArray.length) {
                    movieData.put("dbTitle", movieNameArray[i]);
                }
            } catch (JSONException e) {
                e.printStackTrace();
            }
            recommendedMovies.add(movieData);
        }
        
        request.setAttribute("recommendedMovies", recommendedMovies);
        request.getRequestDispatcher("goManyRecommend.jsp").forward(request, response);
    }
}
