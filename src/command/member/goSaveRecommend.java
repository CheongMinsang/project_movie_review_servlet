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
		String reg_date = CommonUtil.getTodayTime();
		
		int no = dao.getMaxRecoTabelNumber();
		
		MovieDto dto = new MovieDto(writeid, reg_date, Integer.parseInt(movieId), no);
		int result = dao.saveReco(dto);
		
		String msg = "";
		if(result == 1) msg = "추천영화로 등록되었습니다.";
		else msg = "추천영화 등록실패!! 관리자에게 문의 바랍니다.";
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", "javascript:history.back();");

	}

}
