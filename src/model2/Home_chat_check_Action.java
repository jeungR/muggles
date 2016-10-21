package model2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import model1.MemberDAO;
import model1.MemberTO;

public class Home_chat_check_Action implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
						
			String id = request.getParameter("id");
			
			MemberDAO dao = new MemberDAO();
			
			JSONArray datas = dao.getChatInfo(id);
			
			request.setAttribute("datas", datas);
		}		
	}





