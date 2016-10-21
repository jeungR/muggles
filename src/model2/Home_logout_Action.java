package model2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model1.MemberDAO;
import model1.MemberTO;

public class Home_logout_Action implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
		String id = (String)request.getSession().getAttribute("sessionId");
		
		MemberDAO dao = new MemberDAO();
		dao.logOut(id);
	}
}






