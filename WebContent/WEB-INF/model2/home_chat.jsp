<%@ page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONObject"%>

<%
	JSONArray datas = (JSONArray)request.getAttribute("datas");

	out.println(datas);
%>