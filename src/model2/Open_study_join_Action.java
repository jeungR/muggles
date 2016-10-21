package model2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import model1.MemberDAO;
import model1.MemberTO;
import model1.Stu_board_Dao;
import model1.Stu_board_Dto;

public class Open_study_join_Action implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// 로그인 정보
		String id = (String)request.getSession().getAttribute("sessionId");
		
		MemberTO to_log = new MemberTO();
		MemberDAO dao_log = new MemberDAO();
		
		to_log = dao_log.getLoginInfo(id);
		request.setAttribute("to_log", to_log);
		
		System.out.println("join_study_action"+to_log.getUser_seq());
		
		JSONArray datas = dao_log.getChatInfo(id);
		request.setAttribute("datas", datas);
		
		Stu_board_Dto dto = new Stu_board_Dto();
		
		System.out.println("joinbtn");
		dto.setStu_seq(Integer.parseInt(request.getParameter("stu_seq")));
		dto.setUser_seq(request.getParameter("user_seq"));
		
		System.out.println("join");
		Stu_board_Dao dao = new Stu_board_Dao();
		
		int flag = dao.joinStudy(dto);
		System.out.println(flag);
		request.setAttribute("flag", flag);
		
	}

}
