package command.member;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.CommonExecute;
import dao.MovieDao;
import dto.MovieDto;

public class goSaveMovieList implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
        // 세션에서 사용자 식별값(예: sessionId) 가져오기
        HttpSession session = request.getSession();
        String sessionId = (String) session.getAttribute("sessionId");
        
        if (sessionId == null || sessionId.isEmpty()) {
            sessionId = "admin@naver.com"; // 기본값 설정
            session.setAttribute("sessionId", sessionId);
        }
        
        // DAO를 통해 추천 영화 목록 조회 (MovieDao와 MovieDto는 미리 구현되어 있다고 가정)
        MovieDao dao = new MovieDao();
        ArrayList<MovieDto> movieList = dao.getRecoList(sessionId);
        
        // 추천 영화 ID를 쉼표로 구분된 문자열로 구성
        StringBuilder idBuilder = new StringBuilder();
        for (MovieDto movie : movieList) {
            idBuilder.append(movie.getMovieid()).append(",");
        }
        // 마지막 쉼표 제거
        if (idBuilder.length() > 0) {
            idBuilder.setLength(idBuilder.length() - 1);
        }
        
        // 구성된 id 문자열을 request 속성에 저장
        // (혹은 바로 redirect URL에 사용할 수 있도록 값으로 전달)
        request.setAttribute("id", idBuilder.toString());
	}

}
