package model2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import model1.MemberDAO;
import model1.MemberTO;
import model1.Recommend_Tab_Dao;
import model1.Recommend_Tab_Dto;
import model1.Stu_board_Dao;
import model1.Stu_board_Dto;

public class Open_recommend_view_Action implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// 로그인 정보
		String id = (String)request.getSession().getAttribute("sessionId");
		
		MemberTO to_log = new MemberTO();
		MemberDAO dao_log = new MemberDAO();
		
		to_log = dao_log.getLoginInfo(id);
		request.setAttribute("to_log", to_log);
		
		JSONArray datas = dao_log.getChatInfo(id);
		request.setAttribute("datas", datas);
		//

		Recommend_Tab_Dto dto = new Recommend_Tab_Dto();
		dto.setRecomm_seq(Integer.parseInt(request.getParameter("recomm_seq")));
		System.out.println("viewAction");
		
		Recommend_Tab_Dao dao = new Recommend_Tab_Dao();
		dto = dao.boardView(dto);
		System.out.println(dto);
		request.setAttribute("dto", dto);
	}

}
