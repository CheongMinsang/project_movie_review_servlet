package command.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.CommonExecute;
import common.CommonUtil;
import dao.MovieDao;
import dto.MovieDto;

public class ReviewUpdate implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		MovieDao dao = new MovieDao();
		
		HttpSession session = request.getSession();
		String writeid = (String) session.getAttribute("sessionId");
		
		String nickname = dao.getNickname(writeid);
		String movieId = request.getParameter("movieId");
		String ratingValue = request.getParameter("ratingValue");
		String reviewContent = request.getParameter("reviewContent");
		String rating_date = CommonUtil.getTodayTime();
		
		int no = dao.getMaxRatingTabelNumber();
		
		MovieDto dto = new MovieDto(no, Integer.parseInt(movieId), nickname, writeid, reviewContent, rating_date, Integer.parseInt(ratingValue));
		int result = dao.getRatingUpdate(dto);
		
		String msg = "";
		if(result == 1) msg = "리뷰가 수정 되었습니다.";
		else msg = "리뷰수정 실패!! 관리자에게 문의 바랍니다.";
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", "javascript:history.back();");
	}

}
