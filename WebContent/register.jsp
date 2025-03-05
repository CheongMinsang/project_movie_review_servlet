<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 페이지</title>
    <link href="register.css" rel="stylesheet">
	<script type="text/javascript" src="js/jquery-1.8.1.min.js"></script>
	<script src="https://kit.fontawesome.com/a6ae218852.js" crossorigin="anonymous"></script>
</head>
<body>
<form name="mem">
	<input type="hidden" name="t_gubun">
</form>
    <div class="container">
        <a href="javascript:window.close();" class="home-link"><i class="fa-solid fa-house"></i> 홈으로</a>
        <h2 align="center">회원가입</h2>
        <form name="register">
        <input type="hidden" name="t_gubun">
        		<label>이메일</label>
		            <div class="email-container">
		                <input type="email" id="email-input" class="email-input" name="t_id" placeholder="이메일" onkeydown="focusNext(event,'check-button')" autofocus>
		                <button type="button" id="check-button" class="check-button" onkeydown="focusNext(event,'t_password')" onclick="checkUsername()">중복 검사</button>
						<input type="hidden" name="t_confirm_id" size="10" disabled style="border:none"> 
						<input type="hidden" name="t_id_hidden">
		            </div><br><br>
      			<label>비밀번호</label> 
		            <input type="password" id="t_password" name="t_password" placeholder="비밀번호" onkeydown="focusNext(event,'t_confirm_password')"><br><br>
		            <input type="password" id="t_confirm_password" name="t_confirm_password" placeholder="비밀번호 확인" onkeydown="focusNext(event,'t_name')"><br><br>
		        <label>이름</label>    
	            	<input type="text" id="t_name" name="t_name" placeholder="이름" onkeydown="focusNext(event,'t_nickname')"><br><br>
	            <label>닉네임</label>	
	            	<input type="text" id="t_nickname" name="t_nickname" placeholder="이름" onkeydown="focusNext(event,'male')"><br><br>
		        <label>성별</label><br><br>
		        	<input type="radio" id="male" name="t_gender" value="남" onkeydown="focusNext(event,'female')">
		        <label for="male">남자</label>
		        	<input type="radio" id="female" name="t_gender" value="여" onkeydown="focusNext(event,'t_birthdate')">
		        <label for="female">여자</label><br><br><br>
		        <label for="birthDate">생년월일</label>
      				<input type="text" id="t_birthdate" name="t_birthdate" placeholder="19970424 형식으로 입력" onkeydown="focusNext(event,'t_phone')" autocomplete="off"><br><br>
		        <label for="phone">전화번호</label>
		       		<input type="text" id="t_phone" name="t_phone" placeholder="-는 제외하고 입력해주세요" onkeydown="focusNext(event,'button1')" autocomplete="off"><br><br>
            <button type="button" id="button1" onclick="goJoinMember()" class="submit-button">회원가입</button>
            <button type="button" onclick="goLogin()" class="submit-button">로그인</button>
        </form>
    </div>
    <script>
        function goJoinMember() {
            var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            var phone = document.getElementById("t_phone");
            var gender = document.querySelector('input[name="t_gender"]:checked');
            var birthDate = document.getElementById("t_birthdate").value;
            
            if (register.t_id.value === '') {
                alert('이메일을 입력해주세요.');
                register.t_id.focus();
                return;
            }
            
            if (!emailPattern.test(register.t_id.value)) {
                alert('이메일에는 반드시 @가 포함되어야 합니다.');
                register.t_id.focus();
                return;
            }
            
            if(register.t_confirm_id.value == ""){
    			alert("사용가능한 메일인지 중복검사 바랍니다");
    			register.t_id.focus();
    			return;
    		} else {
    			if(register.t_confirm_id.value != "사용가능"){
    				alert("사용가능한 메일인지 중복검사 바랍니다");
    				register.t_id.focus();
    				return;
    			} else {
    				if(register.t_id.value != register.t_id_hidden.value){
    					alert("사용가능한 메일인지 중복검사 바랍니다");
    					register.t_id.focus();
    					return;
    				}
    			}
    		}

            if (register.t_id.value.length > 50) {
                alert('이메일은 최대 50자까지 입력해주세요.');
                register.t_id.select();
                return;
            }

            if (register.t_password.value === '') {
                alert('비밀번호를 입력해주세요.');
                register.t_password.focus();
                return;
            }

            if (register.t_password.value.length > 20) {
                alert('비밀번호는 최대 20자까지 입력해주세요.');
                register.t_password.select();
                return;
            }

            if (register.t_confirm_password.value === '') {
                alert('비밀번호 확인을 입력해주세요.');
                register.t_confirm_password.focus();
                return;
            }

            if (register.t_confirm_password.value !== register.t_password.value) {
                alert("비밀번호 확인이 다릅니다. 확인 바랍니다!");
                return;
            }

            if (register.t_name.value === '') {
                alert('이름을 입력해주세요.');
                register.t_name.focus();
                return;
            }

            if (register.t_name.value.length > 20) {
                alert('이름은 최대 10자까지 입력해주세요.');
                register.t_name.select();
                return;
            }
            
            if (register.t_nickname.value === '') {
                alert('닉네임을 입력해주세요.');
                register.t_nickname.focus();
                return;
            }

            if (register.t_nickname.value.length > 20) {
                alert('닉네임은 최대 20자까지 입력해주세요.');
                register.t_nickname.select();
                return;
            }
            
            // 성별 선택 여부 검증
            if (!gender) {
                alert("성별을 선택해 주세요.");
                document.getElementsByName("gender")[0].focus();
                return false;
            }
            
         // 생년월일 검증
            var birthDatePattern = /^\d{8}$/;
            if (birthDate === "") {
                alert("생년월일을 입력해 주세요.");
                return false;
            } else if (!birthDatePattern.test(birthDate)) {
                alert("생년월일은 YYYYMMDD 형식으로 8자리여야 합니다.");
                return false;
            }

            var year = parseInt(birthDate.substring(0, 4));
            var month = parseInt(birthDate.substring(4, 6));
            var day = parseInt(birthDate.substring(6, 8));

            if (month < 1 || month > 12) {
                alert("월은 01부터 12까지만 입력 가능합니다.");
                return false;
            }

            var daysInMonth = new Date(year, month, 0).getDate();
            if (day < 1 || day > daysInMonth) {
            	alert("해당 월에서 유효한 일은 01일부터 " + daysInMonth + "일 까지 입니다.");
                return false;
            }
            
            // 전화번호 검증
            var phonePattern = /^010\d{8}$/;
            if (phone.value === "") {
                alert("전화번호를 입력해 주세요.");
                phone.focus();
                return false;
            } else if (!phonePattern.test(phone.value)) {
                alert("전화번호는 010으로 시작하며 총 11자리여야 합니다.");
                phone.focus();
                return false;
            }

            register.t_gubun.value = "domemberjoin";
            register.method = "post";
            register.action = "Index2";
            register.submit();
        }
        function checkUsername() {
            if (register.t_id.value == "") {
                alert('이메일을 입력해주세요.');
                register.t_id.focus();
                return;
            }
			
			var id = register.t_id.value; // "aaa"
			$.ajax({ // 비동기식 JSP 접속방식 (화면을 전환하지 않고 실행)
				type :"POST",
				url : "MemberCheckId",
				data: "t_id="+id,
				dataType : "text",
				error : function(){
					alert('통신실패!!!!!');
				},
				success : function(data){
		            var result = $.trim(data); // 공백 제거

		            if (result === "사용가능") {
		                alert("사용 가능한 이메일입니다.");
		            } else if (result === "사용불가") {
		                alert("이미 사용 중인 이메일입니다.");
		            } else {
		                alert("예상치 못한 결과: " + result);
		            }

		            // 입력값 확인용 히든 필드 설정 (필요 시 유지)
		            register.t_confirm_id.value = result;
		            register.t_id_hidden.value = id;
				}
			});	
			return;
        }   
        const ids = ['email-input','t_password','t_confirm_password',
        			't_name','t_nickname','male','female','t_birthDate','t_phone'
        	];

        ids.forEach(id => {
            const element = document.getElementById(id);
            element.addEventListener('focus', function() {
                this.style.borderColor = '#66afe9'; // 입력 중일 때 테두리 색을 오렌지색으로
            });

            element.addEventListener('blur', function() {
                this.style.borderColor = ''; // 기본 테두리 색으로 돌아감
            });
        });
    </script>
    <script>
    // 팝업창이 언로드될 때(닫힐 때) 부모창 새로고침 시도
    window.addEventListener('unload', function(){
        if(window.opener && !window.opener.closed){
            window.opener.location.reload();
        }
    });
</script>
<script>
	function goLogin(){
		window.resizeTo(500, 600); // 현재 창의 크기를 500x1200으로 변경
		mem.t_gubun.value="login";
		mem.method="post";
		mem.action="Index2";
		mem.submit();
	}
	function focusNext(event, nextId){
		if(event.key === "Enter"){
			event.preventDefault();
			document.getElementById(nextId).focus();
		}
	}
</script>
</body>
</html>
