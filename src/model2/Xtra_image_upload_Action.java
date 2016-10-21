package model2;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


public class Xtra_image_upload_Action implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			//업로드 경로 //제한용량 //인코딩 정해야함
			String uploadPath ="C:/java/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/muggles/upload";
			int maxFileSize = 1024*1024*20;
			String encoding ="utf-8";
			//업로드
			MultipartRequest multi = new MultipartRequest(request, uploadPath, maxFileSize, encoding, new DefaultFileRenamePolicy());
			
			String origin_name = multi.getOriginalFileName("image1"); //원래 파일 이름
			String name = multi.getFilesystemName("image1");  //업로드 시킨 파일 이름
			
			//웹상에서 파일 경로
			String path = "http://localhost:8080/muggles/upload/"+multi.getFilesystemName("image1");
			System.out.println("웹상에서 파일경로 : "+path);
			
			//업로드 상태와 업로드된 이미지정보 보냄
			if(origin_name == null){
				request.setAttribute("imgstat", "error");
			}else if(name != null){
				request.setAttribute("imgstat", "good");
				request.setAttribute("path", path);
				request.setAttribute("name", name);
			}
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			request.setAttribute("imgstat", "failed");
		}

		
	}

}
