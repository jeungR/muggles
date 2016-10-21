<%@ page language="java" contentType="text/plain; charset=UTF-8" 
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
    
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>

<%
	String imgstat =(String)request.getAttribute("imgstat");
	
	//업로드 상태에 따라서 프린트 내용 다름
	if(imgstat.equals("good")){
		//JSON 배열 만듦
		JSONArray jsonArray = new JSONArray();
		//JSON 객체 만듦
		JSONObject obj = new JSONObject();
		obj.put("path", request.getAttribute("path"));
		obj.put("name", request.getAttribute("name"));
		jsonArray.add(obj);
		
		out.println(jsonArray);
		
	}else if(imgstat.equals("error")){
		out.print("error");
	}else{
		out.print("failed");
	}
%>