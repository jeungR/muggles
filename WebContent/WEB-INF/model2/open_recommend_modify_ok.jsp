<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="model1.Recommend_Tab_Dao"%>
<%@page import="model1.Recommend_Tab_Dto"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="model1.MemberTO" %>
<%@ page import="model1.MemberDAO" %>
<%

	int flag =(Integer)request.getAttribute("flag");
	System.out.println("writeOK"+flag );
	//성공실패 메시지   
    out.println("<script type='text/javascript'>");
    if(flag ==0){
        out.println("alert('글쓰기에 성공했습니다')");
        out.println("location.href='open_recommend.do';");
    }else{
        out.println("alert('글쓰기에 실패했습니다')");
        out.println("history.back()");
    }
    out.println("</script>");
	
%>
    
    