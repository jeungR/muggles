<%@page import="model1.Recommend_Tab_Dto"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

<%@ page import="model1.Stu_board_Dto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model1.MemberTO" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="model1.MemberDAO" %>
	
<%	
		ArrayList<Recommend_Tab_Dto> list = (ArrayList)request.getAttribute("recommlist");
		
		JSONArray jsonArray = new JSONArray();
		//제이슨타입으로 데이터를 넘겨줌.
		
		
		for(Recommend_Tab_Dto dto : list){
		
		JSONObject obj = new JSONObject();		
		
		obj.put("recomm_seq", dto.getRecomm_seq());
		obj.put("recomm_olin", dto.getRecomm_olin());
		obj.put("recomm_language" , dto.getRecomm_language());
		obj.put("recomm_title", dto.getRecomm_title());
		obj.put("recomm_content", dto.getRecomm_content());
		obj.put("recomm_link",dto.getRecomm_link());
		obj.put("cost",dto.getCst());
		obj.put("cost_detail",dto.getCst_detail());
		obj.put("recomm_img",dto.getRecomm_img());
		
		jsonArray.add(obj);
		
		} 
	out.print(jsonArray);
%>
