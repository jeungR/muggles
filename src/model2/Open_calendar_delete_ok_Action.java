package model2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model1.Open_calendar_DAO;
import model1.Open_calendar_TO;

public class Open_calendar_delete_ok_Action implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		Open_calendar_TO to = new Open_calendar_TO();
		
		to.setSeq(request.getParameter("event_id"));
		to.setUser_id(request.getParameter("user_id"));
	    
	    Open_calendar_DAO dao = new Open_calendar_DAO();
	    dao.deleteOk(to);
	    
	}

}
