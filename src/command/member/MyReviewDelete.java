package command.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MovieDao;

/**
 * Servlet implementation class MyReviewDelete
 */
@WebServlet("/MyReviewDelete")
public class MyReviewDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyReviewDelete() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MovieDao dao = new MovieDao();
		
		String movieid = request.getParameter("movieId");
		HttpSession session = request.getSession();
		String writeid = (String) session.getAttribute("sessionId");
		
		int result = dao.goReviewDelete(movieid,writeid);
		
        String msg = "";
		if(result == 1) msg = "삭제되었습니다";
		else msg = "리뷰 삭제 실패!! 관리자에게 문의 바랍니다.";
		
		response.setContentType("text/html; charset=utf-8"); // 보여줄 웹페이지 형식
		PrintWriter out = response.getWriter(); // out.print를 사용하기 위한 Class
		out.print(msg);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
