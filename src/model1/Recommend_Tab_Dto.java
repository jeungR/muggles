package model1;

public class Recommend_Tab_Dto {
	private int recomm_seq;
	private String recomm_olin;
	private String recomm_language;
	private String recomm_title;
	private String recomm_content;
	private String recomm_link;
	private String cst;
	private String cst_detail;
	private String recomm_img;
	private String user_seq;
	private String user_name;
	
	
	
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public int getRecomm_seq() {
		return recomm_seq;
	}
	public void setRecomm_seq(int recomm_seq) {
		this.recomm_seq = recomm_seq;
	}
	public String getRecomm_olin() {
		return recomm_olin;
	}
	public void setRecomm_olin(String recomm_olin) {
		this.recomm_olin = recomm_olin;
	}
	public String getRecomm_language() {
		return recomm_language;
	}
	public void setRecomm_language(String recomm_language) {
		this.recomm_language = recomm_language;
	}
	public String getRecomm_title() {
		return recomm_title;
	}
	public void setRecomm_title(String recomm_title) {
		this.recomm_title = recomm_title;
	}
	public String getRecomm_content() {
		return recomm_content;
	}
	public void setRecomm_content(String recomm_content) {
		this.recomm_content = recomm_content;
	}
	public String getRecomm_link() {
		return recomm_link;
	}
	public void setRecomm_link(String recomm_link) {
		this.recomm_link = recomm_link;
	}
	public String getCst() {
		return cst;
	}
	public void setCst(String cst) {
		this.cst = cst;
	}
	public String getCst_detail() {
		return cst_detail;
	}
	public void setCst_detail(String cst_detail) {
		this.cst_detail = cst_detail;
	}
	public String getRecomm_img() {
		return recomm_img;
	}
	public void setRecomm_img(String recomm_img) {
		this.recomm_img = recomm_img;
	}
	
	public String getUser_seq() {
		return user_seq;
	}
	public void setUser_seq(String user_seq) {
		this.user_seq = user_seq;
	}
	@Override
	public String toString() {
		return "Recommend_Tab_Dto [recomm_seq=" + recomm_seq + ", recomm_olin=" + recomm_olin + ", recomm_language="
				+ recomm_language + ", recomm_title=" + recomm_title + ", recomm_content=" + recomm_content
				+ ", recomm_link=" + recomm_link + ", cst=" + cst + ", cst_detail=" + cst_detail + ", recomm_img="
				+ recomm_img + ", user_seq=" + user_seq + "]";
	}
	
	
	
}
