package model1;

import java.util.ArrayList;

public class MemberTO {
	private String user_seq;
	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_mail;
	private String user_phone;
	private String user_date;
	private String user_gender;
	private int user_level;
	private String user_photo;
	private ArrayList<String> course_seq;
	private ArrayList<String> course_name;
	private ArrayList<String> course_confirm;
	private String user_last_login;
	private String user_last_logout;
	private ArrayList<MemberTO> memberList;
	
	public MemberTO() {
		this.course_seq = new ArrayList<>();
		this.course_name = new ArrayList<>();
		this.course_confirm = new ArrayList<>();
	}
	
	public final ArrayList<String> getCourse_name() {
		return course_name;
	}
	public final void setCourse_name(String course_name) {
		this.course_name.add(course_name);
	}
	public final ArrayList<String> getCourse_confirm() {
		return course_confirm;
	}
	public final void setCourse_confirm(String course_confirm) {
		this.course_confirm.add(course_confirm);
	}
	public final ArrayList<String> getCourse_seq() {
		return course_seq;
	}
	public final void setCourse_seq(String course_seq) {
		this.course_seq.add(course_seq);
	}
	public final ArrayList<MemberTO> getMemberList() {
		return memberList;
	}
	public final void setMemberList(ArrayList<MemberTO> memberList) {
		this.memberList = memberList;
	}
	public String getUser_last_login() {
		return user_last_login;
	}
	public void setUser_last_login(String user_last_login) {
		this.user_last_login = user_last_login;
	}
	public String getUser_last_logout() {
		return user_last_logout;
	}
	public void setUser_last_logout(String user_last_logout) {
		this.user_last_logout = user_last_logout;
	}
	public String getUser_gender() {
		return user_gender;
	}
	public void setUser_gender(String user_gender) {
		this.user_gender = user_gender;
	}
	public String getUser_seq() {
		return user_seq;
	}
	public void setUser_seq(String user_seq) {
		this.user_seq = user_seq;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_mail() {
		return user_mail;
	}
	public void setUser_mail(String user_mail) {
		this.user_mail = user_mail;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getUser_date() {
		return user_date;
	}
	public void setUser_date(String user_date) {
		this.user_date = user_date;
	}
	public int getUser_level() {
		return user_level;
	}
	public void setUser_level(int user_level) {
		this.user_level = user_level;
	}
	public String getUser_photo() {
		return user_photo;
	}
	public void setUser_photo(String user_photo) {
		this.user_photo = user_photo;
	}

}
