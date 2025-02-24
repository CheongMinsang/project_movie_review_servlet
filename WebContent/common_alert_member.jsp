<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String msg = (String)request.getAttribute("msg");
    String url = (String)request.getAttribute("url");
    String t_gubun = (String)request.getAttribute("t_gubun");
    if(t_gubun != null && !t_gubun.trim().equals("")){
        // URL에 이미 ?가 포함되어 있다면 &를, 없으면 ?를 사용하여 파라미터 추가
        if(url.contains("?")){
            url += "&t_gubun=" + t_gubun;
        } else {
            url += "?t_gubun=" + t_gubun;
        }
    }
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
    // alert로 메시지 표시 후
    alert("<%=msg %>");
    // 지정된 URL로 이동 (여기서는 "Index?t_gubun=login")
    location.href = '<%=url %>';
</script>
</head>
<body>
</body>
</html>
