package dto;

public class MovieDto {
	private String id, password, name, reg_date, exit_date, last_login_date,
					nickname, gender, birthdate, phone, writeid, content, rating_date,
					moviename;
	private int movieid, rating, no;
	
	// 개인 리뷰 목록
	public MovieDto(String name, String content, String rating_date, int movieid, int rating, String moviename) {
		this.name = name;
		this.content = content;
		this.rating_date = rating_date;
		this.movieid = movieid;
		this.rating = rating;
		this.moviename = moviename;
	}

	//회원전원 리뷰목록
	public MovieDto(String name, String content, String rating_date, int movieid, int rating, String moviename, String writeid) {
		this.name = name;
		this.content = content;
		this.rating_date = rating_date;
		this.movieid = movieid;
		this.rating = rating;
		this.moviename = moviename;
		this.writeid = writeid;
	}

	//추천영화목록
	public MovieDto(String reg_date, int movieid, int no) {
		this.reg_date = reg_date;
		this.movieid = movieid;
		this.no = no;
	}

	//가입회원목록조회
	public MovieDto(String id, String name, String reg_date, String nickname, String gender, String birthdate,
			String phone, String exit_date, String password) {
		this.id = id;
		this.name = name;
		this.reg_date = reg_date;
		this.nickname = nickname;
		this.gender = gender;
		this.birthdate = birthdate;
		this.phone = phone;
		this.exit_date = exit_date;
		this.password = password;
	}

	//영화 리뷰 등록
	public MovieDto(int no, int movieid, String nickname, String writeid, String content, String rating_date, int rating, String moviename) {
		this.no = no;
		this.movieid = movieid;
		this.nickname = nickname;
		this.writeid = writeid;
		this.content = content;
		this.rating_date = rating_date;
		this.rating = rating;
		this.moviename = moviename;
	}

	//회원정보 수정 시
	public MovieDto(String id, String name, String nickname, String birthdate, String phone) {
		this.id = id;
		this.name = name;
		this.nickname = nickname;
		this.birthdate = birthdate;
		this.phone = phone;
	}
	
	//회원가입 시
	public MovieDto(String id, String password, String name, String reg_date, String nickname, String gender,
			String birthdate, String phone) {
		this.id = id;
		this.password = password;
		this.name = name;
		this.reg_date = reg_date;
		this.nickname = nickname;
		this.gender = gender;
		this.birthdate = birthdate;
		this.phone = phone;
	}
	
	public MovieDto() {}
	
	//추천영화등록시
	public MovieDto(String writeid, String reg_date, int movieid, int no) {
		this.writeid = writeid;
		this.reg_date = reg_date;
		this.movieid = movieid;
		this.no = no;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getExit_date() {
		return exit_date;
	}
	public void setExit_date(String exit_date) {
		this.exit_date = exit_date;
	}
	public String getLast_login_date() {
		return last_login_date;
	}
	public void setLast_login_date(String last_login_date) {
		this.last_login_date = last_login_date;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getBirthdate() {
		return birthdate;
	}
	public void setBirthdate(String birthdate) {
		this.birthdate = birthdate;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getWriteid() {
		return writeid;
	}

	public void setWriteid(String writeid) {
		this.writeid = writeid;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}
	public String getRating_date() {
		return rating_date;
	}
	public void setRating_date(String rating_date) {
		this.rating_date = rating_date;
	}
	public int getMovieid() {
		return movieid;
	}
	public void setMovieid(int movieid) {
		this.movieid = movieid;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getMoviename() {
		return moviename;
	}
	public void setMoviename(String moviename) {
		this.moviename = moviename;
	}
}
