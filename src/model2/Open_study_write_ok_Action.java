package model2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import model1.MemberDAO;
import model1.MemberTO;
import model1.Stu_board_Dao;
import model1.Stu_board_Dto;

public class Open_study_write_ok_Action implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// 로그인 정보
		String id = (String)request.getSession().getAttribute("sessionId");
		
		MemberTO to_log = new MemberTO();
		MemberDAO dao_log = new MemberDAO();
		
		to_log = dao_log.getLoginInfo(id);
		request.setAttribute("to_log", to_log);
		
		to_log.setUser_seq(request.getParameter("user_seq"));
		System.out.println("toseq: "+to_log.getUser_seq());
		JSONArray datas = dao_log.getChatInfo(id);
		request.setAttribute("datas", datas);
		//
		Stu_board_Dto dto = new Stu_board_Dto();	
		dto.setStu_title(request.getParameter("stu_title"));
		dto.setStu_content(request.getParameter("stu_content"));
		dto.setStu_m_num(Integer.parseInt(request.getParameter("stu_m_num")));
		dto.setStu_s_date(request.getParameter("stu_s_date"));
		dto.setStu_e_date(request.getParameter("stu_e_date"));
		dto.setStu_location(request.getParameter("stu_location"));
		dto.setStu_select_date(request.getParameter("stu_select_date"));
		dto.setUser_seq(request.getParameter("user_seq"));
		System.out.println(dto); 
		System.out.println("writeok 넘어옴");
		Stu_board_Dao dao = new Stu_board_Dao();
		int flag = dao.stu_boardWriterOK(dto);
		//jsp쪽의 writeok로 flag를 보내줘야하므로 setAttribute로 플레그를 보내준다.
		request.setAttribute("flag", flag);
	}

}
