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
        if (dto == null) {
            System.out.println("DTO is null for id: " + id);
        } else {
            System.out.println("DTO retrieved for id: " + id + ", recommendList size: " + 
                (dto.getRecommendList() != null ? dto.getRecommendList().size() : "null"));
        }
        request.setAttribute("dto", dto);
	}

}
