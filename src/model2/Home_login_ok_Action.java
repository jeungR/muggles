package model2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model1.MemberDAO;
import model1.MemberTO;

public class Home_login_ok_Action implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		MemberTO to = new MemberTO();
		
		to.setUser_id(request.getParameter("userId"));
		to.setUser_pw(request.getParameter("userPw"));
		MemberDAO dao = new MemberDAO();
		int flag = dao.loginChk(to);
		
		request.setAttribute("flag", flag);
		request.setAttribute("id", to.getUser_id());
	}
}






