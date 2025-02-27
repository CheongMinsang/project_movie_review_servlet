package command.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.CommonExecute;
import common.CommonUtil;
import dao.MovieDao;
import dto.MovieDto;

public class goSaveRecommend implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		MovieDao dao = new MovieDao();
		
		HttpSession session = request.getSession();
		String writeid = (String) session.getAttribute("sessionId");
		
		String movieId = request.getParameter("movieId");
		String movieName = request.getParameter("movieName");
		if (movieName.contains("'")) {
		    movieName = movieName.replace("'", "''");
		}
		String reg_date = CommonUtil.getTodayTime();
		
		int no = dao.getMaxRecoTabelNumber();
		
		MovieDto dto = new MovieDto(writeid, movieName, reg_date, Integer.parseInt(movieId), no);
		int result = dao.saveReco(dto);
		
		// 세션에서 sessionLevel 값을 가져옴
		String sessionLevel = (String) session.getAttribute("sessionLevel");
		
		String msg = "";
		// sessionLevel 값이 "top"인지 확인하는 if문
		if ("top".equals(sessionLevel)) {
			if(result == 1) msg = "추천 영화가 등록되었습니다.";
			else msg = "추천 영화 등록 실패!! 관리자에게 문의 바랍니다.";
		} else {
			if(result == 1) msg = "북마크에 등록되었습니다.";
			else msg = "북마크 등록 실패!! 관리자에게 문의 바랍니다.";
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", "javascript:history.back();");

	}

}
