<%@ page language="java" contentType="text/plain; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<%@ page import="org.json.simple.JSONObject" %>

<%	
	int flag = (Integer)request.getAttribute("flag");
	
	JSONObject obj = new JSONObject();
	obj.put("flag", flag);
	System.out.println("open_study_delete_ok.jsp");
	out.println(obj);
%>


