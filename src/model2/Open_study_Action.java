package model2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import model1.MemberDAO;
import model1.MemberTO;

public class Open_study_Action implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String id = (String)request.getSession().getAttribute("sessionId");
		
		MemberTO to_log = new MemberTO();
		MemberDAO dao_log = new MemberDAO();
		to_log = dao_log.getLoginInfo(id);
		request.setAttribute("to_log", to_log);
		System.out.println(to_log.getUser_seq());
		
		JSONArray datas = dao_log.getChatInfo(id);
		request.setAttribute("datas", datas);
		System.out.println("open_study_action");
		
	}
	
}
