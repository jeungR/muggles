package model2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model1.Open_calendar_DAO;
import model1.Open_calendar_TO;

public class Open_calendar_write_ok_Action implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		Open_calendar_TO to = new Open_calendar_TO();
		
	    to.setTitle(request.getParameter("title"));
	    to.setStart(request.getParameter("start"));
	    to.setEnd(request.getParameter("end"));
	    to.setAllDay(request.getParameter("allDay"));
	    to.setClassName(request.getParameter("className"));
	    to.setUser_id(request.getParameter("user_id"));
	    to.setUser_level(request.getParameter("user_level"));
	    
	    Open_calendar_DAO dao = new Open_calendar_DAO();
	    dao.writeOk(to);
	    
	}

}
