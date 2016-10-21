package model2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import model1.MemberDAO;
import model1.MemberTO;

public class Home_chat_Action implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
			
			String chat_id = (String)request.getParameter("id");
			String my_id = (String)request.getSession().getAttribute("sessionId");
			
			JSONArray datas = new JSONArray();
			MemberDAO dao = new MemberDAO();
			
			datas = dao.getChatInfo2(my_id, chat_id);
			request.setAttribute("datas", datas);
			
		}		
	}





