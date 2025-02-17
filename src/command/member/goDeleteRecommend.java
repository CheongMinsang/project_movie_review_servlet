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
		
		String movieId = request.getParameter("movieId");
		
		int result = dao.deleteReco(movieId);
		
		String msg = "";
		if(result == 1) msg = "추천영화목록에서 삭제되었습니다.";
		else msg = "추천영화 삭제실패!! 관리자에게 문의 바랍니다.";
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", "javascript:history.back();");

	}

}
