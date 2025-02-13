package command.member;

import javax.servlet.http.HttpServletRequest;

import common.CommonExecute;
import dao.MovieDao;
import dto.MovieDto;

public class MemberMyinfoUpdate implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		MovieDao dao = new MovieDao();
		
		String id = request.getParameter("t_id2");
		String name = request.getParameter("t_name");
		String nickname = request.getParameter("t_nickname");
		String birthdate = request.getParameter("t_birthdate");
		String phone = request.getParameter("t_phone");
		
        // 숫자가 아닌 모든 문자를 제거하여 DB에 숫자만 저장하도록 변환
        if(birthdate != null) {
            birthdate = birthdate.replaceAll("\\D", ""); // 결과: "19970424"
        }
        if(phone != null) {
            phone = phone.replaceAll("\\D", ""); // 결과: "01055663208"
        }
        
        MovieDto dto = new MovieDto(id, name, nickname, birthdate, phone);
        int result = dao.memberInfoUpdate(dto);
        
        String msg = "";
		if(result == 1) msg = "정보가 변경되었습니다.";
		else msg = "정보 수정 실패!! 관리자에게 문의 바랍니다.";
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", "Index");
		request.setAttribute("t_gubun", "myinfo");
	}
}
