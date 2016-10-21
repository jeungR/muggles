<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.oreilly.servlet.ServletUtils" %>
<%
    String fileName = request.getParameter("filename");

    String sFilePath = "C:\\java\\workspace\\muggles\\WebContent\\upload\\" + fileName;
    
    byte b[] = new byte[4096];
    File oFile = new File(sFilePath);
    
    out.clearBuffer();
    response.setContentType("application/octet-stream");
    response.setHeader("Content-Disposition", 
            "attachment;filename=" + URLEncoder.encode(fileName, "utf-8"));
    FileInputStream in = new FileInputStream(sFilePath);
    ServletOutputStream sout = response.getOutputStream();
    int numRead;
    while((numRead = in.read(b, 0, b.length)) != -1) {
        sout.write(b, 0, numRead);
    }
    sout.flush();
    sout.close();
    in.close();
%>