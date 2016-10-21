package model1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import model1.Recommend_Tab_Dto;

public class Recommend_Tab_Dao {
	
private DataSource dataSource = null;
	
	
	public Recommend_Tab_Dao(){
			try {
				Context initCtx = new InitialContext();
				Context envCtx = (Context)initCtx.lookup("java:comp/env");
				dataSource = (DataSource)envCtx.lookup("jdbc/oracle");
			} catch (NamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	
	public void recommWriter(){
		
	}
	public int recommWriterOk(Recommend_Tab_Dto dto){
		Connection conn = null;
		PreparedStatement pstmt = null;
		System.out.println("dao write : "+dto);
		int flag = 1; 
		
		try {
		conn = this.dataSource.getConnection();
		
		
		String sql = "INSERT INTO recommend_tab ("
				+ "recomm_seq,recomm_olin,recomm_language,recomm_title,recomm_content, "
				+ "recomm_link,cst,cst_detail,recomm_img,user_seq) "
				+ "VALUES (recomm_seq.NEXTVAL,?,?,?,?,?,?,?,?,?) ";
			
				pstmt=conn.prepareStatement(sql);
				
				pstmt.setString(1, dto.getRecomm_olin());
				pstmt.setString(2, dto.getRecomm_language());
				pstmt.setString(3, dto.getRecomm_title());
				pstmt.setString(4, dto.getRecomm_content());
				pstmt.setString(5, dto.getRecomm_link());
				pstmt.setString(6, dto.getCst());
				pstmt.setString(7, dto.getCst_detail());
				pstmt.setString(8, dto.getRecomm_img());
				pstmt.setString(9, dto.getUser_seq());
				int result = pstmt.executeUpdate();
				
				System.out.println(result);	
				if(result == 1){
					flag = 0; 
				}
				
		} catch (SQLException e) {
			System.out.println("error:"+e.getMessage());
		}finally{
			if(conn!=null){
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(pstmt!=null){
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return flag;
		
	}
	
	//보드리스트
		public ArrayList<Recommend_Tab_Dto> recommList(){
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			ArrayList<Recommend_Tab_Dto> list = new ArrayList<>();
			try{
				
				conn =this.dataSource.getConnection();

				String sql ="select recomm_seq,recomm_olin,recomm_language,recomm_title,"
						+ "recomm_content,recomm_link,cst,cst_detail,"
						+ "recomm_img "
						+ "from recommend_tab";
						 
					pstmt=conn.prepareStatement(sql);
					rs=pstmt.executeQuery();
				
				while(rs.next()){
					Recommend_Tab_Dto dto = new Recommend_Tab_Dto();
					dto.setRecomm_seq(rs.getInt("recomm_seq"));
					dto.setRecomm_olin(rs.getString("recomm_olin"));
					dto.setRecomm_language(rs.getString("recomm_language"));
					dto.setRecomm_title(rs.getString("recomm_title"));
					dto.setRecomm_content(rs.getString("recomm_content"));
					dto.setRecomm_link(rs.getString("recomm_link"));
					dto.setCst(rs.getString("cst"));
					dto.setCst_detail(rs.getString("cst_detail"));
					dto.setRecomm_img(rs.getString("recomm_img"));
					
					list.add(dto);
					
				}
				System.out.println("recommDtOlist");
			}catch(SQLException e){
				System.out.println("에러 :" + e.getMessage());
			}finally{
				if(conn!=null){
					try {
						conn.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				if(pstmt!=null){
					try {
						pstmt.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				if(rs!=null){
					try {
						rs.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
			return list;
		}
		//보드상세보기
				public Recommend_Tab_Dto boardView(Recommend_Tab_Dto dto){
						
					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
						
					try{
						
						conn = this.dataSource.getConnection();
						 
						String sql ="select re.recomm_seq, u.user_name, re.recomm_language, "
								  + "re.recomm_olin, re.recomm_link, "
								  + "re.recomm_content, re.recomm_title, u.user_seq "
								  + "from recommend_tab re , user_info u "
								  + "where re.recomm_seq = ? ";
						
						pstmt=conn.prepareStatement(sql);
						pstmt.setInt(1, dto.getRecomm_seq());
						
						rs = pstmt.executeQuery();
						while(rs.next()){
							dto.setRecomm_seq(rs.getInt("recomm_seq"));
							dto.setUser_name(rs.getString("user_name"));
							dto.setRecomm_language(rs.getString("recomm_language"));
							dto.setRecomm_olin(rs.getString("recomm_olin"));
							dto.setRecomm_link(rs.getString("recomm_link"));
							dto.setRecomm_content(rs.getString("recomm_content"));
							dto.setRecomm_title(rs.getString("recomm_title"));
							dto.setUser_seq(rs.getString("user_seq"));
						}
						
					}catch(SQLException e){
						System.out.println("에러 :" + e.getMessage());
					}finally{
						if(conn!=null){
							try {
								conn.close();
							} catch (SQLException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						}
						if(pstmt!=null){
							try {
								pstmt.close();
							} catch (SQLException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						}
						if(rs!=null){
							try {
								rs.close();
							} catch (SQLException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						}
					}
					return dto;
				}
	
	public int recommModify(Recommend_Tab_Dto dto){
		return 1;
	}
	
	public int recommDelete(Recommend_Tab_Dto dto){
		return 1;
	}
	
	
	
}
