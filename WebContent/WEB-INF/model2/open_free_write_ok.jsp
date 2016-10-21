<%@page import="model1.FreeBoardDAO"%>
<%@page import="model1.FreeBoardTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<%@ page import="java.sql.Connection" %>    
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>

<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="javax.sql.DataSource" %>

<%
    
    int flag = (Integer)request.getAttribute("flag");

    //성공실패 메시지
    out.println("<script type='text/javascript'>");
    if(flag == 0) {
        out.println("alert('글쓰기에 성공했습니다.');");
        out.println("location.href='./open_free.do';");
    } else {
        out.println("alert('글쓰기에 실패했습니다.');");
        out.println("history.back();");
    }
    out.println("</script>");
%>