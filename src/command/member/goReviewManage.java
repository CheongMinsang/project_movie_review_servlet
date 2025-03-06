package command.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.CommonExecute;
import dao.MovieDao;
import dto.MovieDto;
import java.util.ArrayList;

public class goReviewManage implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
	    // 페이지 파라미터 처리
	    int currentPage = 1;
	    String pageParam = request.getParameter("page");
	    if(pageParam != null && !pageParam.isEmpty()) {
	        try {
	            currentPage = Integer.parseInt(pageParam);
	        } catch (NumberFormatException e) {
	            // 페이지 파라미터가 숫자가 아니면 기본값 1 사용
	        }
	    }
	    
        // 검색 파라미터 처리
        String searchType = request.getParameter("searchType");
        String searchValue = request.getParameter("searchValue");
	    
	    // DAO를 통해 리뷰 데이터 가져오기
	    MovieDao dao = new MovieDao();
	    ArrayList<MovieDto> dtos = null;
	    
	    if(searchType != null && searchValue != null && !searchValue.trim().equals("")) {
	        if(searchType.equals("moviename")) {
	            dtos = dao.searchReviewsByMovieName(searchValue);
	        } else if(searchType.equals("name")) {
	            dtos = dao.searchReviewsByUserName(searchValue);
	        } else if(searchType.equals("writeid")) {
	            dtos = dao.searchReviewsByWriteId(searchValue);
	        } else if(searchType.equals("content")) {
	            dtos = dao.searchReviewsByContent(searchValue);
	        }
	        if(dtos == null) {
	            dtos = new ArrayList<MovieDto>();
	        }
	    } else {
	        dtos = dao.getAllReviews();
	        if(dtos == null) {
	            dtos = new ArrayList<MovieDto>();
	        }
	    }
	    
	    // 결과를 request에 저장
	    request.setAttribute("dtos", dtos);
	    request.setAttribute("currentPage", currentPage);
	    
	    // 페이징 정보 계산
	    int totalReviews = (dtos != null) ? dtos.size() : 0;
	    int reviewsPerPage = 6;
	    int totalPages = (int) Math.ceil((double) totalReviews / reviewsPerPage);
	    
	    request.setAttribute("totalPages", totalPages);
	}
}