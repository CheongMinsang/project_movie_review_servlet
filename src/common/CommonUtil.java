package common;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class CommonUtil {
	
	//로그인 세션 ID
	public static String getSessionId(HttpServletRequest request) {
		HttpSession session = request.getSession();
		//String sessionId = (String)session.getAttribute("sessionId");
		return (String)session.getAttribute("sessionId");
	}
	//로그인 세션 Name
	public static String getSessionName(HttpServletRequest request) {
		HttpSession session = request.getSession();
		//String sessionId = (String)session.getAttribute("sessionId");
		return (String)session.getAttribute("sessionName");
	}
	//로그인 세션 Level
	public static String getSessionLevel(HttpServletRequest request) {
		HttpSession session = request.getSession();
		//String sessionId = (String)session.getAttribute("sessionId");
		return (String)session.getAttribute("sessionLevel");
	}
	
	//첨부파일 경로: 자료실
		public static String getPdsDir() {
			String dir ="C:/Users/JSLHRD/Desktop/track19_jung/track19_project/homepage_jsp_jsl/WebContent/attach/dataroom/";
			
			return dir;
		}
	
	//첨부파일 경로: 공지사항
	public static String getNoticeDir(HttpServletRequest request) {
//		String dir ="C:/Users/JSLHRD/Desktop/track19_jung/track19_project/homepage_jsp_jsl/WebContent/attach/notice/";
		String attachDir =request.getSession().getServletContext().getRealPath("/")+"attach/notice/";
		
		return attachDir;
	}
	//첨부파일 경로: 제품
	public static String getProductDir(HttpServletRequest request) {
		return request.getSession().getServletContext().getRealPath("/")+
		"attach/product/";
	}
	
	//등록시 위작은따옴표 변환
	public static String setQuote(String str) {
		//str : 제목'가나다라~
		return str.replace("'", "&#39;");
	}
	
	public static String getToday(){
		Date time = new Date(); // Tue Oct 01 11:38:48 KST 2024
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); // 2024-10-01
		String toDay = format.format(time);
		return toDay;
	}
	public static String getTodayTime(){
		Date time = new Date(); // Tue Oct 01 11:38:48 KST 2024
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String toDay = format.format(time);
		return toDay;
	}
	
	// 페이지 설정
	public static String pageListPost(int current_page,int total_page, int pageNumber_count){
		int pagenumber;    //화면에 보여질 페이지 인덱스수
		int startpage;     //화면에 보여질 시작 페이지 번호
		int endpage;       //화면에 보여질 마지막 페이지 번호
		int curpage;       //이동하고자 하는 페이지 번호
		
		String strList=""; //리턴될 페이지 인덱스 리스트

		pagenumber = pageNumber_count;   //한 화면의 페이지 인덱스수
		
		//시작 페이지 번호 구하기
		startpage = ((current_page - 1)/ pagenumber) * pagenumber + 1;
		//마지막 페이지 번호 구하기
		endpage = (((startpage -1) + pagenumber) / pagenumber)*pagenumber;
		//총페이지수가 계산된 마지막 페이지 번호보다 작을 경우
		//총페이지수가 마지막 페이지 번호가 됨
		
		if(total_page <= endpage)  endpage = total_page;
					
		//첫번째 페이지 인덱스 화면이 아닌경우
		if(current_page > pagenumber){
			curpage = startpage -1;  //시작페이지 번호보다 1적은 페이지로 이동
			strList = strList +"<a href=javascript:goPage('"+curpage+"') ><i class='fa fa-angle-double-left'></i></a>";
		}
						
		//시작페이지 번호부터 마지막 페이지 번호까지 화면에 표시
		curpage = startpage;
		while(curpage <= endpage){
			if(curpage == current_page){
				strList = strList +"<a class='active'>"+current_page+"</a>";
			} else {
				strList = strList +"<a href=javascript:goPage('"+curpage+"')>"+curpage+"</a>";
			}
			curpage++;
		}
		//뒤에 페이지가 더 있는 경우
		if(total_page > endpage){
			curpage = endpage+1;
			strList = strList + "<a href=javascript:goPage('"+curpage+"') ><i class='fa fa-angle-double-right'></i></a>";
		}
		return strList;
	}
	
}
