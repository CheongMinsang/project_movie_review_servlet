package command.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.CommonExecute;
import common.CommonUtil;
import dao.MovieDao;
import dto.MovieDto;

public class goDeleteRecommend implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		MovieDao dao = new MovieDao();
		
		HttpSession session = request.getSession();
		String writeid = (String) session.getAttribute("sessionId");
		String movieId = request.getParameter("movieId");
		
		int result = dao.deleteReco(movieId,writeid);
		
		// 세션에서 sessionLevel 값을 가져옴
		String sessionLevel = (String) session.getAttribute("sessionLevel");
		
		String msg = "";
		// sessionLevel 값이 "top"인지 확인하는 if문
		if ("top".equals(sessionLevel)) {
			if(result == 1) msg = "추천 영화가 삭제되었습니다.";
			else msg = "추천 영화 삭제 실패!! 관리자에게 문의 바랍니다.";
		} else {
			if(result == 1) msg = "북마크가 삭제되었습니다.";
			else msg = "북마크 삭제 실패!! 관리자에게 문의 바랍니다.";
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", "javascript:history.back();");

	}

}
