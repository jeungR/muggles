package model1;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class Class2_BoardDAO {

	private DataSource dataSource = null;
	
	
	public Class2_BoardDAO(){
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context)initCtx.lookup("java:comp/env");
			dataSource = (DataSource)envCtx.lookup("jdbc/oracle");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			System.out.println("에러 : " + e.getMessage());
		}
	
	}
//////////////////////////////////답글////////////////////////////////////
	public void boardRrite() {	
	}


	public int boardReplyOk(FreeBoardTO to){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs  = null;

		int flag = 2; //데이터베이스 입력 성공실패 여부  성공0, 실패 1
		try {

			conn = dataSource.getConnection();

			//부모글의 group 정보
			String sql = "select grp, grps, grpl from class1_review where seq=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,to.getSeq());

			rs = pstmt.executeQuery();

			int pgrp = 0;
			int pgrps = 0;	
			int pgrpl = 0;
			if(rs.next()) {
				pgrp = rs.getInt("grp");
				pgrps = rs.getInt("grps");
				pgrpl = rs.getInt("grpl");
			}
			//먼저 적힌 답글 grps 증가
			sql = "update freeboard set grps = grps+1 where grp=? and grps>?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, pgrp);
			pstmt.setInt(2, pgrps);
			pstmt.executeUpdate();

			//답글 DB 입력
			sql = "insert into freeboard values (free_seq.nextval, ?, ?, ?, ?, ?, ?, ?, 0, sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pgrp);
			pstmt.setInt(2, pgrps + 1);
			pstmt.setInt(3, pgrpl + 1);

			pstmt.setString(4, to.getTitle());
			
			pstmt.setString(5, to.getWriter());
			
			pstmt.setString(6, to.getContent());
			
			pstmt.setString(7, to.getPassword());
			



			//executeUpdate 리턴 값: 영향 받은 행수
			int result = pstmt.executeUpdate();
			if(result ==0){
				flag =1;
			}else if(result ==1){
				flag =0;
			}

		}catch(SQLException e) {
			System.out.println("에러 : " + e.getMessage());
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn != null) try {conn.close();} catch(SQLException e) {}
		}
		return flag;
		
	}
	////////////////////////////////////////////////////////////////////////////////////////
	public void boardWrite() {	
	}
	
	public int boardWriteOk(FreeBoardTO to) { //ok
		Connection conn = null;
		PreparedStatement pstmt = null;
	
		int flag = 1;
	
		try {
			conn = dataSource.getConnection();

			String sql = "insert into Freeboard values (free_seq.nextval, free_seq.currval, 0, 0, ?, ?, ?, ?, 0, sysdate)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, to.getTitle());
			pstmt.setString(2, to.getWriter());
			pstmt.setString(3, to.getContent());
			pstmt.setString(4, to.getPassword());
			


			if(pstmt.executeUpdate() == 1) {
				flag = 0;
			}
		} catch(SQLException e) {
			System.out.println("에러 : " + e.getMessage());
		} finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try { conn.close(); } catch(SQLException e) {}
		}

		return flag;
	}



//////List//////////////////////////////////////////////////////////////////////////
	public ArrayList<FreeBoardTO> boardList(){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		ArrayList<FreeBoardTO> result = new ArrayList<>();
		
		
		try {
			
			
			conn = dataSource.getConnection();
			
			
			String sql = "select seq, grpl, title, writer, to_char(wdate, 'YY.MM.DD') wdate, hit, trunc(sysdate-wdate) wgap from Freeboard order by seq desc";
			//String sql = "select seq, grpl, title, header, writer, to_char(wdate, 'YY.MM.DD') wdate, hit, trunc(sysdate-wdate) wgap from qnaboard order by grps desc, grps asc";
			pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				FreeBoardTO to = new FreeBoardTO();
				to.setSeq(rs.getString("seq"));
				
				to.setGrpl(rs.getString("grpl"));
				to.setTitle(rs.getString("title"));
			
			
				to.setWriter(rs.getString("writer"));		
				to.setWdate(rs.getString("wdate"));
				to.setHit(rs.getString("hit"));
				to.setWgap(rs.getInt("wgap"));
				
				int grpl= rs.getInt("grpl");
				
				String sgrpl ="";
				for(int j=1 ; j<=grpl ; j++) {
	                sgrpl += "&nbsp;&nbsp;"; 
	            }

				result.add(to);
			}
			
	        
		} catch(SQLException e) {
			System.out.println("에러 : " + e.getMessage());
		} finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try { conn.close(); } catch(SQLException e) {}			
		}
		
		return result;
		}


		public FreeBoardTO boardView(FreeBoardTO to) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			String uploadPath = "../upload/";
			String uploadRealPath = "C:\\java\\workspace\\muggles\\WebContent\\upload";
			String uploadInfo = "";

			try {
				conn = this.dataSource.getConnection();
	
				//	조회수 증가
				String sql = "update freeboard set hit=hit+1 where seq=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, to.getSeq());
				pstmt.executeUpdate();
				pstmt.close();
				

				//view창 데이터 출력
				sql = "select title, writer, wdate, hit, content from freeboard where seq = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, to.getSeq());

				rs = pstmt.executeQuery();
				if(rs.next()) {
					to.setTitle(rs.getString("title"));
					
					
					to.setWriter(rs.getString("writer"));
					
					to.setWdate(rs.getString("wdate"));
					to.setHit(rs.getString("hit"));
					to.setContent(rs.getString("content") == null ? "" : rs.getString("content").replaceAll("\n", "<br />"));//엔터키 처리

				}
			} catch(SQLException e) {
				System.out.println("에러 : " + e.getMessage());
			} finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) {}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
				if(conn != null) try { conn.close(); } catch(SQLException e) {}
			}
			return to;
		}

		
/////////////////////////Modify//////////////////////////

		public FreeBoardTO boardModify(FreeBoardTO to) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				conn = dataSource.getConnection();


				//	modify창 데이터 출력
				String sql = "select title, writer, mail, content from qnaboard where seq = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, to.getSeq());

				rs = pstmt.executeQuery();
				if(rs.next()) {


					to.setTitle(rs.getString("title"));
					to.setWriter(rs.getString("writer"));
					
					to.setContent(rs.getString("content") == null ? "" : rs.getString("content"));
					
				}
			} catch(SQLException e) {
				System.out.println("에러 : " + e.getMessage());
			} finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) {}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
				if(conn != null) try { conn.close(); } catch(SQLException e) {}
			}
			return to;
		}

		public int boardModifyOk(FreeBoardTO to) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			int flag = 2;
			try {
				conn = dataSource.getConnection();

				//	사진업로드를 안했으면 원래 DB 사진 이름 가져옴 //업로드 했으면 원래 파일 지움
				String sql = "select photo1, photo2, file1, file2 from freeboard where seq=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, to.getSeq());
				rs = pstmt.executeQuery();

				
				
				//	////////////////////////////////////////////
				//DB데이터 수정 (파일도 추가 해야함)
				sql = "update freeboard set title=?, mail=?, content=? where seq=? and password=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, to.getTitle());

				pstmt.setString(4, to.getContent());

				
				pstmt.setString(10, to.getSeq());
				pstmt.setString(11, to.getPassword());
				
				int result = pstmt.executeUpdate();
				if(result == 0) {
					flag = 1;
				} else if(result == 1) {
					flag = 0;
				//		///////////////////////////////////////////	  ////////////////수정해야할 부분
				}
				//	//////////////////////////////////////////
			} catch(SQLException e) {
				System.out.println("에러 : " + e.getMessage());
			} finally {
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
				if(conn != null) try { conn.close(); } catch(SQLException e) {}
			}
			return flag;	
		}

		//	///////////////////삭제///////////////////////////////////
		public FreeBoardTO boardDelete(FreeBoardTO to) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				conn = this.dataSource.getConnection();
				
				//delete창 데이터 출력
				String sql = "select title, writer, mail from freeboard where seq = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, to.getSeq());
				
				rs = pstmt.executeQuery();
				if(rs.next()) {
					to.setTitle(rs.getString("title"));
					to.setWriter(rs.getString("writer"));

				}
			} catch(SQLException e) {
				System.out.println("에러 : " + e.getMessage());
			} finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) {}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
				if(conn != null) try { conn.close(); } catch(SQLException e) {}
			}
			return to;
		}
		
		public int boardDeleteOk(FreeBoardTO to) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			

			int flag = 2;
			
			try {

				conn = dataSource.getConnection();


				String sql = "delete from freeboard where seq=? and password=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, to.getSeq());
				pstmt.setString(2, to.getPassword());

				int result = pstmt.executeUpdate();
				if(result ==0){
					flag =1;
				}else if(result ==1){
					flag =0;

				}
			} catch(SQLException e) {
				System.out.println("에러 : " + e.getMessage());
			} finally {
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
				if(conn != null) try { conn.close(); } catch(SQLException e) {}
			}
			return flag;
		}
	}
