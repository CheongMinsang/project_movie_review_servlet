package command.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.CommonExecute;

public class MemberLogout implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		
		String msg ="로그아웃 되었습니다";
		request.setAttribute("msg", msg);
		request.setAttribute("url", "Index");
	}

}
