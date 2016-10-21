package model2;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import model1.MemberDAO;
import model1.MemberTO;
import model1.QnaBoardDAO;
import model1.QnaBoardTO;

//MVC model에서 모든데이터 처리하고 view에 필요한 최소한의 데이터를 넘김
public class Open_qna_reply_ok_Action implements Action {

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
		try {
			String uploadPath = "C:\\java\\workspace\\muggles\\WebContent\\upload";
			int maxFileSize = 1024 * 1024 * 20;
			String encoding = "utf-8";
			MultipartRequest multi = new MultipartRequest(request, uploadPath, maxFileSize, encoding, new DefaultFileRenamePolicy());    
			
			request.setCharacterEncoding("utf-8");
			//업로드파일, 클라이언트 정보 받기 multi
			QnaBoardTO to = new QnaBoardTO();
			
			//업로드파일, 클라이언트 정보 multi
			String cpage = multi.getParameter("cpage");
			String seq =  multi.getParameter("seq");
			
			to.setSeq(multi.getParameter("seq"));
			to.setTitle(multi.getParameter("title"));
			to.setHeader1(multi.getParameter("header1"));
			to.setWriter(multi.getParameter("writer"));
			to.setMail(multi.getParameter("mail"));
			to.setPassword(multi.getParameter("password"));
			to.setContent(multi.getParameter("content"));
			to.setSecret(multi.getParameter("secret") == null ? "0" : "1");
			to.setPhoto1(multi.getFilesystemName("photo1") == null ? "" : multi.getFilesystemName("photo1"));
			to.setPhoto2(multi.getFilesystemName("photo2") == null ? "" : multi.getFilesystemName("photo2"));
			to.setFile1(multi.getFilesystemName("file1") == null ? "" : multi.getFilesystemName("file1"));
			to.setFile2(multi.getFilesystemName("file2") == null ? "" : multi.getFilesystemName("file2"));
			
			
			QnaBoardDAO dao = new QnaBoardDAO();
			int flag = dao.boardReplyOk(to);
			
			
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
