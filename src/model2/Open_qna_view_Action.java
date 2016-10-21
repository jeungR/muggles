package model2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import model1.MemberDAO;
import model1.MemberTO;
import model1.QnaBoardDAO;
import model1.QnaBoardTO;

//MVC model에서 모든데이터 처리하고 view에 필요한 최소한의 데이터를 넘김
public class Open_qna_view_Action implements Action {

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
		//선택한 글의 	TO에 받아오기
	    QnaBoardTO to = new QnaBoardTO();
	    String cpage = request.getParameter("cpage");
		to.setSeq(request.getParameter("seq"));
		
		
		//DAO View에서 필요한 DB데이터를 처리해서 리턴
		QnaBoardDAO dao = new QnaBoardDAO();
		to = dao.boardView(to);
	    
	    //데이터 넘김
		request.setAttribute("cpage", cpage);
	    request.setAttribute("to", to);
	}

}
