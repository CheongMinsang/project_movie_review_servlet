package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import command.member.MemberGoExit;
import command.member.MemberJoin;
import command.member.MemberList;
import command.member.MemberLogin;
import command.member.MemberLogout;
import command.member.MemberMyinfo;
import command.member.MemberMyinfoUpdate;
import command.member.ReviewDelete;
import command.member.ReviewSave;
import command.member.ReviewUpdate;
import command.member.goDeleteRecommend;
import command.member.goGetRecoList;
import command.member.goMemberInfo;
import command.member.goReviewManage;
import command.member.goSaveMovieList;
import command.member.goSaveRatingList;
import command.member.goSaveRecommend;
import common.CommonExecute;
import dao.MovieDao;
import dto.MovieDto;

/**
 * Servlet implementation class Index
 */
@WebServlet("/Index")
public class Index extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Index() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String gubun = request.getParameter("t_gubun");
		if(gubun == null) {
			gubun="index";
		}
		String apiKey = "14268f35e4a6081c29de2405e84e82c2";
		
	    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
	    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
	    response.setDateHeader("Expires", 0); 
		
	    // 회원가입 페이지
		if(gubun.equals("register")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
		    dispatcher.forward(request, response);
		// 로그인 페이지   
		}else if(gubun.equals("login")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
		    dispatcher.forward(request, response); 
		// 회원가입 테이블 저장    
		}else if(gubun.equals("domemberjoin")) {
			CommonExecute mem = new MemberJoin();
			mem.execute(request);
			RequestDispatcher dispatcher = request.getRequestDispatcher("common_alert_member.jsp");
		    dispatcher.forward(request, response);
		// 로그인 실행    
		}else if(gubun.equals("loginForm")) {
			CommonExecute mem = new MemberLogin();
			mem.execute(request);
			RequestDispatcher dispatcher = request.getRequestDispatcher("common_alert_popup.jsp");
		    dispatcher.forward(request, response); 
		// 로그아웃 실행    
		}else if(gubun.equals("logout")) {
			CommonExecute mem = new MemberLogout();
			mem.execute(request);
			
		    // 세션 상태 확인
	        HttpSession session = request.getSession(false);
	        if (session == null) {
	            System.out.println("세션이 성공적으로 무효화되었습니다.");
	        } else {
	            System.out.println("세션 무효화에 실패하였습니다.");
	        }
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("common/common_alert.jsp");
		    dispatcher.forward(request, response); 
		// 내 정보 페이지   
		}else if(gubun.equals("myinfo")) {
			CommonExecute mem = new MemberMyinfo();
			mem.execute(request);
			RequestDispatcher dispatcher = request.getRequestDispatcher("myinfo.jsp");
			dispatcher.forward(request, response); 
		// 회원탈퇴 실행(탈퇴일 추가)	
		}else if(gubun.equals("goMemberExit")) {
			CommonExecute mem = new MemberGoExit();
			mem.execute(request);
			RequestDispatcher dispatcher = request.getRequestDispatcher("common_alert_popup.jsp");
			dispatcher.forward(request, response); 
		// 내 정보 테이블 수정	
		}else if(gubun.equals("myinfoupdate")) {
			CommonExecute mem = new MemberMyinfoUpdate();
			mem.execute(request);
			RequestDispatcher dispatcher = request.getRequestDispatcher("common_alert.jsp");
			dispatcher.forward(request, response);
		// 영화 리뷰 테이블 저장	
		}else if(gubun.equals("reviewSave")) {
			CommonExecute mem = new ReviewSave();
			mem.execute(request);
			RequestDispatcher dispatcher = request.getRequestDispatcher("common_alert.jsp");
			dispatcher.forward(request, response);
		// 관리자 메뉴 페이지 열기
		}else if(gubun.equals("controlMenu")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("controlMenu.jsp");
		    dispatcher.forward(request, response); 
		// 회원 메뉴 페이지 열기    
		}else if(gubun.equals("MemberControlMenu")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("MemberControlMenu.jsp");
		    dispatcher.forward(request, response);
		// 관리자 가입멤버 목록 페이지 열기
		}else if(gubun.equals("goMemberList")) {
			CommonExecute mem = new MemberList();
			mem.execute(request);
			RequestDispatcher dispatcher = request.getRequestDispatcher("showMemberList.jsp");
		    dispatcher.forward(request, response); 
		// 관리자 가입멤버 상세정보 페이지 열기    
		}else if(gubun.equals("goMemberInfo")) {
			CommonExecute mem = new goMemberInfo();
			mem.execute(request);
			RequestDispatcher dispatcher = request.getRequestDispatcher("showMemberInfo.jsp");
		    dispatcher.forward(request, response);
		// 리뷰 삭제 테이블에서 삭제   
		}else if(gubun.equals("RatingDelete")) {
			CommonExecute mem = new ReviewDelete();
			mem.execute(request);
			RequestDispatcher dispatcher = request.getRequestDispatcher("common_alert.jsp");
			dispatcher.forward(request, response);
		// 리뷰 수정 테이블 수정	
		}else if(gubun.equals("ReviewUpdate")) {
			CommonExecute mem = new ReviewUpdate();
			mem.execute(request);
			RequestDispatcher dispatcher = request.getRequestDispatcher("common_alert.jsp");
			dispatcher.forward(request, response);
		// 영화 찜하기
		}else if(gubun.equals("goSaveRecommend")) {
			CommonExecute mem = new goSaveRecommend();
			mem.execute(request);
			RequestDispatcher dispatcher = request.getRequestDispatcher("common_alert.jsp");
			dispatcher.forward(request, response);
		// 찜한 영화 삭제	
		}else if(gubun.equals("goDeleteRecommend")) {
			CommonExecute mem = new goDeleteRecommend();
			mem.execute(request);
			RequestDispatcher dispatcher = request.getRequestDispatcher("common_alert.jsp");
			dispatcher.forward(request, response);
		// 관리자 추천 영화 목록	
		}else if(gubun.equals("goRecoList")) {
		    try {
		        CommonExecute mem = new goGetRecoList();
		        mem.execute(request);
		        
		        String idString = (String) request.getAttribute("id");
		        
		        // 응답을 커밋하기 전에 리다이렉트
		        if (idString != null && !idString.isEmpty()) {
		            response.setStatus(HttpServletResponse.SC_FOUND); // 302 상태 코드 설정
		            response.setHeader("Location", "recommend-movie?id=" + idString);
		            return; // 중요: 여기서 메소드 실행을 종료
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		    }
		//회원 저장한 영화목록    
		}else if(gubun.equals("goSaveMovieList")) {
		    try {
		        CommonExecute mem = new goSaveMovieList();
		        mem.execute(request);
		        
		        String idString = (String) request.getAttribute("id");
		        
		        // 응답을 커밋하기 전에 리다이렉트
		        if (idString != null && !idString.isEmpty()) {
		            response.setStatus(HttpServletResponse.SC_FOUND); // 302 상태 코드 설정
		            response.setHeader("Location", "recommend-movie-member?id=" + idString);
		            return; // 중요: 여기서 메소드 실행을 종료
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		    }
		// 작성한 리뷰 목록 가져오기     
		}else if(gubun.equals("goSaveRatingList")) {
			CommonExecute mem = new goSaveRatingList();
			mem.execute(request);
			RequestDispatcher dispatcher = request.getRequestDispatcher("goSaveRatingList.jsp");
			dispatcher.forward(request, response);
		// 관리자 관리용 전체 리뷰 목록 가져오기
		}else if(gubun.equals("goReviewManage")) {
			CommonExecute mem = new goReviewManage();
			mem.execute(request);
			RequestDispatcher dispatcher = request.getRequestDispatcher("goReviewManage.jsp");
			dispatcher.forward(request, response);
		// 내가 작성한 리뷰 삭제하기	
		}else if(gubun.equals("MyRatingDelete")) {
		    // RequestDispatcher 대신 직접 처리
		    String movieId = request.getParameter("movieId");
		    HttpSession session = request.getSession();
		    String writeid = (String) session.getAttribute("sessionId");
		    
		    MovieDao dao = new MovieDao();
		    int result = dao.goReviewDelete(movieId, writeid);
		    
		    String msg = "";
		    if(result == 1) msg = "삭제되었습니다";
		    else msg = "리뷰 삭제 실패!! 관리자에게 문의 바랍니다.";
		    
		    response.setContentType("text/html; charset=utf-8");
		    PrintWriter out = response.getWriter();
		    out.print(msg);
		    return; // 중요: 더 이상 처리하지 않도록 여기서 종료
		// 관리자 회원 리뷰 삭제하기    
		}else if(gubun.equals("MemberRatingDelete")) {
			// RequestDispatcher 대신 직접 처리
			String movieId = request.getParameter("movieId");
			String writeId = request.getParameter("writeId");
			
			System.out.println(movieId+writeId);
			
			MovieDao dao = new MovieDao();
			int result = dao.goReviewDelete(movieId, writeId);
			
			String msg = "";
			if(result == 1) msg = "삭제되었습니다";
			else msg = "리뷰 삭제 실패!! 관리자에게 문의 바랍니다.";
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(msg);
			return; // 중요: 더 이상 처리하지 않도록 여기서 종료
		}
		
		try { 
			// 개봉 예정 영화 가져오기
			String upcomingData = fetchMovies("https://api.themoviedb.org/3/movie/upcoming", apiKey);
			JSONObject upcomingResponse = new JSONObject(upcomingData);
			JSONArray upcomingMovies = upcomingResponse.getJSONArray("results");
			
			JSONArray sortedUpcomingMovies = sortMoviesByReleaseDate(upcomingMovies);
			request.setAttribute("upcomingMovies", sortedUpcomingMovies);
			
			// 현재 상영 중 영화 가져오기
		    String nowPlayingData = fetchMovies("https://api.themoviedb.org/3/movie/now_playing", apiKey);
		    JSONObject nowPlayingResponse = new JSONObject(nowPlayingData);
		    JSONArray nowPlayingMovies = nowPlayingResponse.getJSONArray("results");
		    
		    // 정렬 적용 (평점 기준)
            JSONArray sortedNowPlayingMovies = sortMoviesByVoteAverage(nowPlayingMovies);
            request.setAttribute("nowPlayingMovies", sortedNowPlayingMovies);
		    
		    // 평점 높은 영화 가져오기
		    String topRatedData = fetchMovies("https://api.themoviedb.org/3/movie/top_rated", apiKey);
		    JSONObject topRatedResponse = new JSONObject(topRatedData);
		    request.setAttribute("topRatedMovies", topRatedResponse.getJSONArray("results"));
		    
		    RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
		    dispatcher.forward(request, response); 
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "영화 데이터를 가져오는 중 오류 발생");
		}
}	
		private String fetchMovies(String apiUrl, String apiKey) throws IOException {
			URL url = new URL(apiUrl + "?api_key=" + apiKey + "&language=ko-KR&page=1"); 
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
		// 개봉일 기준 정렬 함수
	    private JSONArray sortMoviesByReleaseDate(JSONArray movies) {
	        List<JSONObject> movieList = new ArrayList<>();
	
	        // JSONArray -> List<JSONObject> 변환
	        for (int i = 0; i < movies.length(); i++) {
	            try {
					movieList.add(movies.getJSONObject(i));
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        }
	
	        // 개봉일 기준 내림차순 정렬
	        movieList.sort((movie1, movie2) -> {
	            String date1 = movie1.optString("release_date", "1900-01-01");
	            String date2 = movie2.optString("release_date", "1900-01-01");
	            return date2.compareTo(date1); // 최신 개봉일이 먼저 오도록 정렬
	        });
	
	        // List<JSONObject> -> JSONArray 변환
	        return new JSONArray(movieList);
	    }
	    // 평점 기준 정렬 함수
	    private JSONArray sortMoviesByVoteAverage(JSONArray movies) {
	        List<JSONObject> movieList = new ArrayList<>();

	        // JSONArray -> List<JSONObject> 변환
	        for (int i = 0; i < movies.length(); i++) {
	            try {
					movieList.add(movies.getJSONObject(i));
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        }

	        // 평점 기준 내림차순 정렬
	        movieList.sort((movie1, movie2) -> {
	            double vote1 = movie1.optDouble("vote_average", 0.0);
	            double vote2 = movie2.optDouble("vote_average", 0.0);
	            return Double.compare(vote2, vote1); // 높은 평점이 먼저 오도록 정렬
	        });

	        // List<JSONObject> -> JSONArray 변환
	        return new JSONArray(movieList);
	    }
	  
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}