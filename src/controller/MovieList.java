package controller;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * Servlet implementation class MovieList
 */
@WebServlet("/MovieList")
public class MovieList extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public MovieList() {
        super();
    }
    
    // TMDB API 키 및 URL
    private static final String API_KEY = "14268f35e4a6081c29de2405e84e82c2"; // 실제 API 키 사용
    private static final String GENRES_API_URL = "https://api.themoviedb.org/3/genre/movie/list?api_key=" + API_KEY; 

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // 장르 목록 가져오기
        List<Genre> genres = null;
		try {
			genres = fetchGenres();
	    } catch (IOException | JSONException e1) {
	        e1.printStackTrace();
	    }
        request.setAttribute("genres", genres);
        
        // 파라미터 받기
        String gubun = request.getParameter("t_gubun");
        if (gubun == null || gubun.isEmpty()) {
            gubun = "popular";  // 기본값
        }
        String search = request.getParameter("search");
        String sort = request.getParameter("sort");
        String genreId = request.getParameter("genre_id");
        int page = Integer.parseInt(request.getParameter("page") != null ? request.getParameter("page") : "1");
        int pageSize = 20;

        // 파라미터 기본값 설정
        search = (search == null || search.trim().isEmpty()) ? "" : search; // 검색어
        sort = (sort == null || sort.trim().isEmpty()) ? "" : sort;         // 정렬 조건

        // API Key 및 URL
        String apiKey = "14268f35e4a6081c29de2405e84e82c2";
        String apiUrl = "";

        // API URL 설정
        switch (gubun) {
            case "popular":
                apiUrl = "https://api.themoviedb.org/3/movie/popular";
                request.setAttribute("pageTitle", "인기 영화 목록");
                break;
            case "search":
            	apiUrl = "https://api.themoviedb.org/3/movie/popular";
            	request.setAttribute("pageTitle", "검색 결과");
            	break;
            case "upcoming":
                apiUrl = "https://api.themoviedb.org/3/movie/upcoming";
                request.setAttribute("pageTitle", "개봉 예정 목록");
                break;
            case "top_rated":
                apiUrl = "https://api.themoviedb.org/3/movie/top_rated";
                request.setAttribute("pageTitle", "높은 평점 목록");
                break;
            case "genre":
                if (genreId == null || genreId.isEmpty()) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "장르 ID가 필요합니다.");
                    return;
                }
                apiUrl = "https://api.themoviedb.org/3/discover/movie";
                request.setAttribute("pageTitle", "장르별 영화 목록");
                break;    
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 요청입니다.");
                return;
        }

        // apiUrl 확인
        if (apiUrl == null || apiUrl.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "API URL이 잘못 설정되었습니다.");
            return;
        }

        try {
            // 검색 조건이 있을 경우 검색 API로 변경
            if (!search.isEmpty()) {
                apiUrl = "https://api.themoviedb.org/3/search/movie";
            }

            // API 호출
            String data = fetchMovies(apiUrl, apiKey, page, search, genreId);
            if (data == null || data.isEmpty()) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "영화 데이터를 가져오는 데 실패했습니다.");
                return;
            }
            
            JSONObject responseJson = new JSONObject(data);
            JSONArray movies = responseJson.getJSONArray("results");

            // 정렬 적용 (정렬 조건이 있을 경우)
            if ("release_date".equals(sort)) {
                movies = sortMoviesByReleaseDate(movies);
            } else if ("vote_average".equals(sort)) {
                movies = sortMoviesByVoteAverage(movies);
            }

            int totalResults = responseJson.getInt("total_results");
            int totalPages = (int) Math.ceil((double) totalResults / pageSize);

            
            // JSP로 데이터 전달
            request.setAttribute("movies", movies);
            request.setAttribute("t_gubun", gubun);
            request.setAttribute("search", search);
            request.setAttribute("sort", sort);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            RequestDispatcher dispatcher = request.getRequestDispatcher("movie_list.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "영화 데이터를 가져오는 중 오류 발생");
        }
    }
    
    // 장르 목록을 가져오는 메서드
    private List<Genre> fetchGenres() throws IOException, JSONException {
    	String apiKey = URLEncoder.encode(API_KEY, "UTF-8");
        String apiUrlWithLanguage = GENRES_API_URL + "&language=ko-KR";

        URL url = new URL(apiUrlWithLanguage);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");
        connection.connect();

        if (connection.getResponseCode() != 200) {
            throw new RuntimeException("Failed : HTTP error code : " + connection.getResponseCode());
        }

        String result = new BufferedReader(new InputStreamReader(new BufferedInputStream(connection.getInputStream())))
                        .lines().collect(Collectors.joining("\n"));
        
        JSONObject jsonResponse = new JSONObject(result);
        JSONArray genresArray = jsonResponse.getJSONArray("genres");

        List<Genre> genres = new ArrayList<>();
        for (int i = 0; i < genresArray.length(); i++) {
            JSONObject genreObject = genresArray.getJSONObject(i);
            Genre genre = new Genre(genreObject.getInt("id"), genreObject.getString("name"));
            genres.add(genre);
        }
        return genres;
    }

    // Genre 클래스 추가
    public class Genre {
        private int id;
        private String name;

        public Genre(int id, String name) {
            this.id = id;
            this.name = name;
        }

        public int getId() {
            return id;
        }

        public String getName() {
            return name;
        }
    }

 // API 호출 메서드 수정
    private String fetchMovies(String apiUrl, String apiKey, int page, String search, String genreId) throws IOException {
        StringBuilder queryParam = new StringBuilder();
        if (!search.isEmpty()) {
            queryParam.append("&query=").append(URLEncoder.encode(search, "UTF-8"));
        }
        if (genreId != null && !genreId.isEmpty()) {
            queryParam.append("&with_genres=").append(URLEncoder.encode(genreId, "UTF-8"));
        }

        URL url = new URL(apiUrl + "?api_key=" + apiKey + "&language=ko-KR&page=" + page + queryParam.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String inputLine;
        StringBuilder responseStr = new StringBuilder();
        while ((inputLine = in.readLine()) != null) {
            responseStr.append(inputLine);
        }
        in.close();
        return responseStr.toString();
    }

    // 개봉일 기준 정렬 메서드
    private JSONArray sortMoviesByReleaseDate(JSONArray movies) {
        List<JSONObject> movieList = new ArrayList<>();
        for (int i = 0; i < movies.length(); i++) {
            try {
                movieList.add(movies.getJSONObject(i));
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }

        movieList.sort((m1, m2) -> {
            String date1 = m1.optString("release_date", "1900-01-01");
            String date2 = m2.optString("release_date", "1900-01-01");
            return date2.compareTo(date1); // 최신 순 정렬
        });

        return new JSONArray(movieList);
    }

    // 평점 기준 정렬 메서드
    private JSONArray sortMoviesByVoteAverage(JSONArray movies) {
        List<JSONObject> movieList = new ArrayList<>();
        for (int i = 0; i < movies.length(); i++) {
            try {
                movieList.add(movies.getJSONObject(i));
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }

        movieList.sort((m1, m2) -> {
            double vote1 = m1.optDouble("vote_average", 0.0);
            double vote2 = m2.optDouble("vote_average", 0.0);
            return Double.compare(vote2, vote1); // 평점 높은 순 정렬
        });

        return new JSONArray(movieList);
    }
    
    

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
