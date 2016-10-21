<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

<%@ page import="model1.Stu_board_Dto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model1.MemberTO" %>
<%@ page import="model1.MemberDAO" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
	
<%	
		ArrayList<Stu_board_Dto> list = (ArrayList)request.getAttribute("list");
		
		JSONArray jsonArray = new JSONArray();
		//제이슨타입으로 데이터를 넘겨줌.
		MemberTO to_log = (MemberTO)request.getAttribute("to_log");
		String id = (String)session.getAttribute("sessionId");
		int user_seq = Integer.parseInt(to_log.getUser_seq());
	
		System.out.println("jsp2 json " +user_seq);	
		
		JSONObject obj = new JSONObject();		
		obj.put("wuser_seq",to_log.getUser_seq());
		
		for(Stu_board_Dto dto : list){
		obj.put("stu_seq", dto.getStu_seq());
		obj.put("stu_title" , dto.getStu_title());
		obj.put("stu_m_num", dto.getStu_m_num());
		obj.put("stu_p_num", dto.getStu_p_num());
		obj.put("user_name",dto.getUser_name());
		obj.put("stu_content",dto.getStu_content());
		obj.put("stu_wdate",dto.getStu_wdate());
		obj.put("stu_s_date",dto.getStu_s_date());
		obj.put("stu_e_date",dto.getStu_e_date());
		obj.put("user_seq",dto.getUser_seq());
		jsonArray.add(obj);
		System.out.println("stu_seq"+dto.getStu_seq());
		} 
	out.print(jsonArray);
%>
