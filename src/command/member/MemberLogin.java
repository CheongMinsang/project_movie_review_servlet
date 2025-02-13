package command.member;

import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.CommonExecute;
import common.CommonUtil;
import dao.MovieDao;

public class MemberLogin implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		MovieDao dao = new MovieDao();
		String id 		= request.getParameter("t_id");
		String password = request.getParameter("t_password");
		// 111
		try {
			password = dao.encryptSHA256(password);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
		String name = dao.getLoginInfo(id,password);
		
		String msg ="", url="";
		if(name.equals("")) {
			msg ="ID나 비밀번호가 정확하지 않습니다.";
			url ="Index?t_gubun=login";
			
		} else {
			
			int result = dao.memberLoginUpdate(id, CommonUtil.getTodayTime());
			if(result != 1) System.out.println("MemberLogin.java 최종 로그인 시간 Update 오류! ");
			
			msg =name+"님 환영합니다";
			url ="Index";
			
			HttpSession session = request.getSession();
			session.setAttribute("sessionId", id);
			session.setAttribute("sessionName", name);
			if(id.equals("admin@naver.com")) {
				session.setAttribute("sessionLevel", "top");
			} else {
				session.setAttribute("sessionLevel", "member");
			}
			session.setMaxInactiveInterval(60 * 60);
			
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
	}

}
