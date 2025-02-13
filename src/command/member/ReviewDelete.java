package command.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.CommonExecute;
import common.CommonUtil;
import dao.MovieDao;

public class ReviewDelete implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		MovieDao dao = new MovieDao();
		
		String movieid = request.getParameter("movieId");
		HttpSession session = request.getSession();
		String writeid = (String) session.getAttribute("sessionId");
		
		int result = dao.goReviewDelete(movieid,writeid);
		
        String msg = "";
		if(result == 1) msg = "리뷰가 삭제 되었습니다!";
		else msg = "리뷰 삭제 실패!! 관리자에게 문의 바랍니다.";
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", "javascript:history.back();");
	}

}
