package servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model2.Action;
import model2.Priv_qna_delete_ok_Action;
import model2.Priv_qna_Action;
import model2.Priv_qna_modify_ok_Action;
import model2.Priv_qna_view_Action;
import model2.Priv_qna_write_ok_Action;
import model2.Priv_review_delete_ok_Action;
import model2.Priv_review_Action;
import model2.Priv_review_modify_ok_Action;
import model2.Priv_review_view_Action;
import model2.Priv_review_write_ok_Action;
import model2.Priv_talk_Action;
import model2.Xtra_image_upload_Action;
import model2.Open_free_detele_ok_Action;
import model2.Open_free_Action;
import model2.Open_free_modify_ok_Action;
import model2.Open_free_reply_ok_Action;
import model2.Open_free_view_Action;
import model2.Open_free_write_ok_Action;
import model2.Open_map_Action;
import model2.Open_map_write_Action;
import model2.Open_qna_delete_ok_Action;
import model2.Open_qna_Action;

import model2.Open_qna_modify_ok_Action;
import model2.Open_qna_reply_ok_Action;
import model2.Open_qna_view_Action;
import model2.Open_qna_write_ok_Action;
import model2.Open_recomm_Action;
import model2.Open_recommend_delete_ok_Action;
import model2.Open_recommend_list_json_Action;
import model2.Open_recommend_Action;
import model2.Open_recommend_modify_ok_Action;
import model2.Open_recommend_view_Action;
import model2.Open_recommend_write_ok_Action;
import model2.Open_study_Action;
import model2.Home_membership_chkId_ok_Action;
import model2.Home_chat_check_Action;
import model2.Home_chat_write_Action;
import model2.Home_chat_Action;
import model2.Home_main_Action;
import model2.Home_membership_chkCs_ok_Action;
import model2.Home_logout_Action;
import model2.Home_login_ok_Action;
import model2.Home_membership_ok_Action;
import model2.My_account_Action;
import model2.My_study_Action;
import model2.My_writing_Action;
import model2.Open_calendar_Action;
import model2.Open_calendar_delete_ok_Action;
import model2.Open_calendar_json_Action;
import model2.Open_calendar_modify_ok_Action;
import model2.Open_calendar_write_ok_Action;
import model2.Open_study_delete_ok_Action;
import model2.Open_study_join_Action;
import model2.Open_study_list_json_Action;
import model2.Open_study_modify_ok_Action;
import model2.Open_study_view_Action;
import model2.Open_study_write_ok_Action;

/**
 * Servlet implementation class BoardController
 */
@WebServlet("*.do")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			
			String path = request.getRequestURI().replaceAll(request.getContextPath(), "");
			String url = "";
			Action action = null;
			
			HttpServletRequest req = (HttpServletRequest)request;
			
			HttpSession session = req.getSession();
			
//////////////////////////////로그인, 회원가입, 채팅//////////////////////////////////////////////
/////////////////로그인
			if (!(path.equals("/home_login_ok.do") || path.equals("/home_membership.do") || path.equals("/home_membership_ok.do") || path.equals("/home_membership_chkId_ok.do") || path.equals("/home_membership_chkCs_ok.do"))) {
				if ((String)session.getAttribute("sessionId") == null) {
					path = "/home_login.do";
				}
			}
			
			if (path.equals("/*.do") || path.equals("/home_login.do") || path.equals("/index.jsp")) { 
				url = "/WEB-INF/model2/home_login.jsp";

			} else if (path.equals("/home_login_ok.do")) {
				action = new Home_login_ok_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/home_login_ok.jsp";
				
			} else if (path.equals("/home_logout.do")) {
				action = new Home_logout_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/home_logout.jsp";
				
/////////////////회원가입	
			} else if (path.equals("/home_membership.do")) {
				url = "/WEB-INF/model2/home_membership.jsp";
				
			} else if (path.equals("/home_membership_ok.do")) {
				action = new Home_membership_ok_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/home_membership_ok.jsp";
				
			} else if (path.equals("/home_membership_chkId_ok.do")) {
				action = new Home_membership_chkId_ok_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/home_membership_chkId_ok.jsp";
				
			} else if (path.equals("/home_membership_chkCs_ok.do")) {
				action = new Home_membership_chkCs_ok_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/home_membership_chkCs_ok.jsp";
				
/////////////////메인페이지
			} else if (path.equals("/home_main.do")) {
				action = new Home_main_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/index.jsp";
				
/////////////////채팅			
			} else if (path.equals("/home_chat_check.do")) {
				action = new Home_chat_check_Action();
				action.execute(request, response);
				url = "/WEB-INF/json/home_chat_check.jsp";
				
			} else if (path.equals("/home_chat.do")) {
				action = new Home_chat_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/home_chat.jsp";
				
			} else if (path.equals("/home_chat_write.do")) {
				action = new Home_chat_write_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/home_chat_write.jsp";
				
///////////////////////////////////my account 게시판////////////////////////////////////////////////
/////////////////내가쓴글			
			} else if (path.equals("/my_writing.do")) {
				action = new My_writing_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/my_writing.jsp";
				
/////////////////참여스터디
			} else if (path.equals("/my_study.do")) {
				action = new My_study_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/my_study.jsp";
				
/////////////////정보수정
			} else if (path.equals("/my_account.do")) {
				action = new My_account_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/my_account.jsp";
				
///////////////////////////////////open 게시판////////////////////////////////////////////////////////				
/////////////////캘린더
			} else if (path.equals("/open_calendar.do")) {
				action = new Open_calendar_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/open_calendar.jsp";
				
			} else if (path.equals("/open_calendar_json.do")) {
				action = new Open_calendar_json_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/open_calendar_json.jsp";
				
			} else if (path.equals("/open_calendar_write_ok.do")) {
				action = new Open_calendar_write_ok_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/open_calendar_json.jsp";
				
			} else if (path.equals("/open_calendar_modify_ok.do")) {
				action = new Open_calendar_modify_ok_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/open_calendar_json.jsp";
				
			} else if (path.equals("/open_calendar_delete_ok.do")) {
				action = new Open_calendar_delete_ok_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/open_calendar_json.jsp";

				///////////////// 오늘머먹지
			} else if (path.equals("/open_map.do")) {
				action = new Open_map_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/open_map.jsp";

			} else if (path.equals("/open_map_write.do")) {
				action = new Open_map_write_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/open_map_write.jsp";

				///////////////// 자유게시판
			} else if (path.equals("/open_free.do")) {
				action = new Open_free_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/open_free.jsp";

			} else if (path.equals("/open_free_view.do")) {
				action = new Open_free_view_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/open_free_view.jsp";

			} else if (path.equals("/open_free_write_ok.do")) {
				action = new Open_free_write_ok_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/open_free_write_ok.jsp";

			} else if (path.equals("/open_free_detele_ok.do")) {
				action = new Open_free_detele_ok_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/open_free_detele_ok.jsp";

			} else if (path.equals("/open_free_modify_ok.do")) {
				action = new Open_free_modify_ok_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/open_free_modify_ok.jsp";

			} else if (path.equals("/open_free_reply_ok.do")) {
				action = new Open_free_reply_ok_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/open_free_reply_ok.jsp";
				
/////////////////스터디모집
			} else if (path.equals("/open_study.do")) {
				action = new Open_study_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/open_study.jsp";
				
			} else if (path.equals("/open_study_list_json.do")){
				
				action = new Open_study_list_json_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/open_study_list_json.jsp";
				
			} else if (path.equals("/open_study_view.do")){
				
				action = new Open_study_view_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/open_study_view.jsp";
				
			} else if (path.equals("/open_study_write_ok.do")){
				
				action = new Open_study_write_ok_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/open_study_write_ok.jsp";
				
			} else if (path.equals("/open_study_modify_ok.do")){
				action = new Open_study_modify_ok_Action();
				action.execute(request, response);
				
				url = "/WEB-INF/model2/open_study_modify_ok.jsp";
				
			
			} else if (path.equals("/open_study_delete_ok.do")){
				action = new Open_study_delete_ok_Action();
				action.execute(request, response);
	
				url = "/WEB-INF/model2/open_study_delete_ok.jsp";
				
			} else if (path.equals("/open_study_join.do")){
				action = new Open_study_join_Action();
				action.execute(request, response);
				
				url="WEB-INF/model2/open_study_join.jsp";	
/////////////////추천사이트
			} else if (path.equals("/open_recommend.do")){
				System.out.println("recommserver");
				action = new Open_recomm_Action();
				action.execute(request, response);
				System.out.println("recommserver2");
				url = "/WEB-INF/model2/open_recommend.jsp";
				
			} else if (path.equals("/open_recommend_json_list.do")){
				System.out.println("recommlist");
				action = new Open_recommend_list_json_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/open_recommend_list_json.jsp";
				
			} else if (path.equals("/open_recomm_view.do")){
	            System.out.println("write");
	            action = new Open_recommend_view_Action();
	            action.execute(request, response);
	            url = "/WEB-INF/model2/open_recommend_view.jsp";
				
			}else if (path.equals("/open_recommend_write_ok.do")){
				System.out.println("write");
				action = new Open_recommend_write_ok_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/open_recommend_write_ok.jsp";
				
			} else if (path.equals("/open_recommend_modify_ok.do")){
				action = new Open_recommend_modify_ok_Action();
				action.execute(request, response);
				
				url = "/WEB-INF/model2/open_recommend_modify_ok.jsp";
				
			
			} else if (path.equals("/open_recommend_delete_ok.do")){
				action = new Open_recommend_delete_ok_Action();
				action.execute(request, response);
	
				url = "/WEB-INF/model2/open_recommend_delete_ok.jsp";
			

				///////////////// 질문게시판
			} else if (path.equals("/open_qna.do")) {
				action = new Open_qna_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/open_qna.jsp";

			} else if (path.equals("/open_qna_view.do")) {
				action = new Open_qna_view_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/open_qna_view.jsp";

			} else if (path.equals("/open_qna_write_ok.do")) {
				action = new Open_qna_write_ok_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/open_qna_write_ok.jsp";

			} else if (path.equals("/open_qna_modify_ok.do")) {
				action = new Open_qna_modify_ok_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/open_qna_modify_ok.jsp";

			} else if (path.equals("/open_qna_delete_ok.do")) {
				action = new Open_qna_delete_ok_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/open_qna_delete_ok.jsp";

			} else if (path.equals("/open_qna_reply_ok.do")) {
				action = new Open_qna_reply_ok_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/open_qna_reply_ok.jsp";
				
/////////////////////////////////// private 게시판////////////////////////////////////////////////////////
				///////////////// 복습게시판
			} else if (path.equals("/priv_review.do")) {
				action = new Priv_review_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/priv_review.jsp";

			} else if (path.equals("/priv_review_view.do")) {
				action = new Priv_review_view_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/priv_review_view.jsp";

			} else if (path.equals("/priv_review_write_ok.do")) {
				action = new Priv_review_write_ok_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/priv_review_write_ok.jsp";

			} else if (path.equals("/priv_review_modify_ok.do")) {
				action = new Priv_review_modify_ok_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/priv_review_modify_ok.jsp";

			} else if (path.equals("/priv_review_delete_ok.do")) {
				action = new Priv_review_delete_ok_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/priv_review_delete_ok.jsp";
				
				///////////////// 질문게시판
			} else if (path.equals("/priv_qna.do")) {
				action = new Priv_qna_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/priv_qna.jsp";

			} else if (path.equals("/priv_qna_view.do")) {
				action = new Priv_qna_view_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/priv_qna_view.jsp";

			} else if (path.equals("/priv_qna_write_ok.do")) {
				action = new Priv_qna_write_ok_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/priv_qna_write_ok.jsp";

			} else if (path.equals("/priv_qna_delete_ok.do")) {
				action = new Priv_qna_delete_ok_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/priv_qna_delete_ok.jsp";

			} else if (path.equals("/priv_qna_modify_ok.do")) {
				action = new Priv_qna_modify_ok_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/priv_qna_modify_ok.jsp";

				///////////////// 수다게시판
			} else if (path.equals("/priv_talk.do")) {
				action = new Priv_talk_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/priv_talk.jsp";
				
				/////////////////////////////////// 파일 다운로드////////////////////////////////////////////////////////
			} else if (path.equals("/xtra_downloader.do")) {
				url = "/WEB-INF/model2/xtra_downloader.jsp";

			} else if (path.equals("/xtra_image_upload.do")) {
				action = new Xtra_image_upload_Action();
				action.execute(request, response);
				url = "/WEB-INF/model2/xtra_image_upload.jsp";
			}

			if (!url.equals("")) {
				RequestDispatcher dispatcher = request.getRequestDispatcher(url);
				dispatcher.forward(request, response);
			}
		} catch (UnsupportedEncodingException e) {
			System.out.println("에러 : " + e.getMessage());
		} catch (ServletException e) {
			System.out.println("에러: " + e.getMessage());
		} catch (IOException e) {
			System.out.println("에러: " + e.getMessage());
		}
	}
}
