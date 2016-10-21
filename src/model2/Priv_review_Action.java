package model2;



import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import model1.Class1_Review_BoardDAO;

import model1.Class1_Review_BoardTO;
import model1.MemberDAO;
import model1.MemberTO;



//MVC model에서 모든데이터 처리하고 view에 필요한 최소한의 데이터를 넘김
public class Priv_review_Action implements Action {

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
		
			Class1_Review_BoardDAO dao = new Class1_Review_BoardDAO();
	        ArrayList<Class1_Review_BoardTO> lists = dao.boardList();
	        
	        //데이터 넘김
	        request.setAttribute("lists", lists);

		}

}
