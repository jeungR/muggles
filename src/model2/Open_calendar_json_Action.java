package model2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import model1.Open_calendar_DAO;

public class Open_calendar_json_Action implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		//아이디, 등급 받음
		String user_id = request.getParameter("user_id");
		String user_level = request.getParameter("user_level");
		System.out.println(user_id);
		System.out.println(user_level);
		//데이터 가져옴
	    Open_calendar_DAO dao = new Open_calendar_DAO();
	    JSONArray jsonArray = dao.listOk(user_id, user_level);
	    
	    //데이터 넘김
        request.setAttribute("jsonArray", jsonArray);
	}

}
