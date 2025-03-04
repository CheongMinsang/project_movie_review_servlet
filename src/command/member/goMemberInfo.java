package command.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.CommonExecute;
import dao.MovieDao;
import dto.MovieDto;

public class goMemberInfo implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		MovieDao dao = new MovieDao();
		
		String id = request.getParameter("id");
		
		MovieDto dto = dao.getMemberInfo2(id);
		request.setAttribute("dto", dto);
	}

}
