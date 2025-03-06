package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;
import java.net.HttpURLConnection;
import java.net.URL;
import java.io.BufferedReader;
import java.io.InputStreamReader;
	
@WebServlet("/recommend-movie-member")
public class RecommendMovieServlet2 extends HttpServlet {
    private static final String TMDB_API_KEY = "14268f35e4a6081c29de2405e84e82c2";
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
System.out.println("[RecommendMovieServlet2] Servlet 시작");
        
        String ids = request.getParameter("id");
        if (ids == null) {
            ids = (String) request.getAttribute("id");
        }
        
        System.out.println("[RecommendMovieServlet2] ids: " + ids);
        
        List<JSONObject> recommendedMovies = new ArrayList<>();
        
        if (ids == null || ids.trim().isEmpty()) {
            System.out.println("[RecommendMovieServlet2] ids가 없거나 비어 있음");
            request.setAttribute("recommendedMovies", recommendedMovies);
            request.getRequestDispatcher("recommendMovieMember.jsp").forward(request, response);
            return;
        }
        
        String[] recommendedMovieIds = ids.split(",");
        for (String id : recommendedMovieIds) {
            if (id.trim().isEmpty()) continue;
            
            String apiUrl = "https://api.themoviedb.org/3/movie/" + id.trim() + 
                          "?api_key=" + TMDB_API_KEY + "&language=ko-KR";
            
            try {
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
                
                JSONObject movieData = new JSONObject(result.toString());
                recommendedMovies.add(movieData);
                System.out.println("[RecommendMovieServlet2] Movie added: " + id);
            } catch (Exception e) {
                System.out.println("[RecommendMovieServlet2] Error fetching movie " + id + ": " + e.getMessage());
                e.printStackTrace();
            }
        }
        
        System.out.println("[RecommendMovieServlet2] recommendedMovies size: " + recommendedMovies.size());
        request.setAttribute("recommendedMovies", recommendedMovies);
        request.getRequestDispatcher("recommendMovieMember.jsp").forward(request, response);
        System.out.println("[RecommendMovieServlet2] JSP로 포워딩 완료");
    }
}