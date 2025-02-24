<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 예를 들어, 로그인 성공 시 msg로 "로그인 되었습니다"를 전달했다고 가정합니다.
    String msg = (String)request.getAttribute("msg");
    if(msg == null || msg.trim().equals("")){
        msg = "로그인 되었습니다";
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
    // alert로 로그인 성공 메시지를 띄운 후,
    alert("<%=msg %>");
    
    // 부모 창이 열려있으면 새로고침하여 로그인 상태 반영
    if(window.opener && !window.opener.closed){
        window.opener.location.reload();
    }
    
    // 팝업창 닫기
    window.close();
</script>
</head>
<body>
</body>
</html>
