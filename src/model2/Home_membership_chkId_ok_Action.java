package model2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model1.MemberDAO;
import model1.MemberTO;

public class Home_membership_chkId_ok_Action implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		MemberTO to = new MemberTO();
		
		to.setUser_id(request.getParameter("id"));
		System.out.println(to.getUser_id());
		MemberDAO dao = new MemberDAO();
		int flag = dao.checkId(to);
		
		request.setAttribute("flag", flag);
	}
}






