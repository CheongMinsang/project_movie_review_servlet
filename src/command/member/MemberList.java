package command.member;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import common.CommonExecute;
import dao.MovieDao;
import dto.MovieDto;

public class MemberList implements CommonExecute {

    @Override
    public void execute(HttpServletRequest request) {
        MovieDao dao = new MovieDao();
        
        // 검색 파라미터 받기 (예: category = "name", keyword = "홍길동")
        String category = request.getParameter("category");
        String keyword  = request.getParameter("keyword");
        
        // 페이징 파라미터 (기본 1페이지)
        String tempPage = request.getParameter("page");
        int page = 1;
        if (tempPage != null && !tempPage.trim().isEmpty()) {
            try {
                page = Integer.parseInt(tempPage);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        int pageSize = 5; // 한 페이지 당 표시할 레코드 수
        int startRow = (page - 1) * pageSize + 1;
        int endRow = page * pageSize;
        
        // 전체 레코드 수와 전체 페이지 수 계산
        int totalCount = dao.getTotalCount(category, keyword);
        int totalPage = (int) Math.ceil(totalCount / (double) pageSize);
        
        // 검색 및 페이징 조건이 반영된 회원 목록 조회
        ArrayList<MovieDto> dtos = dao.getMemberList(category, keyword, startRow, endRow);
        
        // 결과를 request에 저장 (JSP에서 사용)
        request.setAttribute("dtos", dtos);
        request.setAttribute("page", page);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("category", category);
        request.setAttribute("keyword", keyword);
    }
}
