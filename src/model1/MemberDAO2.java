package model1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.security.MessageDigest;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import model1.MemberTO;

public class MemberDAO2 {
	private DataSource dataSource = null;

	public MemberDAO2() {
		
			Connection conn = null;
			PreparedStatement pstmt = null;
		
		try {
			
			System.out.println("확인1");
			Context initCtx = new InitialContext();
			Context envCtx = (Context)initCtx.lookup("java:comp/env");
			dataSource = (DataSource)envCtx.lookup("jdbc/oracle");
			
			conn = dataSource.getConnection();
			
			String sql="insert into chat_log values (chat_log_seq.nextval, ?, ?, ?, sysdate, ?)";
	        pstmt=conn.prepareStatement(sql);
	        pstmt.setString(1, "test12");
	        pstmt.setString(2, "jh121612");
	        pstmt.setString(3, "me too!");
	        pstmt.setString(4, "false");
	        pstmt.executeQuery();
			
	        sql = "commit";
	        pstmt=conn.prepareStatement(sql);
	        pstmt.executeQuery();
	        
	        System.out.println("확인");
	        
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			System.out.println("�뿉�윭 : " + e.getMessage());
		} catch(SQLException e) {
			System.out.println("���� : " + e.getMessage());
		} finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try { conn.close(); } catch(SQLException e) {}
		}
	}
}


