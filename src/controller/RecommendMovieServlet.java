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
	
@WebServlet("/recommend-movie")
public class RecommendMovieServlet extends HttpServlet {
    private static final String TMDB_API_KEY = "14268f35e4a6081c29de2405e84e82c2";
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 추천 영화 ID 받기 (쉼표로 구분된 여러 ID 처리 가능)
        String[] recommendedMovieIds = request.getParameter("id").split(",");
        List<JSONObject> recommendedMovies = new ArrayList<>();
        
        for (String id : recommendedMovieIds) {
            String apiUrl = "https://api.themoviedb.org/3/movie/" + id.trim() + 
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
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            recommendedMovies.add(movieData);
        }
        
        request.setAttribute("recommendedMovies", recommendedMovies);
        request.getRequestDispatcher("recommendMovie.jsp").forward(request, response);
    }
}