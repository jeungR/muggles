package model2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import model1.MemberDAO;
import model1.MemberTO;

public class Home_chat_write_Action implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
			
			String chat_id = (String)request.getParameter("chat_id");
			String my_id = (String)request.getSession().getAttribute("sessionId");
			String text = (String)request.getParameter("text");
			
			JSONObject data = new JSONObject();
			MemberDAO dao = new MemberDAO();
			
			dao.ChatIntoDB(my_id, chat_id, text);
		}		
	}





