package command.member;

import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;

import common.CommonExecute;
import common.CommonUtil;
import dao.MovieDao;
import dto.MovieDto;

public class MemberJoin implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		MovieDao dao = new MovieDao();
		
		String id = request.getParameter("t_id");
		String password = request.getParameter("t_password");
		try {
			password = dao.encryptSHA256(password);
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String name = request.getParameter("t_name");
		String nickname = request.getParameter("t_nickname");
		String gender = request.getParameter("t_gender");
		String birthdate = request.getParameter("t_birthdate");
		String phone = request.getParameter("t_phone");
		String reg_date = CommonUtil.getTodayTime();
		
		MovieDto dto = new MovieDto(id, password, name, reg_date, nickname, gender, birthdate, phone);
		int result = dao.memberSave(dto);
		
		String msg = "";
		if(result == 1) msg = name+"님 회원 가입되었습니다.";
		else msg = "회원가입 실패!! 관리자에게 문의 바랍니다.";
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", "Index");
		request.setAttribute("t_gubun", "login");
		
	}

}
