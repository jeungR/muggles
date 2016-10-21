<%@ page language="java" contentType="text/plain; charset=UTF-8" 
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
    
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>

<%
	//데이터 받음
	JSONArray jsonArray = (JSONArray)request.getAttribute("jsonArray");    
	//출력
	out.println(jsonArray);
%>