package model2;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import model1.MemberDAO;
import model1.MemberTO;

public class Home_main_Action implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// 濡쒓렇�씤 �젙蹂�
		String id = (String)request.getSession().getAttribute("sessionId");
		
		MemberTO to_log = new MemberTO();
		MemberDAO dao = new MemberDAO();
		
		to_log = dao.getLoginInfo(id);
		request.setAttribute("to_log", to_log);
		
		JSONArray datas = dao.getChatInfo(id);
		request.setAttribute("datas", datas);
		
		ArrayList<String> members = dao.getLoginMembers();
		request.setAttribute("members", members);
			
		}		
	}





