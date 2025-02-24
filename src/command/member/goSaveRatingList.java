package command.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.CommonExecute;
import dao.MovieDao;
import dto.MovieDto;
import java.util.ArrayList;

public class goSaveRatingList implements CommonExecute {

    @Override
    public void execute(HttpServletRequest request) {
    	HttpSession session = request.getSession();
        String sessionId = (String) session.getAttribute("sessionId");
        
        if (sessionId == null || sessionId.isEmpty()) {
            sessionId = "admin@naver.com"; // 기본값 설정
            session.setAttribute("sessionId", sessionId);
        }
        
        // DAO를 통해 추천 영화 목록 조회 (MovieDao와 MovieDto는 미리 구현되어 있다고 가정)
        MovieDao dao = new MovieDao();
        ArrayList<MovieDto> dtos = dao.getReviewList(sessionId);
        
        request.setAttribute("dtos", dtos);
        
    }
}
