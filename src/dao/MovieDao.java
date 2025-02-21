package dao;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import common.DBConnection;
import dto.MovieDto;

public class MovieDao {
	Connection 			con = null;
	PreparedStatement	ps  = null;
	ResultSet 			rs  = null;
	
	// 추천영화목록에 들어가있는지 확인
		public int getRecommendList(String id, String writeid) {
			int count=0;
			String query="select count(*) as count\r\n" + 
					"    from pjt_정민상_recommend \r\n" + 
					"    where movieid ='"+id+"'\r\n" + 
					"    and writeid ='"+writeid+"'";
			try {
				con = DBConnection.getConnection();
				ps  = con.prepareStatement(query);
				rs  = ps.executeQuery();
				if(rs.next()) {
					count = rs.getInt("count");
				}
			}catch(Exception e) {
				System.out.println("getRecommendList() 오류:"+query);
				e.printStackTrace();
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}
			return count;
		}
	
	// 리뷰 목록 가져오기
	public ArrayList<MovieDto> getRatingList(String id){
		ArrayList<MovieDto> dtos = new ArrayList<>();
		String query ="select no, movieid, writeid, name, rating, content, rating_date\r\n" + 
				"from pjt_정민상_rating\r\n" + 
				"where movieid ='"+id+"'\r\n" +
				"order by rating_date desc" ;
		try {
			con = DBConnection.getConnection();
			ps  = con.prepareStatement(query);
			rs  = ps.executeQuery();
			while(rs.next()) {
				int no = rs.getInt("no");
				String writeid = rs.getString("writeid");
				String nickname = rs.getString("name");
				int rating = rs.getInt("rating");
				String content = rs.getString("content");
				String rating_date =rs.getString("rating_date");
				
				Timestamp timestamp = Timestamp.valueOf(rating_date);
				Date date = new Date(timestamp.getTime());

				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				String formattedDate = formatter.format(date);
				
				rating_date = formattedDate;
				
				MovieDto dto = new MovieDto(no, Integer.parseInt(id), nickname, writeid, content, rating_date, rating);
				dtos.add(dto);
				
			}
		}catch(Exception e) {
			System.out.println("getRatingList() 오류:"+query);
			e.printStackTrace();
		}finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return dtos;
	}	
	
	//회원 정보 가져오기
		public MovieDto getMemberInfo2(String id) {
			MovieDto dto = null;
			String query = "select id,password,name,reg_date,last_login_date,\r\n" + 
					"nickname,gender,substr(birthdate,1,4)||'년'||substr(birthdate,5,2)||'월'||substr(birthdate,7)||'일' as birthdate,\r\n" + 
					"substr(phone,1,3)||'-'||substr(phone,4,4)||'-'||substr(phone,8,8) as phone, exit_date\r\n" + 
					"from pjt_정민상_member\r\n" + 
					"where id ='"+id+"'\r\n" ; 
			try {
				con = DBConnection.getConnection();
				ps  = con.prepareStatement(query);
				rs  = ps.executeQuery();
				if(rs.next()) {
					dto = new MovieDto();
					dto.setId(rs.getString("id"));
					dto.setName(rs.getString("name"));
					dto.setReg_date(rs.getString("reg_date"));
					dto.setLast_login_date(rs.getString("last_login_date"));
					dto.setExit_date(rs.getString("exit_date"));
					
					String formattedDate = rs.getString("reg_date");
					String formattedDate2 =	rs.getString("last_login_date");
					String formattedDate3 =	rs.getString("exit_date");
					
			        try {
			            SimpleDateFormat originalFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
			            SimpleDateFormat newFormat = new SimpleDateFormat("yyyy년MM월dd일 HH시mm분");

			            Date date = originalFormat.parse(formattedDate);
			            Date date2 = originalFormat.parse(formattedDate2);
			            formattedDate = newFormat.format(date);
			            formattedDate2 = newFormat.format(date2);

			            // exit_date가 null 또는 빈 문자열이 아닌 경우에만 파싱
			            if (formattedDate3 != null && !formattedDate3.trim().isEmpty()) {
			                Date date3 = originalFormat.parse(formattedDate3);
			                formattedDate3 = newFormat.format(date3);
			            }

			        } catch (Exception e) {
			            e.printStackTrace();
			        }
			        
			        dto.setReg_date(formattedDate);
					dto.setLast_login_date(formattedDate2);
					dto.setExit_date(formattedDate3);
					dto.setNickname(rs.getString("nickname"));
					dto.setGender(rs.getString("gender"));
					dto.setBirthdate(rs.getString("birthdate"));
					dto.setPhone(rs.getString("phone"));
				}
			}catch(Exception e) {
				System.out.println("getMemberInfo() 오류:"+query);
				e.printStackTrace();
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}
			return dto;
		}
	
	//내 정보 가져오기
	public MovieDto getMemberInfo(String id) {
		MovieDto dto = null;
		String query = "select id,password,name,reg_date,last_login_date,\r\n" + 
				"nickname,gender,substr(birthdate,1,4)||'년'||substr(birthdate,5,2)||'월'||substr(birthdate,7)||'일' as birthdate,\r\n" + 
				"substr(phone,1,3)||'-'||substr(phone,4,4)||'-'||substr(phone,8,8) as phone\r\n" + 
				"from pjt_정민상_member\r\n" + 
				"where id ='"+id+"'\r\n" + 
				"and exit_date is null";
		try {
			con = DBConnection.getConnection();
			ps  = con.prepareStatement(query);
			rs  = ps.executeQuery();
			if(rs.next()) {
				dto = new MovieDto();
				dto.setId(rs.getString("id"));
				dto.setPassword(rs.getString("password"));
				dto.setName(rs.getString("name"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setLast_login_date(rs.getString("last_login_date"));
				
				String formattedDate = rs.getString("reg_date");
				String formattedDate2 =	rs.getString("last_login_date");
				
		        try {
		            // 원래 날짜 문자열을 Date 객체로 변환
		            SimpleDateFormat originalFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
		            Date date = originalFormat.parse(formattedDate);
		            Date date2 = originalFormat.parse(formattedDate2);

		            // 원하는 형식으로 변환
		            SimpleDateFormat newFormat = new SimpleDateFormat("yyyy년MM월dd일 HH시mm분");
		            formattedDate = newFormat.format(date);
		            formattedDate2 = newFormat.format(date2);

		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		        
		        dto.setReg_date(formattedDate);
				dto.setLast_login_date(formattedDate2);
				dto.setNickname(rs.getString("nickname"));
				dto.setGender(rs.getString("gender"));
				dto.setBirthdate(rs.getString("birthdate"));
				dto.setPhone(rs.getString("phone"));
			}
		}catch(Exception e) {
			System.out.println("getMemberInfo() 오류:"+query);
			e.printStackTrace();
		}finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return dto;
	}
	
	//아이디 중복검사
	public int checkId(String id) {
		int count=0;
		String query="select count(*) as count\r\n" + 
				"from pjt_정민상_member\r\n" + 
				"where id ='"+id+"'";
		try {
			con = DBConnection.getConnection();
			ps  = con.prepareStatement(query);
			rs  = ps.executeQuery();
			if(rs.next()) {
				count = rs.getInt("count");
			}
		}catch(Exception e) {
			System.out.println("checkId() 오류:"+query);
			e.printStackTrace();
		}finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return count;
	}
	
	//최종로그인시간업데이트
		public int memberLoginUpdate(String id, String todayTime) {
			int result=0;
			String query="update pjt_정민상_member\r\n" + 
					"set last_login_date =\r\n" + 
					"to_date('"+todayTime+"','yyyy-MM-dd hh24:mi:ss')\r\n" + 
					"where id='"+id+"'";
			try {
				con = DBConnection.getConnection();
				ps  = con.prepareStatement(query);
				result = ps.executeUpdate();
			}catch(Exception e) {
				System.out.println("memberLoginUpdate() 오류:"+query);
				e.printStackTrace();
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}
			return result;
		}
	
	// 로그인 정보 조회
	public String getLoginInfo(String id, String password) {
		String name="";
		String query="select name\r\n" + 
				"from pjt_정민상_member\r\n" + 
				"where id ='"+id+"'\r\n" + 
				"and password ='"+password+"'\r\n" + 
				"and exit_date is null";
		try {
			con = DBConnection.getConnection();
			ps  = con.prepareStatement(query);
			rs  = ps.executeQuery();
			if(rs.next()) {
				name = rs.getString("name");
			}
		}catch(Exception e) {
			System.out.println("getLoginInfo() 오류:"+query);
			e.printStackTrace();
		}finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return name;
	}
	
	// 비밀번호 암호화
		public String encryptSHA256(String value) throws NoSuchAlgorithmException{
			String encryptData ="";
			
			MessageDigest sha = MessageDigest.getInstance("SHA-256");
	        sha.update(value.getBytes());
	 
	        byte[] digest = sha.digest();
	        for (int i=0; i<digest.length; i++) {
	            encryptData += Integer.toHexString(digest[i] &0xFF).toUpperCase();
	        }
	         
	        return encryptData;
		}
		
		//회원가입
		public int memberSave(MovieDto dto) {
			int result=0;
			String query="insert into pjt_정민상_member\r\n" + 
					"(id, password, name, reg_date, nickname, gender, birthdate, phone)\r\n" + 
					"values\r\n" + 
					"('"+dto.getId()+"','"+dto.getPassword()+"','"+dto.getName()+"',to_date('"+dto.getReg_date()+"','yyyy-MM-dd hh24:mi:ss'),\r\n" + 
					"'"+dto.getNickname()+"','"+dto.getGender()+"','"+dto.getBirthdate()+"','"+dto.getPhone()+"')";
			try {
				con = DBConnection.getConnection();
				ps  = con.prepareStatement(query);
				result = ps.executeUpdate();
			}catch(Exception e) {
				System.out.println("memberSave() 오류:"+query);
				e.printStackTrace();
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}
			return result;
		}

		public int memberInfoUpdate(MovieDto dto) {
			int result=0;
			String query="update pjt_정민상_member\r\n" + 
					"    set name = '"+dto.getName()+"',\r\n" + 
					"        nickname = '"+dto.getNickname()+"',\r\n" + 
					"        birthdate = '"+dto.getBirthdate()+"',\r\n" + 
					"        phone = '"+dto.getPhone()+"'\r\n" + 
					"where id = '"+dto.getId()+"'";
			try {
				con = DBConnection.getConnection();
				ps  = con.prepareStatement(query);
				result = ps.executeUpdate();
			}catch(Exception e) {
				System.out.println("memberInfoUpdate() 오류:"+query);
				e.printStackTrace();
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}
			return result;
		}
		
		//닉네임 가져오기
		public String getNickname(String writeid) {
			String name = "";
			String query ="select nickname\r\n" + 
					"from pjt_정민상_member\r\n" + 
					"where id ='"+writeid+"'\r\n" + 
					"and exit_date is null";
			try {
				con = DBConnection.getConnection();
				ps  = con.prepareStatement(query);
				rs  = ps.executeQuery();
				if(rs.next()) {
					name = rs.getString("nickname");
				}
			}catch(Exception e) {
				System.out.println("getNickname() 오류:"+query);
				e.printStackTrace();
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}
			return name;
		}
		//리뷰등록
		public int getRating(MovieDto dto) {
			int result = 0;
			String query="insert into pjt_정민상_rating\r\n" + 
					"(no, movieid, writeid, content, rating, name, rating_date)\r\n" + 
					"values\r\n" + 
					"("+dto.getNo()+","+dto.getMovieid()+",'"+dto.getWriteid()+"','"+dto.getContent()+"',"+dto.getRating()+",'"+dto.getNickname()+"',\r\n" + 
					"to_date('"+dto.getRating_date()+"','yyyy-MM-dd hh24:mi:ss')\r\n" + 
					")";
			try {
				con = DBConnection.getConnection();
				ps  = con.prepareStatement(query);
				result = ps.executeUpdate();
			}catch(Exception e) {
				System.out.println("getRating() 오류:"+query);
				e.printStackTrace();
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}
			return result;
		}
		
		//리뷰수정
		public int getRatingUpdate(MovieDto dto) {
			int result = 0;
			String query="update pjt_정민상_rating\r\n" + 
					"set content ='"+dto.getContent()+"',\r\n" + 
					"    rating ='"+dto.getRating()+"',\r\n" + 
					"    rating_date \r\n" + 
					"=to_date('"+dto.getRating_date()+"','yyyy-MM-dd hh24:mi:ss')\r\n" + 
					"where movieid='"+dto.getMovieid()+"'\r\n" + 
					"and writeid='"+dto.getWriteid()+"'";
			try {
				con = DBConnection.getConnection();
				ps  = con.prepareStatement(query);
				result = ps.executeUpdate();
			}catch(Exception e) {
				System.out.println("getRatingUpdate() 오류:"+query);
				e.printStackTrace();
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}
			return result;
		}
		
		//추천영화등록시 가장 큰 넘버
		public int getMaxRecoTabelNumber() {
			int result =0;
			String query ="select nvl(max(to_number(no)),0) +1 as no\r\n" + 
					"from pjt_정민상_recommend";
			try {
				con = DBConnection.getConnection();
				ps  = con.prepareStatement(query);
				rs  = ps.executeQuery();
				if(rs.next()) {
					result = rs.getInt("no");
				}
			}catch(Exception e) {
				System.out.println("getMaxRecoTabelNumber() 오류:"+query);
				e.printStackTrace();
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}
			return result;
		}
		
		//평가시 가장 큰 넘버
		public int getMaxRatingTabelNumber() {
			int result =0;
			String query ="select nvl(max(to_number(no)),0) +1 as no\r\n" + 
					"from pjt_정민상_rating";
			try {
				con = DBConnection.getConnection();
				ps  = con.prepareStatement(query);
				rs  = ps.executeQuery();
				if(rs.next()) {
					result = rs.getInt("no");
				}
			}catch(Exception e) {
				System.out.println("getMaxRatingTabelNumber() 오류:"+query);
				e.printStackTrace();
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}
			return result;
		}
		
		//회원목록조회
		public ArrayList<MovieDto> getMemberList(String category, String keyword, int startRow, int endRow) {
			ArrayList<MovieDto> dtos = new ArrayList<>();
			String sql = "SELECT * FROM ( " +
                     "  SELECT A.*, ROWNUM rn FROM ( " +
                     "    SELECT id, name, reg_date, nickname, gender, " +
                     "           substr(birthdate,1,4)||'년'||substr(birthdate,5,2)||'월'||substr(birthdate,7)||'일' as birthdate, " +
                     "           substr(phone,1,3)||'-'||substr(phone,4,4)||'-'||substr(phone,8,8) as phone, " +
                     "           exit_date " +
                     "    FROM pjt_정민상_member " +
                     "    WHERE 1=1 ";
	        // 검색 조건이 있을 경우 SQL에 조건 추가
	        if (category != null && !category.trim().isEmpty() && 
	            keyword != null && !keyword.trim().isEmpty()) {
	            sql += " AND " + category + " LIKE ? ";
	        }
	        sql += "    ORDER BY reg_date DESC " +
	               "  ) A " +
	               ") WHERE rn BETWEEN ? AND ?";
			try {
				con = DBConnection.getConnection();
				ps  = con.prepareStatement(sql);
				int index = 1;
	            if (category != null && !category.trim().isEmpty() && 
	                keyword != null && !keyword.trim().isEmpty()) {
	                ps.setString(index++, "%" + keyword + "%");
	            }
	            ps.setInt(index++, startRow);
	            ps.setInt(index++, endRow);
				rs  = ps.executeQuery();
				while(rs.next()) {
					String id = rs.getString("id");
					String name = rs.getString("name");
					String reg_date = rs.getString("reg_date");
					String nickname = rs.getString("nickname");
					String gender = rs.getString("gender");
					String birthdate = rs.getString("birthdate");
					String phone = rs.getString("phone");
					String exit_date = rs.getString("exit_date");
					
					// reg_date 포맷 변경 (예: "yyyy-MM-dd HH:mm:ss.S" → "yyyy년MM월dd일 HH시mm분")
		            if(reg_date != null && !reg_date.trim().isEmpty()){
		                try {
		                    SimpleDateFormat originalFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
		                    Date date = originalFormat.parse(reg_date);
		                    SimpleDateFormat newFormat = new SimpleDateFormat("yyyy년MM월dd일 HH시mm분");
		                    reg_date = newFormat.format(date);
		                } catch(Exception e) {
		                    e.printStackTrace();
		                }
		            }
					
					MovieDto dto = new MovieDto(id, name, reg_date, nickname, gender, birthdate, phone, exit_date, "");
					dtos.add(dto);
				}
			}catch(Exception e) {
				System.out.println("getMemberList() 오류:"+sql);
				e.printStackTrace();
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}
			return dtos;
		}
		
	    // 검색 조건에 따른 전체 회원 수를 반환하는 메서드
	    public int getTotalCount(String category, String keyword) {
	        int totalCount = 0;
	        String sql = "SELECT COUNT(*) AS cnt FROM pjt_정민상_member WHERE 1=1 ";
	        if (category != null && !category.trim().isEmpty() &&
	            keyword != null && !keyword.trim().isEmpty()) {
	            sql += " AND " + category + " LIKE ? ";
	        }
	        Connection con = null;
	        PreparedStatement ps = null;
	        ResultSet rs = null;
	        try {
	            con = DBConnection.getConnection();
	            ps = con.prepareStatement(sql);
	            if (category != null && !category.trim().isEmpty() &&
	                keyword != null && !keyword.trim().isEmpty()) {
	                ps.setString(1, "%" + keyword + "%");
	            }
	            rs = ps.executeQuery();
	            if (rs.next()) {
	                totalCount = rs.getInt("cnt");
	            }
	        } catch(Exception e) {
	            System.out.println("getTotalCount() 오류: " + sql);
	            e.printStackTrace();
	        } finally {
	            DBConnection.closeDB(con, ps, rs);
	        }
	        return totalCount;
	    }
		
		//회원탈퇴
		public int goMemberExit(String id, String exit_date) {
			int result=0;
			String query="update pjt_정민상_member\r\n" + 
					"set exit_date =\r\n" + 
					"to_date('"+exit_date+"','yyyy-MM-dd hh24:mi:ss')\r\n" + 
					"where id='"+id+"'";
			try {
				con = DBConnection.getConnection();
				ps  = con.prepareStatement(query);
				result = ps.executeUpdate();
			}catch(Exception e) {
				System.out.println("goMemberExit() 오류:"+query);
				e.printStackTrace();
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}
			return result;
		}
		
		//리뷰 중복작성 검사
		public int checkRatingMember(String id,String sessionId) {
			int result=0;
			String query="select count(*) as count\r\n" + 
					"from pjt_정민상_rating\r\n" + 
					"where movieid ='"+id+"'\r\n" + 
					"and writeid ='"+sessionId+"'";
			try {
				con = DBConnection.getConnection();
				ps  = con.prepareStatement(query);
				rs  = ps.executeQuery();
				if(rs.next()) {
					result = rs.getInt("count");
				}
			}catch(Exception e) {
				System.out.println("checkRatingMember() 오류:"+query);
				e.printStackTrace();
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}
			return result;
		}
		
		//리뷰 삭제
		public int goReviewDelete(String movieid, String writeid) {
			int result=0;
			String query="delete from pjt_정민상_rating\r\n" + 
					"where writeid ='"+writeid+"'\r\n" + 
					"and movieid ='"+movieid+"'";
			try {
				con = DBConnection.getConnection();
				ps  = con.prepareStatement(query);
				result = ps.executeUpdate();
			}catch(Exception e) {
				System.out.println("goReviewDelete() 오류:"+query);
				e.printStackTrace();
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}
			return result;
		}
		
		// 추천영화 삭제
		public int deleteReco(String movieId, String writeId) {
			int result=0;
			String query="delete from pjt_정민상_recommend\r\n" + 
					"where movieid ='"+movieId+"'\r\n" + 
					"and writeid ='"+writeId+"'";
			try {
				con = DBConnection.getConnection();
				ps  = con.prepareStatement(query);
				result = ps.executeUpdate();
			}catch(Exception e) {
				System.out.println("deleteReco() 오류:"+query);
				e.printStackTrace();
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}
			return result;
		}
		
		// 추천영화 저장
		public int saveReco(MovieDto dto) {
			int result=0;
			String query="insert into pjt_정민상_recommend\r\n" + 
					"(no, movieid, writeid, reg_date)\r\n" + 
					"values\r\n" + 
					"("+dto.getNo()+", "+dto.getMovieid()+",'"+dto.getWriteid()+"',\r\n" + 
					"to_date('"+dto.getReg_date()+"','yyyy-MM-dd hh24:mi:ss')\r\n" + 
					")";
			try {
				con = DBConnection.getConnection();
				ps  = con.prepareStatement(query);
				result = ps.executeUpdate();
			}catch(Exception e) {
				System.out.println("saveReco() 오류:"+query);
				e.printStackTrace();
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}
			return result;
		}
		//추천영화목록 가져오기
		public ArrayList<MovieDto> getRecoList(String writeid) {
			ArrayList<MovieDto> dtos = new ArrayList<>();
			String query ="select no,movieid,reg_date\r\n" + 
					"from pjt_정민상_recommend\r\n" + 
					"where writeid='"+writeid+"'\r\n" + 
					"order by reg_date desc" ;
			try {
				con = DBConnection.getConnection();
				ps  = con.prepareStatement(query);
				rs  = ps.executeQuery();
				while(rs.next()) {
					int no = rs.getInt("no");
					int movieid = rs.getInt("movieid");
					String reg_date =rs.getString("reg_date");
					
					Timestamp timestamp = Timestamp.valueOf(reg_date);
					Date date = new Date(timestamp.getTime());

					SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
					String formattedDate = formatter.format(date);
					
					reg_date = formattedDate;
					
					MovieDto dto = new MovieDto(reg_date, movieid, no);
					dtos.add(dto);
					
				}
			}catch(Exception e) {
				System.out.println("getRecoList() 오류:"+query);
				e.printStackTrace();
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}
			return dtos;
		}
}
