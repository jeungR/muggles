package model1;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
//해당 메서드를 부르면 그에 맞는 기능을 가지고 옴..
import javax.sql.DataSource;

import model1.PagingDto;
import model1.Stu_board_Dto;

//model1구조
public class Stu_board_Dao {

	private DataSource dataSource = null;
	
	
	public Stu_board_Dao(){
			try {
				Context initCtx = new InitialContext();
				Context envCtx = (Context)initCtx.lookup("java:comp/env");
				dataSource = (DataSource)envCtx.lookup("jdbc/oracle");
			} catch (NamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	public void boardWriter(){
	}
	
	//jsp파일 wirteok의 필요한게 flag값이므로 인트로 받음
	public int stu_boardWriterOK(Stu_board_Dto dto){
		Connection conn = null;
		PreparedStatement pstmt = null;
		System.out.println("dao write : "+dto);
		int flag = 1; 
		
		try{
			conn = this.dataSource.getConnection();
														
			String sql = "INSERT INTO stu_board (stu_seq,stu_title,stu_s_date,stu_e_date, "
					   + "stu_content,stu_wdate,stu_m_num,stu_p_num, "
					   + "stu_location,stu_select_date,user_seq) "
					   + "VALUES (STU_SEQ.NEXTVAL,?,?,?,?,sysdate,?,0,?,?,?) ";
			pstmt=conn.prepareStatement(sql);
			/* 순서중요 */
			pstmt.setString(1, dto.getStu_title());
			pstmt.setString(2, dto.getStu_s_date());
			pstmt.setString(3, dto.getStu_e_date());
			pstmt.setString(4, dto.getStu_content());
			pstmt.setInt(5, dto.getStu_m_num());
			pstmt.setString(6, dto.getStu_location());
			pstmt.setString(7, dto.getStu_select_date());
			pstmt.setString(8, dto.getUser_seq());
			//스터디보드가 인서트 되는 동시에 스터디정보쪽에서도 인서트가 되어서
			//스터디보드의 시퀀스값과 유저시퀀스값을 넣어줘야함.
			
			/* 리턴값:영향받은 행수 */
			int result = pstmt.executeUpdate();
			System.out.println(result);	
			/* 1이면 정확히 인서트가 됨. */
			
			if(result == 1){
				/* 정상이면 1 비정상이면 0 -> 비정상일경우 전페이지로.. */
				flag = 0; 
			}
		}catch (SQLException e){
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
		}
		return flag;
	}
	//스터디인원추가
	public int joinStudy(Stu_board_Dto dto){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int flag =1;
		String sql="";
		try {
			conn = this.dataSource.getConnection();
			
			sql = "SELECT count(user_seq) cnt ,count(stu_seq) scnt "
				+ "FROM stu_info "
				+ "WHERE user_seq = ? AND stu_seq=? ";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUser_seq());
			pstmt.setInt(2, dto.getStu_seq());
			rs=pstmt.executeQuery();
			
			if(rs.next()){
				String result = rs.getString("cnt");
				String sresult = rs.getString("scnt");
			
				if(result.equals("1")){
					flag=1;
				}else if(result.equals("0")){
					flag=0;
					
					System.out.println("joinStudy DAO");
					sql = "INSERT INTO stu_info (stu_seq,user_seq) "
						 +"VALUES (?,?) ";
			
					pstmt=conn.prepareStatement(sql);
					pstmt.setInt(1, dto.getStu_seq());
					pstmt.setString(2, dto.getUser_seq());
					pstmt.executeUpdate();
			
					sql = "UPDATE stu_board SET stu_p_num=stu_p_num+1 WHERE stu_seq=?";
					pstmt=conn.prepareStatement(sql);
					pstmt.setInt(1, dto.getStu_seq());
					pstmt.executeUpdate();
			
					System.out.println(flag);	
					
					
					}
				}	
		} catch (SQLException e) {
			System.out.println("error :"+e.getMessage());
			e.printStackTrace();
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
		
		return flag;
	}
	
	//보드리스트
	public PagingDto boardList(PagingDto pagingDto){
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			int cpage = pagingDto.getCpage();
			int recordPerpage = pagingDto.getRecordPerpage();
			int blockPerpage = pagingDto.getBlockPerpage();
			
			conn =this.dataSource.getConnection();

			String sql = "select s.stu_seq, s.stu_title, s.stu_m_num, s.stu_p_num,"+
						 "s.stu_wdate, u.user_name,u.user_mail,s.stu_content,s.stu_wdate "+
						 ",s.stu_s_date,stu_e_date,s.user_seq "+
						 "FROM stu_board s "+
						 "INNER JOIN user_info u ON s.user_seq = u.user_seq ORDER BY stu_seq DESC ";

					 
				pstmt=conn.prepareStatement(sql);
				pstmt=conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
				rs=pstmt.executeQuery();
				
				rs.last();
				
				int totalRecord = rs.getRow();
				rs.beforeFirst();
				
				//토탈페이지를 set하여 집어넣음.
				pagingDto.setTotalPage((totalRecord -1) / recordPerpage +1) ;
				
				int skip = (cpage -1 ) * recordPerpage;
				if(skip !=0){
					rs.absolute(skip);
				}
				
			ArrayList<Stu_board_Dto> list = new ArrayList<>();
			for(int i=0; i<recordPerpage && rs.next(); i++){
				Stu_board_Dto dto = new Stu_board_Dto();
				
				dto.setStu_seq(rs.getInt("stu_seq"));
				dto.setStu_title(rs.getString("stu_title"));
				dto.setStu_m_num(rs.getInt("stu_m_num"));
				dto.setStu_p_num(rs.getInt("stu_p_num"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setUser_mail(rs.getString("user_mail"));
				dto.setStu_wdate(rs.getString("stu_wdate"));
				dto.setStu_content(rs.getString("stu_content"));
				dto.setStu_s_date(rs.getString("stu_s_date"));
				dto.setStu_e_date(rs.getString("stu_e_date"));
				dto.setUser_seq(rs.getString("user_seq"));
				list.add(dto);
				
			}
			pagingDto.setBoardList(list);
			
			pagingDto.setStartBlock((cpage -1)/blockPerpage*blockPerpage+1);
			
			pagingDto.setEndBlock(((cpage-1)/blockPerpage)*blockPerpage + blockPerpage);
			
			if(pagingDto.getEndBlock() >= pagingDto.getTotalPage()){
				pagingDto.setEndBlock(pagingDto.getTotalPage());
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
		return pagingDto;
	}
	
	
	//보드상세보기
	public Stu_board_Dto boardView(Stu_board_Dto dto){
			
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
			
		try{
			
			conn = this.dataSource.getConnection();
			 
			String sql ="SELECT s.stu_content,s.stu_s_date,s.stu_e_date,s.stu_m_num "
					  + ",s.stu_p_num,u.user_name,u.user_id,s.stu_title,s.stu_location,"
					  + "s.stu_select_date,u.user_mail,u.user_phone,s.stu_wdate,s.user_seq "
					  + "FROM stu_board s "
					  + "INNER JOIN user_info u ON "
					  + "s.user_seq = u.user_seq "
					  + "WHERE s.stu_seq = ? ";
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getStu_seq());
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				
				dto.setStu_content(rs.getString("stu_content"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setStu_s_date(rs.getString("stu_s_date"));
				dto.setStu_e_date(rs.getString("stu_e_date"));
				dto.setStu_m_num(rs.getInt("stu_m_num"));
				dto.setStu_p_num(rs.getInt("stu_p_num"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setStu_title(rs.getString("stu_title"));
				dto.setStu_location(rs.getString("stu_location"));
				dto.setUser_mail(rs.getString("user_mail"));
				dto.setStu_select_date(rs.getString("stu_select_date"));
				dto.setUser_phone(rs.getString("user_phone"));
				dto.setStu_wdate(rs.getString("stu_wdate"));
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
	
	//보드 수정
	//jsp에서 받은 자료를 매개변수 dto로 받은 후 dto타입으로 뿌려줌.
	public Stu_board_Dto modify(Stu_board_Dto dto){
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try{
			
			conn =this.dataSource.getConnection();
					
			String sql ="SELECT s.stu_content,s.stu_s_date,s.stu_e_date,s.stu_m_num"
					  + "s.stu_p_num,u.user_name"
					  + "FROM stu_board AS s INNER JOIN user_info AS u ON"
					  + "s.user_seq = u.user_seq"
					  + "WHERE s.stu_seq = ?";
			
			//modify1에서 넘어온 seq번호를 dto의 seq에 넣어줌.
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getStu_seq());
			//해당seq번호가지고 쿼리문을 실행시킴
			rs = pstmt.executeQuery();
			
			//와일문을 돌리면서 해당자료를 dto에서 꺼내서 get하여 보내줌
			while(rs.next()){
				
				dto.setStu_content(rs.getString("stu_content"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setStu_s_date(rs.getString("stu_s_date"));
				dto.setStu_e_date(rs.getString("stu_e_date"));
				dto.setStu_m_num(rs.getInt("stu_m_num"));
				dto.setStu_p_num(rs.getInt("stu_p_num"));
				dto.setUser_name(rs.getString("user_name"));
			}
		
		}catch(SQLException e){
			System.out.println("�뿉�윭 :" + e.getMessage());
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
	//수정ok
	public int modifyOK(Stu_board_Dto dto){
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		
		int flag = 2; 
		
		try{
		
			conn =this.dataSource.getConnection();
			
			String sql = "UPDATE stu_board SET "
					+ "stu_title = ? , stu_s_date= ? , stu_e_date= ?,"
					+ "stu_m_num =?, stu_content= ?"
					+ "where user_seq= ? "
					+ "and stu_seq= ? ";
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getStu_title());
			pstmt.setString(2, dto.getStu_s_date());
			pstmt.setString(3, dto.getStu_e_date());
			pstmt.setInt(4, dto.getStu_m_num());
			pstmt.setString(5, dto.getStu_content());
			pstmt.setString(6, dto.getUser_seq());
			pstmt.setInt(7, dto.getStu_seq());
			
			
			//리턴값:영향받은 행수 
			int result = pstmt.executeUpdate();
			 //수행건수가 0이면 수행을 못한것이므로.. 
			if(result == 0){
				
				 //flag가 1번이면 비밀번호가 맞지않음. 
				flag = 1;
				
			}else if (result ==1){
				
				// 플레이그가 0번이면 비밀번호 맞음.
				flag=0;
			}
		}catch (SQLException e){
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
		}
		return flag;
	}
	
	//삭제ok
	public int deleteOK(Stu_board_Dto dto){
		Connection conn = null;
		PreparedStatement pstmt = null;
		

		int flag = 2; 
		
		try{
			conn =this.dataSource.getConnection();
			
			String sql = "DELETE FROM stu_board WHERE stu_seq=? ";
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getStu_seq());
			//리턴값:영향받은 행수 
			int result = pstmt.executeUpdate();
			 //수행건수가 0이면 수행을 못한것이므로.. 
			if(result == 0){
				
				flag = 1;
				
			}else if (result ==1){
				
				 //플레이그가 0번이면 비밀번호 맞음.  
				flag=0;
			}
			
		
		}catch (SQLException e){
			System.out.println("�뿉�윭 :" + e.getMessage());
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
	
	
}
