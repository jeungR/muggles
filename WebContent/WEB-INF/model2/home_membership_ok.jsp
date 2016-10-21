<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int flag = (Integer)request.getAttribute("flag");

	out.println("<script type='text/javascript'>");
	if(flag == 0) {
		out.println("alert('인증 이메일이 발송되었습니다.\\n이메일 확인을 마쳐야 회원가입이 완료됩니다.');");
		out.println("location.href='./home_login.do';");
	} else {
		out.println("alert('회원가입에 실패했습니다.');");
		out.println("history.back();");
	}
	out.println("</script>");
%>








