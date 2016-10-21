<%@page import="model1.QnaBoardDAO"%>
<%@page import="model1.QnaBoardTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.io.File"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%@ page import="java.sql.Connection" %>    
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>

<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="javax.sql.DataSource" %>

<%
	QnaBoardTO to = (QnaBoardTO)request.getAttribute("to");
	
	String seq = to.getSeq();
	int flag = (Integer)request.getAttribute("flag");
	
	
    //성공시 리스트페이지, 실패시 이전페이지
    out.println("<script type='text/javascript'>");
    if(flag == 0) {
        out.println("alert('글수정에 성공했습니다.');");
        out.println("location.href='./open_qna_view.do?seq="+seq+"';");
    } else if(flag == 1) {
        out.println("alert('비밀번호가 잘못되었습니다.');");
        out.println("history.back();");
    } else {
        out.println("alert('글수정에 실패했습니다.');");
        out.println("history.back();");
    }
    out.println("</script>");
%>