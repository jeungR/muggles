package model2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import model1.MemberDAO;

public class Home_membership_chkCs_ok_Action implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
		String startDate = (String)request.getParameter("startDate").replaceAll("-", "");
		
		MemberDAO dao = new MemberDAO();
		JSONArray list = dao.checkCs(startDate);
		
		request.setAttribute("list", list);
	}
}






