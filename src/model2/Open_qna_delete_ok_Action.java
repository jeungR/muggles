package model2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import model1.MemberDAO;
import model1.MemberTO;
import model1.QnaBoardDAO;
import model1.QnaBoardTO;

//MVC model에서 모든데이터 처리하고 view에 필요한 최소한의 데이터를 넘김
public class Open_qna_delete_ok_Action implements Action {

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
		//데이터 클래스를 생성, 클라이언트 정보 넣기
		QnaBoardTO to = new QnaBoardTO();
		
		to.setSeq(request.getParameter("seq"));
		to.setPassword(request.getParameter("password"));
	    
		
		//DAO클래스에서 delete_ok에서 필요한 DB데이터를 처리해서 리턴
		QnaBoardDAO dao = new QnaBoardDAO();
	    int flag = dao.boardDeleteOk(to);
	    
	    //데이터 넘김
	    request.setAttribute("flag", flag);
		
	}

}
