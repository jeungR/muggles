package model2;


import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import model1.Stu_board_Dao;
import model1.MemberDAO;
import model1.MemberTO;
import model1.PagingDto;
import model1.Stu_board_Dto;

public class Open_study_list_json_Action implements Action {

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
		
		int cpage = 1;
		
		if(request.getParameter("cpage")!=null && !request.getParameter("cpage").equals("")){
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}
		
		PagingDto pagingDto = new PagingDto();
		pagingDto.setCpage(cpage);
		
		Stu_board_Dao dao = new Stu_board_Dao();
		pagingDto =dao.boardList(pagingDto);
		
		int totalPage =  pagingDto.getTotalPage();
		int blockPerpage = pagingDto.getBlockPerpage();
		int startBlock = pagingDto.getStartBlock();
		int endBlock = pagingDto.getEndBlock();
		
		ArrayList<Stu_board_Dto> stu_board_Dto = pagingDto.getBoardList();
		
		
		request.setAttribute("list", stu_board_Dto);
		
		request.setAttribute("cpage", cpage);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("blockPerpage", blockPerpage);
		request.setAttribute("startBlock", startBlock);
		request.setAttribute("endBlock", endBlock);
		
	}

}
