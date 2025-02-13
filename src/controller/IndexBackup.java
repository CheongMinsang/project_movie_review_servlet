package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

/**
 * Servlet implementation class Index
 */
@WebServlet("/IndexBackup")
public class IndexBackup extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IndexBackup() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String apiKey = "14268f35e4a6081c29de2405e84e82c2"; 
		request.setCharacterEncoding("utf-8");
		
		try { 
			// 현재 상영 중 영화 가져오기
			String nowPlayingData = fetchMovies("https://api.themoviedb.org/3/movie/now_playing", apiKey);
			JSONObject nowPlayingResponse = new JSONObject(nowPlayingData);
			request.setAttribute("nowPlayingMovies", nowPlayingResponse.getJSONArray("results"));
			// 개봉 예정 영화 가져오기
			String upcomingData = fetchMovies("https://api.themoviedb.org/3/movie/upcoming", apiKey);
			JSONObject upcomingResponse = new JSONObject(upcomingData);
			request.setAttribute("upcomingMovies", upcomingResponse.getJSONArray("results"));
			// 평점 높은 영화 가져오기 
			String topRatedData = fetchMovies("https://api.themoviedb.org/3/movie/top_rated", apiKey);
			JSONObject topRatedResponse = new JSONObject(topRatedData);
			request.setAttribute("topRatedMovies", topRatedResponse.getJSONArray("results"));
			RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
			dispatcher.forward(request, response); 
		}
			catch (Exception e) {
				e.printStackTrace();
				response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "영화 데이터를 가져오는 중 오류 발생");
		}
	} 
	private String fetchMovies(String apiUrl, String apiKey) throws IOException {
		URL url = new URL(apiUrl + "?api_key=" + apiKey + "&language=ko-KR&page=1"); 
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET"); 
		BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		String inputLine; StringBuilder responseStr = new StringBuilder();
		while ((inputLine = in.readLine()) != null) { responseStr.append(inputLine); } in.close();
		return responseStr.toString();
	}
		
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}