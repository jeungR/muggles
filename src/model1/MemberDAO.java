package model1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.security.MessageDigest;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import model1.MemberTO;

public class MemberDAO {
	private DataSource dataSource = null;

	public MemberDAO() {
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context)initCtx.lookup("java:comp/env");
			dataSource = (DataSource)envCtx.lookup("jdbc/oracle");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			System.out.println("�뜝�럥�뱺�뜝�럩�몠 : " + e.getMessage());
		}
	}
	
	public void register() {	
	}

	public int registerOk(MemberTO to) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		int flag = 1;
		
		try {
			conn = dataSource.getConnection();
			
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(to.getUser_pw().getBytes("UTF-8"));
            StringBuffer hexString = new StringBuffer();
 
            for (int i = 0; i < hash.length; i++) {
                String hex = Integer.toHexString(0xff & hash[i]);
                if(hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }

            String sql = "insert into user_info values (user_seq.nextval, ?, ?, ?, ?, ?, ?, ?, 0, ?, sysdate, sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to.getUser_id());
			pstmt.setString(2, hexString.toString());
			pstmt.setString(3, to.getUser_name());
			pstmt.setString(4, to.getUser_gender());
			pstmt.setString(5, to.getUser_mail());
			pstmt.setString(6, to.getUser_phone());			
			pstmt.setString(7, to.getUser_date());
			System.out.println("회원가입 :" + to.getUser_photo());
			pstmt.setString(8, to.getUser_photo() == null ? "./images/avatar.png" : to.getUser_photo());
		
			if(pstmt.executeUpdate() == 1) {
				sql = "insert into user_course_list values (user_course_list_seq.nextval, ?, ?, 'false')";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, to.getUser_id());
				pstmt.setString(2, to.getCourse_seq().get(0));
				
				if (pstmt.executeUpdate() == 1) {
					flag = 0;
				}
			}
            
		} catch(SQLException e) {
			System.out.println("RegisterOkError : " + e.getMessage());
		} catch(Exception e) {
			throw new RuntimeException(e);
		} finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try { conn.close(); } catch(SQLException e) {}
		}
		
		return flag;
	}
	
	public int checkId(MemberTO to) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		int flag = 0;
		
		try {
			conn = dataSource.getConnection();
			
			String sql="select user_id from user_info where user_id = ?";
	        pstmt=conn.prepareStatement(sql);
	        pstmt.setString(1, to.getUser_id());
			
			if(pstmt.executeUpdate() == 1) {
				flag = 1;
			}
		} catch(SQLException e) {
			System.out.println("CheckIdError : " + e.getMessage());
		} finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try { conn.close(); } catch(SQLException e) {}
		}
		
		return flag;
	}
	
	public JSONArray checkCs(String startDate) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		JSONArray list = new JSONArray();
		
		try {
			conn = dataSource.getConnection();
			
			String sql="select seq, loc, c_name, to_char(c_startdate, 'YYYY.MM.DD') c_startdate, to_char(c_enddate, 'YYYY.MM.DD') c_enddate from course_list where c_startdate = ?";
	        pstmt=conn.prepareStatement(sql);
	        pstmt.setString(1, startDate);
	        rs = pstmt.executeQuery();
			
			while(rs.next()) {
				JSONObject obj = new JSONObject();
				obj.put("seq", rs.getString("seq"));
				obj.put("loc", rs.getString("loc"));
				obj.put("c_name", rs.getString("c_name"));
				obj.put("c_startdate", rs.getString("c_startdate"));
				obj.put("c_enddate", rs.getString("c_enddate"));
				
				list.add(obj);
			}
		} catch(SQLException e) {
			System.out.println("CheckCsError : " + e.getMessage());
		} finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try { conn.close(); } catch(SQLException e) {}
			if(rs != null) try { rs.close(); } catch(SQLException e) {}
		}
		
		return list;
	}
	
	public int loginChk(MemberTO to) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int flag = 2;
		
		try {
			conn = dataSource.getConnection();
			
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(to.getUser_pw().getBytes("UTF-8"));
            StringBuffer hexString = new StringBuffer();
 
            for (int i = 0; i < hash.length; i++) {
                String hex = Integer.toHexString(0xff & hash[i]);
                if(hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
			
			String sql="select count(*) from user_info where user_id = ? and user_pw = ?";
			
	        pstmt=conn.prepareStatement(sql);
	        pstmt.setString(1, to.getUser_id());
	        pstmt.setString(2, hexString.toString());
	        rs = pstmt.executeQuery();
	        
			if (rs.next()) {
				String count = rs.getString("count(*)");
				if (count.equals("0")) {
					flag = 1;
				} else if (count.equals("1")) {
					flag = 0;
					
					sql = "update user_info set user_last_login = sysdate where user_id = ?";
					pstmt=conn.prepareStatement(sql);
			        pstmt.setString(1, to.getUser_id());
			        pstmt.executeQuery();
					
			        sql = "insert into login_member values(?)";
			        pstmt=conn.prepareStatement(sql);
			        pstmt.setString(1, to.getUser_id());
			        pstmt.executeQuery();
			        
			        sql = "commit";
			        pstmt=conn.prepareStatement(sql);
			        pstmt.executeQuery();
				}
			}
			
		} catch(SQLException e) {
			System.out.println("LoginChkError : " + e.getMessage());
		} catch(Exception e) {
			throw new RuntimeException(e);
		} finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try { conn.close(); } catch(SQLException e) {}
			if(rs != null) try { rs.close(); } catch(SQLException e) {}			
		}
		
		return flag;
	}
	
	public MemberTO getLoginInfo(String id) {
		MemberTO to = new MemberTO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		
		try {
			conn = dataSource.getConnection();
			
			String sql="select user_seq, user_name, user_mail, user_phone, user_gender, user_level, user_photo, to_char(user_birth, 'YYYY-MM-DD') user_date, to_char(user_last_logout, 'YY-MM-DD HH24:MI:SS') logout from user_info where user_id = ?";
			
	        pstmt=conn.prepareStatement(sql);
	        pstmt.setString(1, id);
	        rs = pstmt.executeQuery();
	        
			if (rs.next()) {
				to.setUser_mail(rs.getString("user_mail"));
				to.setUser_phone(rs.getString("user_phone"));
				to.setUser_gender(rs.getString("user_gender"));
				to.setUser_name(rs.getString("user_name"));
				to.setUser_level(rs.getInt("user_level"));
				to.setUser_photo(rs.getString("user_photo"));
				to.setUser_last_logout(rs.getString("logout"));
				to.setUser_seq(rs.getString("user_seq"));
				to.setUser_date(rs.getString("user_date"));
			}
			
			sql = "select u.course_seq seq, u.c_confirm con, c.c_name name from course_list c, user_course_list u where c.seq = u.course_seq and user_id = ?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs2 = pstmt.executeQuery();
			
			while (rs2.next()) {
				System.out.println(rs2.getInt("seq"));
				System.out.println(rs2.getString("con"));
				System.out.println(rs2.getString("name"));
				to.setCourse_seq(String.valueOf(rs2.getInt("seq")));
				to.setCourse_confirm(rs2.getString("con"));
				to.setCourse_name(rs2.getString("name"));
				/*System.out.println(to.getCourse_seq().get(0));
				System.out.println(to.getCourse_confirm().get(0));
				System.out.println(to.getCourse_name().get(0));*/
			}
			
			sql = "update user_info set user_last_login = sysdate where user_id = ?";
			pstmt=conn.prepareStatement(sql);
	        pstmt.setString(1, id);
	        pstmt.executeQuery();
	        
		} catch(SQLException e) {
			System.out.println("GetLoginInfoError : " + e.getMessage());
		} catch(Exception e) {
			throw new RuntimeException(e);
		} finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try { conn.close(); } catch(SQLException e) {}
			if(rs != null) try { rs.close(); } catch(SQLException e) {}			
			if(rs2 != null) try { rs2.close(); } catch(SQLException e) {}			
		}
		
		return to;
	}
	
	public ArrayList<String> getLoginMembers() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<String> members = new ArrayList<>();
		
		try {
			conn = dataSource.getConnection();
			
			String sql="select user_id from login_member";
			
	        pstmt=conn.prepareStatement(sql);
	        rs = pstmt.executeQuery();
	        
			while (rs.next()) {
				members.add(rs.getString("user_id"));
			}
			
			
		} catch(SQLException e) {
			System.out.println("GetLoginMembersError : " + e.getMessage());
		} finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try { conn.close(); } catch(SQLException e) {}
			if(rs != null) try { rs.close(); } catch(SQLException e) {}			
		}
		
		return members;
	}
	
	public JSONArray getChatInfo(String id) {
		JSONArray datas = new JSONArray();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		
		try {
			conn = dataSource.getConnection();
			
			String sql = "select u.user_id, u.user_name, u.user_photo " +
						 "from user_info u, " +
						 "(select distinct sender_id from chat_log where receiver_id = ? " +
						 "union " +
						 "select distinct receiver_id from chat_log where sender_id = ?) c " +
						 "where c.sender_id = u.user_id";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();	
			
			while(rs.next()) {
				
				JSONObject data = new JSONObject();

				data.put("user_id", rs.getString("user_id"));
				data.put("user_name", rs.getString("user_name"));
				data.put("user_photo", rs.getString("user_photo"));
				
				sql = "select * from " +
						"(select com_text " +
								"from chat_log " +
								"where sender_id = ? and receiver_id = ? " +
								"or sender_id = ? and receiver_id = ? " +
								"order by com_time desc) " +
								"where rownum = 1";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, rs.getString("user_id"));
				pstmt.setString(3, rs.getString("user_id"));
				pstmt.setString(4, id);
				rs2 = pstmt.executeQuery();
				
				while(rs2.next()) {
					
					data.put("com_text", rs2.getString("com_text"));
					datas.add(data);
				}
			}
			
		} catch(SQLException e) {
			System.out.println("GetChatInfoError : " + e.getMessage());
		} finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try { conn.close(); } catch(SQLException e) {}
		}
		return datas;
	}
	
	
	public JSONArray getChatInfo2(String my_id, String chat_id) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		JSONArray datas = new JSONArray();

		try {
			conn = dataSource.getConnection();
			
			String sql = "select c.sender_id, u.user_photo, c.com_text, to_char(c.com_time, 'YY.MM.DD HH24:MI:SS') com_time " +
						 "from user_info u, " +
						 "(select sender_id, com_text, com_time from chat_log " + 
						 "where receiver_id = ? and sender_id = ? " +
						 "or " +
						 "receiver_id = ? and sender_id = ?) c " +
						 "where c.sender_id = u.user_id " +
						 "order by com_time desc";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, my_id);
			pstmt.setString(2, chat_id);
			pstmt.setString(3, chat_id);
			pstmt.setString(4, my_id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {

				JSONObject data = new JSONObject();
				
				data.put("sender_id", rs.getString("sender_id"));
				data.put("user_photo", rs.getString("user_photo"));
				data.put("com_text", rs.getString("com_text"));
				data.put("com_time", rs.getString("com_time"));			
				datas.add(data);
			}
			
			
		} catch(SQLException e) {
			System.out.println("GetChatInfo2Error : " + e.getMessage());
		} finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try { conn.close(); } catch(SQLException e) {}
		}
		
		return datas;
	}
	
	public void logOut(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = dataSource.getConnection();
			
			String sql="update user_info set user_last_logout = sysdate where user_id = ?";
			
	        pstmt=conn.prepareStatement(sql);
	        pstmt.setString(1, id);
	        pstmt.executeQuery();
	        
	        sql="delete from login_member where user_id = ?";
	        
	        pstmt=conn.prepareStatement(sql);
	        pstmt.setString(1, id);
	        pstmt.executeQuery();
	        
	        sql="commit";
	        
	        pstmt=conn.prepareStatement(sql);
	        pstmt.executeQuery();
	        
		} catch(SQLException e) {
			System.out.println("LogOutError : " + e.getMessage());
		} catch(Exception e) {
			throw new RuntimeException(e);
		} finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try { conn.close(); } catch(SQLException e) {}
		}
	}
	
	
	public void ChatIntoDB(String my_id, String chat_id, String text) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = dataSource.getConnection();
			
			String sql="insert into chat_log values(chat_log_seq.nextval, ?, ?, ?, sysdate, ?)";
			
	        pstmt=conn.prepareStatement(sql);
	        pstmt.setString(1, my_id);
	        pstmt.setString(2, chat_id);
	        pstmt.setString(3, text);
	        pstmt.setString(4, "true");
	        pstmt.executeQuery();
	        
	        sql="commit";
	        
	        pstmt=conn.prepareStatement(sql);
	        pstmt.executeQuery();
	        
		} catch(SQLException e) {
			System.out.println("ChatIntoDBError : " + e.getMessage());
		} catch(Exception e) {
			throw new RuntimeException(e);
		} finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try { conn.close(); } catch(SQLException e) {}
		}
	}
	
}








