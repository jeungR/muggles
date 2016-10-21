<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page import="org.json.simple.JSONObject" %>
    <%
    
    int flag = (Integer)request.getAttribute("flag");
	
	System.out.println("open_study_join_ok.jsp");
	out.println("<script type='text/javascript'>");
    if(flag == 0) {
        out.println("alert('참여성공');");
        out.println("location.href='./open_study.do';");
    } else if(flag == 1) {
        out.println("alert('이미속한그룹입니다.');");
        out.println("history.back();");
    } else {
        out.println("alert('참여할수 없습니다.');");
        out.println("history.back();");
    }
    out.println("</script>");
	
	%>
    