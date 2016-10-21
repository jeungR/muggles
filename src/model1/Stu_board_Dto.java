package model1;

public class Stu_board_Dto {

	 private int stu_seq;
	 private String stu_title;
	 private String stu_s_date;
	 private String stu_e_date;
	 private int stu_m_num;
	 private String stu_content;
	 private int stu_p_num;
	 private String user_seq;
	 private String stu_wdate;
	 private String user_name;
	 private String user_id;
	 private String user_mail;
	 private String stu_location;
	 private String stu_select_date;
	 private String user_phone;
	 
	 
	 
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getStu_select_date() {
		return stu_select_date;
	}
	public void setStu_select_date(String stu_select_date) {
		this.stu_select_date = stu_select_date;
	}
	public String getStu_location() {
		return stu_location;
	}
	public void setStu_location(String stu_location) {
		this.stu_location = stu_location;
	}
	
	public String getUser_mail() {
		return user_mail;
	}
	public void setUser_mail(String user_mail) {
		this.user_mail = user_mail;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getStu_wdate() {
		return stu_wdate;
	}
	public void setStu_wdate(String stu_wdate) {
		this.stu_wdate = stu_wdate;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public int getStu_seq() {
		return stu_seq;
	}
	public void setStu_seq(int stu_seq) {
		this.stu_seq = stu_seq;
	}
	public String getStu_title() {
		return stu_title;
	}
	public void setStu_title(String stu_title) {
		this.stu_title = stu_title;
	}
	public String getStu_s_date() {
		return stu_s_date;
	}
	public void setStu_s_date(String stu_s_date) {
		this.stu_s_date = stu_s_date;
	}
	public String getStu_e_date() {
		return stu_e_date;
	}
	public void setStu_e_date(String stu_e_date) {
		this.stu_e_date = stu_e_date;
	}
	public int getStu_m_num() {
		return stu_m_num;
	}
	public void setStu_m_num(int i) {
		this.stu_m_num = i;
	}
	public String getStu_content() {
		return stu_content;
	}
	public void setStu_content(String stu_content) {
		this.stu_content = stu_content;
	}
	public int getStu_p_num() {
		return stu_p_num;
	}
	public void setStu_p_num(int stu_p_num) {
		this.stu_p_num = stu_p_num;
	}
	public String getUser_seq() {
		return user_seq;
	}
	public void setUser_seq(String user_seq) {
		this.user_seq = user_seq;
	}
	@Override
	public String toString() {
		return "Stu_board_Dto [stu_seq=" + stu_seq + ", stu_title=" + stu_title + ", stu_s_date=" + stu_s_date
				+ ", stu_e_date=" + stu_e_date + ", stu_m_num=" + stu_m_num + ", stu_content=" + stu_content
				+ ", stu_p_num=" + stu_p_num + ", user_seq=" + user_seq + ", user_name=" + user_name + ", stu_wdate="
				+ stu_wdate + "]";
	}

	 
	 
	 
}
