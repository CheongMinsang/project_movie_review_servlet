package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/MovieDetail")
public class MovieDetail extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String movieId = request.getParameter("id");
        String apiKey = "14268f35e4a6081c29de2405e84e82c2";

        if (movieId != null && !movieId.isEmpty()) {
            try {
                // TMDB API를 사용해 영화 상세 정보 가져오기
                String movieDetailData = fetchMovieDetail("https://api.themoviedb.org/3/movie/" + movieId, apiKey);
                JSONObject movieDetail = new JSONObject(movieDetailData);
                request.setAttribute("movieDetail", movieDetail);

                // 예고편 정보 가져오기
                String trailersData = fetchMovieDetail("https://api.themoviedb.org/3/movie/" + movieId + "/videos", apiKey);
                JSONObject trailersObject = new JSONObject(trailersData);
                JSONArray trailers = trailersObject.optJSONArray("results");
                request.setAttribute("movieTrailers", trailers);

                // 제작진 정보 가져오기
                String creditsData = fetchMovieDetail("https://api.themoviedb.org/3/movie/" + movieId + "/credits", apiKey);
                JSONObject creditsObject = new JSONObject(creditsData);
                JSONArray crew = creditsObject.optJSONArray("crew");
                request.setAttribute("movieCrew", crew);

                // 상세 페이지로 전달
                RequestDispatcher dispatcher = request.getRequestDispatcher("movieDetail.jsp");
                dispatcher.forward(request, response);
            } catch (Exception e) {
                // 디버깅 로그 추가
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "영화 상세 정보를 가져오는 중 오류 발생: " + e.getMessage());
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "유효하지 않은 영화 ID");
        }
    }

    private String fetchMovieDetail(String apiUrl, String apiKey) throws IOException {
        // URL 생성
        URL url = new URL(apiUrl + "?api_key=" + apiKey + "&language=ko-KR");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        // 응답 코드 확인
        int responseCode = conn.getResponseCode();
        if (responseCode != 200) {
            throw new IOException("HTTP 응답 코드: " + responseCode + ", 요청 경로: " + apiUrl);
        }

        // 응답 읽기 (UTF-8 명시)
        try (BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8))) {
            StringBuilder responseStr = new StringBuilder();
            String inputLine;
            while ((inputLine = in.readLine()) != null) {
                responseStr.append(inputLine);
            }
            System.out.println("API 응답 데이터: " + responseStr); // 디버깅용
            return responseStr.toString();
        }
    }
}
