package subPage;

public class groupPageBean {
	//groupmemberboard
	private int gr_mem_gnum; //그룹 번호
	private String mem_id; //아이디
	private int gr_mem_number; //그룹 회원 번호 - pnum
	
	private String gr_mem_name; //이름
	private String mem_email;
	private String group_goal; //스터디 목표
	
	private String group_studydate; //스터디 남은 기간
	private String group_startdate; //스터디 시작 일자
	private String group_finishdate; //스터디 목표 일자
	
	private String group_interests; //관심 분야
	private int group_report; //신고 누적 횟수
	private int group_like;
	
	
	private String group_date; //오늘 날짜
	private String group_introduce; //자기 소개
	
	
	public String getMem_email() {
		return mem_email;
	}
	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}


	
	public int getGr_mem_gnum() {
		return gr_mem_gnum;
	}
	public int getGroup_like() {
		return group_like;
	}
	public void setGroup_like(int group_like) {
		this.group_like = group_like;
	}
	public void setGr_mem_gnum(int gr_mem_gnum) {
		this.gr_mem_gnum = gr_mem_gnum;
	}
	
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public int getGr_mem_number() {
		return gr_mem_number;
	}
	public void setGr_mem_number(int gr_mem_number) {
		this.gr_mem_number = gr_mem_number;
	}
	
	public String getGr_mem_name() {
		return gr_mem_name;
	}
	public void setGr_mem_name(String gr_mem_name) {
		this.gr_mem_name = gr_mem_name;
	}
	
	public String getGroup_goal() {
		return group_goal;
	}
	public void setGroup_goal(String group_goal) {
		this.group_goal = group_goal;
	}
	public String getGroup_studydate() {
		return group_studydate;
	}
	public void setGroup_studydate(String group_studydate) {
		this.group_studydate = group_studydate;
	}
	public String getGroup_startdate() {
		return group_startdate;
	}
	public void setGroup_startdate(String group_startdate) {
		this.group_startdate = group_startdate;
	}
	public String getGroup_finishdate() {
		return group_finishdate;
	}
	public void setGroup_finishdate(String group_finishdate) {
		this.group_finishdate = group_finishdate;
	}
	public String getGroup_interests() {
		return group_interests;
	}
	public void setGroup_interests(String group_interests) {
		this.group_interests = group_interests;
	}
	public String getGroup_date() {
		return group_date;
	}
	public void setGroup_date(String group_date) {
		this.group_date = group_date;
	}
	public String getGroup_introduce() {
		return group_introduce;
	}
	public void setGroup_introduce(String group_introduce) {
		this.group_introduce = group_introduce;
	}
	public int getGroup_report() {
		return group_report;
	}
	public void setGroup_report(int group_report) {
		this.group_report = group_report;
	}
	
	
	//groupboard
	private String gr_mem_study; //공부 기록
	private int gr_mem_conid;
	private String gr_mem_date; //오늘 날짜
	private int gr_check;
	
	public int getGr_mem_conid() {
		return gr_mem_conid;
	}
	public void setGr_mem_conid(int gr_mem_conid) {
		this.gr_mem_conid = gr_mem_conid;
	}
	public String getGr_mem_study() {
		return gr_mem_study;
	}
	public void setGr_mem_study(String gr_mem_study) {
		this.gr_mem_study = gr_mem_study;
	}
	
	public String getGr_mem_date() {
		return gr_mem_date;
	}
	public void setGr_mem_date(String gr_mem_date) {
		this.gr_mem_date = gr_mem_date;
	}
	public int getGr_check() {
		return gr_check;
	}
	public void setGr_check(int gr_check) {
		this.gr_check = gr_check;
	}
}
