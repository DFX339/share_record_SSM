package cn.dfx.share_record_SSM.dsum.meeting.pojo;

import java.util.Date;

/**
 * 会议内容的实体类
 * @author Administrator
 *
 */
public class Meeting {
	
	private int id;
	private int userid;
	private String title;
	private String content;
	private Date createtime;
	private String companynum;
	
	public Meeting(){}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserid() {
		return userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getCompanynum() {
		return companynum;
	}

	public void setCompanynum(String companynum) {
		this.companynum = companynum;
	}
	
	
	
	
}
