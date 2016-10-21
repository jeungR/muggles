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

import java.io.File;

public class QnaBoardDAO {
	private DataSource dataSource = null;

	public QnaBoardDAO() {
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
	
	
	public int boardReplyOk(QnaBoardTO to){
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs  = null;
	    
	    int flag = 2; //데이터베이스 입력 성공실패 여부  성공0, 실패 1
	    try {
	        
	        conn = dataSource.getConnection();
	        
	        //부모글의 group 정보
	        String sql = "select grp, grps, grpl from qnaboard where seq=?";
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
	        sql = "update qnaboard set grps = grps+1 where grp=? and grps>?";
	        pstmt = conn.prepareStatement(sql);
	        
	        pstmt.setInt(1, pgrp);
	        pstmt.setInt(2, pgrps);
	        pstmt.executeUpdate();
	        
	        //답글 DB 입력
	        sql = "insert into qnaboard values (board_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0, sysdate, ?)";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, pgrp);
	        pstmt.setInt(2, pgrps + 1);
	        pstmt.setInt(3, pgrpl + 1);
	        
	        pstmt.setString(4, to.getTitle());
	        pstmt.setString(5, to.getHeader1());
	        pstmt.setString(6, to.getWriter());
	        pstmt.setString(7, to.getMail());
	        pstmt.setString(8, to.getContent());
	        pstmt.setString(9, to.getSecret());
	        pstmt.setString(10, to.getPassword());
	        pstmt.setString(11, to.getPhoto1());
	        pstmt.setString(12, to.getPhoto2());
	        pstmt.setString(13, to.getFile1());
	        pstmt.setString(14, to.getFile2());
	        pstmt.setString(15, to.getHeader2());
	        
	        
	        
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
	/////////////////////////////////////////////////////////////////////////////////////////
	public void boardWrite() {	
	}

	public int boardWriteOk(QnaBoardTO to) { //ok
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		int flag = 1;
		
		try {
			conn = dataSource.getConnection();
			
			String sql = "insert into qnaboard values (board_seq.nextval, board_seq.currval, 0, 0, ?, ?, ?, ?, null, ?, null, ?, null, null, ?, null,"
					+ " 0, sysdate)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, to.getTitle());
			pstmt.setString(2, to.getHeader1());
			pstmt.setString(3, to.getHeader2());
			pstmt.setString(4, to.getWriter());
			//pstmt.setString(4, to.getMail());
			pstmt.setString(5, to.getContent());
			//pstmt.setString(6, to.getSecret());
			pstmt.setString(6, to.getPassword());
			//pstmt.setString(7, to.getPhoto1());
			//pstmt.setString(9, to.getPhoto2());
			pstmt.setString(7, to.getFile1());
			//pstmt.setString(11, to.getFile2());
			
			
			
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
	
	
	
////// List//////////////////////////////////페이지 없는것.//////////////////////////////////////////////
	public ArrayList<QnaBoardTO> boardList(){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		ArrayList<QnaBoardTO> result = new ArrayList<>();
		
		
		try {
			
			
			conn = dataSource.getConnection();
			
			
			String sql = "select seq, grpl, title, header1, writer, to_char(wdate, 'YY.MM.DD') wdate, hit, trunc(sysdate-wdate) wgap, header2 from qnaboard order by seq desc";
			//String sql = "select seq, grpl, title, header, writer, to_char(wdate, 'YY.MM.DD') wdate, hit, trunc(sysdate-wdate) wgap from qnaboard order by grps desc, grps asc";
			pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				QnaBoardTO to = new QnaBoardTO();
				to.setSeq(rs.getString("seq"));
				
				to.setGrpl(rs.getString("grpl"));
				to.setTitle(rs.getString("title"));
				to.setHeader1(rs.getString("header1"));
				to.setHeader2(rs.getString("header2"));
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
		
			
			/*
			//비밀글
			BoardTO to = new BoardTO();
			String secret = rs.getString("secret")==null?"0":"1";
			if(!secret.equals("0")){
				sql = "select seq, header, title, writer, wdate, hit from qnaboard where secret = 0";
					
			}else if(!secret.equals("1")){
				sql = "select seq, header, title, writer, wdate, hit from qnaboard where secret = 1";
			}
			*/
			
			
	        
		} catch(SQLException e) {
			System.out.println("에러 : " + e.getMessage());
		} finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try { conn.close(); } catch(SQLException e) {}			
		}
		
		return result;
	}

	
	public QnaBoardTO boardView(QnaBoardTO to) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String uploadPath = "../upload/";
	    String uploadRealPath = "C:\\java\\workspace\\muggles\\WebContent\\upload";
	    String uploadInfo = "";
		
		try {
			conn = this.dataSource.getConnection();
			
			//조회수 증가
			String sql = "update qnaboard set hit=hit+1 where seq=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to.getSeq());
			pstmt.executeUpdate();
			pstmt.close();
			
			
			//view창 데이터 출력
			sql = "select title, header1, header2, writer, mail, wdate, hit, content, password, file1 from qnaboard where seq = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to.getSeq());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				to.setTitle(rs.getString("title"));
				to.setHeader1(rs.getString("header1"));
				to.setHeader2(rs.getString("header2"));
				to.setWriter(rs.getString("writer"));
				
				to.setMail(rs.getString("mail") == null ? "" : rs.getString("mail"));
				to.setWdate(rs.getString("wdate"));
				to.setHit(rs.getString("hit"));
				to.setContent(rs.getString("content") == null ? "" : rs.getString("content").replaceAll("\n", "<br />"));//엔터키 처리
				to.setPassword(rs.getString("password"));
				//사진추가
				//to.setPhoto1(rs.getString("photo1")==null?"noimage.png" : rs.getString("photo1"));
				//to.setPhoto2(rs.getString("photo2")==null?"noimage.png" : rs.getString("photo2"));
				
				
				to.setFile1(rs.getString("file1")==null ? "" : rs.getString("file1"));
				//to.setFile2(rs.getString("file2")==null ? "" : rs.getString("file2"));
				
				
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
/*
	public QnaBoardTO boardModify(QnaBoardTO to) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = dataSource.getConnection();
			
			
			//modify창 데이터 출력
			String sql = "select header1, header2, title, writer, content, from qnaboard where seq = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to.getSeq());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				to.setHeader1(rs.getString("header1"));
				to.setHeader2(rs.getString("header2"));
				to.setTitle(rs.getString("title"));
				to.setWriter(rs.getString("writer"));
				//to.setMail(rs.getString("mail") == null?"":rs.getString("mail"));
				to.setContent(rs.getString("content") == null ? "" : rs.getString("content"));
				//to.setPhoto1(rs.getString("photo1")==null?"noimage.png" : rs.getString("photo1"));
				//to.setPhoto2(rs.getString("photo2")==null?"noimage.png" : rs.getString("photo2"));
				//to.setFile1(rs.getString("file1")==null?"" : rs.getString("file1"));
				//to.setFile2(rs.getString("file2")==null?"" : rs.getString("file2"));
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
*/
	public int boardModifyOk(QnaBoardTO to) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int flag = 2;
		try {
			conn = dataSource.getConnection();
/*			
			//사진업로드를 안했으면 원래 DB 사진 이름 가져옴 //업로드 했으면 원래 파일 지움
            String sql = "select photo1, photo2, file1, file2 from qnaboard where seq=?";
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, to.getSeq());
            rs = pstmt.executeQuery();
            
            String prePhoto1 = "";
            String prePhoto2 = "";
            String preFile1 = "";
            String preFile2 = "";
            
            if(rs.next()){
                if(to.getPhoto1().equals("")){
                    to.setPhoto1(rs.getString("photo1")==null?"":rs.getString("photo1"));
                }else if(!to.getPhoto1().equals(rs.getString("photo1"))){
                    prePhoto1 = rs.getString("photo1")==null?"":rs.getString("photo1");
                }
                if(to.getPhoto2().equals("")){
                    to.setPhoto2(rs.getString("photo2")==null?"":rs.getString("photo2"));
                }else if(!to.getPhoto2().equals(rs.getString("photo2"))){
                    prePhoto2 = rs.getString("photo2")==null?"":rs.getString("photo2");
                }
                if(to.getFile1().equals("")){
                    to.setFile1(rs.getString("file1")==null?"":rs.getString("file1"));
                }else if(!to.getFile1().equals(rs.getString("file1"))){
                    preFile1 = rs.getString("file1")==null?"":rs.getString("file1");
                }
                if(to.getFile2().equals("")){
                    to.setFile2(rs.getString("file2")==null?"":rs.getString("file2"));
                }else if(!to.getFile2().equals(rs.getString("file2"))){
                    preFile2 = rs.getString("file2")==null?"":rs.getString("file2");
                }
            }

		*/	
			
			//////////////////////////////////////////////
			//DB데이터 수정 (파일도 추가 해야함)
			String sql = "update qnaboard set title=?, writer=?, header1=?, header2=?, content=? where seq=? and password=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to.getTitle());
			pstmt.setString(2, to.getWriter());
			pstmt.setString(3, to.getHeader1());
			pstmt.setString(4, to.getHeader2());
			
		
			pstmt.setString(5, to.getContent());
			//pstmt.setString(6, to.getPhoto1());
			//pstmt.setString(7, to.getPhoto2());
			//pstmt.setString(8, to.getFile1());
			//pstmt.setString(8, to.getFile2());
		
			
			pstmt.setString(6, to.getSeq());
			pstmt.setString(7, to.getPassword());

			int result = pstmt.executeUpdate();
			if(result == 0) {
				flag = 1;
			} else if(result == 1) {
				flag = 0;
			/////////////////////////////////////////////	  ////////////////수정해야할 부분
				//파일삭제
			/*	if(!prePhoto1.equals("")){
                    File f = new File("C:\\java\\workspace\\muggles\\WebContent\\upload", prePhoto1);
                    f.delete();
                }
                if(!prePhoto2.equals("")){
                    File f = new File("C:\\java\\workspace\\muggles\\WebContent\\upload", prePhoto2);
                    f.delete();
                }
                if(!preFile1.equals("")){
                    File f = new File("C:\\java\\workspace\\muggles\\WebContent\\upload", preFile1);
                    f.delete();
                }
                if(!preFile2.equals("")){
                    File f = new File("C:\\java\\workspace\\muggles\\WebContent\\upload", preFile2);
                    f.delete();
                }*/
			}
			////////////////////////////////////////////
		} catch(SQLException e) {
			System.out.println("에러 : " + e.getMessage());
		} finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try { conn.close(); } catch(SQLException e) {}
		}
		return flag;
	}

	/////////////////////삭제///////////////////////////////////
	public QnaBoardTO boardDelete(QnaBoardTO to) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = this.dataSource.getConnection();
			
			//delete창 데이터 출력
			String sql = "select title, writer, mail from qnaboard where seq = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to.getSeq());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				to.setTitle(rs.getString("title"));
				to.setWriter(rs.getString("writer"));
				to.setMail(rs.getString("mail") == null ? "" : rs.getString("mail"));
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

	public int boardDeleteOk(QnaBoardTO to) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		int flag = 2;
		
		try {
			
			conn = dataSource.getConnection();
			//삭제할 사진명, 파일명
			
			/*
			String sql = "select photo1, photo2, file1, file2 from qnaboard where seq=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, to.getSeq());
            
            rs = pstmt.executeQuery();
            String photo1 = "";
            String photo2 = "";
            String file1 = "";
            String file2 = "";
            if(rs.next()) {
                photo1 = rs.getString("photo1")==null?"noimage.png":rs.getString("photo1");
                photo2 = rs.getString("photo2")==null?"noimage.png":rs.getString("photo2");
                file1 = rs.getString("file1")==null?"":rs.getString("file1");
                file2 = rs.getString("file2")==null?"":rs.getString("file2");
            }
        */    
            
          
		//delete 처리
		
            //이 sql문장은 삭제가 아니라 수정임
            //sql = "update qnaboard set title='삭제됨', photo1='', photo2='', file1='', file2='', content='' where seq=? and password=?";
		    String sql = "delete from qnaboard where seq=? and password=?";
            
		    pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, to.getSeq());
            pstmt.setString(2, to.getPassword());
         
            
            int result = pstmt.executeUpdate();
            if(result ==0){
                flag =1;
            }else if(result ==1){
                flag =0;
            /*    
                //파일 삭제
                if(!photo1.equals("")){
                    File f = new File("C:\\java\\workspace\\muggles\\WebContent\\upload", photo1);
                    f.delete();
                }
                if(!photo2.equals("")){
                    File f = new File("C:\\java\\workspace\\muggles\\WebContent\\upload", photo2);
                    f.delete();
                }
                if(!file1.equals("")){
                    File f = new File("C:\\java\\workspace\\muggles\\WebContent\\upload", file1);
                    f.delete();
                }
                if(!file2.equals("")){
                    File f = new File("C:\\java\\workspace\\muggles\\WebContent\\upload", file2);
                    f.delete();
                }
                */
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









