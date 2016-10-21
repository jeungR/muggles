<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int flag = (Integer)request.getAttribute("flag");
	String id = (String)request.getAttribute("id");

	out.println("<script type='text/javascript'>");
	if(flag == 0) {
		session.setAttribute("sessionId", id);
		response.sendRedirect("./home_main.do");
	} else if (flag == 1) {
		out.println("alert('아이디 또는 비밀번호가 일치하지 않습니다');");
		out.println("history.back();");
	} else {
		out.println("alert('서버 오류입니다');");		
		out.println("history.back();");
	}
	out.println("</script>");
%>








