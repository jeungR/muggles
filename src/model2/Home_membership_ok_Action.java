package model2;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model1.MemberDAO;
import model1.MemberTO;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;



public class Home_membership_ok_Action implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
		String uploadPath = "C:\\Users\\outou\\Desktop\\muggles_total_v3\\WebContent\\upload";
	    int maxFileSize = 1024 * 1024 * 20;
	    String encoding = "utf-8";
	    MultipartRequest multi;
	    
	    String user_id = "";
	    String user_pw = "";
	    String user_name = "";
	    String gender = "";
	    String phone = "";
	    String email = "";
	    String birthDate = "";
	    String photo = "";
	    String course_name = "";
	    String course_seq = "";
	    
		try {
			multi = new MultipartRequest(request, uploadPath, maxFileSize, encoding, new DefaultFileRenamePolicy());
			
			user_id = multi.getParameter("user_id");
		    user_pw = multi.getParameter("user_pw");
		    user_name = multi.getParameter("user_name");
		    gender = multi.getParameter("gender");
		    phone = multi.getParameter("phone").replaceAll("-", "");
		    email = multi.getParameter("email");
		    birthDate = multi.getParameter("birthDate").replaceAll("-", "");
		    photo = multi.getFilesystemName("photo") == null ? "" : multi.getFilesystemName("photo");
		    course_name = multi.getParameter("course_name");
		    course_seq = multi.getParameter("course_seq");
		    
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}    
		
		MemberTO to = new MemberTO();
		
		to.setUser_id(user_id);
		to.setUser_pw(user_pw);
		to.setUser_name(user_name);
		
		// ����Ȯ��
		to.setUser_gender(gender);
		to.setUser_phone(phone);
		to.setUser_mail(email);
		to.setUser_date(birthDate);
		to.setCourse_seq(course_seq);
		to.setCourse_name(course_name);
		to.setUser_photo(photo);
		
		System.out.println("확인용 : " + to.getUser_id());
		System.out.println("확인용 : " + to.getUser_name());
		System.out.println("확인용 : " + to.getUser_gender());
		System.out.println("확인용 : " + to.getUser_phone());
		System.out.println("확인용 : " + to.getUser_mail());
		System.out.println("확인용 : " + to.getUser_date());
		System.out.println("확인용 : " + to.getUser_photo());
				
		// �ڽ� ��ȣ�� ���̺� ���� ����� �ٸ��� ó���������
		
		MemberDAO dao = new MemberDAO();
		int flag = dao.registerOk(to);
		
		request.setAttribute("flag", flag);
	}
}






