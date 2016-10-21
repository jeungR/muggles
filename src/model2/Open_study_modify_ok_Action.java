package model2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import model1.MemberDAO;
import model1.MemberTO;
import model1.Stu_board_Dao;
import model1.Stu_board_Dto;

public class Open_study_modify_ok_Action implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// 로그인 정보
		String id = (String)request.getSession().getAttribute("sessionId");
		
		MemberTO to_log = new MemberTO();
		MemberDAO dao_log = new MemberDAO();
		
		to_log = dao_log.getLoginInfo(id);
		request.setAttribute("to_log", to_log);
		
		JSONArray datas = dao_log.getChatInfo(id);
		request.setAttribute("datas", datas);
		//
		Stu_board_Dto dto = new Stu_board_Dto();
		dto.setStu_seq(Integer.parseInt(request.getParameter("stu_seq")));
		dto.setStu_title(request.getParameter("stu_title"));
		dto.setStu_content(request.getParameter("stu_content"));
		dto.setStu_m_num(Integer.parseInt(request.getParameter("stu_m_num")));

		Stu_board_Dao dao = new Stu_board_Dao();
		
		int flag = dao.modifyOK(dto);
		
		request.setAttribute("flag", flag);
		
	}

}
