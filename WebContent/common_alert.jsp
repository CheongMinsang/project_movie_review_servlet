<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String msg = (String)request.getAttribute("msg");
	String url = (String)request.getAttribute("url");
	String t_gubun  = (String)request.getAttribute("t_gubun");
    if(t_gubun != null && !t_gubun.trim().equals("")){
        // 이미 URL에 ?가 포함되어 있다면 &를 사용하여 추가하고,
        // 그렇지 않다면 ?를 붙여서 파라미터를 추가합니다.
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
	alert("<%=msg %>");
    if('<%=url%>' === "javascript:history.back();") {
        // history.back() 대신 document.referrer를 사용하여 이전 페이지의 URL로 이동하면
        // 브라우저가 해당 URL을 새로 요청하므로 새로고침 효과를 얻을 수 있습니다.
        if(document.referrer && document.referrer !== "") {
            location.href = document.referrer;
        } else {
            // 이전 페이지 URL이 없으면 fallback으로 현재 페이지를 강제 새로고침
            location.reload(true);
        }
    } else {
        location.href = '<%=url%>';
    }
</script>
</head>
<body>
</body>
</html>