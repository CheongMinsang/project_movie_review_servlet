package command.member;

import javax.servlet.http.HttpServletRequest;
import common.CommonExecute;
import dao.MovieDao;
import dto.MovieDto;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;

public class goGetManyReview implements CommonExecute {

    @Override
    public void execute(HttpServletRequest request) {
        
        // DAO를 통해 추천 영화 목록 조회 (MovieDao와 MovieDto는 미리 구현되어 있다고 가정)
        MovieDao dao = new MovieDao();
        int gubun =1;
        ArrayList<MovieDto> movieList = dao.goManyReview(gubun);
        
        // 추천 영화 ID를 쉼표로 구분된 문자열로 구성
        StringBuilder idBuilder = new StringBuilder();
        StringBuilder idBuilder2 = new StringBuilder();
        for (MovieDto movie : movieList) {
        	idBuilder.append(movie.getMovieid()).append(",");
        	idBuilder2.append(movie.getMoviename()).append(",");
        }
        // 마지막 쉼표 제거
        if (idBuilder.length() > 0) {
            idBuilder.setLength(idBuilder.length() - 1);
        }
        if (idBuilder2.length() > 0) {
        	idBuilder2.setLength(idBuilder2.length() - 1);
        }
        
        // 구성된 id 문자열을 request 속성에 저장
        // (혹은 바로 redirect URL에 사용할 수 있도록 값으로 전달)
        request.setAttribute("id", idBuilder.toString());
        try {
            String encodedName = URLEncoder.encode(idBuilder2.toString(), "UTF-8");
            request.setAttribute("name", encodedName);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
    }
}
