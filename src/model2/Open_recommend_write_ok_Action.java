package model2;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import model1.MemberDAO;
import model1.MemberTO;
import model1.Recommend_Tab_Dao;
import model1.Recommend_Tab_Dto;

public class Open_recommend_write_ok_Action implements Action{

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
		
		String uploadPath = "C:\\Users\\outou\\Desktop\\muggles_total_v3\\WebContent\\upload";
		int maxFileSize = 1024 * 1024 * 10;
		String encoding = "utf-8";
		Recommend_Tab_Dto dto;
		try {
			MultipartRequest multi 
				= new MultipartRequest(
						request,
						uploadPath,
						maxFileSize,
						encoding,
						new DefaultFileRenamePolicy());
			
			request.setCharacterEncoding("utf-8");
			
			dto = new Recommend_Tab_Dto();
			System.out.println("write_ok:::" + multi.getParameter("user_seq"));
			dto.setRecomm_olin(multi.getParameter("recomm_olin"));
			dto.setRecomm_language(multi.getParameter("recomm_language"));
			dto.setRecomm_title(multi.getParameter("recomm_title"));
			dto.setRecomm_content(multi.getParameter("recomm_content"));
			dto.setRecomm_link(multi.getParameter("recomm_link"));
			dto.setCst(multi.getParameter("cost"));
			dto.setCst_detail(multi.getParameter("cost_detail"));
			dto.setRecomm_img(multi.getFilesystemName("recomm_img"));
			dto.setUser_seq(multi.getParameter("user_seq"));
			System.out.println("writeOK" );
			System.out.println("writeOKaction : "+dto);

			Recommend_Tab_Dao dao = new Recommend_Tab_Dao();
			int flag = dao.recommWriterOk(dto);
			System.out.println("write ok::" + flag);
			request.setAttribute("flag", flag);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		
		}
		
		
	}

}
