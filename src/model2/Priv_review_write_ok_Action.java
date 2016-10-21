package model2;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import model1.Class1_Review_BoardDAO;
import model1.Class1_Review_BoardTO;
import model1.MemberDAO;
import model1.MemberTO;

//MVC model에서 모든데이터 처리하고 view에 필요한 최소한의 데이터를 넘김
public class Priv_review_write_ok_Action implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// 로그인 정보
		String id = (String)request.getSession().getAttribute("sessionId");
		
		MemberTO to_log = new MemberTO();
		MemberDAO dao_log = new MemberDAO();
		
		to_log = dao_log.getLoginInfo(id);
		request.setAttribute("to_log", to_log);
		
		JSONArray datas = dao_log.getChatInfo(id);
		request.setAttribute("datas", datas);
		//
		//업로드
	    try {
			String uploadPath = "C:\\java\\workspace\\muggles\\WebContent\\upload";
			int maxFileSize = 1024 * 1024 * 20;
			String encoding = "utf-8";
			MultipartRequest multi = new MultipartRequest(request, uploadPath, maxFileSize, encoding, new DefaultFileRenamePolicy());    
			
			
			//request.setCharacterEncoding("utf-8");
			//업로드파일, 클라이언트 정보 받기 multi
			Class1_Review_BoardTO to = new Class1_Review_BoardTO();
			
			to.setTitle(multi.getParameter("title"));
			//
			
			System.out.println(to.getTitle());
			
			to.setHeader1(multi.getParameter("header1"));
			to.setHeader2(multi.getParameter("header2"));
			
			to.setWriter(multi.getParameter("writer"));
			
			System.out.println(to.getWriter());
			
			//to.setMail(multi.getParameter("mail"));
			to.setPassword(multi.getParameter("password"));
			to.setContent(multi.getParameter("content"));
			
			//DAO클래스에서 write_ok에서 필요한 DB데이터를 처리해서 리턴
			Class1_Review_BoardDAO dao = new Class1_Review_BoardDAO();
			int flag = dao.boardWriteOk(to);
			
			//데이터 넘김
			request.setAttribute("flag", flag);
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
