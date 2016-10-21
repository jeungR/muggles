package model1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class Open_calendar_DAO {
	private DataSource dataSource = null;
	
	public Open_calendar_DAO() {
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context)initCtx.lookup("java:comp/env");
			dataSource = (DataSource)envCtx.lookup("jdbc/oracle");
		} catch (NamingException e) {
			System.out.println("DAO 에러 : " + e.getMessage());
		}
	}
	//쓰기
	public void writeOk(Open_calendar_TO to){
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = dataSource.getConnection();

			String sql = "insert into open_calendar values (calendar_seq.nextval, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to.getTitle());
			pstmt.setString(2, to.getStart());
			pstmt.setString(3, to.getEnd());
			pstmt.setString(4, to.getAllDay());
			pstmt.setString(5, to.getClassName());
			pstmt.setString(6, to.getUser_id());
			pstmt.setString(7, to.getUser_level());
			
			int result = pstmt.executeUpdate();
			System.out.println("DAO : "+result);
			
		}catch(SQLException e) {
			System.out.println("DAO 에러 : " + e.getMessage());
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn != null) try {conn.close();} catch(SQLException e) {}
		}
		
	}
	//읽기
	public JSONArray listOk(String user_id, String user_level){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs  = null;
		
		JSONArray jsonArray = new JSONArray();
		
		try {
			conn = dataSource.getConnection();
			//관리자일 경우 달력일정을 수정가능하게 불러옴
			if(user_level.equals("관리자")){
				String sql = "select * from open_calendar where user_level = '관리자'";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, user_id);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					JSONObject obj = new JSONObject();
					
		            obj.put("id", rs.getString("seq"));
		            obj.put("title", rs.getString("title"));
		            obj.put("start", rs.getString("start_day"));
		            obj.put("end", rs.getString("end_day"));
		            obj.put("allDay", rs.getString("allay").equals("true")?true:false);
		            obj.put("className", rs.getString("classname"));
		            obj.put("editable", true);
		            
		            jsonArray.add(obj);
				}
			}else{
			//회원일 경우 자신의 일정만 수정가능하게 불러옴
				String sql = "select * from open_calendar "
						+"where user_id=? "
						+"or "
						+"user_level = '관리자' "
						+"and "
						+"classname = 'bg-danger text-white'";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, user_id);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					JSONObject obj = new JSONObject();
					
		            obj.put("id", rs.getString("seq"));
		            obj.put("title", rs.getString("title"));
		            obj.put("start", rs.getString("start_day"));
		            obj.put("end", rs.getString("end_day"));
		            obj.put("allDay", rs.getString("allday").equals("true")?true:false);
		            obj.put("className", rs.getString("classname"));
		            obj.put("editable", rs.getString("user_level").equals("관리자")?false:true);
		            
		            jsonArray.add(obj);
				}
			}
			
		}catch(SQLException e) {
			System.out.println("DAO 에러 : " + e.getMessage());
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn != null) try {conn.close();} catch(SQLException e) {}
		}
		
		return jsonArray;
	}
	//수정
	public void modifyOk(Open_calendar_TO to){
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = dataSource.getConnection();

			String sql = "update open_calendar set start_day=?, end_day=?, allday=? where seq=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to.getStart());
			pstmt.setString(2, to.getEnd());
			pstmt.setString(3, to.getAllDay());
			pstmt.setString(4, to.getSeq());
			
			int result = pstmt.executeUpdate();
			System.out.println("DAO mod : "+result);
			
		}catch(SQLException e) {
			System.out.println("DAO 에러 : " + e.getMessage());
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn != null) try {conn.close();} catch(SQLException e) {}
		}
		
	}
	//삭제
	public void deleteOk(Open_calendar_TO to){
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = dataSource.getConnection();
			
			String sql = "delete from open_calendar where seq=? and user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to.getSeq());
			pstmt.setString(2, to.getUser_id());
			
			int result = pstmt.executeUpdate();
			System.out.println("DAO del : "+result);
			
		}catch(SQLException e) {
			System.out.println("DAO 에러 : " + e.getMessage());
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn != null) try {conn.close();} catch(SQLException e) {}
		}
		
	}
}
