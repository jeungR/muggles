package servlet;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import model1.MemberDAO;

@WebListener
public class BoardListener implements HttpSessionListener, HttpSessionAttributeListener {

	  private static int totalActiveSessions;

	  public static int getTotalActiveSession(){
		return totalActiveSessions;
	  }

	  MemberDAO dao = new MemberDAO();
	  
	  public BoardListener() {
	        // TODO Auto-generated constructor stub
	    }
	  
	  @Override
	  public void sessionCreated(HttpSessionEvent arg0) {
		totalActiveSessions++;
		System.out.println("sessionCreated - add one session into counter");
		System.out.println(arg0.getSession().getAttribute("sessionId").toString() + "님이 로그인 하셨습니다");
		System.out.println("현재 접속 " + totalActiveSessions + "명");
	  }

	  @Override
	  public void sessionDestroyed(HttpSessionEvent arg0) {
		totalActiveSessions--;
		System.out.println("sessionDestroyed - deduct one session from counter");
		System.out.println(arg0.getSession().getAttribute("sessionId").toString() + "님이 로그아웃 하셨습니다");
		String id = arg0.getSession().getAttribute("sessionId").toString();
		dao.logOut(id);
		System.out.println("현재 접속 " + totalActiveSessions + "명");
	  }
	  
	  @Override
	  public void attributeAdded(HttpSessionBindingEvent arg0)  { 
		System.out.println("AttributeAdded " + arg0.getName() + " " + arg0.getValue());
		System.out.println("현재 접속 " + totalActiveSessions + "명");
	  }

	  @Override
	  public void attributeRemoved(HttpSessionBindingEvent arg0)  { 
		System.out.println("AttributeRemoved " + arg0.getName() + " " + arg0.getValue());
		System.out.println("현재 접속 " + totalActiveSessions + "명");
	  }

	  @Override
	  public void attributeReplaced(HttpSessionBindingEvent arg0) {
		System.out.println("AttributeReplaced " + arg0.getName() + " " + arg0.getValue());
		System.out.println("현재 접속 " + totalActiveSessions + "명");
		String id = (String)arg0.getValue();
		dao.logOut(id);
	  }
	  
	}
