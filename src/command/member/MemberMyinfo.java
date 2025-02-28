package command.member;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.CommonExecute;
import dao.MovieDao;
import dto.MovieDto;

public class MemberMyinfo implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		MovieDao dao = new MovieDao();
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("sessionId");
		String name = (String) session.getAttribute("sessionName");
		
		MovieDto dto = dao.getMemberInfo(id);
		request.setAttribute("dto", dto);
		
		//ArrayList<MovieDto> dtos = dao.getUserRecoList(id);
		//ArrayList<MovieDto> daos = dao.getUserReviewList(id);

	}

}
