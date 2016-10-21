package model2;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import model1.FreeBoardDAO;
import model1.FreeBoardTO;
import model1.MemberDAO;
import model1.MemberTO;

//MVC model에서 모든데이터 처리하고 view에 필요한 최소한의 데이터를 넘김
public class Open_free_modify_ok_Action implements Action {

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
			//데이터 클래스를 생성, 클라이언트 정보 넣음
			FreeBoardTO to = new FreeBoardTO();
			
			
			to.setSeq(multi.getParameter("seq"));
			to.setTitle(multi.getParameter("title"));
			to.setWriter(multi.getParameter("writer"));
			to.setPassword(multi.getParameter("password"));
			to.setContent(multi.getParameter("content"));
			
			System.out.println("view action seq ="+ to.getSeq());
			System.out.println("view action password ="+ to.getPassword());
			

			//DAO클래스에서 modify_ok에서 필요한 DB데이터를 처리해서 리턴
			FreeBoardDAO dao = new FreeBoardDAO();
			int flag = dao.boardModifyOk(to);

			
			
			//데이터 넘김
			request.setAttribute("to", to);
			
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
