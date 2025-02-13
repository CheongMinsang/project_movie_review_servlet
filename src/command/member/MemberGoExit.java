package command.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.CommonExecute;
import common.CommonUtil;
import dao.MovieDao;

public class MemberGoExit implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		MovieDao dao = new MovieDao();
		
		String id = request.getParameter("t_id2");
		String exit_date = CommonUtil.getTodayTime();
		
		int result = dao.goMemberExit(id,exit_date);
		
		HttpSession session = request.getSession();
		session.invalidate();
		
        String msg = "";
		if(result == 1) msg = "회원 탈퇴 되었습니다.";
		else msg = "회원 탈퇴 실패!! 관리자에게 문의 바랍니다.";
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", "Index");
	}

}
