package model2;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import model1.MemberDAO;
import model1.MemberTO;
import model1.PagingDto;
import model1.Recommend_Tab_Dao;
import model1.Recommend_Tab_Dto;
import model1.Stu_board_Dao;
import model1.Stu_board_Dto;

public class Open_recommend_list_json_Action implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// 로그인 정보
		String id = (String)request.getSession().getAttribute("sessionId");
		MemberTO to_log = new MemberTO();
		MemberDAO dao_log = new MemberDAO();
		to_log = dao_log.getLoginInfo(id);
		request.setAttribute("to_log", to_log);
		//request.setAttribute("user_seq", to_log.getUser_seq());
		JSONArray datas = dao_log.getChatInfo(id);
		request.setAttribute("datas", datas);
		
	
		Recommend_Tab_Dao dao = new Recommend_Tab_Dao();
		ArrayList<Recommend_Tab_Dto> dto=dao.recommList();
		
		
		request.setAttribute("recommlist", dto);
		
	}

}
